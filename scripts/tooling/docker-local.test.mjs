import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import test from 'node:test';
import { assertContainer, assertImage, assertLocalContext, assertVolume, createArguments, dockerEnvironment, localDocker, manageDocker } from './docker-local.mjs';

const secret = 'a'.repeat(64);
function image() { return { Id: localDocker.imageIds[0], Os: 'linux', Architecture: 'amd64', RepoDigests: [localDocker.image] }; }
function volume() { return { Name: localDocker.volume, Driver: 'local', Labels: { [localDocker.label]: localDocker.owner }, Options: null }; }
function container(running = false) {
  const args = createArguments();
  return {
    Id: 'owned-container-id', Name: '/' + localDocker.name, Image: localDocker.imageIds[0],
    State: { Running: running },
    Config: { Labels: { [localDocker.label]: localDocker.owner }, Image: localDocker.image, User: '999:999',
      Entrypoint: ['docker-entrypoint.sh'], Cmd: args.slice(args.indexOf(localDocker.image) + 1),
      Env: ['POSTGRES_HOST_AUTH_METHOD=scram-sha-256', 'POSTGRES_DB=your_own_local', 'POSTGRES_USER=postgres', 'POSTGRES_PASSWORD=' + secret] },
    HostConfig: { ReadonlyRootfs: true, Privileged: false, NanoCpus: 2_000_000_000, Memory: 1024 ** 3,
      MemorySwap: 1024 ** 3, PidsLimit: 128, RestartPolicy: { Name: 'no' }, CapDrop: ['ALL'],
      SecurityOpt: ['no-new-privileges:true'], NetworkMode: 'default', LogConfig: { Type: 'local', Config: { 'max-size': '1m', 'max-file': '1' } },
      Tmpfs: { '/tmp': 'rw,nosuid,nodev,size=32m,mode=1777', '/var/run/postgresql': 'rw,nosuid,nodev,size=16m,uid=999,gid=999,mode=0775' },
      PortBindings: { '5432/tcp': [{ HostIp: '127.0.0.1', HostPort: '' }] } },
    Mounts: [{ Type: 'volume', Name: localDocker.volume, Destination: '/var/lib/postgresql', RW: true }],
    NetworkSettings: { Ports: { '5432/tcp': [{ HostIp: '127.0.0.1', HostPort: '54329' }] } },
  };
}
function fake(options = {}) {
  const state = { c: options.c ?? null, v: options.v ?? null, calls: [], lines: [], engine: options.engine ?? true, readiness: options.readiness ?? true };
  const run = (args, extra = {}) => {
    state.calls.push({ args, extra });
    const ok = out => ({ ok: true, out: typeof out === 'string' ? out : JSON.stringify(out) });
    if (args[0] === 'context') return ok(JSON.stringify(options.endpoint ?? 'npipe:////./pipe/dockerDesktopLinuxEngine'));
    if (args[0] === 'info') return state.engine ? ok('linux') : { ok: false, out: '' };
    if (args[0] === 'desktop') { state.engine = options.desktopWorks ?? true; return { ok: state.engine, out: '' }; }
    if (args[0] === 'image') return options.imageMissing ? { ok: false, out: '' } : ok([image()]);
    if (args[0] === 'container' && args[1] === 'ls') return ok(state.c ? state.c.Id : '');
    if (args[0] === 'container' && args[1] === 'inspect') return ok([state.c]);
    if (args[0] === 'volume' && args[1] === 'ls') return ok(state.v ? state.v.Name : '');
    if (args[0] === 'volume' && args[1] === 'inspect') return ok([state.v]);
    if (args[0] === 'volume' && args[1] === 'create') { state.v = volume(); return ok(state.v.Name); }
    if (args[0] === 'create') { assert.equal(extra.secret, secret); assert.ok(!args.includes(secret)); state.c = container(); return ok(state.c.Id); }
    if (args[0] === 'start') { state.c.State.Running = true; return { ok: !options.uncertainStart, out: '' }; }
    if (args[0] === 'stop') { state.c.State.Running = false; return ok(state.c.Id); }
    if (args[0] === 'exec') return { ok: state.readiness, out: '' };
    throw new Error('Unexpected synthetic Docker call');
  };
  return { state, settings: { run, sleep: async () => {}, print: s => state.lines.push(s), makeSecret: () => secret,
    freeBytes: () => options.free ?? 25n * 1024n ** 3n } };
}

test('only the reviewed PostgreSQL image is accepted, not unrelated Redis/Versity', () => {
  assert.doesNotThrow(() => assertImage(image()));
  for (const change of [{ Id: 'sha256:b51665e66f00759be7c3152ad5ac3c66fb2f619c13ef62dea7cc1f9914524635' },
    { Id: 'sha256:30292fc2eeacc67a36993b01f7a7a5e3361a19cced0e80c1d71cfa2a4b0a2499' }, { Os: 'windows' }, { Architecture: 'arm64' }, { RepoDigests: [] }]) {
    assert.throws(() => assertImage({ ...image(), ...change }), /missing or mismatched/);
  }
});
test('local named pipe only, no remote endpoint or context switch', () => {
  assert.doesNotThrow(() => assertLocalContext('npipe:////./pipe/dockerDesktopLinuxEngine'));
  for (const endpoint of ['tcp://remote:2375', 'ssh://remote', 'unix:///remote.sock', 'npipe:////./pipe/other']) assert.throws(() => assertLocalContext(endpoint), /non-local/);
});
test('Docker children do not inherit owner app secrets or remote Docker overrides', () => {
  assert.deepEqual(dockerEnvironment({ PATH: 'node', SYSTEMROOT: 'windows', R2_SECRET_ACCESS_KEY: 'private', DATABASE_URL: 'private', DOCKER_HOST: 'remote', DOCKER_CONTEXT: 'remote', POSTGRES_PASSWORD: 'owner', NODE_OPTIONS: 'untrusted' }), { PATH: 'node', SYSTEMROOT: 'windows' });
});
test('creation is bounded, loopback-only, no pulls, host mounts, static password or restart daemon', () => {
  const args = createArguments();
  assert.ok(args.includes(localDocker.image) && args.includes('127.0.0.1::5432'));
  assert.deepEqual(args.slice(args.indexOf('--pull'), args.indexOf('--pull') + 2), ['--pull', 'never']);
  assert.ok(args.includes('--read-only') && args.includes('no-new-privileges:true') && args.includes('1g') && args.includes('2'));
  assert.ok(!args.includes(secret) && !args.includes('--privileged') && !args.some(a => a.includes('type=bind') || a.includes('docker.sock')));
});
test('full container and volume identity validated, independent of object key order', () => {
  assert.doesNotThrow(() => assertContainer(container()));
  assert.doesNotThrow(() => assertVolume(volume()));
  assert.throws(() => assertVolume({ ...volume(), Labels: {} }), /unrelated/);
  assert.throws(() => assertVolume({ ...volume(), Options: { device: '/host' } }), /unrelated/);
  const c = container(); c.Config.Labels = {};
  assert.throws(() => assertContainer(c), /unrelated/);
});
test('unsafe resource, network, mount and command drift is refused rather than repaired', () => {
  for (const mutate of [c => { c.HostConfig.Privileged = true; }, c => { c.HostConfig.ReadonlyRootfs = false; },
    c => { c.HostConfig.Memory = 0; }, c => { c.HostConfig.NetworkMode = 'host'; },
    c => { c.HostConfig.PortBindings['5432/tcp'][0].HostIp = '0.0.0.0'; }, c => { c.Mounts.push({ Type: 'bind' }); },
    c => { c.Config.Cmd = ['postgres']; }, c => { c.HostConfig.Tmpfs = {}; }]) {
    const c = container(); mutate(c); assert.throws(() => assertContainer(c), /safety configuration/);
  }
});
test('first start creates only dedicated labeled data/container and readiness, not app schema', async () => {
  const { state, settings } = fake(); await manageDocker('start', settings);
  assert.equal(state.c.State.Running, true);
  assert.equal(state.v.Name, localDocker.volume);
  assert.ok(state.calls.some(c => c.args[0] === 'create') && state.calls.some(c => c.args[0] === 'exec'));
  assert.ok(state.lines.some(line => line.includes('127.0.0.1:54329')) && state.lines.every(line => !line.includes(secret)));
});
test('running start is idempotent and restart preserves existing data volume/password', async () => {
  const { state, settings } = fake({ c: container(true), v: volume() }); await manageDocker('start', settings);
  assert.ok(!state.calls.some(c => ['create', 'start'].includes(c.args[0])));
  state.c.State.Running = false; await manageDocker('start', settings);
  assert.equal(state.c.State.Running, true);
  assert.equal(state.calls.filter(c => c.args[0] === 'start').length, 1);
  assert.ok(!state.calls.some(c => c.args[0] === 'create' || c.args.includes('rm') || c.args.includes('prune')));
});
test('stop is idempotent, preserves data/image, never stops other services or Docker Desktop', async () => {
  const { state, settings } = fake({ c: container(true), v: volume() }); await manageDocker('stop', settings); await manageDocker('stop', settings);
  assert.equal(state.c.State.Running, false);
  assert.equal(state.calls.filter(c => c.args[0] === 'stop').length, 1);
  assert.ok(!state.calls.some(c => c.args.includes('rm') || c.args.includes('prune') || c.args[0] === 'desktop'));
  assert.ok(state.calls.filter(c => c.args[0] === 'stop').every(c => c.args.at(-1) === 'owned-container-id'));
});
test('absent stop does not create or remove anything', async () => {
  const { state, settings } = fake(); await manageDocker('stop', settings);
  assert.ok(!state.calls.some(c => ['create', 'start', 'stop', 'volume'].includes(c.args[0])));
});
test('remote context, low space, missing image and foreign volume fail before mutation', async () => {
  for (const [options, marker] of [[{ endpoint: 'tcp://remote:2375' }, /non-local/], [{ free: 19n * 1024n ** 3n }, /20 GiB/],
    [{ imageMissing: true }, /not cached/], [{ v: { ...volume(), Labels: {} } }, /unrelated.*volume/]]) {
    const { state, settings } = fake(options); await assert.rejects(manageDocker('start', settings), marker);
    assert.ok(!state.calls.some(c => ['create', 'start', 'stop'].includes(c.args[0])));
  }
});
test('same-name foreign or drifted container is never started or stopped', async () => {
  const c = container(true); c.Config.Image = 'redis:8.2-alpine';
  for (const action of ['start', 'stop']) {
    const { state, settings } = fake({ c, v: volume() }); await assert.rejects(manageDocker(action, settings), /unrelated/);
    assert.ok(!state.calls.some(c => ['create', 'start', 'stop'].includes(c.args[0])));
  }
});
test('an existing container with missing storage is not silently reset', async () => {
  const { state, settings } = fake({ c: container() }); await assert.rejects(manageDocker('start', settings), /volume is missing/);
  assert.ok(!state.calls.some(c => c.args[0] === 'create' || c.args[0] === 'volume' && c.args[1] === 'create'));
});
test('start may open existing Desktop, stop never starts an unavailable engine', async () => {
  const a = fake({ engine: false }); await manageDocker('start', a.settings);
  assert.ok(a.state.calls.some(c => c.args[0] === 'desktop'));
  const b = fake({ engine: false }); await assert.rejects(manageDocker('stop', b.settings), /unavailable/);
  assert.ok(!b.state.calls.some(c => c.args[0] === 'desktop'));
});
test('readiness failure and uncertain start stop only the started owned container, preserving data', async () => {
  for (const options of [{ readiness: false }, { uncertainStart: true }]) {
    const { state, settings } = fake(options); await assert.rejects(manageDocker('start', settings));
    assert.equal(state.c.State.Running, false);
    assert.equal(state.v.Name, localDocker.volume);
    assert.ok(!state.calls.some(c => c.args.includes('rm') || c.args.includes('prune')));
  }
});
test('invalid action performs no Docker operation and wrappers use their own directory', async () => {
  const { state, settings } = fake(); await assert.rejects(manageDocker('reset', settings), /Usage/); assert.equal(state.calls.length, 0);
  for (const action of ['start', 'stop']) {
    const source = readFileSync(new URL(`../../docker-${action}.cmd`, import.meta.url), 'utf8');
    assert.ok(source.includes('"%~dp0scripts\\docker-local.mjs" ' + action));
    assert.ok(source.includes('exit /b %errorlevel%') && source.includes('DisableDelayedExpansion'));
    assert.ok(!/down|prune|--force|\.env/i.test(source));
  }
});
