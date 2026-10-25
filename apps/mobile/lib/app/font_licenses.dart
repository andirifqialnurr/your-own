import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

bool _registered = false;

void registerFontLicenses() {
  if (_registered) return;
  _registered = true;
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(const ['DM Sans'], license);
  });
}
