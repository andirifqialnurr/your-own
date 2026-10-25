import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_own/app/font_licenses.dart';
import 'package:your_own/shared_ui/theme/app_theme.dart';
import 'package:your_own/shared_ui/theme/app_tokens.g.dart';

import 'support/load_fonts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadAppFonts);

  for (final brightness in Brightness.values) {
    final theme = AppTheme.build(brightness);
    final c = theme.extension<AppColors>()!;

    test('$brightness uses semantic zinc, DM Sans and neutral primary', () {
      expect(theme.scaffoldBackgroundColor, c.canvas);
      expect(theme.colorScheme.surface, c.surface);
      expect(theme.colorScheme.primary, c.primary);
      expect(theme.colorScheme.primary, isNot(c.badge));
      expect(theme.scaffoldBackgroundColor, isNot(Colors.black));
      expect(theme.textTheme.bodyLarge!.fontFamily, 'DM Sans');
      expect(theme.textTheme.bodyLarge!.fontSize, 16);
      expect(theme.textTheme.labelLarge!.fontSize, 16);
      expect(theme.inputDecorationTheme.labelStyle!.fontSize, 16);
      expect(theme.textTheme.bodyLarge!.height, 1.5);
      expect(
        theme.textTheme.titleMedium!.fontVariations,
        contains(const FontVariation('wght', 600)),
      );
      expect(theme.cardTheme.elevation, 0);
      expect(theme.dialogTheme.elevation, 0);
      expect(theme.appBarTheme.scrolledUnderElevation, 0);
    });

    test('$brightness text/status/button pairs meet 4.5:1 contrast', () {
      for (final foreground in [c.textPrimary, c.textSecondary, c.textMuted]) {
        for (final background in [c.canvas, c.surface, c.raised]) {
          expect(_contrast(foreground, background), greaterThanOrEqualTo(4.5));
        }
      }
      for (final pair in [
        (c.onBadge, c.badge),
        (c.onSelection, c.selection),
        (c.onDisabled, c.disabled),
        (c.info, c.infoSurface),
        (c.success, c.successSurface),
        (c.warning, c.warningSurface),
        (c.error, c.errorSurface),
      ]) {
        expect(_contrast(pair.$1, pair.$2), greaterThanOrEqualTo(4.5));
      }
      for (final style in [
        theme.filledButtonTheme.style!,
        AppTheme.outlined(c),
        AppTheme.outlined(c, selected: true),
      ]) {
        for (final states in <Set<WidgetState>>[
          {},
          {WidgetState.hovered},
          {WidgetState.pressed},
          {WidgetState.focused},
          {WidgetState.disabled},
        ]) {
          expect(
            _contrast(
              style.foregroundColor!.resolve(states)!,
              style.backgroundColor!.resolve(states)!,
            ),
            greaterThanOrEqualTo(4.5),
          );
          final minimum = style.minimumSize!.resolve(states)!;
          expect(minimum.width, greaterThanOrEqualTo(48));
          expect(minimum.height, greaterThanOrEqualTo(48));
        }
      }
      for (final background in [c.canvas, c.surface, c.raised]) {
        expect(_contrast(c.focus, background), greaterThanOrEqualTo(3));
        expect(_contrast(c.controlBorder, background), greaterThanOrEqualTo(3));
      }
    });

    test(
      '$brightness button states and system-bar icon policy are explicit',
      () {
        final style = theme.filledButtonTheme.style!;
        expect(
          style.backgroundColor!.resolve({WidgetState.hovered}),
          c.primaryHover,
        );
        expect(
          style.backgroundColor!.resolve({WidgetState.pressed}),
          c.primaryPressed,
        );
        expect(
          style.backgroundColor!.resolve({WidgetState.disabled}),
          c.disabled,
        );
        expect(style.animationDuration, Duration.zero);
        expect(
          theme.textButtonTheme.style!.backgroundColor!.resolve({
            WidgetState.disabled,
            WidgetState.hovered,
          }),
          c.disabled,
        );
        expect(
          AppTheme.outlined(c, selected: true).side!.resolve({})!.width,
          2,
        );
        final bars = AppTheme.systemBars(brightness);
        final icons = brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;
        expect(bars.statusBarBrightness, brightness);
        expect(bars.statusBarIconBrightness, icons);
        expect(bars.systemNavigationBarIconBrightness, icons);
        expect(bars.systemNavigationBarContrastEnforced, isTrue);
        expect(bars.systemStatusBarContrastEnforced, isTrue);
      },
    );
  }

  test(
    'bundled font manifest contains DM Sans and no Material icon font',
    () async {
      final fonts =
          jsonDecode(await rootBundle.loadString('FontManifest.json'))
              as List<dynamic>;
      final families = fonts.cast<Map<String, dynamic>>();
      expect(
        families.any((font) => font['family'] == 'MaterialIcons'),
        isFalse,
      );
      final dmSans = families.singleWhere(
        (font) => font['family'] == 'DM Sans',
      );
      expect(
        (dmSans['fonts'] as List<dynamic>).single['asset'],
        'assets/fonts/DMSans-Variable.ttf',
      );
      final bytes = await rootBundle.load('assets/fonts/DMSans-Variable.ttf');
      expect(bytes.lengthInBytes, 240164);
      expect(bytes.getUint32(0), 0x00010000);
    },
  );

  test(
    'complete OFL notice is available through the license registry',
    () async {
      registerFontLicenses();
      registerFontLicenses();
      final entries = await LicenseRegistry.licenses
          .where((entry) => entry.packages.contains('DM Sans'))
          .toList();
      expect(entries, hasLength(1));
      final notice = entries.single.paragraphs
          .map((paragraph) => paragraph.text)
          .join('\n');
      expect(notice, contains('Copyright 2014 The DM Sans Project Authors'));
      expect(notice, contains('SIL OPEN FONT LICENSE Version 1.1'));
      expect(notice, contains('TERMINATION'));
      expect(notice, contains('DISCLAIMER'));
    },
  );
}

double _contrast(Color first, Color second) {
  final a = first.computeLuminance();
  final b = second.computeLuminance();
  return (math.max(a, b) + 0.05) / (math.min(a, b) + 0.05);
}
