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

  @override
  String get navToday => 'Today';

  @override
  String get navProgress => 'Progress';

  @override
  String get navCircle => 'Circle';

  @override
  String get navYou => 'You';

  @override
  String get primaryNavigation => 'Primary navigation';

  @override
  String get navigationScrollHint => 'Scroll to reach all destinations.';

  @override
  String get settingsTitle => 'Your settings';

  @override
  String get back => 'Back';

  @override
  String get messagesTitle => 'Messages';

  @override
  String get messagesEntry => 'Messages (unavailable)';

  @override
  String get messagesUnavailable =>
      'Messaging and unread status are not available in this development setup.';

  @override
  String get progressUnavailable =>
      'Personal summaries are not available in this development setup.';

  @override
  String get circleUnavailable =>
      'Social sharing is not available in this development setup.';

  @override
  String get catalogTitle => 'UI development catalog';

  @override
  String get catalogNotice =>
      'Synthetic examples only. No records, requests or messages are saved or sent.';

  @override
  String get catalogActions => 'Actions';

  @override
  String get catalogFields => 'Fields';

  @override
  String get catalogFeedback => 'Feedback';

  @override
  String get catalogIcons => 'Icons';

  @override
  String get catalogPrimary => 'Primary action';

  @override
  String get catalogSecondary => 'Secondary action';

  @override
  String get catalogGhost => 'Quiet action';

  @override
  String get catalogDisabled => 'Unavailable action';

  @override
  String get catalogBusy => 'Simulated saving…';

  @override
  String get catalogSelected => 'Selected choice';

  @override
  String get catalogHover => 'Hover preview';

  @override
  String get catalogPressed => 'Pressed preview';

  @override
  String get catalogFocus => 'Keyboard focus example';

  @override
  String get catalogNote => 'Example note (required)';

  @override
  String get catalogHelper =>
      'Use synthetic text only. This input is kept only while this page is open.';

  @override
  String get catalogRequired => 'Enter a synthetic note before continuing.';

  @override
  String get catalogFailure =>
      'Simulated failure. Your draft is unchanged; you can retry.';

  @override
  String get catalogSave => 'Simulate save';

  @override
  String catalogAttempts(int count) {
    return 'Simulation attempts: $count';
  }

  @override
  String get catalogReadonly => 'Read-only example';

  @override
  String get catalogReadonlyHint =>
      'This value can be selected and copied, but not edited.';

  @override
  String get catalogDisabledField => 'Disabled example';

  @override
  String get catalogInvalidField => 'Invalid example';

  @override
  String get catalogSample => 'Synthetic example';

  @override
  String get catalogCardTitle => 'Static card';

  @override
  String get catalogCardBody =>
      'This surface is not a button. Its content wraps without stretching across a large window.';

  @override
  String get catalogLoading => 'Loading example';

  @override
  String get catalogLoadingBody =>
      'An unknown duration is not a percentage. This static indicator also respects reduced motion.';

  @override
  String get catalogEmpty => 'Nothing here yet';

  @override
  String get catalogEmptyBody =>
      'No synthetic items have been added. This is not a zero-valued personal summary.';

  @override
  String get catalogError => 'Example error';

  @override
  String get catalogUnavailable => 'Unavailable example';

  @override
  String get catalogUnavailableBody =>
      'This feature is not available. No permission or service is implied.';

  @override
  String get catalogDialog => 'Open confirmation example';

  @override
  String get catalogDialogTitle => 'Confirm the example?';

  @override
  String get catalogDialogBody =>
      'This only demonstrates a dialog. Confirming does not delete, publish or save anything.';

  @override
  String get catalogCancel => 'Cancel';

  @override
  String get catalogConfirm => 'Confirm example';

  @override
  String get catalogConfirmed => 'Example confirmed. No data changed.';

  @override
  String get catalogCancelled => 'Example cancelled. No data changed.';

  @override
  String get routeUnavailable => 'Page unavailable';

  @override
  String get routeUnavailableDescription =>
      'This page is not available in this development setup. No records were loaded.';
}
