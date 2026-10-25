import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';

const base = new URL('../apps/mobile/assets/fonts/', import.meta.url);
const manifest = JSON.parse(readFileSync(new URL('provenance.json', base), 'utf8'));
assert.equal(manifest.family, 'DM Sans');
assert.deepEqual(manifest.files.map(file => file.path), ['DMSans-Variable.ttf', 'OFL.txt']);
for (const file of manifest.files) {
  const location = new URL(file.path, base);
  const bytes = readFileSync(location);
  assert.equal(bytes.length, file.bytes, fileURLToPath(location));
  assert.equal(createHash('sha256').update(bytes).digest('hex'), file.sha256, fileURLToPath(location));
}
console.info('Bundled DM Sans and OFL bytes match the reviewed provenance manifest.');
