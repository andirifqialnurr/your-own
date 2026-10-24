import 'package:flutter/material.dart';

import '../core/config/app_config.dart';
import '../features/setup/presentation/setup_screen.dart';
import '../l10n/generated/app_localizations.dart';

class YourOwnApp extends StatelessWidget {
  const YourOwnApp({required this.config, super.key});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5A00)),
        scaffoldBackgroundColor: const Color(0xFFF4F4F5),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5A00),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF09090B),
      ),
      home: const SetupScreen(),
    );
  }
}
