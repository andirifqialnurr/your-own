import 'package:flutter/foundation.dart';

import '../../core/domain/appearance_preference.dart';

/// UI state only. Preference failures never become fake successful saves.
final class AppearanceController extends ChangeNotifier {
  AppearanceController(this._store);

  final AppearancePreferenceStore _store;
  AppearancePreference _value = AppearancePreference.system;
  bool _storageError = false;
  bool _saving = false;
  bool _disposed = false;
  int _revision = 0;
  Future<void>? _restore;
  Future<void>? _writer;

  AppearancePreference get value => _value;
  bool get storageError => _storageError;
  bool get saving => _saving;

  Future<void> restore({Duration timeout = const Duration(seconds: 2)}) =>
      _restore ??= _read(timeout);

  Future<void> _read(Duration timeout) async {
    final revision = _revision;
    try {
      final saved = await _store.read().timeout(timeout);
      if (!_disposed && revision == _revision) _value = saved;
    } catch (_) {
      if (!_disposed && revision == _revision) _storageError = true;
    }
    _notify();
  }

  Future<void> select(AppearancePreference value) {
    if (_disposed) return Future<void>.value();
    if (value == _value && !_storageError) {
      return _writer ?? Future<void>.value();
    }
    _value = value;
    _revision++;
    _storageError = false;
    if (_writer != null) {
      _notify();
      return _writer!;
    }
    _saving = true;
    final writer = Future<void>.microtask(_drain);
    _writer = writer;
    _notify();
    return writer;
  }

  Future<void> retry() => select(_value);

  Future<void> _drain() async {
    try {
      int writtenRevision;
      do {
        writtenRevision = _revision;
        try {
          // No timeout: abandoning a platform write could let it finish after
          // a newer write and overwrite the latest preference. Coalesce instead.
          await _store.write(_value);
          if (writtenRevision == _revision) _storageError = false;
        } catch (_) {
          if (writtenRevision == _revision) _storageError = true;
        }
      } while (writtenRevision != _revision);
    } finally {
      _writer = null;
      _saving = false;
      _notify();
    }
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
