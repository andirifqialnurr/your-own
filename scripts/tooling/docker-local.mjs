import { spawnSync } from 'node:child_process';
import { randomBytes } from 'node:crypto';
import { statfsSync } from 'node:fs';
import { setTimeout as delay } from 'node:timers/promises';

export const localDocker = Object.freeze({
  context: 'desktop-linux',
  name: 'your-own-local-postgres',
  volume: 'your-own-local-postgres-data',
  label: 'dev.your-own.local-helper',
  owner: 'postgres-18.6-v1',
  image: 'postgres@sha256:6b38fe68f2c02cafffbbce7496f76d110d8a947c039bd22c067e9a43c2250240',
  imageIds: [
    'sha256:6b38fe68f2c02cafffbbce7496f76d110d8a947c039bd22c067e9a43c2250240',
    'sha256:63d4ad6f3de5e288238b3044970a677dcb0e77004d8b6050732aa0cbbeedf5d7',
  ],
});
const tmpfs = {
  '/var/run/postgresql': 'rw,nosuid,nodev,size=16m,uid=999,gid=999,mode=0775',
  '/tmp': 'rw,nosuid,nodev,size=32m,mode=1777',
};
const postgresArgs = ['postgres', '-c', 'shared_buffers=32MB', '-c', 'max_connections=40',
  '-c', 'max_wal_size=64MB', '-c', 'min_wal_size=32MB', '-c', 'temp_file_limit=65536', '-c', 'log_statement=none'];
const readyArgs = ['pg_isready', '--host', '127.0.0.1', '--username', 'postgres', '--dbname', 'your_own_local'];
function requireSafe(condition, message) {
  if (!condition) throw new Error(message);
}
function canonical(value) {
  if (Array.isArray(value)) return value.map(canonical);
  if (value && typeof value === 'object') return Object.fromEntries(Object.keys(value).sort().map(key => [key, canonical(value[key])]));
  return value;
}
function same(a, b) { return JSON.stringify(canonical(a)) === JSON.stringify(canonical(b)); }
export function dockerEnvironment(source = process.env) {
  const allowed = /^(PATH|PATHEXT|SYSTEMROOT|WINDIR|COMSPEC|SYSTEMDRIVE|PROGRAMFILES|PROGRAMFILES\(X86\)|PROGRAMDATA|USERPROFILE|APPDATA|LOCALAPPDATA|TEMP|TMP)$/i;
  return Object.fromEntries(Object.entries(source).filter(([name]) => allowed.test(name)));
}
export function dockerCommand(args, { secret, timeout = 15000 } = {}) {
  const env = dockerEnvironment();
  if (secret) env.POSTGRES_PASSWORD = secret;
  const result = spawnSync('docker.exe', ['--context', localDocker.context, ...args], {
    env, encoding: 'utf8', timeout, maxBuffer: 512 * 1024, windowsHide: true,
  });
  // Do not serialize process errors/stdout/stderr/inspect Env into ordinary logs.
  return { ok: !result.error && result.status === 0, out: result.stdout ?? '' };
}
function parseOne(result, message) {
  requireSafe(result.ok, message);
  let rows;
  try { rows = JSON.parse(result.out); } catch { throw new Error(message); }
  requireSafe(Array.isArray(rows) && rows.length === 1, message);
  return rows[0];
}
export function assertLocalContext(endpoint) {
  requireSafe(/^npipe:\/+\.\/pipe\/(dockerDesktopLinuxEngine|docker_engine)$/i.test(endpoint),
    'Refusing a non-local Docker context. Use the existing Docker Desktop Linux engine.');
}
export function assertImage(image) {
  requireSafe(localDocker.imageIds.includes(image?.Id) && image.Os === 'linux' && image.Architecture === 'amd64'
    && image.RepoDigests?.includes(localDocker.image), 'Reviewed PostgreSQL image is missing or mismatched; no image will be pulled.');
}
export function assertVolume(volume) {
  requireSafe(volume?.Name === localDocker.volume && volume.Driver === 'local'
    && volume.Labels?.[localDocker.label] === localDocker.owner
    && Object.keys(volume.Options ?? {}).length === 0,
  'Refusing an unrelated or incompatible volume with the reserved name.');
}
export function assertContainer(container) {
  const c = container?.Config, h = container?.HostConfig;
  requireSafe(container?.Name === '/' + localDocker.name && c?.Labels?.[localDocker.label] === localDocker.owner
    && c.Image === localDocker.image && localDocker.imageIds.includes(container.Image),
  'Refusing an unrelated container or image with the reserved name.');
  const mounts = container.Mounts ?? [], binding = h?.PortBindings?.['5432/tcp'];
  requireSafe(c.User === '999:999' && same(c.Cmd, postgresArgs) && same(c.Entrypoint, ['docker-entrypoint.sh'])
    && h.ReadonlyRootfs && !h.Privileged && h.NanoCpus === 2_000_000_000 && h.Memory === 1024 ** 3
    && h.MemorySwap === 1024 ** 3 && h.PidsLimit === 128 && h.RestartPolicy?.Name === 'no'
    && h.CapDrop?.includes('ALL') && h.SecurityOpt?.includes('no-new-privileges:true')
    && ['default', 'bridge'].includes(h.NetworkMode)
    && h.LogConfig?.Type === 'local' && h.LogConfig.Config?.['max-size'] === '1m' && h.LogConfig.Config?.['max-file'] === '1'
    && same(h.Tmpfs, tmpfs) && Object.keys(h.PortBindings ?? {}).length === 1
    && binding?.length === 1 && binding[0].HostIp === '127.0.0.1'
    && mounts.length === 1 && mounts[0].Type === 'volume' && mounts[0].Name === localDocker.volume
    && mounts[0].Destination === '/var/lib/postgresql' && mounts[0].RW === true
    && c.Env?.includes('POSTGRES_HOST_AUTH_METHOD=scram-sha-256')
    && c.Env.includes('POSTGRES_DB=your_own_local') && c.Env.includes('POSTGRES_USER=postgres')
    && c.Env.some(value => /^POSTGRES_PASSWORD=[a-f0-9]{64}$/.test(value)),
  'Refusing a container whose local safety configuration has changed.');
}
export function createArguments() {
  return ['create', '--pull', 'never', '--name', localDocker.name, '--label', `${localDocker.label}=${localDocker.owner}`,
    '--platform', 'linux/amd64', '--user', '999:999', '--read-only', '--cap-drop', 'ALL',
    '--security-opt', 'no-new-privileges:true', '--pids-limit', '128', '--cpus', '2', '--memory', '1g', '--memory-swap', '1g',
    '--restart', 'no', '--log-driver', 'local', '--log-opt', 'max-size=1m', '--log-opt', 'max-file=1',
    '--mount', `type=volume,src=${localDocker.volume},dst=/var/lib/postgresql`,
    ...Object.entries(tmpfs).flatMap(([target, flags]) => ['--tmpfs', `${target}:${flags}`]),
    '--env', 'POSTGRES_PASSWORD', '--env', 'POSTGRES_HOST_AUTH_METHOD=scram-sha-256',
    '--env', 'POSTGRES_DB=your_own_local', '--env', 'POSTGRES_USER=postgres',
    '--publish', '127.0.0.1::5432', localDocker.image, ...postgresArgs];
}
export async function manageDocker(action, {
  run = dockerCommand,
  freeBytes = () => { const fs = statfsSync('C:/', { bigint: true }); return fs.bavail * fs.bsize; },
  sleep = delay, print = console.info, makeSecret = () => randomBytes(32).toString('hex'),
} = {}) {
  requireSafe(['start', 'stop'].includes(action), 'Usage: docker-start.cmd or docker-stop.cmd (no arguments).');
  if (action === 'start') requireSafe(BigInt(freeBytes()) >= 20n * 1024n ** 3n,
    'Keep at least 20 GiB free on C: before starting the local database.');
  const context = run(['context', 'inspect', localDocker.context, '--format', '{{json .Endpoints.docker.Host}}']);
  requireSafe(context.ok, 'Docker Desktop context is unavailable. Install/configure Docker separately; nothing was changed.');
  let endpoint;
  try { endpoint = JSON.parse(context.out); } catch { throw new Error('Cannot verify the local Docker endpoint.'); }
  assertLocalContext(endpoint);
  const engineReady = () => {
    const result = run(['info', '--format', '{{.OSType}}']);
    return result.ok && result.out.trim() === 'linux';
  };
  if (!engineReady()) {
    requireSafe(action === 'start', 'Docker engine is unavailable; cannot verify or stop the sandbox.');
    print('Starting the existing Docker Desktop installation...');
    requireSafe(run(['desktop', 'start'], { timeout: 60000 }).ok, 'Open Docker Desktop, then rerun docker-start.cmd. No service was created.');
    let available = false;
    for (let n = 0; n < 30; n++) {
      if (engineReady()) { available = true; break; }
      await sleep(1000);
    }
    requireSafe(available, 'Docker Desktop did not become ready within 30 checks. Retry after it is ready.');
  }
  const findContainer = () => {
    const listed = run(['container', 'ls', '-a', '--filter', `name=^/${localDocker.name}$`, '--format', '{{.ID}}']);
    requireSafe(listed.ok, 'Cannot list the dedicated container.');
    if (!listed.out.trim()) return null;
    const c = parseOne(run(['container', 'inspect', localDocker.name]), 'Cannot inspect the dedicated container.');
    assertContainer(c);
    return c;
  };
  let container = findContainer();
  if (action === 'stop' && !container) {
    print('Your Own PostgreSQL is already absent. Other containers were not touched.');
    return;
  }
  if (action === 'start') {
    assertImage(parseOne(run(['image', 'inspect', localDocker.image]), 'Reviewed PostgreSQL image is not cached. No pull was attempted.'));
  }
  const volumes = run(['volume', 'ls', '--format', '{{.Name}}']);
  requireSafe(volumes.ok, 'Cannot verify the dedicated data volume.');
  if (!volumes.out.split(/\r?\n/).includes(localDocker.volume)) {
    requireSafe(action === 'start' && !container, 'The expected data volume is missing; refusing to recreate it for an existing container.');
    requireSafe(run(['volume', 'create', '--driver', 'local', '--label', `${localDocker.label}=${localDocker.owner}`, localDocker.volume]).ok,
      'Could not create the dedicated data volume.');
  }
  assertVolume(parseOne(run(['volume', 'inspect', localDocker.volume]), 'Cannot inspect the dedicated data volume.'));
  if (action === 'stop') {
    if (container.State?.Running) {
      requireSafe(run(['stop', '--time', '15', container.Id], { timeout: 30000 }).ok, 'Could not stop the owned sandbox. No data was deleted.');
      requireSafe(!findContainer()?.State?.Running, 'The sandbox is still running.');
    }
    print('Your Own PostgreSQL is stopped. Container and data volume are preserved.');
    return;
  }
  if (!container) {
    requireSafe(run(createArguments(), { secret: makeSecret(), timeout: 30000 }).ok,
      'Could not create the sandbox. Its data volume was not deleted; no image pull was attempted.');
    container = findContainer();
    requireSafe(container, 'Created sandbox could not be verified.');
  }
  let started = false;
  try {
    if (!container.State?.Running) {
      started = true;
      requireSafe(run(['start', container.Id], { timeout: 30000 }).ok, 'Could not start the owned sandbox.');
    }
    let ready = false;
    for (let n = 0; n < 30; n++) {
      if (run(['exec', container.Id, ...readyArgs], { timeout: 5000 }).ok) { ready = true; break; }
      await sleep(500);
    }
    requireSafe(ready, 'PostgreSQL did not become ready within 30 checks. Container/data are preserved.');
    const actual = findContainer(), ports = actual?.NetworkSettings?.Ports?.['5432/tcp'];
    requireSafe(actual?.State?.Running && ports?.length === 1 && ports[0].HostIp === '127.0.0.1'
      && /^\d+$/.test(ports[0].HostPort), 'Cannot verify the running loopback endpoint.');
    print(`Your Own PostgreSQL is ready at 127.0.0.1:${ports[0].HostPort}.`);
    print(`Sandbox shell: docker --context ${localDocker.context} exec -it ${localDocker.name} psql -U postgres -d your_own_local`);
    print('No API configuration changed. Use docker-stop.cmd when finished; data is preserved.');
  } catch (error) {
    if (started) {
      const owned = findContainer();
      if (owned?.State?.Running) {
        requireSafe(run(['stop', '--time', '15', owned.Id], { timeout: 30000 }).ok,
          'Startup failed and cleanup could not stop the sandbox. Run docker-stop.cmd; data is preserved.');
      }
    }
    throw error;
  }
}
