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
}
