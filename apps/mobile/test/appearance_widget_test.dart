import 'dart:async';
import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_own/app/app.dart';
import 'package:your_own/app/appearance/appearance_controller.dart';
import 'package:your_own/app/bootstrap.dart';
import 'package:your_own/core/config/app_config.dart';
import 'package:your_own/core/domain/appearance_preference.dart';
import 'package:your_own/features/setup/presentation/setup_screen.dart';
import 'package:your_own/shared_ui/theme/app_focus_outline.dart';
import 'package:your_own/shared_ui/theme/app_tokens.g.dart';

import 'support/appearance_store.dart';
import 'support/load_fonts.dart';
import 'support/navigation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await loadAppFonts();
    await rootBundle.loadString('assets/fonts/OFL.txt');
  });

  testWidgets('bootstrap waits for restoration before first app frame', (
    tester,
  ) async {
    final read = Completer<AppearancePreference>();
    final store = FakeAppearanceStore()..onRead = () => read.future;
    bootstrap(AppEnvironment.development, appearanceStore: store);
    await tester.pump();
    expect(find.byType(YourOwnApp), findsNothing);
    expect(store.writes, isEmpty);
    read.complete(AppearancePreference.dark);
    await tester.pump();
    await tester.pump();
    final app = tester.widget<YourOwnApp>(find.byType(YourOwnApp));
    addTearDown(app.appearance.dispose);
    expect(_brightness(tester), Brightness.dark);
    expect(find.textContaining('only to this session'), findsNothing);
  });

  testWidgets(
    'startup timeout shows System plus warning; late result is ignored',
    (tester) async {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
      addTearDown(tester.platformDispatcher.clearAllTestValues);
      final read = Completer<AppearancePreference>();
      final store = FakeAppearanceStore()..onRead = () => read.future;
      bootstrap(AppEnvironment.development, appearanceStore: store);
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      final app = tester.widget<YourOwnApp>(find.byType(YourOwnApp));
      addTearDown(app.appearance.dispose);
      expect(_brightness(tester), Brightness.light);
      expect(find.textContaining('only to this session'), findsOneWidget);
      read.complete(AppearancePreference.dark);
      await tester.pump();
      expect(_brightness(tester), Brightness.light);
      expect(store.writes, isEmpty);
    },
  );

  testWidgets('explicit choices win; only System follows platform changes', (
    tester,
  ) async {
    final store = FakeAppearanceStore();
    await _mount(tester, store);
    final semantics = tester.ensureSemantics();
    try {
      expect(_brightness(tester), Brightness.light);
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      await tester.pumpAndSettle();
      expect(_brightness(tester), Brightness.dark);
      expect(store.writes, isEmpty);

      await _choose(tester, 'light');
      expect(_brightness(tester), Brightness.light);
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
      await tester.pump();
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      await tester.pump();
      expect(_brightness(tester), Brightness.light);

      await _choose(tester, 'dark');
      expect(_brightness(tester), Brightness.dark);
      final selected = tester.getSemantics(
        find.byKey(const ValueKey('appearance-dark')),
      );
      final flags = selected.getSemanticsData().flagsCollection;
      expect(flags.isSelected, Tristate.isTrue);
      expect(flags.isInMutuallyExclusiveGroup, isTrue);
      expect(flags.isButton, isTrue);
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
      await tester.pump();
      expect(_brightness(tester), Brightness.dark);
      await _choose(tester, 'system');
      expect(_brightness(tester), Brightness.light);
      expect(store.writes, [
        AppearancePreference.light,
        AppearancePreference.dark,
        AppearancePreference.system,
      ]);
      expect(
        tester
            .widget<MaterialApp>(find.byType(MaterialApp))
            .themeAnimationDuration,
        Duration.zero,
      );
      final bars = tester.widget<AnnotatedRegion<SystemUiOverlayStyle>>(
        find.byType(AnnotatedRegion<SystemUiOverlayStyle>),
      );
      expect(bars.value.statusBarIconBrightness, Brightness.dark);
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('saving/failure are visible and Retry saves the session choice', (
    tester,
  ) async {
    final writing = Completer<void>();
    final store = FakeAppearanceStore()..onWrite = (_) => writing.future;
    await _mount(tester, store);
    await _choose(tester, 'dark');
    expect(find.text('Saving appearance…'), findsOneWidget);
    expect(_brightness(tester), Brightness.dark);
    writing.completeError(StateError('synthetic failure'));
    await tester.pumpAndSettle();
    expect(find.textContaining('only to this session'), findsOneWidget);
    expect(store.value, AppearancePreference.system);
    store.onWrite = null;
    await tester.ensureVisible(find.text('Retry'));
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(store.value, AppearancePreference.dark);
    expect(find.textContaining('only to this session'), findsNothing);
    expect(find.text('Saving appearance…'), findsNothing);
  });

  testWidgets('keyboard traversal, visible focus and Space activate choices', (
    tester,
  ) async {
    final store = FakeAppearanceStore();
    await _mount(tester, store);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    final outline = find.byType(AppFocusOutline).first;
    final decorated = tester.widget<Container>(
      find.descendant(of: outline, matching: find.byType(Container)).first,
    );
    final border = (decorated.decoration! as BoxDecoration).border! as Border;
    expect(border.top.color, AppColors.light.focus);
    expect(border.top.width, AppTokens.focusWidth);
    expect(decorated.padding, const EdgeInsets.all(AppTokens.focusOffset));
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pumpAndSettle();
    expect(store.value, AppearancePreference.light);
  });

  testWidgets('theme switch preserves the setup scroll element and offset', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.reset);
    final appearance = await _mount(tester, FakeAppearanceStore());
    await tester.drag(
      find.byKey(const PageStorageKey('setup-scroll')),
      const Offset(0, -250),
    );
    await tester.pumpAndSettle();
    final element = tester.element(find.byType(SetupScreen));
    final scroll = tester.state<ScrollableState>(
      find.descendant(
        of: find.byKey(const PageStorageKey('setup-scroll')),
        matching: find.byType(Scrollable),
      ),
    );
    final offset = scroll.position.pixels;
    expect(offset, greaterThan(0));
    await appearance.select(AppearancePreference.dark);
    await tester.pump();
    expect(tester.element(find.byType(SetupScreen)), same(element));
    expect(scroll.position.pixels, offset);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'a synthetic private route retains draft, focus, timer and scroll',
    (tester) async {
      final appearance = await _mount(tester, FakeAppearanceStore());
      final context = tester.element(find.byType(SetupScreen));
      unawaited(
        Navigator.of(
          context,
        ).push<void>(MaterialPageRoute(builder: (_) => const _DraftFixture())),
      );
      await tester.pumpAndSettle();
      final state = tester.state<_DraftFixtureState>(
        find.byType(_DraftFixture),
      );
      await tester.enterText(find.byType(TextField), 'Synthetic private draft');
      state.text.selection = const TextSelection(
        baseOffset: 4,
        extentOffset: 9,
      );
      state.scroll.jumpTo(300);
      await tester.pump(const Duration(seconds: 2));
      final ticks = state.ticks;
      expect(ticks, greaterThan(0));
      expect(state.focus.hasFocus, isTrue);
      await appearance.select(AppearancePreference.dark);
      await tester.pump();
      expect(tester.state(find.byType(_DraftFixture)), same(state));
      expect(state.text.text, 'Synthetic private draft');
      expect(
        state.text.selection,
        const TextSelection(baseOffset: 4, extentOffset: 9),
      );
      expect(state.focus.hasFocus, isTrue);
      expect(state.scroll.offset, 300);
      expect(state.ticks, ticks);
      expect(
        find.text('Synthetic private route — not published'),
        findsOneWidget,
      );
      expect(_brightness(tester), Brightness.dark);
      expect(tester.takeException(), isNull);
      await tester.pump(const Duration(seconds: 1));
      expect(state.ticks, ticks + 1);
      await tester.pumpWidget(const SizedBox());
    },
  );

  testWidgets('bundled license dialog is readable at 200% and has no icons', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(568, 320);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.reset);
    await _mount(tester, FakeAppearanceStore());
    await tester.ensureVisible(find.text('DM Sans license'));
    await tester.tap(find.text('DM Sans license'));
    await tester.pumpAndSettle();
    final license = tester.widget<FutureBuilder<String>>(
      find.byType(FutureBuilder<String>),
    );
    // Await the dialog's actual asset read; fake-frame pumping is not I/O.
    await tester.runAsync(() => license.future!);
    await tester.pumpAndSettle();
    expect(
      find.textContaining('SIL OPEN FONT LICENSE Version 1.1'),
      findsOneWidget,
      reason: tester
          .widgetList<Text>(find.byType(Text))
          .map((text) => text.data)
          .join('\n'),
    );
    expect(find.byType(Icon), findsNothing);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets(
    'missing license asset shows a localized failure, not network fallback',
    (tester) async {
      final appearance = AppearanceController(FakeAppearanceStore());
      addTearDown(appearance.dispose);
      await appearance.restore();
      await tester.pumpWidget(
        DefaultAssetBundle(
          bundle: _MissingLicenseBundle(),
          child: YourOwnApp(
            config: AppConfig.forEnvironment(AppEnvironment.development),
            appearance: appearance,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await selectDestination(tester, 'you');
      await tester.ensureVisible(find.text('DM Sans license'));
      await tester.tap(find.text('DM Sans license'));
      await tester.pumpAndSettle();
      expect(
        find.text('The bundled license could not be loaded.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );
}

Future<AppearanceController> _mount(
  WidgetTester tester,
  FakeAppearanceStore store,
) async {
  tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
  addTearDown(tester.platformDispatcher.clearAllTestValues);
  final appearance = AppearanceController(store);
  addTearDown(appearance.dispose);
  await appearance.restore();
  await tester.pumpWidget(
    YourOwnApp(
      config: AppConfig.forEnvironment(AppEnvironment.development),
      appearance: appearance,
    ),
  );
  await tester.pumpAndSettle();
  await selectDestination(tester, 'you');
  return appearance;
}

Future<void> _choose(WidgetTester tester, String mode) async {
  final finder = find.byKey(ValueKey('appearance-$mode'));
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Brightness _brightness(WidgetTester tester) =>
    Theme.of(tester.element(find.byType(Scaffold).last)).brightness;

class _MissingLicenseBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    if (key == 'assets/fonts/OFL.txt') {
      throw StateError('synthetic missing asset');
    }
    return rootBundle.load(key);
  }
}

class _DraftFixture extends StatefulWidget {
  const _DraftFixture();

  @override
  State<_DraftFixture> createState() => _DraftFixtureState();
}

class _DraftFixtureState extends State<_DraftFixture> {
  final text = TextEditingController();
  final focus = FocusNode();
  final scroll = ScrollController();
  late final Timer timer;
  int ticks = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() => ticks++),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    text.dispose();
    focus.dispose();
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        const Text('Synthetic private route — not published'),
        Text('Ticks: $ticks'),
        TextField(controller: text, focusNode: focus),
        Expanded(
          child: ListView.builder(
            controller: scroll,
            itemCount: 60,
            itemBuilder: (_, index) =>
                SizedBox(height: 48, child: Text('Synthetic row $index')),
          ),
        ),
      ],
    ),
  );
}
