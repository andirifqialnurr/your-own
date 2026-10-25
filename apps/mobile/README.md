# Your Own Mobile

Flutter **3.38.9 / Dart 3.10.8**, using the existing laptop SDK. This is a localized adaptive development shell with DM Sans, semantic zinc themes, System/Light/Dark selection and an owned Hugeicons Free Stroke Rounded adapter (28 core aliases, four used in primary navigation). Only a non-sensitive appearance preference is stored; there is no account, network client or personal-record database—not a finished tracker.

## Navigate

- [Feature/composition ownership](docs/FEATURE_INDEX.md) · [Actual routes](docs/ROUTE_MAP.md)
- [Implemented component catalog](docs/COMPONENT_CATALOG.md)
- [Requirement → code → test/evidence](docs/TRACEABILITY.md)

These indexes link real initial files and distinguish partial host support from full product/native acceptance. Update them when routes, feature contracts, components or tests move.

## Host setup and checks

From the repository root, `pnpm check:local` runs the complete current Windows host lane, including both frozen installs, actual SDK-pin checks and generated-file drift detection. Use `--offline` only with populated caches. It compares goldens without updating them; no native build or hosted CI execution occurs. See [commands, fixture isolation and macOS blockers](../../docs/cookbook/local-verification.md).

Individual commands from this directory:

```bash
flutter pub get --enforce-lockfile
flutter gen-l10n
flutter analyze --no-pub
flutter test --no-pub
dart format --output=none --set-exit-if-changed lib/app lib/core lib/features lib/shared_ui lib/main.dart lib/main_development.dart lib/main_staging.dart lib/main_production.dart test
```

The initial setup used `flutter pub get --offline` against already cached packages. The application owns `pubspec.lock`, independent of the root pnpm lockfile. `.flutter-version` at the repository root records the SDK pin; it does not install or switch an SDK automatically.

From the repository root, run `pnpm check` for the [import-boundary policy](../../docs/cookbook/import-boundaries.md), token drift and bundled font/license hashes as well as API checks. Edit `design/tokens.json`, then run `pnpm tokens:generate`; do not hand-edit `app_tokens.g.dart`. The Node checks need no extra Dart package.

## Native run, when an Android target is available

```bash
flutter run -t lib/main_development.dart -d <device-id>
```

This is a **future device command**, not a command verified by the host tests. Android/iOS wrappers were generated from Flutter 3.38.9 with `flutter create --empty --no-pub --platforms=android,ios --org com.example --project-name your_own apps/mobile`; they have not been built, installed or run on a device/emulator. No new SDK/emulator was installed. Android still needs a compatible JDK/SDK and actual target; iOS requires macOS/Xcode/signing. The initial Android template uses Java 17, Gradle 8.14, AGP 8.11.1, Kotlin 2.2.20 and SDK compile/target 36; these are generated defaults, not validated native compatibility or product OS floors.

The preference adapter's Android source declares AGP 8.13.1/Kotlin 2.3.0, whereas the app template retains AGP 8.11.1/Kotlin 2.2.20. Actual build/resolution compatibility remains pending; see the [appearance dependency review](../../docs/cookbook/mobile-appearance-foundation.md#font-and-dependency-review). No toolchain upgrade or vendor patch was made.

`com.example.your_own` is a temporary development identifier, not an owned/published application ID. Starter launcher/splash images and the Material icon font were removed; Android may show an OS-default launcher placeholder, and the iOS AppIcon catalog is intentionally empty. Approved brand assets and release signing are required before packaging for distribution. The generated debug-key release-signing fallback was removed.

## Entry points and boundaries

| Path | Responsibility |
|---|---|
| `lib/main.dart`, `lib/main_development.dart` | Explicit development startup |
| `lib/main_staging.dart`, `lib/main_production.dart` | Fail closed: these environments are not configured |
| `lib/core/config/app_config.dart` | Pure environment configuration, without service URLs or secrets |
| `lib/app/bootstrap.dart` | Validate first, restore preference before the first app frame; bounded read failure shows a warning |
| `lib/app/app.dart` | Owns one stable router/session, localization, ThemeMode and system-bar policy |
| `lib/app/appearance/appearance_controller.dart` | UI preference state, serialized/coalesced saves and retry |
| `lib/core/domain/appearance_preference.dart` | Pure enum/storage contract |
| `lib/core/preferences/shared_preferences_appearance_store.dart` | Single-key non-sensitive preference adapter |
| `lib/app/router/`, `lib/app/shell/` | Stateful branch composition and adaptive navigation; no feature/domain services |
| `lib/shared_ui/layout/` | Usable-window policy and bounded scrollable content |
| `lib/shared_ui/icons/app_icon.dart` | Only vendor-icon import; 28 closed semantic aliases and directional mirroring |
| `lib/shared_ui/controls/`, `surfaces/`, `feedback/`, `overlays/` | First shared buttons/fields/cards/status/dialogs; no storage or service ownership |
| `lib/app/catalog/catalog_screen.dart` | Debug-only, in-memory synthetic catalog; guarded simulation/confirmation examples |
| `lib/shared_ui/theme/` | Generated semantic tokens, ThemeData, focus outline and bundled-font license dialog |
| `assets/fonts/` | DM Sans, full OFL and reviewed provenance |
| `lib/features/setup/presentation/setup_screen.dart` | Settings/appearance presentation under You; no storage/network access |
| `lib/l10n/app_en.arb` | Authoritative English strings |
| `lib/l10n/generated/` | Generated with `flutter gen-l10n`; do not hand-edit |
| `test/adaptive_shell_test.dart`, `test/layout_policy_test.dart`, `test/app_icon_test.dart` | Breakpoints, insets, 19 viewport cases, both themes/100–200% text, keyboard/focus, stateful history/Back and icon mapping |
| `test/shared_ui_test.dart`, `test/catalog_golden_test.dart`, `test/goldens/` | Component semantics, 200% text, clipboard/modal/focus/reflow behavior and ten reviewed host images |
| `test/config_test.dart` | Development configuration and blocked deployment entry points |
| `test/app_test.dart` | Five window sizes, both themes, actual DM Sans, 200% text and reachable 48-unit targets |
| `test/appearance_*_test.dart`, `test/theme_test.dart` | Preference/adapter failures, OS precedence, keyboard/semantics, state retention, contrast and font/license checks |

The [appearance foundation](../../docs/cookbook/mobile-appearance-foundation.md) now uses bundled DM Sans and explicit semantic tokens, not a seeded palette. `shared_preferences 2.5.4` is restricted to `your_own.appearance.v1` (`system/light/dark`); it is **not suitable for critical data or credentials**. Restore/save failures are visible; no silent in-memory persistence fallback exists. Host package tests use strict doubles, not native storage.

The [T06 adaptive report](../../docs/cookbook/mobile-adaptive-shell.md) records local `go_router 17.5.0` / `hugeicons 1.2.0` review and tests. Small/short windows use deliberately scrollable compact navigation; Medium/Large use a rail only when measured labels fit; Largest uses a sidebar. `BoundedPage` limits form/reading widths. The same branch navigators stay mounted across reflow; inactive branches cannot take focus or expose semantics.

| Current local route | Actual behavior |
|---|---|
| `/today` | Initial setup information, not a dashboard |
| `/progress` | Unavailable personal summaries |
| `/circle` | Unavailable social sharing; visible Messages entry |
| `/you` | Working appearance settings and font notice |
| `/messages` | Explicitly unavailable messaging/unread status; safe Back |
| `/unavailable`, unmatched routes | Neutral page, no input/record details echoed |
| `/dev/catalog` (debug only) | Synthetic shared UI catalog, linked from You |

External-looking/query/fragment routes are rejected to the neutral page. This is not authenticated deep-link support; no native link registrations, session guards, public URL contracts or message service exist. No fake unread count is shown. Navigation state is session-only, not process-death restoration or encrypted draft persistence. Domain flows and master/detail panels remain later work.

The [first shared UI catalog (T07)](../../docs/cookbook/mobile-shared-ui.md) is available at **You → UI development catalog** in debug builds only. Its **Actions / Fields / Feedback / Icons** sections use synthetic fixtures, with no domain request or persistence. `AppButton.busy` is controlled presentation: callers still own synchronous submission guards and outcome handling. The plain-text field is not a Money/password parser. See [visual baseline instructions and notices](test/goldens/README.md); normal `flutter test` compares images, and deliberate regeneration requires inspection followed by a normal repeat. `flutter_svg 2.3.0`, already used by Hugeicons, is directly pinned for test loader synchronization without changing any resolved version/hash. Run root `pnpm check:ui` for the conservative artwork guard.

The remaining product component/icon inventory, charts, auth and encrypted personal storage remain later work. Material layout primitives do not authorize Material icon artwork. No runtime font download or starter glyph is used.

Widget checks run on the Windows Flutter test host. They do not establish Android/iOS/iPad lifecycle, device accessibility, encryption or release readiness.

[M01 evidence](../../docs/cookbook/local-development-bootstrap.md) · [Mobile specification](../../docs/MOBILE_TECH_SPEC.md) · [Design system](../../docs/cookbook/design-system.md)
