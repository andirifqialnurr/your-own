import 'dart:async';
import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:your_own/app/app.dart';
import 'package:your_own/app/appearance/appearance_controller.dart';
import 'package:your_own/app/router/app_destination.dart';
import 'package:your_own/app/router/app_router.dart';
import 'package:your_own/app/shell/app_shell.dart';
import 'package:your_own/core/config/app_config.dart';
import 'package:your_own/core/domain/appearance_preference.dart';
import 'package:your_own/l10n/generated/app_localizations.dart';
import 'package:your_own/l10n/generated/app_localizations_en.dart';
import 'package:your_own/shared_ui/icons/app_icon.dart';
import 'package:your_own/shared_ui/layout/layout_policy.dart';
import 'package:your_own/shared_ui/theme/app_focus_outline.dart';
import 'package:your_own/shared_ui/theme/app_theme.dart';
import 'package:your_own/shared_ui/theme/app_tokens.g.dart';

import 'support/appearance_store.dart';
import 'support/load_fonts.dart';
import 'support/navigation.dart';

const _sizes = [
  Size(280, 568),
  Size(320, 568),
  Size(390, 844),
  Size(568, 320),
  Size(844, 390),
  Size(600, 1024),
  Size(768, 1024),
  Size(1024, 768),
  Size(1024, 1366),
  Size(1366, 1024),
  Size(599, 800),
  Size(600, 800),
  Size(839, 800),
  Size(840, 800),
  Size(1199, 800),
  Size(1200, 800),
  Size(1024, 479),
  Size(1024, 480),
  Size(2560, 1440),
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadAppFonts);
  for (final brightness in Brightness.values) {
    for (final scale in [1.0, 2.0]) {
      for (final size in _sizes) {
        testWidgets('adaptive $size $brightness at ${scale * 100}% text', (
          tester,
        ) async {
          _view(tester, size, brightness, scale);
          final store = FakeAppearanceStore();
          await _mount(tester, store);
          final policy = tester
              .widget<LayoutScope>(find.byType(LayoutScope))
              .policy;
          expect(
            policy.windowClass,
            LayoutPolicy.resolve(
              width: size.width,
              height: size.height,
              railLabelsFit: true,
            ).windowClass,
          );
          final expectedNavigation = size.height < 480 || size.width < 600
              ? NavigationPlacement.bottom
              : size.width >= 1200
              ? NavigationPlacement.sidebar
              : scale == 1
              ? NavigationPlacement.rail
              : NavigationPlacement.bottom;
          expect(policy.navigation, expectedNavigation);
          expect(find.byType(AppIcon), findsNWidgets(4));
          expect(find.byType(Icon), findsNothing);
          for (final destination in AppDestination.values) {
            final nav = find.byKey(ValueKey('nav-${destination.name}'));
            await tester.ensureVisible(nav);
            final rect = tester.getRect(nav);
            expect(rect.width, greaterThanOrEqualTo(48));
            expect(rect.height, greaterThanOrEqualTo(48));
            expect(rect.left, greaterThanOrEqualTo(-0.01));
            expect(rect.right, lessThanOrEqualTo(size.width + 0.01));
            await tester.tap(nav);
            await tester.pumpAndSettle();
            expect(
              tester.widget<AppShell>(find.byType(AppShell)).selectedIndex,
              destination.index,
            );
            expect(tester.takeException(), isNull);
          }
          expect(store.writes, isEmpty);
        });
      }
    }
  }

  for (final width in [320.0, 1024.0]) {
    testWidgets(
      'keyboard reaches/activates navigation with visible retained focus at $width',
      (tester) async {
        _view(tester, Size(width, 768), Brightness.dark, 1);
        await _mount(tester, FakeAppearanceStore());
        const progress = ValueKey('nav-progress');
        for (var attempt = 0; attempt < 12; attempt++) {
          await tester.sendKeyEvent(LogicalKeyboardKey.tab);
          await tester.pumpAndSettle();
          if (FocusManager.instance.primaryFocus?.context
                  ?.findAncestorWidgetOfExactType<OutlinedButton>()
                  ?.key ==
              progress) {
            break;
          }
        }
        final focus = FocusManager.instance.primaryFocus!;
        expect(
          focus.context!.findAncestorWidgetOfExactType<OutlinedButton>()?.key,
          progress,
        );
        final outline = find
            .ancestor(
              of: find.byKey(progress),
              matching: find.byType(AppFocusOutline),
            )
            .first;
        final ring =
            tester
                    .widget<Container>(
                      find
                          .descendant(
                            of: outline,
                            matching: find.byType(Container),
                          )
                          .first,
                    )
                    .decoration!
                as BoxDecoration;
        expect((ring.border! as Border).top.color, AppColors.dark.focus);
        tester.view.physicalSize = const Size(1366, 1024);
        await tester.pumpAndSettle();
        expect(FocusManager.instance.primaryFocus, same(focus));
        await tester.sendKeyEvent(LogicalKeyboardKey.space);
        await tester.pumpAndSettle();
        expect(tester.widget<AppShell>(find.byType(AppShell)).selectedIndex, 1);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('navigation respects logical start under RTL', (tester) async {
    _view(tester, const Size(1024, 768), Brightness.light, 1);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.build(Brightness.light),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) =>
            Directionality(textDirection: TextDirection.rtl, child: child!),
        home: AppShell(
          selectedIndex: 0,
          onSelect: (_) {},
          child: const SizedBox(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final content = tester.getRect(find.byKey(const ValueKey('shell-content')));
    expect(content.left, 0);
    expect(content.right, 944);
    expect(
      tester.getRect(find.byKey(const ValueKey('primary-navigation'))).right,
      1024,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('safe-area width and keyboard-reduced height select the layout', (
    tester,
  ) async {
    _view(tester, const Size(640, 568), Brightness.light, 2);
    tester.view.viewPadding = const FakeViewPadding(
      left: 20,
      right: 20,
      top: 24,
      bottom: 24,
    );
    tester.view.padding = const FakeViewPadding(left: 20, right: 20, top: 24);
    tester.view.viewInsets = const FakeViewPadding(bottom: 200);
    final store = FakeAppearanceStore();
    await _mount(tester, store);
    final policy = tester.widget<LayoutScope>(find.byType(LayoutScope)).policy;
    expect(policy.windowClass, WindowClass.medium);
    expect(policy.navigation, NavigationPlacement.bottom);
    final body = tester.getRect(find.byKey(const ValueKey('shell-content')));
    expect(body.left, 20);
    expect(body.right, 620);
    expect(body.top, 24);
    expect(body.bottom, lessThanOrEqualTo(368));
    await selectDestination(tester, 'you');
    final control = find.byKey(const ValueKey('appearance-dark'));
    await tester.ensureVisible(control);
    final rect = tester.getRect(control);
    expect(rect.top, greaterThanOrEqualTo(body.top - 0.01));
    expect(rect.bottom, lessThanOrEqualTo(body.bottom + 0.01));
    await tester.tap(control);
    await tester.pumpAndSettle();
    expect(store.value, AppearancePreference.dark);
    tester.view.physicalSize = const Size(639, 568);
    await tester.pumpAndSettle();
    expect(
      tester.widget<LayoutScope>(find.byType(LayoutScope)).policy.windowClass,
      WindowClass.small,
    );
    expect(store.writes, hasLength(1));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'measured long labels use reachable compact navigation; sidebar wraps',
    (tester) async {
      _view(tester, const Size(768, 1024), Brightness.light, 2);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.build(Brightness.light),
          localizationsDelegates: [
            _LongLabelsDelegate(),
            ...AppLocalizations.localizationsDelegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: AppShell(
            selectedIndex: 0,
            onSelect: (_) {},
            child: const SizedBox(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        tester.widget<LayoutScope>(find.byType(LayoutScope)).policy.navigation,
        NavigationPlacement.bottom,
      );
      await tester.ensureVisible(find.byKey(const ValueKey('nav-you')));
      expect(tester.takeException(), isNull);
      tester.view.physicalSize = const Size(1366, 1024);
      await tester.pumpAndSettle();
      expect(
        tester.widget<LayoutScope>(find.byType(LayoutScope)).policy.navigation,
        NavigationPlacement.sidebar,
      );
      await tester.ensureVisible(find.byKey(const ValueKey('nav-you')));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('only the active branch is exposed to focus and semantics', (
    tester,
  ) async {
    _view(tester, const Size(1024, 768), Brightness.light, 1);
    await _mount(tester, FakeAppearanceStore());
    final handle = tester.ensureSemantics();
    try {
      await selectDestination(tester, 'you');
      expect(find.text('Your settings'), findsOneWidget);
      await selectDestination(tester, 'circle');
      expect(find.text('Your settings'), findsNothing);
      expect(
        find.textContaining('Social sharing is not available'),
        findsOneWidget,
      );
      final node = tester
          .getSemantics(find.byKey(const ValueKey('nav-circle')))
          .getSemanticsData();
      expect(node.label, 'Circle');
      expect(node.flagsCollection.isSelected, Tristate.isTrue);
      expect(node.flagsCollection.isButton, isTrue);
      final inactive = tester
          .getSemantics(find.byKey(const ValueKey('nav-you')))
          .getSemanticsData();
      expect(inactive.flagsCollection.isSelected, Tristate.isFalse);
      expect(find.byType(Icon), findsNothing);
    } finally {
      handle.dispose();
    }
  });

  testWidgets(
    'actual branch/detail history retains draft, focus, scroll, privacy and one timer on resize',
    (tester) async {
      _view(tester, const Size(390, 844), Brightness.light, 1);
      final counts = _Counts();
      final appearance = AppearanceController(FakeAppearanceStore());
      await appearance.restore();
      late final GoRouter router;
      router = createAppRouter(
        appearance,
        branches: [
          for (final destination in AppDestination.values)
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: destination.path,
                  builder: (_, _) => TextButton(
                    onPressed: () => router.push('/today/item/sample-1'),
                    child: Text('Open ${destination.name} fixture'),
                  ),
                  routes: destination == AppDestination.today
                      ? [
                          GoRoute(
                            path: 'item/:id',
                            pageBuilder: (_, state) => NoTransitionPage<void>(
                              key: state.pageKey,
                              child: _DraftFixture(
                                id: state.pathParameters['id']!,
                                counts: counts,
                              ),
                            ),
                          ),
                        ]
                      : [],
                ),
              ],
            ),
        ],
      );
      addTearDown(() {
        router.dispose();
        appearance.dispose();
      });
      await tester.pumpWidget(
        YourOwnApp(
          config: AppConfig.forEnvironment(AppEnvironment.development),
          appearance: appearance,
          router: router,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Open today fixture'));
      await tester.pumpAndSettle();
      final state = tester.state<_DraftFixtureState>(
        find.byType(_DraftFixture),
      );
      await tester.enterText(find.byType(TextField), 'Synthetic draft only');
      await tester.tap(find.text('Hide synthetic amount'));
      await tester.tap(find.text('Synthetic save'));
      state.focus.requestFocus();
      state.text.selection = const TextSelection(
        baseOffset: 2,
        extentOffset: 6,
      );
      state.scroll.jumpTo(240);
      await tester.pump();
      for (final size in [
        const Size(599, 800),
        const Size(600, 800),
        const Size(839, 800),
        const Size(840, 800),
        const Size(1199, 800),
        const Size(1200, 800),
        const Size(568, 320),
        const Size(1366, 1024),
        const Size(320, 568),
      ]) {
        tester.view.physicalSize = size;
        await tester.pump();
        expect(tester.state(find.byType(_DraftFixture)), same(state));
        expect(state.text.text, 'Synthetic draft only');
        expect(
          state.text.selection,
          const TextSelection(baseOffset: 2, extentOffset: 6),
        );
        expect(state.focus.hasFocus, isTrue);
        expect(state.scroll.offset, 240);
        expect(state.widget.id, 'sample-1');
        expect(state.hidden, isTrue);
        expect(find.text('Synthetic hidden amount'), findsNothing);
        expect(counts.created, 1);
        expect(counts.writes, 1);
        expect(tester.takeException(), isNull);
      }
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      await appearance.select(AppearancePreference.dark);
      await tester.pump(const Duration(seconds: 2));
      expect(state.ticks, 2);
      expect(state.focus.hasFocus, isTrue);
      expect(state.scroll.offset, 240);
      expect(tester.takeException(), isNull);
      await selectDestination(tester, 'you');
      expect(state.focus.hasFocus, isFalse);
      await tester.sendKeyEvent(LogicalKeyboardKey.keyX);
      expect(state.text.text, 'Synthetic draft only');
      await selectDestination(tester, 'today');
      expect(tester.state(find.byType(_DraftFixture)), same(state));
      expect(
        GoRouterState.of(tester.element(find.byType(_DraftFixture))).uri.path,
        '/today/item/sample-1',
      );
      expect(counts.created, 1);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Open today fixture'), findsOneWidget);
      expect(counts.disposed, 1);
      await tester.pumpWidget(const SizedBox());
    },
  );

  for (final size in [const Size(320, 568), const Size(1366, 1024)]) {
    testWidgets(
      'messages entry and safe Back work at $size without a fake unread count',
      (tester) async {
        _view(tester, size, Brightness.dark, 2);
        final store = FakeAppearanceStore();
        await _mount(tester, store);
        await selectDestination(tester, 'circle');
        final entry = find.text('Messages (unavailable)');
        await tester.ensureVisible(entry);
        await tester.tap(entry);
        await tester.pumpAndSettle();
        expect(find.text('Messages'), findsOneWidget);
        expect(
          find.text(
            'Messaging and unread status are not available in this development setup.',
          ),
          findsOneWidget,
        );
        await tester.ensureVisible(find.text('Back'));
        await tester.tap(find.text('Back'));
        await tester.pumpAndSettle();
        expect(tester.widget<AppShell>(find.byType(AppShell)).selectedIndex, 2);
        final router = GoRouter.of(tester.element(find.byType(AppShell)));
        router.go('/messages');
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text('Back'));
        await tester.tap(find.text('Back'));
        await tester.pumpAndSettle();
        expect(tester.widget<AppShell>(find.byType(AppShell)).selectedIndex, 2);
        expect(store.writes, isEmpty);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'unknown or external-looking routes are neutral and do not echo input',
    (tester) async {
      _view(tester, const Size(390, 844), Brightness.dark, 2);
      await _mount(tester, FakeAppearanceStore());
      final router = GoRouter.of(tester.element(find.byType(AppShell)));
      for (final input in [
        '/missing-sensitive-marker',
        '/today?token=sensitive-marker',
        'https://example.invalid/today',
        '/you#sensitive-marker',
      ]) {
        router.go(input);
        await tester.pumpAndSettle();
        expect(find.text('Page unavailable'), findsOneWidget);
        expect(find.textContaining('sensitive-marker'), findsNothing);
        expect(find.textContaining('example.invalid'), findsNothing);
        expect(tester.takeException(), isNull);
      }
      await tester.ensureVisible(find.text('Appearance'));
      await tester.tap(find.text('Appearance'));
      await tester.pumpAndSettle();
      expect(tester.widget<AppShell>(find.byType(AppShell)).selectedIndex, 3);
      await selectDestination(tester, 'today');
      expect(tester.widget<AppShell>(find.byType(AppShell)).selectedIndex, 0);
    },
  );
}

void _view(
  WidgetTester tester,
  Size size,
  Brightness brightness,
  double scale,
) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  tester.platformDispatcher.platformBrightnessTestValue = brightness;
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearAllTestValues);
}

Future<void> _mount(WidgetTester tester, FakeAppearanceStore store) async {
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
}

class _LongLabels extends AppLocalizationsEn {
  @override
  String get navToday => 'Today with a deliberately long localized label';
  @override
  String get navYou => 'Your settings with a deliberately long localized label';
}

class _LongLabelsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';
  @override
  Future<AppLocalizations> load(Locale locale) async => _LongLabels();
  @override
  bool shouldReload(_LongLabelsDelegate old) => false;
}

class _Counts {
  int created = 0;
  int disposed = 0;
  int writes = 0;
}

class _DraftFixture extends StatefulWidget {
  const _DraftFixture({required this.id, required this.counts});
  final String id;
  final _Counts counts;
  @override
  State<_DraftFixture> createState() => _DraftFixtureState();
}

class _DraftFixtureState extends State<_DraftFixture> {
  final text = TextEditingController();
  final focus = FocusNode();
  final scroll = ScrollController();
  late final Timer timer;
  int ticks = 0;
  bool hidden = false;
  @override
  void initState() {
    super.initState();
    widget.counts.created++;
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
    widget.counts.disposed++;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      TextField(
        controller: text,
        focusNode: focus,
        decoration: const InputDecoration(labelText: 'Synthetic draft'),
      ),
      Expanded(
        child: ListView(
          controller: scroll,
          children: [
            TextButton(
              onPressed: () => widget.counts.writes++,
              child: const Text('Synthetic save'),
            ),
            Text('Selected ${widget.id}; synthetic ticks $ticks'),
            TextButton(
              onPressed: () => setState(() => hidden = !hidden),
              child: Text(
                hidden ? 'Show synthetic amount' : 'Hide synthetic amount',
              ),
            ),
            if (!hidden) const Text('Synthetic hidden amount'),
            for (var row = 0; row < 60; row++)
              SizedBox(height: 48, child: Text('Synthetic row $row')),
          ],
        ),
      ),
    ],
  );
}
