import 'package:flutter/widgets.dart';

import '../core/config/app_config.dart';
import 'app.dart';

void bootstrap(AppEnvironment environment) {
  // Validate before creating widgets or any future service dependencies.
  final config = AppConfig.forEnvironment(environment);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(YourOwnApp(config: config));
}
