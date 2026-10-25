import 'dart:async';

import 'package:flutter/widgets.dart';

import '../core/config/app_config.dart';
import '../core/domain/appearance_preference.dart';
import '../core/preferences/shared_preferences_appearance_store.dart';
import 'app.dart';
import 'appearance/appearance_controller.dart';
import 'font_licenses.dart';

void bootstrap(
  AppEnvironment environment, {
  AppearancePreferenceStore? appearanceStore,
}) {
  // Keep validation synchronous: unsupported deployment entry points fail first.
  final config = AppConfig.forEnvironment(environment);
  final binding = WidgetsFlutterBinding.ensureInitialized();
  final appearance = AppearanceController(
    appearanceStore ?? SharedPreferencesAppearanceStore(),
  );
  registerFontLicenses();
  binding.deferFirstFrame();
  unawaited(_launch(config, appearance, binding));
}

Future<void> _launch(
  AppConfig config,
  AppearanceController appearance,
  WidgetsBinding binding,
) async {
  try {
    // Bounded read: don't paint a wrong-theme application before restoration.
    // Failure falls back to System with an explicit storage warning, not a save.
    await appearance.restore();
    runApp(YourOwnApp(config: config, appearance: appearance));
  } finally {
    binding.allowFirstFrame();
  }
}
