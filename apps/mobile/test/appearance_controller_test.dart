import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:your_own/app/appearance/appearance_controller.dart';
import 'package:your_own/core/domain/appearance_preference.dart';

import 'support/appearance_store.dart';

void main() {
  for (final choice in AppearancePreference.values) {
    test('restores $choice without writing; restore is idempotent', () async {
      final store = FakeAppearanceStore(value: choice);
      final controller = AppearanceController(store);
      addTearDown(controller.dispose);
      await controller.restore();
      await controller.restore();
      expect(controller.value, choice);
      expect(controller.storageError, isFalse);
      expect(store.reads, 1);
      expect(store.writes, isEmpty);
    });
  }

  test(
    'default is System and selecting unchanged mode does not write',
    () async {
      final store = FakeAppearanceStore();
      final controller = AppearanceController(store);
      addTearDown(controller.dispose);
      await controller.restore();
      await controller.select(AppearancePreference.system);
      expect(controller.value, AppearancePreference.system);
      expect(store.writes, isEmpty);
    },
  );

  test('read failure is visible; explicit retry may save System', () async {
    final store = FakeAppearanceStore()
      ..onRead = () async => throw StateError('synthetic read failure');
    final controller = AppearanceController(store);
    addTearDown(controller.dispose);
    await controller.restore();
    expect(controller.value, AppearancePreference.system);
    expect(controller.storageError, isTrue);
    expect(store.writes, isEmpty);
    await controller.retry();
    expect(store.writes, [AppearancePreference.system]);
    expect(controller.storageError, isFalse);
  });

  test('timed-out read cannot later change the theme or write', () async {
    final read = Completer<AppearancePreference>();
    final store = FakeAppearanceStore()..onRead = () => read.future;
    final controller = AppearanceController(store);
    addTearDown(controller.dispose);
    await controller.restore(timeout: Duration.zero);
    expect(controller.storageError, isTrue);
    read.complete(AppearancePreference.dark);
    await Future<void>.delayed(Duration.zero);
    expect(controller.value, AppearancePreference.system);
    expect(store.writes, isEmpty);
  });

  test('late read cannot overwrite a newer explicit selection', () async {
    final read = Completer<AppearancePreference>();
    final store = FakeAppearanceStore()..onRead = () => read.future;
    final controller = AppearanceController(store);
    addTearDown(controller.dispose);
    final restoring = controller.restore();
    await controller.select(AppearancePreference.light);
    read.complete(AppearancePreference.dark);
    await restoring;
    expect(controller.value, AppearancePreference.light);
    expect(controller.storageError, isFalse);
  });

  test(
    'failed write retains session choice, reports error and retries',
    () async {
      final store = FakeAppearanceStore()
        ..onWrite = (_) async => throw StateError('synthetic write failure');
      final controller = AppearanceController(store);
      addTearDown(controller.dispose);
      await controller.restore();
      await controller.select(AppearancePreference.dark);
      expect(controller.value, AppearancePreference.dark);
      expect(controller.storageError, isTrue);
      expect(controller.saving, isFalse);
      expect(store.value, AppearancePreference.system);
      store.onWrite = null;
      await controller.retry();
      expect(controller.storageError, isFalse);
      expect(store.value, AppearancePreference.dark);
      final restarted = AppearanceController(store);
      addTearDown(restarted.dispose);
      await restarted.restore();
      expect(restarted.value, AppearancePreference.dark);
    },
  );

  test(
    'rapid changes serialize writes and coalesce to the latest mode',
    () async {
      final firstWrite = Completer<void>();
      final store = FakeAppearanceStore();
      var active = 0;
      var maximumActive = 0;
      store.onWrite = (_) async {
        active++;
        if (active > maximumActive) maximumActive = active;
        if (store.writes.length == 1) await firstWrite.future;
        active--;
      };
      final controller = AppearanceController(store);
      addTearDown(controller.dispose);
      await controller.restore();
      final writing = controller.select(AppearancePreference.dark);
      await Future<void>.delayed(Duration.zero);
      unawaited(controller.select(AppearancePreference.light));
      unawaited(controller.select(AppearancePreference.system));
      expect(controller.value, AppearancePreference.system);
      expect(controller.saving, isTrue);
      firstWrite.complete();
      await writing;
      expect(maximumActive, 1);
      expect(store.writes, [
        AppearancePreference.dark,
        AppearancePreference.system,
      ]);
      expect(store.value, AppearancePreference.system);
      expect(controller.saving, isFalse);
    },
  );

  test(
    'stale write failure does not cancel a newer requested choice',
    () async {
      final firstWrite = Completer<void>();
      final store = FakeAppearanceStore()..onWrite = (_) => firstWrite.future;
      final controller = AppearanceController(store);
      addTearDown(controller.dispose);
      final writing = controller.select(AppearancePreference.dark);
      await Future<void>.delayed(Duration.zero);
      unawaited(controller.select(AppearancePreference.light));
      store.onWrite = null;
      firstWrite.completeError(StateError('synthetic stale failure'));
      await writing;
      expect(store.value, AppearancePreference.light);
      expect(controller.storageError, isFalse);
    },
  );

  test('synchronous adapter failure does not wedge the write queue', () async {
    final controller = AppearanceController(_SynchronousFailureStore());
    addTearDown(controller.dispose);
    await controller.select(AppearancePreference.dark);
    expect(controller.storageError, isTrue);
    await controller.select(AppearancePreference.light);
    expect(controller.storageError, isTrue);
    expect(controller.saving, isFalse);
    expect(controller.value, AppearancePreference.light);
  });

  test(
    'disposal suppresses notifications but flushes accepted final choice',
    () async {
      final firstWrite = Completer<void>();
      final store = FakeAppearanceStore()..onWrite = (_) => firstWrite.future;
      final controller = AppearanceController(store);
      final writing = controller.select(AppearancePreference.dark);
      await Future<void>.delayed(Duration.zero);
      unawaited(controller.select(AppearancePreference.light));
      controller.dispose();
      firstWrite.complete();
      await writing;
      await controller.select(AppearancePreference.system);
      expect(store.value, AppearancePreference.light);
    },
  );
}

class _SynchronousFailureStore implements AppearancePreferenceStore {
  @override
  Future<AppearancePreference> read() => throw StateError('synthetic read');

  @override
  Future<void> write(AppearancePreference preference) =>
      throw StateError('synthetic write');
}
