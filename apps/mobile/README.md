# Your Own Mobile

Flutter **3.38.9 / Dart 3.10.8**, using the existing laptop SDK. This is an icon-free, localized setup screen with no account, network client, database or personal records—not a finished tracker.

## Host setup and checks

From this directory:

```bash
flutter pub get --enforce-lockfile
flutter gen-l10n
flutter analyze --no-pub
flutter test --no-pub
dart format --output=none --set-exit-if-changed lib/app lib/core lib/main.dart lib/main_development.dart lib/main_staging.dart lib/main_production.dart test
```

The initial setup used `flutter pub get --offline` against already cached packages. The application owns `pubspec.lock`, independent of the root pnpm lockfile. `.flutter-version` at the repository root records the SDK pin; it does not install or switch an SDK automatically.

## Native run, when an Android target is available

```bash
flutter run -t lib/main_development.dart -d <device-id>
```

This is a **future device command**, not a command verified by the host tests. Android/iOS wrappers were generated from Flutter 3.38.9 with `flutter create --empty --no-pub --platforms=android,ios --org com.example --project-name your_own apps/mobile`; they have not been built, installed or run on a device/emulator. No new SDK/emulator was installed. Android still needs a compatible JDK/SDK and actual target; iOS requires macOS/Xcode/signing. The initial Android template uses Java 17, Gradle 8.14, AGP 8.11.1, Kotlin 2.2.20 and SDK compile/target 36; these are generated defaults, not validated native compatibility or product OS floors.

`com.example.your_own` is a temporary development identifier, not an owned/published application ID. Starter launcher/splash images and the Material icon font were removed; Android may show an OS-default launcher placeholder, and the iOS AppIcon catalog is intentionally empty. Approved brand assets and release signing are required before packaging for distribution. The generated debug-key release-signing fallback was removed.

## Entry points and boundaries

| Path | Responsibility |
|---|---|
| `lib/main.dart`, `lib/main_development.dart` | Explicit development startup |
| `lib/main_staging.dart`, `lib/main_production.dart` | Fail closed: these environments are not configured |
| `lib/core/config/app_config.dart` | Pure environment configuration, without service URLs or secrets |
| `lib/app/bootstrap.dart` | Validate before starting widgets or future services |
| `lib/app/app.dart` | Scrollable setup screen, system light/dark appearance |
| `lib/l10n/app_en.arb` | Authoritative English strings |
| `lib/l10n/generated/` | Generated with `flutter gen-l10n`; do not hand-edit |
| `test/config_test.dart` | Development configuration and blocked deployment entry points |
| `test/app_test.dart` | Five window sizes, both themes, 200% text, no icon widgets |

The shell uses SDK typography and a minimal zinc background, **not the completed DM Sans/token/component system**. Theme preference persistence, adaptive navigation/state, Hugeicons adapters, chart rendering, auth and encrypted storage belong to later tasks. Material layout widgets do not introduce Material icon artwork; no starter counter or icon glyph is used.

Widget checks run on the Windows Flutter test host. They do not establish Android/iOS/iPad lifecycle, device accessibility, encryption or release readiness.

[M01 evidence](../../docs/cookbook/local-development-bootstrap.md) · [Mobile specification](../../docs/MOBILE_TECH_SPEC.md) · [Design system](../../docs/cookbook/design-system.md)
