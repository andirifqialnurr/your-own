import assert from 'node:assert/strict';
import { after, before, test } from 'node:test';
import { createApplication } from '../dist/app.js';

let app;
let origin;
before(async () => {
  app = await createApplication();
  await app.listen(0, '127.0.0.1');
  origin = await app.getUrl();
});
after(async () => { await app?.close(); });

test('liveness serves only a constant status over real loopback HTTP', async () => {
  const response = await fetch(`${origin}/v1/health/live`);
  assert.equal(response.status, 200);
  assert.deepEqual(await response.json(), { status: 'ok' });
  assert.equal(response.headers.get('cache-control'), 'no-store');
  assert.equal(response.headers.get('x-content-type-options'), 'nosniff');
  assert.equal(response.headers.get('x-powered-by'), null);
});

test('readiness honestly remains unavailable until application services exist', async () => {
  const response = await fetch(`${origin}/v1/health/ready`);
  assert.equal(response.status, 503);
  assert.deepEqual(await response.json(), { status: 'not_ready' });
  assert.equal(response.headers.get('cache-control'), 'no-store');
});

test('uncomposed identity adds no auth, upload, sync, operator or tracker endpoint', async () => {
  for (const path of [
    '/v1/identity', '/v1/auth/login', '/v1/auth/refresh', '/v1/auth/reset',
    '/upload', '/v1/sync/commands', '/v1/operator/session', '/v1/money/transactions',
  ]) {
    const response = await fetch(origin + path, { method: 'POST' });
    assert.equal(response.status, 404);
    await response.arrayBuffer();
  }
});
