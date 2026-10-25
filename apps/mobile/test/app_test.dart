import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_own/app/app.dart';
import 'package:your_own/app/appearance/appearance_controller.dart';
import 'package:your_own/core/config/app_config.dart';

import 'support/appearance_store.dart';
import 'support/load_fonts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadAppFonts);
  final config = AppConfig.forEnvironment(AppEnvironment.development);
  for (final brightness in Brightness.values) {
    for (final size in [
      const Size(320, 568),
      const Size(568, 320),
      const Size(768, 1024),
      const Size(1024, 768),
      const Size(1366, 1024),
    ]) {
      testWidgets('local setup at $size, $brightness and 200% text', (
        tester,
      ) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = size;
        tester.platformDispatcher.platformBrightnessTestValue = brightness;
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        addTearDown(tester.view.reset);
        addTearDown(tester.platformDispatcher.clearAllTestValues);

        final appearance = AppearanceController(FakeAppearanceStore());
        await appearance.restore();
        addTearDown(appearance.dispose);
        await tester.pumpWidget(
          YourOwnApp(config: config, appearance: appearance),
        );
        await tester.pumpAndSettle();
        expect(find.text('Your Own'), findsOneWidget);
        expect(find.text('Focus, Read, Intake, and Money.'), findsOneWidget);
        expect(find.byType(Icon), findsNothing);
        expect(tester.takeException(), isNull);
        final scaffold = tester.element(find.byType(Scaffold));
        expect(Theme.of(scaffold).brightness, brightness);
        await tester.ensureVisible(
          find.textContaining('No personal data is stored.'),
        );
        for (final choice in ['system', 'light', 'dark']) {
          final button = find.byKey(ValueKey('appearance-$choice'));
          await tester.ensureVisible(button);
          final target = tester.getSize(button);
          expect(target.width, greaterThanOrEqualTo(48));
          expect(target.height, greaterThanOrEqualTo(48));
        }
        expect(tester.takeException(), isNull);
      });
    }
  }
}
