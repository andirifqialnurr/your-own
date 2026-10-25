import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_own/app/catalog/catalog_screen.dart';
import 'package:your_own/shared_ui/controls/app_button.dart';
import 'package:your_own/shared_ui/overlays/app_dialog.dart';

import 'support/load_fonts.dart';
import 'support/render_catalog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadAppFonts);
  for (final brightness in Brightness.values) {
    testWidgets('confirmation ${brightness.name} visual baseline', (
      tester,
    ) async {
      await mountCatalog(
        tester,
        brightness: brightness,
        size: const Size(900, 800),
      );
      await tester.ensureVisible(find.byKey(const ValueKey('catalog-dialog')));
      await tester.tap(find.byKey(const ValueKey('catalog-dialog')));
      await settleArtwork(tester);
      expect(find.byType(Icon), findsNothing);
      expect(tester.takeException(), isNull);
      await expectLater(
        find.byType(AppDialog),
        matchesGoldenFile('goldens/dialog_${brightness.name}.png'),
      );
    });
    for (final section in CatalogSection.values) {
      testWidgets(
        'catalog ${section.name} ${brightness.name} visual baseline',
        (tester) async {
          await mountCatalog(tester, section: section, brightness: brightness);
          if (section == CatalogSection.actions) {
            tester
                .widget<AppButton>(find.byKey(const ValueKey('catalog-focus')))
                .focusNode!
                .requestFocus();
            await tester.pumpAndSettle();
          }
          expect(find.byType(Icon), findsNothing);
          expect(tester.takeException(), isNull);
          await expectLater(
            find.byKey(catalogCapture),
            matchesGoldenFile(
              'goldens/catalog_${section.name}_${brightness.name}.png',
            ),
          );
        },
      );
    }
  }
}
