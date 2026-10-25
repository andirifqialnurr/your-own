import assert from 'node:assert/strict';
import { mkdtempSync, mkdirSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import path from 'node:path';
import test from 'node:test';
import { checkDocumentation, formatErrors, markdownFacts } from './documentation.mjs';

function fixture(t) {
  const root = mkdtempSync(path.join(tmpdir(), 'your-own-doc-test-'));
  t.after(() => rmSync(root, { recursive: true, force: true }));
  mkdirSync(path.join(root, 'docs'));
  writeFileSync(path.join(root, 'code.ts'), 'export {};\n');
  writeFileSync(path.join(root, 'docs/reference.md'), '# Target — title\n\n# Target — title\n');
  return root;
}

test('local code, directory, heading, duplicate heading and external links', t => {
  const root = fixture(t);
  writeFileSync(path.join(root, 'README.md'), '# Home\n[code](code.ts) [directory](docs/) [self](#home) [target](docs/reference.md#target--title-1) [external](https://example.invalid/not-fetched)\n');
  assert.deepEqual(checkDocumentation(root, ['README.md', 'docs/reference.md']), { files: 2, links: 4, examples: 0 });
});

for (const [target, reason] of [['missing.ts', 'missing target'], ['docs/reference.md#missing', 'missing heading'], ['../outside.md', 'leaves repository'], ['%GG', 'URI malformed']]) {
  test(`rejects broken index ${target}`, t => {
    const root = fixture(t);
    writeFileSync(path.join(root, 'README.md'), `[bad](${target})\n`);
    assert.throws(() => checkDocumentation(root, ['README.md', 'docs/reference.md']), new RegExp(reason));
  });
}

test('fenced source is not interpreted as links or headings; JSON is checked', () => {
  const facts = markdownFacts('# Real\n```text\n# Not a heading\n[not a link](absent)\n```\n```json\n{"synthetic":true}\n```\n');
  assert.deepEqual([...facts.anchors], ['real']);
  assert.equal(facts.examples, 1);
  assert.equal(facts.prose.includes('not a link'), false);
  assert.deepEqual(facts.errors, []);
});

for (const [text, expected] of [['```json\nno\n```', 'invalid JSON'], ['```text\nopen', 'unclosed'], ['| A | B |\n|---|\n', 'table'], ['# title  \n', 'whitespace']]) {
  test(`rejects documentation ${expected}`, () => assert.ok(markdownFacts(text).errors.some(error => error.includes(expected))));
}

test('escaped table pipes and CRLF are supported', () => {
  assert.deepEqual(markdownFacts('| A | B |\r\n|---|---|\r\n| escaped \\| pipe | value |\r\n').errors, []);
  assert.deepEqual(formatErrors('const value = 1;\r\n'), []);
});

test('owned source whitespace check rejects tabs, trailing space and missing newline', () => {
  assert.deepEqual(formatErrors('\tconst value = 1; '), ['missing final newline', 'tab character (use spaces)', 'trailing whitespace']);
  assert.deepEqual(formatErrors('const value = 1;\n'), []);
});
