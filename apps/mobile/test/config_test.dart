import 'package:flutter_test/flutter_test.dart';
import 'package:your_own/core/config/app_config.dart';
import 'package:your_own/main_production.dart' as production;
import 'package:your_own/main_staging.dart' as staging;

void main() {
  test('development has explicit local-only configuration', () {
    final config = AppConfig.forEnvironment(AppEnvironment.development);
    expect(config.environment, AppEnvironment.development);
  });

  test('staging and production fail closed before app startup', () {
    expect(staging.main, throwsUnsupportedError);
    expect(production.main, throwsUnsupportedError);
  });
}
