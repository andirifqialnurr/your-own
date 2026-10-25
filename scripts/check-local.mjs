import { spawnSync } from 'node:child_process';
import { readFileSync } from 'node:fs';
import path from 'node:path';
import { checkArguments, launchSpec, localPlan, protectedSnapshot, runPlan, validateVersions } from './tooling/local-checks.mjs';

const root = path.resolve(import.meta.dirname, '..');
function invoke(tool, args, cwd = '.', capture = false) {
  const launch = launchSpec(tool, args, process.platform);
  const result = spawnSync(launch.command, launch.args, {
    cwd: path.resolve(root, cwd), encoding: 'utf8',
    stdio: capture ? ['ignore', 'pipe', 'pipe'] : 'inherit',
  });
  if (result.error || result.status !== 0) throw new Error(`${tool} ${args.join(' ')} failed (${result.error?.code ?? result.signal ?? result.status}). No retry or bypass performed.`);
  return capture ? `${result.stdout}${result.stderr}` : '';
}

try {
  const { offline } = checkArguments(process.argv.slice(2));
  // Golden images were reviewed on this OS only. Other hosts need a reviewed lane,
  // not silently regenerated/tolerated pixels or a falsely reported native pass.
  if (process.platform !== 'win32') throw new Error('Full host lane is currently Windows-only (reviewed goldens). Other host/native lanes need approval and validation; pnpm check remains independently available.');
  const manifest = JSON.parse(readFileSync(path.join(root, 'package.json'), 'utf8'));
  const pins = {
    node: readFileSync(path.join(root, '.node-version'), 'utf8').trim(),
    pnpm: manifest.packageManager.replace(/^pnpm@/, ''),
    flutter: readFileSync(path.join(root, '.flutter-version'), 'utf8').trim(),
    dart: '3.10.8', // Bundled with the pinned Flutter; also check PATH's dart launcher.
  };
  if (manifest.engines.node !== pins.node || manifest.engines.pnpm !== pins.pnpm) throw new Error('Runtime pin files disagree');
  // Reject Node before asking any package manager/SDK to execute.
  if (process.version !== `v${pins.node}`) throw new Error('Node pin mismatch; no installation performed');
  const versions = {
    node: process.version,
    pnpm: invoke('pnpm', ['--version'], '.', true),
    flutter: JSON.parse(invoke('flutter', ['--version', '--machine'], '.', true)),
    dart: invoke('dart', ['--version'], '.', true),
  };
  validateVersions(versions, pins);
  console.info(`Verified local tools: Node ${pins.node}, pnpm ${pins.pnpm}, Flutter ${pins.flutter}, Dart ${pins.dart}.`);
  runPlan(localPlan(offline), step => {
    console.info(`\n== ${step.label} ==`);
    invoke(step.tool, step.args, step.cwd);
  }, () => protectedSnapshot(root));
  console.info('\nPASS: local host lane only; lock/generated contents unchanged.');
  console.info('NOT RUN: native Android/iOS/iPad builds/devices, hosted CI, approved macOS lane, signing or deployment.');
} catch (error) {
  console.error(error.message);
  process.exitCode = 1;
}
