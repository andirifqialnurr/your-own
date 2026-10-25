import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { cpSync, mkdirSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import test from 'node:test';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');

function fixture(body) {
  const directory = mkdtempSync(path.join(tmpdir(), 'your-own-design-test-'));
  try {
    mkdirSync(path.join(directory, 'scripts'));
    for (const script of ['generate-theme-tokens.mjs', 'check-mobile-assets.mjs']) {
      cpSync(path.join(root, 'scripts', script), path.join(directory, 'scripts', script));
    }
    cpSync(path.join(root, 'design'), path.join(directory, 'design'), { recursive: true });
    body(directory);
  } finally {
    rmSync(directory, { recursive: true, force: true });
  }
}

function run(directory, script, ...args) {
  const result = spawnSync(process.execPath, [path.join(directory, 'scripts', script), ...args], { encoding: 'utf8', timeout: 15000 });
  assert.ifError(result.error);
  return result.status;
}

test('token generation is deterministic; check rejects stale output', () => fixture(directory => {
  const script = 'generate-theme-tokens.mjs';
  assert.equal(run(directory, script), 0);
  const output = path.join(directory, 'apps/mobile/lib/shared_ui/theme/app_tokens.g.dart');
  const first = readFileSync(output, 'utf8');
  assert.equal(run(directory, script), 0);
  assert.equal(readFileSync(output, 'utf8'), first);
  assert.equal(run(directory, script, '--check'), 0);
  writeFileSync(output, first + '// stale fixture\n');
  assert.notEqual(run(directory, script, '--check'), 0);
}));

test('token generation rejects mismatched palette roles and unknown arguments', () => fixture(directory => {
  const script = 'generate-theme-tokens.mjs';
  assert.notEqual(run(directory, script, '--unknown'), 0);
  const source = path.join(directory, 'design/tokens.json');
  const tokens = JSON.parse(readFileSync(source, 'utf8'));
  delete tokens.colors.dark.canvas;
  writeFileSync(source, JSON.stringify(tokens));
  assert.notEqual(run(directory, script), 0);
}));

test('asset verification rejects same-length font and license corruption', () => fixture(directory => {
  const relative = 'apps/mobile/assets/fonts';
  cpSync(path.join(root, relative), path.join(directory, relative), { recursive: true });
  const script = 'check-mobile-assets.mjs';
  assert.equal(run(directory, script), 0);
  for (const name of ['DMSans-Variable.ttf', 'OFL.txt']) {
    const file = path.join(directory, relative, name);
    const original = readFileSync(file);
    const corrupted = Buffer.from(original);
    corrupted[0] ^= 1;
    writeFileSync(file, corrupted);
    assert.notEqual(run(directory, script), 0);
    writeFileSync(file, original);
  }
  assert.equal(run(directory, script), 0);
}));
