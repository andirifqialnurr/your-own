enum AppEnvironment { development, staging, production }

/// This shell has no network client, provider credentials or persistence.
final class AppConfig {
  const AppConfig._(this.environment);

  factory AppConfig.forEnvironment(AppEnvironment environment) {
    if (environment != AppEnvironment.development) {
      throw UnsupportedError(
        'Staging and production are not configured for this bootstrap.',
      );
    }
    return AppConfig._(environment);
  }

  final AppEnvironment environment;
}
