import assert from 'node:assert/strict';
import { execFileSync } from 'node:child_process';
import { mkdirSync, mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import test from 'node:test';
import { dartImports, typescriptImports } from './imports.mjs';
import { edgeViolation, sourceViolation } from './policy.mjs';

const apiPackages = new Set(['@nestjs/common', 'reflect-metadata']);
const check = (language, source, dependency) => edgeViolation(language, source, dependency, apiPackages);

const allowed = [
  ['api', 'app.module.ts', './health/health.module.js'],
  ['api', 'app.module.ts', './modules/money/money.http.module.js'],
  ['api', 'worker.module.ts', './modules/money/money.module.js'],
  ['api', 'health/health.module.ts', './health.controller.js'],
  ['api', 'health/health.controller.ts', '@nestjs/common'],
  ['api', 'main.ts', 'node:http'],
  ['api', 'modules/money/domain/amount.ts', './currency.js'],
  ['api', 'modules/money/domain/amount.ts', '../../../common/domain/id.js'],
  ['api', 'modules/progress/application/query.ts', '../../money/index.js'],
  ['api', 'modules/progress/progress.module.ts', '../money/money.module.js'],
  ['api', 'modules/money/index.ts', './domain/amount.js'],
  ['api', 'modules/money/infrastructure/store.ts', '../domain/repository.js'],
  ['mobile', 'app/app.dart', '../features/setup/presentation/setup_screen.dart'],
  ['mobile', 'features/setup/presentation/setup_screen.dart', 'package:flutter/material.dart'],
  ['mobile', 'features/setup/presentation/setup_screen.dart', '../../../l10n/generated/app_localizations.dart'],
  ['mobile', 'features/money/domain/amount.dart', 'dart:math'],
  ['mobile', 'features/money/domain/amount.dart', 'package:your_own/core/domain/id.dart'],
  ['mobile', 'features/money/domain/amount.dart', './currency.dart'],
  ['mobile', 'features/progress/presentation/today.dart', '../../money/public.dart'],
  ['mobile', 'features/money/public.dart', 'domain/amount.dart'],
  ['mobile', 'features/money/data/store.dart', '../domain/repository.dart'],
  ['mobile', 'core/network/client.dart', 'dart:io'],
  ['mobile', 'shared_ui/icons/app_icon.dart', 'package:hugeicons/hugeicons.dart'],
  ['mobile', 'app/router/app_router.dart', 'package:go_router/go_router.dart'],
  ['mobile', 'app/bootstrap.dart', '../core/preferences/shared_preferences_appearance_store.dart'],
  ['mobile', 'core/preferences/shared_preferences_appearance_store.dart', 'package:shared_preferences/shared_preferences.dart'],
  ['mobile', 'features/setup/presentation/setup_screen.dart', '../../../core/domain/appearance_preference.dart'],
  ['mobile', 'features/setup/presentation/setup_screen.dart', '../../../shared_ui/theme/app_tokens.g.dart'],
];
for (const row of allowed) test(`allows ${row.join(' -> ')}`, () => assert.equal(check(...row), null));

const rejected = [
  ['api', 'app.module.ts', './health/health.controller.js'],
  ['api', 'worker.module.ts', './modules/money/money.http.module.js'],
  ['api', 'modules/money/domain/amount.ts', '@nestjs/common'],
  ['api', 'modules/money/domain/amount.ts', 'node:http'],
  ['api', 'modules/money/domain/amount.ts', '../infrastructure/store.js'],
  ['api', 'modules/money/domain/amount.ts', '../../../config/environment.js'],
  ['api', 'modules/money/domain/amount.ts', '../../read/domain/book.js'],
  ['api', 'modules/money/index.ts', './infrastructure/store.js'],
  ['api', 'modules/money/application/post.ts', '../transport/dto.js'],
  ['api', 'modules/money/application/post.ts', '../../../infrastructure/database/client.js'],
  ['api', 'modules/money/transport/http/controller.ts', '../../infrastructure/store.js'],
  ['api', 'modules/progress/application/query.ts', '../../money/application/query.js'],
  ['api', 'modules/money/domain/amount.ts', '../../../../mobile/lib/main.dart'],
  ['api', 'modules/money/application/query.ts', '@/modules/money/domain/amount'],
  ['api', 'common/domain/id.ts', '@nestjs/common'],
  ['api', 'common/format.ts', '../modules/money/index.js'],
  ['api', 'modules/money/application/query.ts', '../../../app.module.js'],
  ['mobile', 'features/money/domain/amount.dart', 'package:flutter/widgets.dart'],
  ['mobile', 'features/money/domain/amount.dart', 'dart:io'],
  ['mobile', 'features/money/domain/amount.dart', '../data/store.dart'],
  ['mobile', 'features/money/domain/amount.dart', 'package:your_own/features/read/domain/book.dart'],
  ['mobile', 'features/money/domain/amount.dart', 'package:your_own/../outside.dart'],
  ['mobile', 'features/money/public.dart', 'presentation/screen.dart'],
  ['mobile', 'features/money/presentation/screen.dart', '../data/store.dart'],
  ['mobile', 'features/money/presentation/screen.dart', 'dart:io'],
  ['mobile', 'features/money/presentation/screen.dart', 'package:dio/dio.dart'],
  ['mobile', 'features/money/presentation/screen.dart', 'package:drift/drift.dart'],
  ['mobile', 'features/money/presentation/screen.dart', 'package:your_own/core/network/client.dart'],
  ['mobile', 'features/money/presentation/screen.dart', 'package:your_own/Core/Network/client.dart'],
  ['mobile', 'features/progress/presentation/screen.dart', '../../money/presentation/screen.dart'],
  ['mobile', 'features/progress/presentation/screen.dart', 'package:your_own/features/money/data/store.dart'],
  ['mobile', 'features/money/data/store.dart', '../presentation/screen.dart'],
  ['mobile', 'features/money/presentation/screen.dart', '../../../app/bootstrap.dart'],
  ['mobile', 'shared_ui/button.dart', '../features/money/public.dart'],
  ['mobile', 'shared_ui/button.dart', '../core/network/client.dart'],
  ['mobile', 'shared_ui/button.dart', '../app/bootstrap.dart'],
  ['mobile', 'features/money/presentation/screen.dart', '../../../core/client.dart'],
  ['mobile', 'features/money/presentation/screen.dart', '../%64ata/store.dart'],
  ['mobile', 'features/money/domain/amount.dart', './unscanned.txt'],
  ['api', 'modules/money/domain/amount.ts', './unscanned.json'],
  ['mobile', 'core/domain/id.dart', 'package:flutter/foundation.dart'],
  ['mobile', 'core/domain/appearance_preference.dart', 'package:shared_preferences/shared_preferences.dart'],
  ['mobile', 'features/setup/presentation/setup_screen.dart', 'package:shared_preferences/shared_preferences.dart'],
  ['mobile', 'shared_ui/theme/app_theme.dart', 'package:shared_preferences/shared_preferences.dart'],
  ['mobile', 'features/setup/presentation/setup_screen.dart', '../../../core/preferences/shared_preferences_appearance_store.dart'],
  ['mobile', 'features/setup/presentation/setup_screen.dart', 'package:hugeicons/hugeicons.dart'],
  ['mobile', 'shared_ui/theme/app_theme.dart', 'package:hugeicons/hugeicons.dart'],
  ['mobile', 'core/domain/appearance_preference.dart', 'package:hugeicons/hugeicons.dart'],
  ['mobile', 'features/setup/presentation/setup_screen.dart', 'package:go_router/go_router.dart'],
  ['mobile', 'shared_ui/layout/layout_policy.dart', 'package:go_router/go_router.dart'],
  ['mobile', 'core/domain/appearance_preference.dart', 'package:go_router/go_router.dart'],
  ['mobile', 'main.dart', 'file:///other/app.dart'],
  ['mobile', 'main.dart', '/other/app.dart'],
];
for (const row of rejected) test(`rejects ${row.join(' -> ')}`, () => assert.ok(check(...row)));

test('rejects platform-specific source trees and misplaced features', () => {
  for (const language of ['api', 'mobile']) {
    for (const file of ['android/app.dart', 'ios/app.dart', 'tablet/main.dart', '../other/app.dart', 'money/file.ts']) {
      assert.ok(sourceViolation(language, file));
    }
  }
  assert.ok(sourceViolation('api', 'modules/money/domains/amount.ts'));
  assert.ok(sourceViolation('mobile', 'features/money/widgets/view.dart'));
  assert.equal(sourceViolation('api', 'modules/money/domain/amount.ts'), null);
  assert.equal(sourceViolation('mobile', 'features/setup/presentation/setup_screen.dart'), null);
});

test('TypeScript reads static, type-only, re-export, import type, dynamic and require dependencies', () => {
  assert.deepEqual(typescriptImports(`
    // import 'not-a-dependency';
    import type { A } from './a.js';
    import 'reflect-metadata';
    export { A } from './b.js';
    export type * from './c.js';
    type B = import('./d.js').B;
    void import('./e.js');
    const f = require('./f.js');
    const g = require.resolve('./g.js');
    import h = require('./h.js');
    const text = "import './not-real.js'";
  `), ['./a.js', 'reflect-metadata', './b.js', './c.js', './d.js', './e.js', './f.js', './g.js', './h.js']);
});

test('TypeScript rejects computed loading and malformed syntax', () => {
  for (const source of ['void import(name);', 'require(name);', 'require.resolve(name);', 'import {']) {
    assert.throws(() => typescriptImports(source));
  }
  assert.deepEqual(typescriptImports('void import(`./a.js`);'), ['./a.js']);
});

test('Dart handles nested comments, annotations, multiline and conditional imports/exports', () => {
  assert.deepEqual(dartImports(`
    /* import 'bad.dart'; /* nested */ */
    @Deprecated("synthetic annotation")
    library;
    import r'first.dart'
      if (dart.library.io) 'io.dart'
      if (dart.library.js_interop == 'true') 'web.dart' deferred as adapter;
    export
      'contract.dart' show Contract;
    part 'generated.g.dart';
    class Example { String text = "import 'not-real.dart';"; }
  `), ['first.dart', 'io.dart', 'web.dart', 'contract.dart', 'generated.g.dart']);
  assert.deepEqual(dartImports("part of 'parent.dart'; class Part {}"), ['parent.dart']);
  assert.deepEqual(dartImports("@Annotation<int>.named() import 'first.dart';"), ['first.dart']);
});

test('Dart fails closed on escaped/interpolated URIs, named parts and malformed directives', () => {
  for (const source of [
    String.raw`import 'package:\u0066lutter/widgets.dart';`,
    "import '$variable.dart';", "part of named_library;",
    "import 'missing_semicolon.dart'", "import 'unfinished", '/* unclosed',
  ]) assert.throws(() => dartImports(source), source);
});

test('every conditional branch and re-export goes through the same domain policy', () => {
  for (const dependency of dartImports("export 'amount.dart' if (dart.library.io) 'dart:io';")) {
    assert.equal(Boolean(check('mobile', 'features/money/domain/value.dart', dependency)), dependency === 'dart:io');
  }
  for (const dependency of typescriptImports("export type { A } from '@nestjs/common';")) {
    assert.ok(check('api', 'modules/money/index.ts', dependency));
  }
});

test('real CLI passes owned fixtures, rejects bad imports/aliases and returns nonzero', () => {
  const root = mkdtempSync(path.join(tmpdir(), 'your-own-boundary-test-'));
  const script = fileURLToPath(new URL('../check-boundaries.mjs', import.meta.url));
  const write = (name, text) => {
    const file = path.join(root, name);
    mkdirSync(path.dirname(file), { recursive: true });
    writeFileSync(file, text);
  };
  const run = () => execFileSync(process.execPath, [script, '--root', root], { encoding: 'utf8', timeout: 15000, stdio: ['ignore', 'pipe', 'pipe'] });
  try {
    write('apps/api/package.json', JSON.stringify({ dependencies: { '@nestjs/common': '12.2.0' } }));
    write('apps/api/tsconfig.json', JSON.stringify({ compilerOptions: {} }));
    write('apps/api/src/common/domain/value.ts', 'export type Value = number;');
    write('apps/mobile/lib/main.dart', 'void main() {}');
    assert.match(run(), /2 source files, 0 dependency directives/);
    write('apps/api/src/common/domain/value.ts', "import { Injectable } from '@nestjs/common';");
    assert.throws(run, (error) => error.status === 1 && /domain\/contracts cannot depend/.test(error.stderr));
    write('apps/api/src/common/domain/value.ts', 'export type Value = number;');
    write('apps/mobile/lib/features/money/presentation/view.dart', "import '../data/store.dart';");
    assert.throws(run, (error) => error.status === 1 && /presentation must receive/.test(error.stderr));
    write('apps/api/tsconfig.json', JSON.stringify({ compilerOptions: { paths: { '@/*': ['src/*'] } } }));
    assert.throws(run, (error) => error.status === 1 && /aliases\/import maps/.test(error.stderr));
  } finally {
    rmSync(root, { recursive: true, force: true });
  }
});
