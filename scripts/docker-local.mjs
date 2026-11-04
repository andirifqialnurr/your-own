import { readFileSync } from 'node:fs';
import { manageDocker } from './tooling/docker-local.mjs';

try {
  const pin = readFileSync(new URL('../.node-version', import.meta.url), 'utf8').trim();
  if (process.versions.node !== pin) throw new Error(`Use the pinned Node ${pin}; no tool upgrade was attempted.`);
  if (process.platform !== 'win32') throw new Error('These helpers support Windows Docker Desktop Linux containers only.');
  if (process.argv.length !== 3) throw new Error('Usage: docker-start.cmd or docker-stop.cmd (no arguments).');
  await manageDocker(process.argv[2]);
} catch (error) {
  console.error(error instanceof Error ? error.message : 'Local Docker helper failed. No data was deleted.');
  process.exitCode = 1;
}
