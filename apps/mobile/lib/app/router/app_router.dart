import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/setup/presentation/foundation_page.dart';
import '../../features/setup/presentation/setup_screen.dart';
import '../../l10n/generated/app_localizations.dart';
import '../appearance/appearance_controller.dart';
import '../catalog/catalog_screen.dart';
import '../shell/app_shell.dart';
import 'app_destination.dart';

/// Construct once per application session, never inside a layout/theme builder.
/// Optional branches support composition/owned synthetic state fixtures.
GoRouter createAppRouter(
  AppearanceController appearance, {
  List<StatefulShellBranch>? branches,
}) => GoRouter(
  initialLocation: AppDestination.today.path,
  overridePlatformDefaultLocation: true,
  debugLogDiagnostics: false,
  redirect: (context, state) =>
      state.uri.hasScheme ||
          state.uri.hasAuthority ||
          state.uri.hasQuery ||
          state.uri.hasFragment
      ? '/unavailable'
      : null,
  errorPageBuilder: (context, state) =>
      NoTransitionPage<void>(key: state.pageKey, child: _unavailable(context)),
  routes: [
    if (kDebugMode)
      GoRoute(
        path: '/dev/catalog',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: CatalogScreen(
            onBack: () {
              final router = GoRouter.of(context);
              if (router.canPop()) {
                router.pop();
              } else {
                router.go(AppDestination.you.path);
              }
            },
          ),
        ),
      ),
    GoRoute(
      path: '/unavailable',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: _unavailable(context),
      ),
    ),
    GoRoute(
      path: '/messages',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Scaffold(
          body: SafeArea(
            child: FoundationPage(
              title: AppLocalizations.of(context).messagesTitle,
              description: AppLocalizations.of(context).messagesUnavailable,
              storageKey: 'messages-scroll',
              onOpenAppearance: () =>
                  GoRouter.of(context).go(AppDestination.you.path),
              onBack: () {
                final router = GoRouter.of(context);
                if (router.canPop()) {
                  router.pop();
                } else {
                  router.go(AppDestination.circle.path);
                }
              },
            ),
          ),
        ),
      ),
    ),
    StatefulShellRoute(
      builder: (context, state, shell) => AppShell(
        selectedIndex: shell.currentIndex,
        onSelect: (index) => shell.goBranch(index),
        child: shell,
      ),
      navigatorContainerBuilder: (context, shell, children) => IndexedStack(
        index: shell.currentIndex,
        children: [
          for (var index = 0; index < children.length; index++)
            Offstage(
              offstage: index != shell.currentIndex,
              child: ExcludeFocus(
                excluding: index != shell.currentIndex,
                child: TickerMode(
                  enabled: index == shell.currentIndex,
                  child: children[index],
                ),
              ),
            ),
        ],
      ),
      branches:
          branches ??
          [
            for (final destination in AppDestination.values)
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: destination.path,
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: ListenableBuilder(
                        listenable: appearance,
                        builder: (context, _) {
                          final strings = AppLocalizations.of(context);
                          if (destination == AppDestination.you) {
                            return SetupScreen(
                              preference: appearance.value,
                              saving: appearance.saving,
                              storageError: appearance.storageError,
                              onPreferenceChanged: appearance.select,
                              onRetry: appearance.retry,
                              onOpenCatalog: kDebugMode
                                  ? () => GoRouter.of(
                                      context,
                                    ).push('/dev/catalog')
                                  : null,
                            );
                          }
                          return FoundationPage(
                            title: destination == AppDestination.today
                                ? strings.setupTitle
                                : destination.label(strings),
                            description: switch (destination) {
                              AppDestination.today => strings.setupDescription,
                              AppDestination.progress =>
                                strings.progressUnavailable,
                              AppDestination.circle =>
                                strings.circleUnavailable,
                              AppDestination.you => throw StateError(
                                'You is composed separately',
                              ),
                            },
                            onOpenMessages: destination == AppDestination.circle
                                ? () => GoRouter.of(context).push('/messages')
                                : null,
                            storageKey: '${destination.name}-scroll',
                            storageError: appearance.storageError,
                            onOpenAppearance: () => GoRouter.of(
                              context,
                            ).go(AppDestination.you.path),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
          ],
    ),
  ],
);

Widget _unavailable(BuildContext context) {
  final strings = AppLocalizations.of(context);
  return Scaffold(
    body: SafeArea(
      child: FoundationPage(
        title: strings.routeUnavailable,
        description: strings.routeUnavailableDescription,
        storageKey: 'unavailable-scroll',
        onOpenAppearance: () =>
            GoRouter.of(context).go(AppDestination.you.path),
      ),
    ),
  );
}
