import 'package:shared_preferences/shared_preferences.dart';

import '../domain/appearance_preference.dart';

/// Reads/writes only this key; never scans or clears other preferences.
final class SharedPreferencesAppearanceStore
    implements AppearancePreferenceStore {
  SharedPreferencesAppearanceStore({
    SharedPreferencesAsync Function()? createPreferences,
  }) : _createPreferences = createPreferences ?? SharedPreferencesAsync.new;

  static const key = 'your_own.appearance.v1';
  final SharedPreferencesAsync Function() _createPreferences;

  @override
  Future<AppearancePreference> read() async {
    final value = await _createPreferences().getString(key);
    return switch (value) {
      null || 'system' => AppearancePreference.system,
      'light' => AppearancePreference.light,
      'dark' => AppearancePreference.dark,
      _ => throw const FormatException('Unsupported appearance preference'),
    };
  }

  @override
  Future<void> write(AppearancePreference preference) =>
      _createPreferences().setString(key, preference.name);
}
