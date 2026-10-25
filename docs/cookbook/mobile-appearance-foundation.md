# Flutter Appearance Foundation

- **Task:** M01-T05, under [Decision 0012's appearance continuation](decisions/0012-local-development-bootstrap.md#appearance-continuation)
- **Checkpoint:** 2026-10-25 UTC — implemented; host checks pass; native verification pending
- **Contracts:** [Design system](design-system.md), [mobile specification](../MOBILE_TECH_SPEC.md), [PRD NFR-09](../PRD.md#nfr-09--appearance-and-shared-visual-system)

## Implementation and ownership

| Source | Responsibility |
|---|---|
| `design/tokens.json` | Platform-neutral foundation colors, geometry and typography; no workspace package or web app added |
| `scripts/generate-theme-tokens.mjs` | Deterministic Flutter adapter generation and drift check |
| `apps/mobile/lib/shared_ui/theme/app_tokens.g.dart` | Generated semantic `AppColors` extension and `AppTokens`; do not hand-edit |
| `apps/mobile/lib/shared_ui/theme/app_theme.dart` | Explicit zinc light/dark schemes, neutral actions and component-state defaults; no seed palette |
| `apps/mobile/lib/shared_ui/theme/app_focus_outline.dart` | Stable 3-unit keyboard-focus outline with 2-unit surface gap |
| `apps/mobile/lib/core/domain/appearance_preference.dart` | Pure System/Light/Dark enum and storage contract |
| `apps/mobile/lib/core/preferences/shared_preferences_appearance_store.dart` | One non-sensitive native preference key; no UI imports it |
| `apps/mobile/lib/app/appearance/appearance_controller.dart` | Restoration, session choice, serialized/coalesced writes, visible failure/retry state |
| `apps/mobile/lib/app/bootstrap.dart`, `app.dart` | Early restoration, stable app/navigation identity, `ThemeMode`, system-bar policy and no theme cross-fade |
| `apps/mobile/lib/features/setup/presentation/setup_screen.dart` | Localized, wrapping appearance selector; injected enum/callbacks only |

This is the foundation subset, not the complete component/icon/chart catalog or adaptive routing. Existing import policy remains unchanged: the preference package is allowed in infrastructure, **not** domain, presentation or shared UI. Eight regression cases exercise those directions.

## Preference behavior

- Default **System**; explicit Light/Dark wins over OS changes. Only System follows platform brightness. OS events do not write preferences.
- Use `SharedPreferencesAsync`, not the legacy cached API. Read/write only `your_own.appearance.v1`, with allowlisted values `system`, `light`, `dark`. No `getAll`, broad clear, account sync, credential or personal-record storage.
- Resolve before the first Flutter application frame. A missing value defaults to System without writing. Invalid values, unavailable adapters and failed/timed-out reads show an explicit warning; unknown stored data is not silently replaced. Read timeout is two seconds; a late result cannot override a user choice.
- Apply a selection immediately for this session, serialize writes and coalesce queued changes to the latest choice. A failed save stays visibly unsaved and offers Retry. There is **no silent memory-store fallback**.
- Do not time out a write and start another: an abandoned native operation could finish late and overwrite the newer value. A stalled write stays visibly pending while the UI remains usable. Disposing the controller suppresses notifications but permits already accepted writes to finish.
- The package explicitly does **not** guarantee disk durability after a completed call. This is suitable only for non-critical appearance; it does not establish encrypted persistence, crash durability, cross-device behavior or OS backup policy.
- `MaterialApp` and its navigator are not keyed by theme. Theme interpolation is disabled. Host fixtures retain their existing route, text/selection, focus, scroll and running synthetic timer; actual future tracker/privacy flows still need their own tests.

## Font and dependency review

DM Sans is bundled locally; no `google_fonts` package, runtime font download, Cosmica, italic asset, reference-app font or icon package is added. The unmodified variable TTF supports optical size 9–40 and weight 100–1000; the adapter explicitly selects its weight/optical-size axes. English-first rendering is tested, not universal script coverage.

[Font provenance and full OFL notice](../../apps/mobile/assets/fonts/README.md) record both immutable upstream sources, hashes and redistribution conditions. The TTF and notice bytes matched the original DM Sans repository and Google Fonts mirror. The notice is bundled, registered with `LicenseRegistry`, and available through the icon-free **DM Sans license** dialog. `.gitattributes` preserves the upstream license's CRLF bytes; `pnpm check:assets` verifies both hashes.

The exact direct pin is **`shared_preferences 2.5.4`**, selected from the existing cache and checked against current version metadata. Offline resolution added **16 hosted identities and one SDK package (`flutter_web_plugins`)**, leaving all 24 existing hosted versions/hashes unchanged:

| Added hosted package | Version |
|---|---|
| shared_preferences | 2.5.4 |
| shared_preferences_android | 2.4.21 |
| shared_preferences_foundation | 2.5.6 |
| shared_preferences_linux | 2.4.1 |
| shared_preferences_platform_interface | 2.4.1 |
| shared_preferences_web | 2.4.3 |
| shared_preferences_windows | 2.4.1 |
| path_provider_linux | 2.2.2 |
| path_provider_platform_interface | 2.1.3 |
| path_provider_windows | 2.3.0 |
| plugin_platform_interface | 2.1.8 |
| ffi | 2.2.0 |
| file | 7.0.1 |
| platform | 3.1.6 |
| web | 1.1.1 |
| xdg_directories | 1.1.0 |

All 16 version metadata records were available/not retracted; their archive hashes matched the new lock and cached archive-hash markers. Declared Dart/Flutter constraints accept installed Dart 3.10.8 / Flutter 3.38.9. Six distinct LICENSE texts were read and mapped by hash across these packages; all contain BSD three-clause terms with the actual Flutter/Dart author notices. No added package has a `hook/` directory. This does not verify every cached source byte or the eventual native dependency/artifact/license closure. A public OSV batch query for these 16 exact Pub identities returned **zero matching advisories at 2026-10-25T00:23:18Z**, not a security certification or a fresh audit of unrelated graphs.

The native adapter requires separate execution evidence:

- Android plugin source declares Java 17, minimum SDK 24, AGP **8.13.1**, Kotlin **2.3.0**, DataStore 1.1.7 and AndroidX Preference 1.2.1. The generated app wrapper still declares AGP **8.11.1** / Kotlin **2.2.20**. Actual Gradle resolution/build compatibility is **unverified**; no wrapper/vendor patch or tool upgrade was made to hide this difference.
- Foundation source declares iOS 13/macOS 10.15, CocoaPods Swift 5.0 and SwiftPM tools 5.9. Its supplied privacy manifest declares UserDefaults reason `1C8F.1`. Final application manifests, native notices and archive contents remain unverified.
- These are package/template constraints, **not adopted product OS floors or new desktop/web support**. No native build, emulator, Docker service, personal database or deployment was run.

Only the Flutter lock changed: SHA-256 `99d8a6acc986c708a577755479799e81a79450f9266e6ad0c82fb43f27b5f612`. The pnpm lock, strict policies and exact Nest-parent Multer override remain unchanged. Decision 0010's owner/review deadline is not renewed by this work.

## Verification and traceability

| Requirement / behavior | Executed host evidence |
|---|---|
| NFR-09 semantic appearance | `theme_test.dart`: zinc/neutral mapping, DM Sans, body/input sizing, explicit hover/pressed/disabled/selected state values and system-bar style values |
| NFR-01 contrast and controls | Text/status/action token pairs meet 4.5:1; control borders/focus meet 3:1; actual targets at least 48; keyboard activation, merged selected/action semantics and visible focus |
| NFR-09 preference persistence contract | `appearance_store_test.dart`: strict package test double, three-value round trips, missing/invalid values, single-key access and unavailable adapter; **not native storage proof** |
| NFR-09 restore/save failures | `appearance_controller_test.dart`: no startup writes, read timeout/late result, write retry, synchronous adapter failure, serialized/coalesced changes and disposal |
| NFR-09 appearance without state loss | `appearance_widget_test.dart`: actual bootstrap with injected store, OS/explicit precedence, warning/retry, stable route/draft/selection/focus/scroll/timer fixture, license dialog and asset failure |
| NFR-07/08 bounded layout regression | `app_test.dart`: five window sizes, both themes, actual bundled font, 200% text and reachable controls; not native/iPad/adaptive-navigation completion |
| Asset integrity / ownership | `tokens:check`, `check:assets`, three positive/negative design-script tests, **80 boundary tests**, real **24-file / 66-directive** source scan |
| Existing API/config safety | **19 API tests**, including all ten Multer regressions; staging/production Flutter entry points still fail closed |

Final checks: **51 Flutter tests**, analyzer, formatting of 24 owned/generated Dart files, frozen/offline Pub repeat, and root `pnpm check` passed. No test/lint suppression or dependency exception was added.

Development failures were retained rather than presented as first-pass success: an incorrect localization getter, redundant/missing imports and use of the SDK's deprecated semantics API were corrected; the first widget run exposed selected-state semantics on a separate node, fixed by merging selection and button action semantics. Tests also needed timely semantics-handle disposal and an explicit await of actual license-asset I/O instead of assuming fake-frame pumping completed it. The generator was adjusted to produce SDK-formatted Dart rather than exempting its output from formatting. An inline documentation helper failed with a shell-escaped regular expression (`re.PatternError`); the standalone corrected checker then passed without waiving checks.

The local review/checkpoint files are at `C:/Users/HP/AppData/Local/Temp/your-own-appearance-fkaakf9e/` (`baseline.json`, version metadata, `preference-dependencies.json`, OSV request/response, initial/final test logs). Those temporary files supplement the durable source/tests/report. Documentation/preservation checks pass for **68 Markdown files, 1,092 local links/anchors, four JSON examples, 67 requirement IDs and 224 tasks**; six tasks remain checked. All 13 historical snapshots, unrelated pre-existing files and HEAD are unchanged; no commit or push was made.

## Remaining native checks and next slice

M01-T05 stays **unchecked: Implemented, host verified, native pending**. Before claiming full completion, build the actual adapters with the selected toolchain; verify restart persistence for each choice, OS changes while running/resuming, native launch-screen transitions and status/navigation-bar contrast (including Android edge-to-edge). Check real keyboard/TalkBack/VoiceOver, large text and applicable tablet/iPad windows. Re-run state/privacy cases with actual feature state when those features exist.

No device/Mac access is invented and the deferred hardware inventory is not restarted. On a subsequent bounded continuation, the next local coding slice is **M01-T06 — adaptive shell and route state**; it is not started here. T03, M00 and full release gates remain open.
