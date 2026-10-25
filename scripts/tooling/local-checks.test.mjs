import assert from 'node:assert/strict';
import { mkdtempSync, mkdirSync, rmSync, writeFileSync, unlinkSync } from 'node:fs';
import { tmpdir } from 'node:os';
import path from 'node:path';
import test from 'node:test';
import { checkArguments, launchSpec, localPlan, protectedSnapshot, runPlan, snapshotChanges, validateVersions } from './local-checks.mjs';

const pins = { node: '24.18.0', pnpm: '12.8.1', flutter: '3.38.9', dart: '3.10.8' };
const versions = { node: 'v24.18.0', pnpm: '12.8.1\n', flutter: { frameworkVersion: '3.38.9', dartSdkVersion: '3.10.8' }, dart: 'Dart SDK version: 3.10.8 (stable) on "windows_x64"' };

test('requires actual matching Node/pnpm/Flutter/bundled and PATH Dart versions', () => {
  assert.doesNotThrow(() => validateVersions(versions, pins));
  for (const key of ['node', 'pnpm', 'dart']) assert.throws(() => validateVersions({ ...versions, [key]: 'wrong' }, pins), /pin mismatch/);
  for (const key of ['frameworkVersion', 'dartSdkVersion']) assert.throws(() => validateVersions({ ...versions, flutter: { ...versions.flutter, [key]: 'wrong' } }, pins), /pin mismatch/);
});

test('only explicit offline flag is accepted, no bypass/update flags', () => {
  assert.deepEqual(checkArguments([]), { offline: false });
  assert.deepEqual(checkArguments(['--offline']), { offline: true });
  for (const args of [['--force'], ['--update-goldens'], ['--skip-native'], ['--offline', '--offline']]) assert.throws(() => checkArguments(args), /Usage/);
});

test('plan freezes both locks, disables lifecycle scripts and never installs/upgrades SDKs or builds native', () => {
  const plan = localPlan(true);
  assert.equal(plan.length, 7);
  assert.deepEqual(plan[0].args, ['install', '--frozen-lockfile', '--ignore-scripts', '--offline']);
  assert.deepEqual(plan[2].args, ['pub', 'get', '--enforce-lockfile', '--offline']);
  assert.equal(plan[1].tool, 'pnpm');
  assert.equal(plan[1].cwd, '.');
  assert.deepEqual(plan[6].args, ['test', '--no-pub', '--reporter', 'expanded']);
  assert.ok(plan.slice(2).every(step => step.cwd === 'apps/mobile'));
  assert.ok(localPlan(false).every(step => !step.args.includes('--offline')));
  assert.ok(plan.every(step => !step.args.some(arg => ['upgrade', 'build', '--update-goldens', '--delete-conflicting-outputs'].includes(arg))));
});

test('serial plan stops at first failure without retrying or running later steps', () => {
  const calls = [];
  const snapshot = () => new Map([['lock', 'same']]);
  assert.throws(() => runPlan(localPlan(false), step => {
    calls.push(step.label);
    if (calls.length === 2) throw new Error('synthetic failure');
  }, snapshot), /synthetic failure/);
  assert.equal(calls.length, 2);
});

test('successful steps execute in order and drift is detected even after a failed command', () => {
  const calls = [];
  runPlan(localPlan(false), step => calls.push(step.label), () => new Map());
  assert.deepEqual(calls, localPlan(false).map(step => step.label));
  let read = 0;
  assert.throws(() => runPlan(localPlan(false), () => { throw new Error('synthetic command failure'); },
    () => new Map([['lock', read++ ? 'changed' : 'old']])), error => {
    assert.match(error.message, /synthetic command failure/);
    assert.match(error.message, /Lock\/generated drift/);
    return true;
  });
});

test('snapshot comparison detects additions, removals and content changes', () => {
  assert.deepEqual(snapshotChanges(new Map([['a', 'old'], ['b', 'same'], ['c', 'removed']]), new Map([['a', 'new'], ['b', 'same'], ['d', 'added']])), ['a', 'c', 'd']);
});

test('actual protected snapshot ignores CRLF but fails generated additions and missing locks', t => {
  const root = mkdtempSync(path.join(tmpdir(), 'your-own-check-test-'));
  t.after(() => rmSync(root, { recursive: true, force: true }));
  for (const name of ['pnpm-lock.yaml', 'apps/mobile/pubspec.lock', 'apps/mobile/lib/shared_ui/theme/app_tokens.g.dart', 'apps/mobile/lib/l10n/generated/app.dart']) {
    mkdirSync(path.dirname(path.join(root, name)), { recursive: true });
    writeFileSync(path.join(root, name), 'synthetic\r\n');
  }
  const before = protectedSnapshot(root);
  writeFileSync(path.join(root, 'pnpm-lock.yaml'), 'synthetic\n');
  assert.deepEqual(snapshotChanges(before, protectedSnapshot(root)), []);
  writeFileSync(path.join(root, 'apps/mobile/lib/l10n/generated/new.dart'), 'new\n');
  assert.deepEqual(snapshotChanges(before, protectedSnapshot(root)), ['apps/mobile/lib/l10n/generated/new.dart']);
  unlinkSync(path.join(root, 'pnpm-lock.yaml'));
  assert.throws(() => protectedSnapshot(root), /ENOENT/);
});

test('platform launch uses safe fixed commands; shell metacharacters are rejected', () => {
  assert.deepEqual(launchSpec('flutter', ['--version', '--machine'], 'win32'), { command: 'cmd.exe', args: ['/d', '/s', '/c', 'flutter --version --machine'] });
  assert.deepEqual(launchSpec('pnpm', ['check'], 'linux'), { command: 'pnpm', args: ['check'] });
  for (const args of [['&&evil'], ['x y'], ['%PATH%'], ['$(evil)'], ['a\nb']]) assert.throws(() => launchSpec('pnpm', args, 'win32'), /Unsupported/);
  assert.throws(() => launchSpec('unknown', [], 'win32'), /Unsupported/);
});
