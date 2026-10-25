import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_own/app/app.dart';
import 'package:your_own/app/appearance/appearance_controller.dart';
import 'package:your_own/app/catalog/catalog_screen.dart';
import 'package:your_own/core/config/app_config.dart';
import 'package:your_own/shared_ui/controls/app_button.dart';
import 'package:your_own/shared_ui/controls/app_text_field.dart';
import 'package:your_own/shared_ui/icons/app_icon.dart';
import 'package:your_own/shared_ui/overlays/app_dialog.dart';
import 'package:your_own/shared_ui/surfaces/app_card.dart';
import 'package:your_own/shared_ui/theme/app_tokens.g.dart';

import 'support/appearance_store.dart';
import 'support/load_fonts.dart';
import 'support/navigation.dart';
import 'support/render_catalog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadAppFonts);
  for (final brightness in Brightness.values) {
    for (final size in [
      const Size(320, 568),
      const Size(568, 320),
      const Size(768, 1024),
      const Size(1024, 768),
      const Size(1366, 1024),
    ]) {
      testWidgets(
        'catalog sections remain reachable at $size $brightness / 200%',
        (tester) async {
          await mountCatalog(
            tester,
            size: size,
            brightness: brightness,
            scale: 2,
          );
          for (final section in CatalogSection.values) {
            final tab = find.byKey(ValueKey('catalog-${section.name}'));
            await tester.ensureVisible(tab);
            await tester.tap(tab);
            await settleArtwork(tester);
            for (final button in find.byType(AppButton).evaluate().toList()) {
              final target = find.byWidget(button.widget);
              await tester.ensureVisible(target);
              final control = find.descendant(
                of: target,
                matching: find.byWidgetPredicate((w) => w is ButtonStyleButton),
              );
              final rect = tester.getRect(control);
              expect(rect.width, greaterThanOrEqualTo(48));
              expect(rect.height, greaterThanOrEqualTo(48));
              expect(rect.left, greaterThanOrEqualTo(0));
              expect(rect.right, lessThanOrEqualTo(size.width));
            }
            expect(find.byType(Icon), findsNothing);
            expect(tester.takeException(), isNull);
          }
        },
      );
    }
  }

  testWidgets(
    'buttons expose selected/disabled/pending state and named icon actions',
    (tester) async {
      await mountCatalog(tester);
      final handle = tester.ensureSemantics();
      try {
        final selected = tester
            .getSemantics(find.text('Selected choice'))
            .getSemanticsData();
        expect(selected.flagsCollection.isSelected, Tristate.isTrue);
        final disabled = tester
            .getSemantics(find.text('Unavailable action'))
            .getSemanticsData();
        expect(disabled.flagsCollection.isEnabled, Tristate.isFalse);
        final pending = tester
            .getSemantics(find.text('Simulated saving…'))
            .getSemanticsData();
        expect(pending.flagsCollection.isEnabled, Tristate.isFalse);
        final close = tester
            .getSemantics(
              find.descendant(
                of: find.byType(AppIconButton),
                matching: find.byType(OutlinedButton),
              ),
            )
            .getSemanticsData();
        expect(close.label, 'Close');
        expect(close.flagsCollection.isButton, isTrue);
        final button = tester.widget<OutlinedButton>(
          find.ancestor(
            of: find.text('Selected choice'),
            matching: find.byType(OutlinedButton),
          ),
        );
        expect(button.style!.side!.resolve({})!.width, 2);
        for (final label in ['Hover preview', 'Pressed preview']) {
          final preview = tester.widget<AppButton>(
            find.ancestor(
              of: find.text(label),
              matching: find.byType(AppButton),
            ),
          );
          final state = label == 'Hover preview'
              ? WidgetState.hovered
              : WidgetState.pressed;
          expect(preview.statesController!.value, contains(state));
        }
        final card = tester.widget<Card>(
          find.descendant(
            of: find.byType(AppCard),
            matching: find.byType(Card),
          ),
        );
        expect(
          (card.shape! as RoundedRectangleBorder).side.color,
          AppColors.light.border,
        );
        expect(
          Theme.of(tester.element(find.byType(AppCard))).cardTheme.elevation,
          0,
        );
        expect(
          find.descendant(
            of: find.byType(AppCard),
            matching: find.byType(InkWell),
          ),
          findsNothing,
        );
      } finally {
        handle.dispose();
      }
    },
  );

  testWidgets(
    'same-frame simulated submission is guarded; failure, retry and section switches retain input',
    (tester) async {
      await mountCatalog(tester, section: CatalogSection.fields);
      final field = find.descendant(
        of: find.byKey(const ValueKey('catalog-draft')),
        matching: find.byType(TextField),
      );
      final save = find.byKey(const ValueKey('catalog-save'));
      await tester.tap(save);
      await tester.pump();
      expect(
        find.text('Enter a synthetic note before continuing.'),
        findsNWidgets(2),
      );
      await tester.enterText(field, 'Synthetic draft');
      final callback = tester.widget<AppButton>(save).onPressed!;
      callback();
      callback();
      await tester.pump();
      expect(find.text('Simulation attempts: 1'), findsOneWidget);
      expect(tester.widget<AppButton>(save).busy, isTrue);
      await tester.pump(const Duration(milliseconds: 300));
      expect(
        find.text('Simulated failure. Your draft is unchanged; you can retry.'),
        findsOneWidget,
      );
      expect(
        tester.widget<TextField>(field).controller!.text,
        'Synthetic draft',
      );
      await tester.tap(find.byKey(const ValueKey('catalog-icons')));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const ValueKey('catalog-fields')));
      await tester.tap(find.byKey(const ValueKey('catalog-fields')));
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(field).controller!.text,
        'Synthetic draft',
      );
      await tester.ensureVisible(save);
      await tester.tap(save);
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Simulation attempts: 2'), findsOneWidget);
      // A pending local demo may finish after the route is removed; no setState
      // after dispose, persistence fallback or real service is involved.
      tester.widget<AppButton>(save).onPressed!();
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.takeException(), isNull);
    },
  );

  for (final size in [
    const Size(320, 568),
    const Size(568, 320),
    const Size(1366, 1024),
  ]) {
    testWidgets(
      'confirmation at $size has safe focus, Back/Escape and no double opening',
      (tester) async {
        await mountCatalog(tester, size: size, scale: 2);
        final trigger = find.byKey(const ValueKey('catalog-dialog'));
        await tester.ensureVisible(trigger);
        final callback = tester.widget<AppButton>(trigger).onPressed!;
        callback();
        callback();
        await tester.pumpAndSettle();
        expect(find.byType(AppDialog), findsOneWidget);
        expect(find.byType(Icon), findsNothing);
        expect(
          FocusManager.instance.primaryFocus!.context!
              .findAncestorWidgetOfExactType<TextButton>(),
          isNotNull,
        );
        for (var tab = 0; tab < 4; tab++) {
          await tester.sendKeyEvent(LogicalKeyboardKey.tab);
          await tester.pumpAndSettle();
          expect(
            FocusManager.instance.primaryFocus!.context!
                .findAncestorWidgetOfExactType<AppDialog>(),
            isNotNull,
          );
        }
        await tester.sendKeyEvent(LogicalKeyboardKey.escape);
        await tester.pumpAndSettle();
        expect(find.byType(AppDialog), findsNothing);
        expect(
          find.text('Example cancelled. No data changed.'),
          findsOneWidget,
        );
        await tester.ensureVisible(trigger);
        await tester.tap(trigger);
        await tester.pumpAndSettle();
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
        expect(find.byType(AppDialog), findsNothing);
        await tester.ensureVisible(trigger);
        await tester.tap(trigger);
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text('Confirm example'));
        await tester.tap(find.text('Confirm example'));
        await tester.pumpAndSettle();
        expect(
          find.text('Example confirmed. No data changed.'),
          findsOneWidget,
        );
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('keyboard confirmation restores the actual trigger focus', (
    tester,
  ) async {
    await mountCatalog(tester);
    const trigger = ValueKey('catalog-dialog');
    for (var attempt = 0; attempt < 24; attempt++) {
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();
      if (FocusManager.instance.primaryFocus?.context
              ?.findAncestorWidgetOfExactType<AppButton>()
              ?.key ==
          trigger) {
        break;
      }
    }
    final before = FocusManager.instance.primaryFocus!;
    expect(
      before.context!.findAncestorWidgetOfExactType<AppButton>()?.key,
      trigger,
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(
      FocusManager.instance.primaryFocus!.context!
          .findAncestorWidgetOfExactType<AppButton>()
          ?.label,
      'Cancel',
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(FocusManager.instance.primaryFocus, same(before));
  });

  testWidgets(
    'plain fields keep accessible labels, read-only/disabled state and an icon-free clipboard toolbar',
    (tester) async {
      String clipboard = 'Synthetic paste';
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.getData') return {'text': clipboard};
          if (call.method == 'Clipboard.hasStrings') {
            return {'value': clipboard.isNotEmpty};
          }
          if (call.method == 'Clipboard.setData') {
            clipboard = (call.arguments as Map)['text'] as String;
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );
      await mountCatalog(tester, section: CatalogSection.fields);
      final fields = tester
          .widgetList<TextField>(find.byType(TextField))
          .toList();
      expect(fields[1].readOnly, isTrue);
      expect(fields[2].enabled, isFalse);
      final handle = tester.ensureSemantics();
      try {
        final first = find.byType(TextField).first;
        expect(
          tester.getSemantics(first).getSemanticsData().label,
          contains('Example note (required)'),
        );
        await tester.enterText(first, 'Synthetic copy');
        fields[0].controller!.selection = const TextSelection(
          baseOffset: 0,
          extentOffset: 14,
        );
        final editable = tester.state<EditableTextState>(
          find.byType(EditableText).first,
        );
        editable.showToolbar();
        await tester.pumpAndSettle();
        expect(find.text('Copy'), findsOneWidget);
        expect(find.byType(Icon), findsNothing);
        await tester.tap(find.text('Copy'));
        await tester.pumpAndSettle();
        expect(clipboard, 'Synthetic copy');
        clipboard = 'Synthetic paste';
        fields[0].controller!.selection = const TextSelection(
          baseOffset: 0,
          extentOffset: 14,
        );
        editable.showToolbar();
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text('Paste'));
        await tester.tap(find.text('Paste'));
        await tester.pumpAndSettle();
        expect(fields[0].controller!.text, 'Synthetic paste');
        expect(tester.takeException(), isNull);
      } finally {
        handle.dispose();
      }
    },
  );

  testWidgets(
    'all aliases stay decorative and only directional arrows mirror',
    (tester) async {
      await mountCatalog(tester, section: CatalogSection.icons);
      expect(find.byType(AppIcon), findsNWidgets(AppSymbol.values.length + 1));
      for (final direction in TextDirection.values) {
        await tester.pumpWidget(
          Directionality(
            textDirection: direction,
            child: DefaultTextStyle(
              style: const TextStyle(color: Color(0xFF18181B)),
              child: Row(
                children: [
                  for (final symbol in [
                    AppSymbol.back,
                    AppSymbol.next,
                    AppSymbol.money,
                  ])
                    AppIcon(symbol),
                ],
              ),
            ),
          ),
        );
        await settleArtwork(tester);
        final transforms = tester
            .widgetList<Transform>(find.byType(Transform))
            .toList();
        expect(
          transforms[0].transform.entry(0, 0),
          direction == TextDirection.rtl ? -1 : 1,
        );
        expect(
          transforms[1].transform.entry(0, 0),
          direction == TextDirection.rtl ? -1 : 1,
        );
        expect(transforms[2].transform.entry(0, 0), 1);
      }
    },
  );

  testWidgets(
    'dialog reflow keeps field element, draft, focus and selection with keyboard insets',
    (tester) async {
      await mountCatalog(tester);
      final controller = TextEditingController(text: 'Synthetic dialog draft');
      final focus = FocusNode();
      addTearDown(controller.dispose);
      addTearDown(focus.dispose);
      final context = tester.element(find.byType(CatalogScreen));
      showDialog<void>(
        context: context,
        animationStyle: AnimationStyle.noAnimation,
        builder: (context) => AppDialog(
          title: 'Synthetic editor',
          actions: [
            AppButton(
              label: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          child: AppTextField(
            label:
                'Long synthetic field label that must remain visible and wrap',
            controller: controller,
            focusNode: focus,
          ),
        ),
      );
      await tester.pumpAndSettle();
      final state = tester.state<EditableTextState>(find.byType(EditableText));
      focus.requestFocus();
      controller.selection = const TextSelection(
        baseOffset: 2,
        extentOffset: 7,
      );
      await tester.pump();
      for (final size in [
        const Size(320, 568),
        const Size(568, 320),
        const Size(1366, 1024),
      ]) {
        tester.view.physicalSize = size;
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        await tester.pumpAndSettle();
        expect(
          tester.state<EditableTextState>(find.byType(EditableText)),
          same(state),
        );
        expect(controller.text, 'Synthetic dialog draft');
        expect(
          controller.selection,
          const TextSelection(baseOffset: 2, extentOffset: 7),
        );
        expect(focus.hasFocus, isTrue);
        expect(tester.takeException(), isNull);
      }
      tester.view.physicalSize = const Size(320, 568);
      tester.view.viewInsets = const FakeViewPadding(bottom: 200);
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Cancel'));
      expect(
        tester.getRect(find.text('Cancel')).bottom,
        lessThanOrEqualTo(368),
      );
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.byType(AppDialog), findsNothing);
    },
  );

  testWidgets(
    'debug catalog is reachable from You and returns without preference writes',
    (tester) async {
      final store = FakeAppearanceStore();
      final appearance = AppearanceController(store);
      await appearance.restore();
      addTearDown(appearance.dispose);
      await tester.pumpWidget(
        YourOwnApp(
          config: AppConfig.forEnvironment(AppEnvironment.development),
          appearance: appearance,
        ),
      );
      await tester.pumpAndSettle();
      await selectDestination(tester, 'you');
      await tester.ensureVisible(find.text('UI development catalog'));
      await tester.tap(find.text('UI development catalog'));
      await tester.pumpAndSettle();
      expect(find.byType(CatalogScreen), findsOneWidget);
      await tester.ensureVisible(find.text('Back'));
      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();
      expect(find.text('Your settings'), findsOneWidget);
      expect(store.writes, isEmpty);
    },
  );
}
