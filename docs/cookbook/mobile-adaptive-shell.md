# Mobile Adaptive Shell — M01-T06

- **Checkpoint:** 2026-10-25 UTC; coding agent implementation/evidence, not owner release acceptance.
- **Status:** Implemented; host verified, native pending. T06 remains unchecked.
- **Authority:** [Decision 0012 continuation](decisions/0012-local-development-bootstrap.md#adaptive-shell-continuation), [mobile navigation/adaptive contracts](../MOBILE_TECH_SPEC.md#7-navigation-and-deep-links), [design system](design-system.md#4-adaptive-layout-system), [M01 log](../milestones/01-foundations.md).
- **Tools:** Existing Flutter 3.38.9 / Dart 3.10.8, Node 24.18.0 / pnpm 12.8.1; no global upgrade.

## Implemented behavior

- `YourOwnApp` owns one go_router instance per app session, outside theme/layout builders. `StatefulShellRoute` retains Today / Progress / Circle / You branches. An injected router belongs to its external composition owner.
- Stable `Stack` slots change geometry without moving/recreating the branch navigators. Inactive branches are offstage, excluded from focus/semantics and have widget tickers disabled. This does **not** stop a domain timer merely because its screen is hidden.
- Shared generated geometry tokens classify usable width after safe insets and before navigation/gutters: `<600`, `600–<840`, `840–<1200`, `>=1200`. Interactive height accounts for the keyboard. Below 480, navigation stays compact. No orientation/device-name heuristic.
- Medium/Large use an 80-unit rail only when measured localized labels fit at the current `TextScaler`; otherwise compact navigation remains deliberately scrollable, with a scrollbar and semantic hint. Largest uses a 240-unit sidebar with wrapping labels. Compact height derives from actual label metrics, not fixed/clamped text size.
- Navigation has labels, 48-unit minimum targets, non-color-only selected borders, merged selected/button semantics and visible keyboard focus. Only four closed `AppSymbol` aliases render Hugeicons Free Stroke Rounded. There are no Material/Cupertino glyphs, implicit app-bar icons, remote SVG inputs or icon-family fallbacks.
- `BoundedPage` respects local constraints, adaptive gutters and 640/720 form/reading maxima. It does not force a wide workspace, detail pane or stretched text onto a narrow container.
- Today is setup information, Progress/Circle are unavailable placeholders, and You contains working appearance settings. Circle visibly links to **Messages (unavailable)**. `/messages` explicitly says messaging/unread status is unavailable, without invented counts or a send API; text-only Back returns safely even after direct route entry.
- Unknown routes and external-looking/query/fragment inputs receive a neutral unavailable page without echoing inputs. No-transition pages and zero theme animation avoid private-screen cross-fades. This is not an authentication/deep-link security implementation.

Current routes and source ownership are indexed in [the mobile README](../../apps/mobile/README.md#entry-points-and-boundaries). Feature presentation receives callbacks; only `app/` may import go_router, and only `shared_ui/icons/app_icon.dart` may import Hugeicons. The [import policy](import-boundaries.md) adds these exact scopes, not a general UI-package allowance.

## Dependency and notice review

Local direct pins: **go_router 17.5.0** and **hugeicons 1.2.0**. The reviewed go_router 18.1.1 requires Dart 3.12 / Flutter 3.44, so it was not installed and no SDK upgrade was made. The selected 17.5.0 declares Dart `^3.10.0` / Flutter `>=3.38.0`; actual analysis/widget tests pass with the existing SDK. These are local pins, not complete production/platform certification.

Resolution adds **14 hosted identities**, retaining all existing 40 hosted versions/hashes and five SDK packages. Exact version metadata was available/not retracted; archive hashes matched the lock and Pub cache markers; declared SDK constraints accept the installed SDK. No added `hook/` directory was found. This does not independently verify every cached source byte or native artifact.

| Added packages | Reviewed notice |
|---|---|
| go_router 17.5.0; vector_graphics 1.2.3; vector_graphics_compiler 1.3.0 | BSD three-clause; Copyright 2013 The Flutter Authors |
| vector_graphics_codec 1.1.13 | BSD three-clause; Copyright 2013 The Flutter Authors, all rights reserved |
| hugeicons 1.2.0 | MIT; Copyright (c) 2024 Halal Labs |
| flutter_svg 2.3.0; path_parsing 1.1.0 | MIT; Copyright (c) 2018 Dan Field |
| petitparser 7.0.2 | MIT; Copyright (c) 2006–2024 Lukas Renggli |
| xml 6.6.1 | MIT; Copyright (c) 2006–2025 Lukas Renggli |
| args 2.7.0; logging 1.3.0 | BSD three-clause; Copyright 2013, Dart project authors |
| http 1.6.0; http_parser 4.1.2 | BSD three-clause; Copyright 2014, Dart project authors |
| typed_data 1.4.0 | BSD three-clause; Copyright 2015, Dart project authors |

Ten distinct full LICENSE texts were inspected and retained in the dependency review checkpoint. Keep complete copyright, permission/conditions and disclaimers in applicable redistribution; BSD no-endorsement conditions remain. This table is not a substitute license or a final archive-notice review. Full catalog/web/poster icon usage remains separately gated; no Pro assets were added.

An OSV batch query for these **14 exact Pub identities** returned **zero matching advisories at 2026-10-25 02:39 UTC**. This is bounded/date-specific, not exhaustive security or native Maven/CocoaPods review. The SVG dependency's transitive HTTP package does not create an app network client: production artwork uses only the closed local constants.

`apps/mobile/pubspec.lock` SHA-256: `66eca28e6ed9fccb175f9444ba97b6954f575c6aa77fb1cb494f64da5692bd5e`. Root pnpm lock/policies, font/OFL bytes, native wrappers and all 13 historical snapshots are unchanged. Existing preference-plugin/native compatibility gaps and Decision 0010's review deadline remain unchanged.

## Verification and traceability

**259 local tests passed:** 149 Flutter + 88 boundary + 19 API + three design-script tests. Root `pnpm check` passes token/asset checks, boundary scan (**31 files / 101 directives**), strict lint/types and API tests/build. Separate Flutter localization generation, offline/enforced-lockfile repeat, analyzer and formatting of 35 owned/generated Dart files pass. Documentation checks pass for 69 Markdown files, 1,108 local links/anchors, four JSON examples, 67 requirement IDs, 224 tasks and 20 plans; six tasks remain checked.

| Contract | Implementation | Evidence |
|---|---|---|
| Navigation, PRD section 8 | `app/router/`, `app/shell/`, setup placeholders | `adaptive_shell_test.dart`: all destinations, Messages entry, direct-entry Back, neutral unknown routes |
| NFR-07 / NFR-08 | `shared_ui/layout/`, generated geometry, stable navigator slots | `layout_policy_test.dart`: all width edges and 479/480; adaptive tests: 19 viewports × two themes × 100/200% text |
| NFR-01 / NFR-08 | Labeled focusable navigation, constrained content, safe/keyboard insets | Insets reduce 640 to 600/599 usable width; short heights, long labels, RTL placement, 48-unit targets, merged semantics, Tab/Space and visible retained focus |
| NFR-02 / NFR-08 / NFR-09 | One router/retained branch composition, no domain writes | Actual nested go_router **test-only** fixture preserves selected ID, draft/selection/focus, nonzero scroll, explicitly hidden synthetic amount, one timer and one explicit synthetic write across breakpoints/theme/text changes; branch switching and platform Back tested |
| NFR-09 regression | Existing appearance controller/store/themes and You settings | Prior appearance/theme/license/contrast tests retained and adapted to navigate to You |
| Icon/ownership contract | Closed Free Stroke Rounded adapter; scoped import rules | `app_icon_test.dart`, 76 viewport cases, eight added allowed/rejected boundary cases; no built-in glyph widgets |

The 19 viewport cases include 280×568, both small-phone baselines, short landscape, tablet portrait/landscape, large-iPad-sized windows, all breakpoint edges, 479/480 heights and 2560×1440. These are logical test surfaces, **not** actual tested devices or a new supported desktop product.

Corrections retained in the logs: an initial missing-braces analyzer finding was fixed; the missing-license test now opens You before finding its settings control; a route-history assertion was corrected to inspect the active `GoRouterState`, since imperative pushes do not necessarily update `routeInformationProvider`'s URI. Route element identity/history/Back assertions still run; no suppression or product-rule waiver was introduced.

External local checkpoint: `C:/Users/HP/AppData/Local/Temp/your-own-adaptive-c35ila8q/` contains the pre-T06 baseline, version metadata, notice/hash/SDK review, OSV request/response and initial/final logs. It is not an immutable repository snapshot or a device result. T05 was separately committed/pushed as `983de74`; T06's separate commit/push is authorized by the owner, with the actual publication result reported after execution.

## Remaining gates and next slice

T03/T05/T06 stay unchecked until applicable actual Android/iOS/iPad build/lifecycle, rotation/split-window, keyboard/IME, screen-reader, system-bar and persistence evidence exists. Native accessibility, visual review/goldens, platform Back/predictive-back behavior and package distribution artifacts are not certified by these host tests. No emulator/SDK setup, Docker, provider, real personal data, tracker/social/auth service, deployment or release was enabled.

Retained state is **in-session only**. Synthetic draft/timer/hide-value fixtures do not implement domain features, encrypted persistence, process-death recovery, account-switch privacy, notification schedules or real Money/message flows. Full master/detail/domain routing, production link registration/authorization, complete icon/components and native checks remain later work.

Next proposed bounded local task: **M01-T07 — shared UI primitives/development catalog**, not started. This checkpoint does not authorize unattended execution of the remaining roadmap.
