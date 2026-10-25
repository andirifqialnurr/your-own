// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Your Own';

  @override
  String get setupTitle => 'Your space to make progress.';

  @override
  String get setupDescription => 'Focus, Read, Intake, and Money.';

  @override
  String get setupNotice =>
      'Development setup only. Tracking and sign-in are not available yet. No personal data is stored.';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get appearanceDescription =>
      'Choose how this app looks on this device.';

  @override
  String get appearanceSystem => 'System';

  @override
  String get appearanceLight => 'Light';

  @override
  String get appearanceDark => 'Dark';

  @override
  String get appearanceSaving => 'Saving appearance…';

  @override
  String get appearanceStorageError =>
      'Appearance could not be restored or saved. Your current choice applies only to this session until saving succeeds.';

  @override
  String get retry => 'Retry';

  @override
  String get fontLicense => 'DM Sans license';

  @override
  String get licenseLoading => 'Loading license…';

  @override
  String get licenseError => 'The bundled license could not be loaded.';

  @override
  String get close => 'Close';
}
