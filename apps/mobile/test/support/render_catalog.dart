import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_own/app/catalog/catalog_screen.dart';
import 'package:your_own/l10n/generated/app_localizations.dart';
import 'package:your_own/shared_ui/theme/app_theme.dart';

const catalogCapture = ValueKey('catalog-capture');

Future<void> mountCatalog(
  WidgetTester tester, {
  CatalogSection section = CatalogSection.actions,
  Brightness brightness = Brightness.light,
  Size size = const Size(900, 1400),
  double scale = 1,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearAllTestValues);
  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(brightness),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: RepaintBoundary(
        key: catalogCapture,
        child: CatalogScreen(initialSection: section, onBack: () {}),
      ),
    ),
  );
  await settleArtwork(tester);
}

Future<void> settleArtwork(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Await the actual loader futures, not a guessed sleep or empty placeholders.
  final elements = find.byType(SvgPicture).evaluate().toList();
  await tester.runAsync(() async {
    await Future.wait([
      for (final element in elements)
        (element.widget as SvgPicture).bytesLoader.loadBytes(element),
    ]);
  });
  await tester.pumpAndSettle();
}
