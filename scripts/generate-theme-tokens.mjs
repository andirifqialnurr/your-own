import assert from 'node:assert/strict';
import { mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const tokens = JSON.parse(readFileSync(path.join(root, 'design/tokens.json'), 'utf8'));
const output = path.join(root, 'apps/mobile/lib/shared_ui/theme/app_tokens.g.dart');
const names = Object.keys(tokens.colors.light);
assert.deepEqual(Object.keys(tokens.colors.dark), names);
assert.match(tokens.fontFamily, /^[A-Za-z ]+$/);
for (const name of [...names, ...Object.keys(tokens.geometry), ...Object.keys(tokens.typography)]) assert.match(name, /^[a-z][A-Za-z0-9]*$/);
for (const palette of Object.values(tokens.colors)) for (const color of Object.values(palette)) assert.match(color, /^#[A-F0-9]{6}$/);
for (const value of Object.values(tokens.geometry)) assert.ok(Number.isInteger(value) && value > 0);
for (const [size, height, weight] of Object.values(tokens.typography)) assert.ok(size > 0 && height >= size && [400, 500, 600, 700].includes(weight));

function lerpField(name) {
  const line = `      ${name}: Color.lerp(${name}, other.${name}, t)!,`;
  return line.length <= 80 ? line : `      ${name}: Color.lerp(\n        ${name},\n        other.${name},\n        t,\n      )!,`;
}

const text = `// GENERATED from design/tokens.json. Run pnpm tokens:generate; do not edit.\nimport 'package:flutter/material.dart';\n\nabstract final class AppTokens {\n  static const fontFamily = '${tokens.fontFamily}';\n${Object.entries(tokens.geometry).map(([key, value]) => `  static const double ${key} = ${value};`).join('\n')}\n\n  static const textTheme = TextTheme(\n${Object.entries(tokens.typography).map(([key, [size, height, weight]]) => `    ${key}: TextStyle(\n      fontFamily: fontFamily,\n      fontSize: ${size},\n      height: ${height} / ${size},\n      fontWeight: FontWeight.w${weight},\n      letterSpacing: 0,\n      fontVariations: [FontVariation('wght', ${weight}), FontVariation('opsz', ${Math.min(40, Math.max(9, size))})],\n    ),`).join('\n')}\n  );\n}\n\n@immutable\nclass AppColors extends ThemeExtension<AppColors> {\n  const AppColors({\n${names.map(name => `    required this.${name},`).join('\n')}\n  });\n\n${names.map(name => `  final Color ${name};`).join('\n')}\n\n${Object.entries(tokens.colors).map(([mode, colors]) => `  static const ${mode} = AppColors(\n${names.map(name => `    ${name}: Color(0xFF${colors[name].slice(1)}),`).join('\n')}\n  );`).join('\n\n')}\n\n  static AppColors of(BuildContext context) =>\n      Theme.of(context).extension<AppColors>()!;\n\n  @override\n  AppColors copyWith({\n${names.map(name => `    Color? ${name},`).join('\n')}\n  }) => AppColors(\n${names.map(name => `    ${name}: ${name} ?? this.${name},`).join('\n')}\n  );\n\n  @override\n  AppColors lerp(covariant AppColors? other, double t) {\n    if (other == null) return this;\n    return AppColors(\n${names.map(lerpField).join('\n')}\n    );\n  }\n}\n`;
const args = process.argv.slice(2);
assert.ok(args.length === 0 || (args.length === 1 && args[0] === '--check'), 'Use --check or no arguments');
if (args[0] === '--check') {
  assert.equal(readFileSync(output, 'utf8').replaceAll('\r\n', '\n'), text, 'Regenerate Flutter tokens from the JSON source');
  console.info('Generated Flutter tokens match design/tokens.json.');
} else {
  mkdirSync(path.dirname(output), { recursive: true });
  writeFileSync(output, text);
  console.info('Generated apps/mobile/lib/shared_ui/theme/app_tokens.g.dart');
}
