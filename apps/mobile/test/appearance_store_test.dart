import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_own/core/domain/appearance_preference.dart';
import 'package:your_own/core/preferences/shared_preferences_appearance_store.dart';

void main() {
  for (final choice in AppearancePreference.values) {
    test('adapter writes only allowlisted $choice and reloads it', () async {
      final preferences = _PreferencesFake();
      final store = SharedPreferencesAppearanceStore(
        createPreferences: () => preferences,
      );
      await store.write(choice);
      final restarted = SharedPreferencesAppearanceStore(
        createPreferences: () => preferences,
      );
      expect(await restarted.read(), choice);
      expect(preferences.values, {
        'unrelated.synthetic.key': 'untouched',
        SharedPreferencesAppearanceStore.key: choice.name,
      });
      expect(preferences.reads, [SharedPreferencesAppearanceStore.key]);
    });
  }

  test('absent preference defaults to System without writing', () async {
    final preferences = _PreferencesFake();
    final store = SharedPreferencesAppearanceStore(
      createPreferences: () => preferences,
    );
    expect(await store.read(), AppearancePreference.system);
    expect(preferences.values, {'unrelated.synthetic.key': 'untouched'});
  });

  for (final invalid in <Object>['', 'Dark', 'unknown', 123, true]) {
    test(
      'invalid stored value $invalid is rejected, not overwritten',
      () async {
        final preferences = _PreferencesFake()
          ..values[SharedPreferencesAppearanceStore.key] = invalid;
        final store = SharedPreferencesAppearanceStore(
          createPreferences: () => preferences,
        );
        await expectLater(store.read(), throwsA(anything));
        expect(
          preferences.values[SharedPreferencesAppearanceStore.key],
          invalid,
        );
      },
    );
  }

  test(
    'unavailable native adapter is surfaced, never replaced with memory',
    () async {
      final store = SharedPreferencesAppearanceStore(
        createPreferences: () => throw StateError('synthetic missing plugin'),
      );
      await expectLater(store.read(), throwsStateError);
      expect(() => store.write(AppearancePreference.dark), throwsStateError);
    },
  );
}

/// A strict test double of the package boundary, not a native persistence test.
class _PreferencesFake implements SharedPreferencesAsync {
  final values = <String, Object>{'unrelated.synthetic.key': 'untouched'};
  final reads = <String>[];

  @override
  Future<String?> getString(String key) async {
    reads.add(key);
    return values[key] as String?;
  }

  @override
  Future<void> setString(String key, String value) async {
    values[key] = value;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnsupportedError(
    'Unexpected preference access: ${invocation.memberName}',
  );
}
