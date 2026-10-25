import assert from 'node:assert/strict';
import { mkdtempSync, mkdirSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import path from 'node:path';
import test from 'node:test';
import { artworkViolations, checkMobileUi } from '../check-mobile-ui.mjs';

for (const source of ['Icon(Icons.add)', 'Icon(CupertinoIcons.back)', 'BackButton()', 'CloseButton()', 'DrawerButton()', 'EndDrawerButton()', "const font = 'MaterialIcons';", 'HugeIcons.solidRoundedHome01', '/* Icons.add is also rejected conservatively */']) {
  test(`artwork guard rejects ${source}`, () => assert.notEqual(artworkViolations(source, 'shared_ui/icons/app_icon.dart').length, 0));
}
test('Free Stroke Rounded symbols are confined to the owned adapter', () => {
  assert.deepEqual(artworkViolations('HugeIcons.strokeRoundedHome01', 'shared_ui/icons/app_icon.dart'), []);
  assert.notEqual(artworkViolations('HugeIcons.strokeRoundedHome01', 'features/setup/presentation/example.dart').length, 0);
  assert.deepEqual(artworkViolations('AppIcon(AppSymbol.back)', 'shared_ui/controls/example.dart'), []);
});
test('actual tree scan rejects implicit glyphs and an enabled Material font', () => {
  const root = mkdtempSync(path.join(tmpdir(), 'your-own-ui-test-'));
  try {
    mkdirSync(path.join(root, 'apps/mobile/lib'), { recursive: true });
    const source = path.join(root, 'apps/mobile/lib/example.dart');
    const manifest = path.join(root, 'apps/mobile/pubspec.yaml');
    writeFileSync(source, 'AppIcon(AppSymbol.back)');
    writeFileSync(manifest, 'flutter:\n  generate: true\n');
    assert.equal(checkMobileUi(root), 1);
    writeFileSync(source, 'BackButton()');
    assert.throws(() => checkMobileUi(root), /implicit built-in/);
    writeFileSync(source, 'AppIcon(AppSymbol.back)');
    writeFileSync(manifest, 'flutter:\n  uses-material-design: true\n');
    assert.throws(() => checkMobileUi(root), /font is enabled/);
  } finally { rmSync(root, { recursive: true, force: true }); }
});
