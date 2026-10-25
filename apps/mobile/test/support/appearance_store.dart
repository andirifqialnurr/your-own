import 'package:your_own/core/domain/appearance_preference.dart';

/// Test-only storage. The application never falls back to this fake.
class FakeAppearanceStore implements AppearancePreferenceStore {
  FakeAppearanceStore({this.value = AppearancePreference.system});

  AppearancePreference value;
  int reads = 0;
  final writes = <AppearancePreference>[];
  Future<AppearancePreference> Function()? onRead;
  Future<void> Function(AppearancePreference)? onWrite;

  @override
  Future<AppearancePreference> read() async {
    reads++;
    return onRead == null ? value : await onRead!();
  }

  @override
  Future<void> write(AppearancePreference preference) async {
    writes.add(preference);
    await onWrite?.call(preference);
    value = preference;
  }
}
