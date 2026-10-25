import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Your Own'**
  String get appName;

  /// No description provided for @setupTitle.
  ///
  /// In en, this message translates to:
  /// **'Your space to make progress.'**
  String get setupTitle;

  /// No description provided for @setupDescription.
  ///
  /// In en, this message translates to:
  /// **'Focus, Read, Intake, and Money.'**
  String get setupDescription;

  /// No description provided for @setupNotice.
  ///
  /// In en, this message translates to:
  /// **'Development setup only. Tracking and sign-in are not available yet. No personal data is stored.'**
  String get setupNotice;

  /// No description provided for @appearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceTitle;

  /// No description provided for @appearanceDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose how this app looks on this device.'**
  String get appearanceDescription;

  /// No description provided for @appearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get appearanceSystem;

  /// No description provided for @appearanceLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get appearanceLight;

  /// No description provided for @appearanceDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get appearanceDark;

  /// No description provided for @appearanceSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving appearance…'**
  String get appearanceSaving;

  /// No description provided for @appearanceStorageError.
  ///
  /// In en, this message translates to:
  /// **'Appearance could not be restored or saved. Your current choice applies only to this session until saving succeeds.'**
  String get appearanceStorageError;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @fontLicense.
  ///
  /// In en, this message translates to:
  /// **'DM Sans license'**
  String get fontLicense;

  /// No description provided for @licenseLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading license…'**
  String get licenseLoading;

  /// No description provided for @licenseError.
  ///
  /// In en, this message translates to:
  /// **'The bundled license could not be loaded.'**
  String get licenseError;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @navCircle.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get navCircle;

  /// No description provided for @navYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get navYou;

  /// No description provided for @primaryNavigation.
  ///
  /// In en, this message translates to:
  /// **'Primary navigation'**
  String get primaryNavigation;

  /// No description provided for @navigationScrollHint.
  ///
  /// In en, this message translates to:
  /// **'Scroll to reach all destinations.'**
  String get navigationScrollHint;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your settings'**
  String get settingsTitle;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @messagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messagesTitle;

  /// No description provided for @messagesEntry.
  ///
  /// In en, this message translates to:
  /// **'Messages (unavailable)'**
  String get messagesEntry;

  /// No description provided for @messagesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Messaging and unread status are not available in this development setup.'**
  String get messagesUnavailable;

  /// No description provided for @progressUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Personal summaries are not available in this development setup.'**
  String get progressUnavailable;

  /// No description provided for @circleUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Social sharing is not available in this development setup.'**
  String get circleUnavailable;

  /// No description provided for @catalogTitle.
  ///
  /// In en, this message translates to:
  /// **'UI development catalog'**
  String get catalogTitle;

  /// No description provided for @catalogNotice.
  ///
  /// In en, this message translates to:
  /// **'Synthetic examples only. No records, requests or messages are saved or sent.'**
  String get catalogNotice;

  /// No description provided for @catalogActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get catalogActions;

  /// No description provided for @catalogFields.
  ///
  /// In en, this message translates to:
  /// **'Fields'**
  String get catalogFields;

  /// No description provided for @catalogFeedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get catalogFeedback;

  /// No description provided for @catalogIcons.
  ///
  /// In en, this message translates to:
  /// **'Icons'**
  String get catalogIcons;

  /// No description provided for @catalogPrimary.
  ///
  /// In en, this message translates to:
  /// **'Primary action'**
  String get catalogPrimary;

  /// No description provided for @catalogSecondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary action'**
  String get catalogSecondary;

  /// No description provided for @catalogGhost.
  ///
  /// In en, this message translates to:
  /// **'Quiet action'**
  String get catalogGhost;

  /// No description provided for @catalogDisabled.
  ///
  /// In en, this message translates to:
  /// **'Unavailable action'**
  String get catalogDisabled;

  /// No description provided for @catalogBusy.
  ///
  /// In en, this message translates to:
  /// **'Simulated saving…'**
  String get catalogBusy;

  /// No description provided for @catalogSelected.
  ///
  /// In en, this message translates to:
  /// **'Selected choice'**
  String get catalogSelected;

  /// No description provided for @catalogHover.
  ///
  /// In en, this message translates to:
  /// **'Hover preview'**
  String get catalogHover;

  /// No description provided for @catalogPressed.
  ///
  /// In en, this message translates to:
  /// **'Pressed preview'**
  String get catalogPressed;

  /// No description provided for @catalogFocus.
  ///
  /// In en, this message translates to:
  /// **'Keyboard focus example'**
  String get catalogFocus;

  /// No description provided for @catalogNote.
  ///
  /// In en, this message translates to:
  /// **'Example note (required)'**
  String get catalogNote;

  /// No description provided for @catalogHelper.
  ///
  /// In en, this message translates to:
  /// **'Use synthetic text only. This input is kept only while this page is open.'**
  String get catalogHelper;

  /// No description provided for @catalogRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a synthetic note before continuing.'**
  String get catalogRequired;

  /// No description provided for @catalogFailure.
  ///
  /// In en, this message translates to:
  /// **'Simulated failure. Your draft is unchanged; you can retry.'**
  String get catalogFailure;

  /// No description provided for @catalogSave.
  ///
  /// In en, this message translates to:
  /// **'Simulate save'**
  String get catalogSave;

  /// No description provided for @catalogAttempts.
  ///
  /// In en, this message translates to:
  /// **'Simulation attempts: {count}'**
  String catalogAttempts(int count);

  /// No description provided for @catalogReadonly.
  ///
  /// In en, this message translates to:
  /// **'Read-only example'**
  String get catalogReadonly;

  /// No description provided for @catalogReadonlyHint.
  ///
  /// In en, this message translates to:
  /// **'This value can be selected and copied, but not edited.'**
  String get catalogReadonlyHint;

  /// No description provided for @catalogDisabledField.
  ///
  /// In en, this message translates to:
  /// **'Disabled example'**
  String get catalogDisabledField;

  /// No description provided for @catalogInvalidField.
  ///
  /// In en, this message translates to:
  /// **'Invalid example'**
  String get catalogInvalidField;

  /// No description provided for @catalogSample.
  ///
  /// In en, this message translates to:
  /// **'Synthetic example'**
  String get catalogSample;

  /// No description provided for @catalogCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Static card'**
  String get catalogCardTitle;

  /// No description provided for @catalogCardBody.
  ///
  /// In en, this message translates to:
  /// **'This surface is not a button. Its content wraps without stretching across a large window.'**
  String get catalogCardBody;

  /// No description provided for @catalogLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading example'**
  String get catalogLoading;

  /// No description provided for @catalogLoadingBody.
  ///
  /// In en, this message translates to:
  /// **'An unknown duration is not a percentage. This static indicator also respects reduced motion.'**
  String get catalogLoadingBody;

  /// No description provided for @catalogEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get catalogEmpty;

  /// No description provided for @catalogEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'No synthetic items have been added. This is not a zero-valued personal summary.'**
  String get catalogEmptyBody;

  /// No description provided for @catalogError.
  ///
  /// In en, this message translates to:
  /// **'Example error'**
  String get catalogError;

  /// No description provided for @catalogUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable example'**
  String get catalogUnavailable;

  /// No description provided for @catalogUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'This feature is not available. No permission or service is implied.'**
  String get catalogUnavailableBody;

  /// No description provided for @catalogDialog.
  ///
  /// In en, this message translates to:
  /// **'Open confirmation example'**
  String get catalogDialog;

  /// No description provided for @catalogDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm the example?'**
  String get catalogDialogTitle;

  /// No description provided for @catalogDialogBody.
  ///
  /// In en, this message translates to:
  /// **'This only demonstrates a dialog. Confirming does not delete, publish or save anything.'**
  String get catalogDialogBody;

  /// No description provided for @catalogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get catalogCancel;

  /// No description provided for @catalogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm example'**
  String get catalogConfirm;

  /// No description provided for @catalogConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Example confirmed. No data changed.'**
  String get catalogConfirmed;

  /// No description provided for @catalogCancelled.
  ///
  /// In en, this message translates to:
  /// **'Example cancelled. No data changed.'**
  String get catalogCancelled;

  /// No description provided for @routeUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Page unavailable'**
  String get routeUnavailable;

  /// No description provided for @routeUnavailableDescription.
  ///
  /// In en, this message translates to:
  /// **'This page is not available in this development setup. No records were loaded.'**
  String get routeUnavailableDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
