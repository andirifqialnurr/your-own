import { readdirSync, readFileSync } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

// Deliberately conservative textual guard (including comments/strings), not a
// Dart parser or proof against all implicit SDK artwork. Widget checks still
// exercise the actual navigation, dialogs and text-selection toolbar.
export function artworkViolations(source, name) {
  const issues = [];
  if (/\b(?:Icons|CupertinoIcons)\s*\.|\b(?:MaterialIcons|MaterialSymbols|CupertinoIcons)\b/.test(source)) issues.push('built-in icon family');
  if (/\b(?:BackButton|CloseButton|DrawerButton|EndDrawerButton)\s*\(/.test(source)) issues.push('implicit built-in navigation glyph');
  for (const match of source.matchAll(/\bHugeIcons\s*\.\s*(\w+)/g)) {
    if (name !== 'shared_ui/icons/app_icon.dart' || !match[1].startsWith('strokeRounded')) issues.push('vendor symbol outside the Free Stroke Rounded adapter');
  }
  return issues;
}

export function checkMobileUi(root) {
  const base = path.join(root, 'apps/mobile/lib');
  let files = 0;
  const errors = [];
  function scan(directory) {
    for (const entry of readdirSync(directory, { withFileTypes: true })) {
      const filename = path.join(directory, entry.name);
      if (entry.isSymbolicLink()) throw new Error('UI source symlinks require review');
      if (entry.isDirectory()) scan(filename);
      else if (filename.endsWith('.dart')) {
        files++;
        const relative = path.relative(base, filename).split(path.sep).join('/');
        for (const issue of artworkViolations(readFileSync(filename, 'utf8'), relative)) errors.push(`${relative}: ${issue}`);
      }
    }
  }
  scan(base);
  if (/^\s*uses-material-design:\s*true\s*$/m.test(readFileSync(path.join(root, 'apps/mobile/pubspec.yaml'), 'utf8'))) errors.push('Material icon font is enabled');
  if (errors.length) throw new Error(errors.join('\n'));
  return files;
}

if (path.resolve(process.argv[1] ?? '') === fileURLToPath(import.meta.url)) {
  if (process.argv.length !== 2) throw new Error('Usage: node scripts/check-mobile-ui.mjs');
  const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
  console.log(`Mobile artwork guard passed: ${checkMobileUi(root)} Dart files.`);
}
