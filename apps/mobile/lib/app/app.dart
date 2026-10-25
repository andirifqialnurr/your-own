import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/config/app_config.dart';
import '../core/domain/appearance_preference.dart';
import '../features/setup/presentation/setup_screen.dart';
import '../l10n/generated/app_localizations.dart';
import '../shared_ui/theme/app_theme.dart';
import 'appearance/appearance_controller.dart';

class YourOwnApp extends StatelessWidget {
  const YourOwnApp({required this.config, required this.appearance, super.key});

  final AppConfig config;
  final AppearanceController appearance;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appearance,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalizations.of(context).appName,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.build(Brightness.light),
        darkTheme: AppTheme.build(Brightness.dark),
        themeMode: switch (appearance.value) {
          AppearancePreference.system => ThemeMode.system,
          AppearancePreference.light => ThemeMode.light,
          AppearancePreference.dark => ThemeMode.dark,
        },
        themeAnimationDuration: Duration.zero,
        builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppTheme.systemBars(Theme.of(context).brightness),
          child: child!,
        ),
        home: SetupScreen(
          preference: appearance.value,
          saving: appearance.saving,
          storageError: appearance.storageError,
          onPreferenceChanged: appearance.select,
          onRetry: appearance.retry,
        ),
      ),
    );
  }
}
