import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_own/app/app.dart';
import 'package:your_own/core/config/app_config.dart';

void main() {
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

        await tester.pumpWidget(YourOwnApp(config: config));
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
        expect(tester.takeException(), isNull);
      });
    }
  }
}
