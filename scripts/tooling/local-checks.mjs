import { createHash } from 'node:crypto';
import { lstatSync, readdirSync, readFileSync } from 'node:fs';
import path from 'node:path';

export function checkArguments(args) {
  if (args.length === 0) return { offline: false };
  if (args.length === 1 && args[0] === '--offline') return { offline: true };
  throw new Error('Usage: node scripts/check-local.mjs [--offline] (or pnpm check:local after install; no native builds)');
}

export function validateVersions({ node, pnpm, flutter, dart }, pins) {
  if (node !== `v${pins.node}` || pnpm.trim() !== pins.pnpm ||
      flutter.frameworkVersion !== pins.flutter || flutter.dartSdkVersion.split(' ')[0] !== pins.dart ||
      !dart.includes(`Dart SDK version: ${pins.dart} `)) {
    throw new Error('Tool pin mismatch; select the documented installed tools. This command never upgrades SDKs.');
  }
}

export function localPlan(offline) {
  const extra = offline ? ['--offline'] : [];
  return [
    { label: 'Frozen JavaScript install (scripts disabled)', tool: 'pnpm', args: ['install', '--frozen-lockfile', '--ignore-scripts', ...extra], cwd: '.' },
    { label: 'Root docs/lint/types/unit/API build checks', tool: 'pnpm', args: ['check'], cwd: '.' },
    { label: 'Enforced Flutter lock', tool: 'flutter', args: ['pub', 'get', '--enforce-lockfile', ...extra], cwd: 'apps/mobile' },
    { label: 'Localization generation', tool: 'flutter', args: ['gen-l10n'], cwd: 'apps/mobile' },
    { label: 'Flutter analysis', tool: 'flutter', args: ['analyze', '--no-pub'], cwd: 'apps/mobile' },
    { label: 'Dart formatting (generated localization stays generator-owned)', tool: 'dart', args: ['format', '--output=none', '--set-exit-if-changed', 'lib/app', 'lib/core', 'lib/features', 'lib/shared_ui', 'lib/main.dart', 'lib/main_development.dart', 'lib/main_staging.dart', 'lib/main_production.dart', 'test'], cwd: 'apps/mobile' },
    { label: 'Flutter unit/widget/golden comparison', tool: 'flutter', args: ['test', '--no-pub', '--reporter', 'expanded'], cwd: 'apps/mobile' },
  ];
}

export function protectedSnapshot(root) {
  const result = new Map();
  function visit(name) {
    const full = path.join(root, name);
    const stat = lstatSync(full);
    if (stat.isSymbolicLink()) throw new Error(`Protected path is a symlink: ${name}`);
    if (stat.isDirectory()) {
      result.set(`${name}/`, 'directory');
      for (const entry of readdirSync(full).sort()) visit(`${name}/${entry}`);
    } else {
      // Git checkouts may use CRLF. Detect content drift, not line-ending conversion.
      const text = readFileSync(full, 'utf8').replaceAll('\r\n', '\n');
      result.set(name, createHash('sha256').update(text).digest('hex'));
    }
  }
  for (const name of ['pnpm-lock.yaml', 'apps/mobile/pubspec.lock', 'apps/mobile/lib/l10n/generated', 'apps/mobile/lib/shared_ui/theme/app_tokens.g.dart']) visit(name);
  return result;
}

export function snapshotChanges(before, after) {
  return [...new Set([...before.keys(), ...after.keys()])].filter(name => before.get(name) !== after.get(name)).sort();
}

export function runPlan(plan, execute, snapshot) {
  const before = snapshot();
  for (const step of plan) {
    let failure;
    try { execute(step); } catch (error) { failure = error.message; }
    let changes;
    try { changes = snapshotChanges(before, snapshot()); }
    catch (error) { failure = [failure, error.message].filter(Boolean).join('\n'); changes = []; }
    if (failure || changes.length) {
      throw new Error([failure, changes.length ? `Lock/generated drift after ${step.label}: ${changes.join(', ')}. Review changes; no files were restored or discarded.` : null].filter(Boolean).join('\n'));
    }
  }
}

// Windows .cmd/.bat launchers require cmd.exe; only fixed tools and plain arguments
// from this file/the CLI are allowed, never arbitrary owner input or shell snippets.
export function launchSpec(tool, args, platform) {
  if (!['pnpm', 'flutter', 'dart'].includes(tool) || args.some(arg => !/^[a-zA-Z0-9_./:=*-]+$/.test(arg))) {
    throw new Error('Unsupported check command');
  }
  return platform === 'win32'
    ? { command: 'cmd.exe', args: ['/d', '/s', '/c', [tool, ...args].join(' ')] }
    : { command: tool, args };
}
