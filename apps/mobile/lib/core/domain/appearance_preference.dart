/// Installation-local, non-sensitive preference. Never an account credential.
enum AppearancePreference { system, light, dark }

abstract interface class AppearancePreferenceStore {
  Future<AppearancePreference> read();
  Future<void> write(AppearancePreference preference);
}
