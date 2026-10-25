import 'package:flutter/services.dart';

Future<void> loadAppFonts() => (FontLoader(
  'DM Sans',
)..addFont(rootBundle.load('assets/fonts/DMSans-Variable.ttf'))).load();
