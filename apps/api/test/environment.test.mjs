import assert from 'node:assert/strict';
import { execFileSync } from 'node:child_process';
import test from 'node:test';
import { ConfigurationError, readEnvironment } from '../dist/config/environment.js';

for (const environment of ['development', 'test']) {
  test(`accepts explicit ${environment} configuration`, () => {
    assert.deepEqual(readEnvironment({ APP_ENV: environment }), {
      environment, host: '127.0.0.1', port: 3000,
    });
    assert.ok(Object.isFrozen(readEnvironment({ APP_ENV: environment })));
  });
}

test('accepts valid port boundaries and loopback only', () => {
  for (const port of ['1', '3001', '65535']) {
    assert.equal(readEnvironment({ APP_ENV: 'test', API_PORT: port, API_HOST: '127.0.0.1' }).port, Number(port));
  }
});

test('fails closed on missing, misspelled or deployment environment', () => {
  for (const env of [{}, { APP_ENV: '' }, { APP_ENV: 'staging' }, { APP_ENV: 'production' }, { APP_ENV: 'Development' }]) {
    assert.throws(() => readEnvironment(env), ConfigurationError);
  }
});

test('rejects invalid ports and non-loopback interfaces', () => {
  for (const port of ['', '0', '-1', '65536', '1.5', '3000junk', ' 3000', '1e3', 'NaN']) {
    assert.throws(() => readEnvironment({ APP_ENV: 'test', API_PORT: port }), ConfigurationError);
  }
  for (const host of ['', '0.0.0.0', '::', 'example.com']) {
    assert.throws(() => readEnvironment({ APP_ENV: 'test', API_HOST: host }), ConfigurationError);
  }
});

test('real entry point exits before listening and does not disclose invalid input', () => {
  assert.throws(() => execFileSync(process.execPath, ['dist/main.js'], {
    env: { ...process.env, APP_ENV: 'sensitive-value-do-not-log' },
    encoding: 'utf8', stdio: ['ignore', 'pipe', 'pipe'], timeout: 10000,
  }), (error) => {
    assert.equal(error.status, 1);
    assert.match(error.stderr, /APP_ENV must be development or test/);
    assert.doesNotMatch(error.stderr + error.stdout, /sensitive-value-do-not-log/);
    return true;
  });
});
