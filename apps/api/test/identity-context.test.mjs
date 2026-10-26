import assert from 'node:assert/strict';
import { execFileSync } from 'node:child_process';
import { mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { test } from 'node:test';
import * as identity from '../dist/modules/identity/index.js';

const { evaluateIdentityAccess } = identity;
const own = { kind: 'own-data', ownerUserId: 'fixture-user-a' };
const operation = { kind: 'operator', capability: 'fixture.case.review' };
const personal = (changes = {}) => ({
  userId: 'fixture-user-a',
  authorityReference: 'fixture-context-a',
  scope: 'personal',
  lifecycle: 'active',
  authenticationState: 'current',
  emailVerified: true,
  assurance: { method: 'primary' },
  staffGrant: { status: 'none' },
  ...changes,
});
const operator = (changes = {}) => personal({
  scope: 'operator',
  assurance: { method: 'totp', freshness: 'fresh' },
  staffGrant: {
    status: 'current', authorityReference: 'fixture-staff-grant-a',
    capabilities: ['fixture.case.review'],
  },
  ...changes,
});
const authenticated = (actor) => ({ status: 'authenticated', actor });
const verdict = (actor, requirement = own) => evaluateIdentityAccess(authenticated(actor), requirement).status;

test('identity barrel exposes a pure policy only, not a runtime authority or actor factory', () => {
  assert.deepEqual(Object.keys(identity), ['evaluateIdentityAccess']);
});

test('an already trusted eligible personal fixture can access its own data', () => {
  assert.equal(verdict(personal()), 'allowed');
});

test('authority unavailable stays distinct from denied, with no actor or error echo', () => {
  assert.deepEqual(evaluateIdentityAccess({ status: 'unavailable' }, own), { status: 'unavailable' });
  assert.deepEqual(evaluateIdentityAccess({ status: 'denied' }, own), { status: 'denied' });
  assert.deepEqual(evaluateIdentityAccess({ status: 'unavailable', actor: personal(), error: 'fixture-no-echo' }, own), { status: 'unavailable' });
});

test('missing and malformed resolutions deny without inventing an actor', () => {
  for (const resolution of [undefined, null, false, '', [], {}, { status: 'anonymous' },
    { status: 'authenticated' }, { status: 'authenticated', actor: null }]) {
    assert.deepEqual(evaluateIdentityAccess(resolution, own), { status: 'denied' });
  }
});

for (const lifecycle of ['suspended', 'deleting', 'deleted']) {
  test(`already trusted ${lifecycle} context is not eligible`, () => {
    assert.equal(verdict(personal({ lifecycle })), 'denied');
    assert.equal(verdict(operator({ lifecycle }), operation), 'denied');
  });
}

for (const authenticationState of ['pending', 'revoked', 'expired']) {
  test(`${authenticationState} authentication state denies both policy scopes`, () => {
    assert.equal(verdict(personal({ authenticationState })), 'denied');
    assert.equal(verdict(operator({ authenticationState }), operation), 'denied');
  });
}

test('own-data policy requires verified email and exact owner without coercion', () => {
  assert.equal(verdict(personal({ emailVerified: false })), 'denied');
  assert.equal(verdict(personal(), { kind: 'own-data', ownerUserId: 'fixture-user-b' }), 'denied');
  assert.equal(verdict(personal(), { kind: 'own-data', ownerUserId: 'FIXTURE-USER-A' }), 'denied');
  assert.equal(verdict(personal({ userId: 1 }), { kind: 'own-data', ownerUserId: '1' }), 'denied');
});

test('operator context is not a general private-tracker viewer', () => {
  assert.equal(verdict(operator()), 'denied');
});

test('ordinary personal context and frontend flags cannot confer operator scope', () => {
  assert.equal(verdict(personal({ isAdmin: true, mfaVerified: true, 'x-admin': 'true' }), operation), 'denied');
  assert.equal(verdict(personal({ assurance: { method: 'totp', freshness: 'fresh' } }), operation), 'denied');
});

test('operator policy allows only a pretrusted current scoped grant with fresh TOTP', () => {
  assert.deepEqual(evaluateIdentityAccess(authenticated(operator()), operation), { status: 'allowed' });
  assert.equal(verdict(operator({ emailVerified: false }), operation), 'denied');
});

for (const method of ['primary', 'mfa', 'recovery']) {
  test(`${method} assurance is not required fresh operator TOTP`, () => {
    assert.equal(verdict(operator({ assurance: { method, freshness: 'fresh', mfaVerified: true } }), operation), 'denied');
  });
}

test('stale or unspecified TOTP freshness denies operator access', () => {
  for (const assurance of [{ method: 'totp', freshness: 'stale' }, { method: 'totp' },
    { method: 'totp', freshness: 'recent' }, { method: 'totp', freshness: true }]) {
    assert.equal(verdict(operator({ assurance }), operation), 'denied');
  }
});

test('missing revoked or malformed staff grants deny', () => {
  const sparseCapabilities = [];
  sparseCapabilities[1] = 'fixture.case.review';
  for (const staffGrant of [undefined, null, {}, { status: 'none' }, { status: 'revoked' },
    { status: 'current', authorityReference: '', capabilities: ['fixture.case.review'] },
    { status: 'current', authorityReference: 'fixture-reference', capabilities: 'fixture.case.review' },
    { status: 'current', authorityReference: 'fixture-reference', capabilities: [1] },
    { status: 'current', authorityReference: 'fixture-reference', capabilities: sparseCapabilities }]) {
    assert.equal(verdict(operator({ staffGrant }), operation), 'denied');
  }
});

test('capability matching is exact and does not expand wildcard or role labels', () => {
  for (const capabilities of [[], ['*'], ['admin'], ['fixture.case.*'], ['FIXTURE.CASE.REVIEW'], ['fixture.case.other']]) {
    assert.equal(verdict(operator({ staffGrant: {
      status: 'current', authorityReference: 'fixture-grant', capabilities,
    } }), operation), 'denied');
  }
});

test('malformed internal context and server requirements fail closed', () => {
  for (const changes of [{ userId: '' }, { userId: ' fixture-user-a' },
    { authorityReference: '' }, { authorityReference: 'fixture\u0000reference' },
    { lifecycle: 'unknown' }, { scope: 'admin' }, { authenticationState: 'valid' },
    { emailVerified: 'true' }, { assurance: null }]) {
    assert.equal(verdict(personal(changes)), 'denied');
  }
  for (const required of [null, undefined, {}, { kind: 'own-data' },
    { kind: 'own-data', ownerUserId: ' ' }, { kind: 'operator', capability: '' },
    { kind: 'operator', capability: 1 }, { kind: 'unknown' }]) {
    assert.equal(evaluateIdentityAccess(authenticated(operator()), required).status, 'denied');
  }
});

test('policies are deterministic, do not mutate frozen context, and return no private projection', () => {
  const actor = Object.freeze(operator({
    assurance: Object.freeze({ method: 'totp', freshness: 'fresh' }),
    staffGrant: Object.freeze({
      status: 'current', authorityReference: 'fixture-grant',
      capabilities: Object.freeze(['fixture.case.review']),
    }),
  }));
  const resolution = Object.freeze(authenticated(actor));
  const required = Object.freeze({ ...operation });
  const before = JSON.stringify(resolution);
  assert.deepEqual(evaluateIdentityAccess(resolution, required), { status: 'allowed' });
  assert.deepEqual(evaluateIdentityAccess(resolution, required), { status: 'allowed' });
  assert.equal(JSON.stringify(resolution), before);
});

test('S0 types compile for valid callers and reject invalid scopes outcomes and mutation', () => {
  const root = mkdtempSync(path.join(tmpdir(), 'your-own-identity-types-'));
  const compiler = fileURLToPath(new URL('../node_modules/typescript/bin/tsc', import.meta.url));
  const entry = fileURLToPath(new URL('../src/modules/identity/index.js', import.meta.url)).replaceAll('\\', '/');
  const config = path.join(root, 'tsconfig.json');
  const source = path.join(root, 'caller.mts');
  const valid = `import { evaluateIdentityAccess, type ActorContext, type ActorAssurance,
    type IdentityAuthority, type IdentityResolution, type IdentityAccessDecision } from '${entry}';
const actor: ActorContext = {
 userId: 'fixture-user', authorityReference: 'fixture-context', scope: 'personal',
 lifecycle: 'active', authenticationState: 'current', emailVerified: true,
 assurance: { method: 'primary' }, staffGrant: { status: 'none' },
};
const result: IdentityResolution = { status: 'authenticated', actor };
const authority: IdentityAuthority = { async resolveActor() { return { status: 'unavailable' }; } };
const decision: IdentityAccessDecision = evaluateIdentityAccess(result, { kind: 'own-data', ownerUserId: actor.userId });
void authority; void decision;
`;
  try {
    writeFileSync(config, JSON.stringify({ compilerOptions: {
      target: 'ES2024', lib: ['ES2024'], module: 'NodeNext', moduleResolution: 'NodeNext',
      strict: true, noEmit: true, types: [], skipLibCheck: false,
      noUncheckedIndexedAccess: true, exactOptionalPropertyTypes: true,
    }, files: [source] }));
    writeFileSync(source, valid);
    const run = () => execFileSync(process.execPath, [compiler, '-p', config], {
      encoding: 'utf8', timeout: 15000, stdio: ['ignore', 'pipe', 'pipe'],
    });
    assert.equal(run(), '');
    writeFileSync(source, valid + `
actor.userId = 'fixture-other';
const invalidScope: ActorContext = { ...actor, scope: 'admin' };
const invalidResult: IdentityResolution = { status: 'anonymous' };
const invalidAssurance: ActorAssurance = { method: 'totp', freshness: 'recent' };
const invalidAuthority: IdentityAuthority = { async resolveActor() { return 'allowed'; } };
void invalidScope; void invalidResult; void invalidAssurance; void invalidAuthority;
`);
    assert.throws(run, (error) => error.status !== 0 && /TS2322/.test(error.stdout)
      && /TS2540/.test(error.stdout) && !/TS2307/.test(error.stdout));
  } finally {
    rmSync(root, { recursive: true, force: true });
  }
});
