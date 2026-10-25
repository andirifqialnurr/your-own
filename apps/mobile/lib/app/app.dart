import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../core/config/app_config.dart';
import '../core/domain/appearance_preference.dart';
import '../l10n/generated/app_localizations.dart';
import '../shared_ui/theme/app_theme.dart';
import 'appearance/appearance_controller.dart';
import 'router/app_router.dart';

class YourOwnApp extends StatefulWidget {
  const YourOwnApp({
    required this.config,
    required this.appearance,
    this.router,
    super.key,
  });

  final AppConfig config;
  final AppearanceController appearance;

  /// External composition owns disposal when supplying a router.
  final GoRouter? router;

  @override
  State<YourOwnApp> createState() => _YourOwnAppState();
}

class _YourOwnAppState extends State<YourOwnApp> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = widget.router ?? createAppRouter(widget.appearance);
  }

  @override
  void didUpdateWidget(YourOwnApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.router != widget.router ||
        oldWidget.appearance != widget.appearance) {
      if (oldWidget.router == null) _router.dispose();
      _router = widget.router ?? createAppRouter(widget.appearance);
    }
  }

  @override
  void dispose() {
    if (widget.router == null) _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: widget.appearance,
    builder: (context, _) => MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.build(Brightness.light),
      darkTheme: AppTheme.build(Brightness.dark),
      themeMode: switch (widget.appearance.value) {
        AppearancePreference.system => ThemeMode.system,
        AppearancePreference.light => ThemeMode.light,
        AppearancePreference.dark => ThemeMode.dark,
      },
      themeAnimationDuration: Duration.zero,
      builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppTheme.systemBars(Theme.of(context).brightness),
        child: child!,
      ),
    ),
  );
}
