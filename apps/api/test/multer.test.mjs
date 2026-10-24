import assert from 'node:assert/strict';
import { execFileSync } from 'node:child_process';
import test from 'node:test';

// One isolated process per case; an unhandled parser error must fail the test.
for (const name of [
  'async-teardown', 'normal-upload', 'field-exact', 'field-over',
  'field-default-exact', 'field-default-over', 'field-unicode-exact',
  'field-unicode-over', 'storage-failed-cleanup', 'storage-success-cleanup',
]) {
  test(`scoped Multer 2.5.0 override: ${name}`, () => {
    const output = execFileSync(process.execPath, ['test/multer-regressions.cjs', name], {
      encoding: 'utf8', timeout: 12000, stdio: ['ignore', 'pipe', 'pipe'],
    });
    assert.deepEqual(JSON.parse(output).name, name);
    assert.equal(JSON.parse(output).passed, true);
  });
}
