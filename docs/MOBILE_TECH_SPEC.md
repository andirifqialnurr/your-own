# Your Own — Flutter Mobile Technical Specification

- **Version:** 0.9
- **Status:** Technical proposal for review; no application scaffold implemented yet
- **Platforms:** Android phones/tablets first for the limited personal pilot; iPhone/iPad remain required. Minimum OS versions and platform release readiness remain pending.
- **Accepted rollout:** [Decision 0001 — scope and release tracks](cookbook/decisions/0001-scope-and-release-tracks.md)
- **Confirmed:** Flutter mobile, NestJS backend, Next.js user/admin web clients, four tracking modes, adaptive Small/Medium/Large/Largest layouts
- **Source product requirements:** [PRD.md](PRD.md)
- **Engineering overview:** [System architecture and cross-cutting documents](cookbook/architecture.md)
- **Backend integration specification:** [BACKEND_TECH_SPEC.md](BACKEND_TECH_SPEC.md)
- **Related web specifications:** [User website](WEB_PRD.md) · [Admin CMS](ADMIN_CMS_PRD.md)
- **Scope:** Mobile architecture, implementation boundaries, dependencies, platform behavior, and verification

> One coherent Flutter application, designed for both a small phone and a large iPad—not a stretched phone UI and not four separate applications.

## Contents

- [1. Authority and decision status](#1-authority-and-decision-status)
- [2. Recommended mobile stack](#2-recommended-mobile-stack)
- [3. Platform support and native boundaries](#3-platform-support-and-native-boundaries)
- [4. Architecture and dependency rules](#4-architecture-and-dependency-rules)
- [5. Proposed project structure](#5-proposed-project-structure)
- [6. State management and lifecycle](#6-state-management-and-lifecycle)
- [7. Navigation and deep links](#7-navigation-and-deep-links)
- [8. Responsive and adaptive design](#8-responsive-and-adaptive-design)
- [9. Design system and accessibility](#9-design-system-and-accessibility)
- [10. Local persistence and data contracts](#10-local-persistence-and-data-contracts)
- [11. Offline synchronization](#11-offline-synchronization)
- [12. Authentication and account isolation](#12-authentication-and-account-isolation)
- [13. API integration](#13-api-integration)
- [14. Feature implementation breakdown](#14-feature-implementation-breakdown)
- [15. Focus timer engineering](#15-focus-timer-engineering)
- [16. Progress calendars and summaries](#16-progress-calendars-and-summaries)
- [17. Progress poster rendering and sharing](#17-progress-poster-rendering-and-sharing)
- [18. Social data and cache permissions](#18-social-data-and-cache-permissions)
- [19. Messaging and realtime](#19-messaging-and-realtime)
- [20. Notifications and device permissions](#20-notifications-and-device-permissions)
- [21. Security and data lifecycle](#21-security-and-data-lifecycle)
- [22. Performance and observability](#22-performance-and-observability)
- [23. Testing and acceptance matrix](#23-testing-and-acceptance-matrix)
- [24. Tooling and delivery pipeline](#24-tooling-and-delivery-pipeline)
- [25. Existing-app reuse assessment](#25-existing-app-reuse-assessment)
- [26. Implementation sequence](#26-implementation-sequence)
- [27. Open decisions and release gates](#27-open-decisions-and-release-gates)

## 1. Authority and decision status

The PRD owns product scope and user-visible behavior. This document translates that scope into a proposed Flutter implementation. A conflict must be resolved explicitly; implementation convenience must not silently change the PRD.

**Confirmed decisions:**
- Flutter is the mobile framework.
- NestJS is the backend framework; see the linked backend specification for the proposed contract and server design.
- Next.js user web and admin CMS are separate clients of that backend. Their browser constraints/rollout do not silently change Flutter's mobile requirements.
- Focus, Read, Intake, and Money belong in the intended full V1.
- Phone and tablet adaptation, including large iPads, is a V1 requirement.
- Android-first is the accepted limited-pilot distribution order, not a waiver of iOS/iPad spikes, adaptive requirements or native verification gates.
- The social layer is progress-card based, with the full V1 interactions defined in the PRD.
- [Decision 0002](cookbook/decisions/0002-rounded-icons-and-chart-rendering.md) requires one external rounded icon family instead of Material/built-in icons, and permits custom Flutter charts where needed; [Decision 0004](cookbook/decisions/0004-toolchain-directions-and-icon-family.md) selects **Hugeicons Free Stroke Rounded** with first-party Flutter/React packages behind semantic adapters. Exact icon pins and rendering/notice handling remain unverified; no mobile chart package is selected.

[Decision 0003](cookbook/decisions/0003-product-defaults.md) accepts account-required V1 (no guest), private signup/followers-only publication defaults, Today/selected-mode navigation, English-first Android UI, mL/US-fluid-ounce support, 25/5/15 timer defaults with no historical duration edits, locked single-base-currency semantics, independent savings and all CARD-07 outputs privately in V1-A. Provider, exact conversions/currency metadata and sync behavior remain technical gates.

**Accepted supporting-stack directions (Decision 0004):** isolated current compatible stable Flutter SDK, Riverpod, Drift, Dio and go_router. Exact SDK/package pins, encrypted SQLite driver/keys, compatibility and platform evidence remain gates; no upgrade or installation is authorized.

**Other recommended defaults, not yet approved selections:**
- Feature-first modular architecture within one Flutter application.
- Local-first personal tracking with explicit synchronization.
- REST/OpenAPI integration with the confirmed NestJS backend.
- Supabase Auth, Socket.IO, and FCM integration behind mobile-owned interfaces.

Flutter, NestJS, and Next.js have been confirmed for their respective clients/backend. This document does not treat the recommended API conventions, identity provider, database, package versions, or hosting as already approved.

**Non-goals:** Selecting the complete backend/web architecture, implementing server schemas, building Flutter Web, GPS training, games, meals/nutrition, bank connections, or advanced project management.

## 2. Recommended mobile stack

Use one primary solution per concern. Do not combine Riverpod, Bloc, and GetX simply because the existing applications use different libraries.

| Concern | Candidate / accepted direction | Responsibility and constraints |
|---|---|---|
| UI/runtime | Flutter stable + Dart | Shared Android/iOS application; pin an exact tested SDK at bootstrap |
| State and dependency injection | `flutter_riverpod` | Feature controllers, repository injection, reactive queries; not a database |
| Routing | `go_router` | Auth-aware routes, deep links, nested navigation, adaptive list/detail destinations |
| Local persistence | `drift`, `drift_dev`, supported SQLite driver | Typed queries, transactions, migrations, reactive personal data; not automatic cloud sync |
| HTTP | `dio` | Authenticated API calls, timeouts, cancellation, structured failures |
| Icons | Hugeicons Free Stroke Rounded; first-party `hugeicons` package direction | Selected family, pins pending; SVG-backed artwork behind owned semantic adapter, no built-in glyph fallback |
| API serialization | `json_annotation`, `json_serializable`, OpenAPI-generated client where suitable | DTOs and contract alignment; generated transport models stay out of domain/UI APIs |
| Generation | `build_runner` | Drift and serialization generation; generated files are not manually edited |
| Models | Immutable Dart classes, sealed states, enums | Domain invariants; add `freezed` only where its value justifies another generator |
| Identifiers | `uuid` | Client-generated entity/operation IDs that survive offline retries |
| Dates/formatting | `intl`, `timezone`; device-zone adapter such as `flutter_timezone` if needed | Locale-aware display and IANA-zone calculations, not hand-built UTC offsets |
| Credentials | `flutter_secure_storage` through a credential-store interface | OS-backed credential/key storage; not a place for large databases |
| Authentication | `supabase_flutter`, if Supabase Auth is approved | Identity/session integration only; business-data access goes through the API |
| Realtime | `socket_io_client`, if the API uses Socket.IO | Authorized live updates; durable messages still belong to the server/database |
| Push | `firebase_core`, `firebase_messaging` | FCM registration and delivery; iOS also requires APNs configuration |
| Local notifications | `flutter_local_notifications` | Focus completion and optional water reminders, subject to OS limits |
| Sharing/files | `share_plus`, `path_provider` | Own-card image export and platform share sheets; clean sensitive temporary files |
| Network hints | `connectivity_plus`, optional | Scheduling hint only; connectivity type does not prove API reachability |
| Crash diagnostics | `sentry_flutter`, optional after privacy configuration | Redacted technical errors/performance; no automatic sensitive screen capture |
| Testing | `flutter_test`, `integration_test`, Dart test utilities; `mocktail` where useful | Unit, widget, adaptive, persistence, and end-to-end tests |
| Analysis | `flutter_lints` plus selected strict rules | Consistent baseline without an excessively customized lint framework |

### Dependency policy

- This table is not a tested compatibility matrix. Validate package/API compatibility on Android and iOS before locking versions.
- Use the current compatible stable Flutter/Dart baseline at project bootstrap, then pin it. Do not write an unverified "latest" version into this spec.
- Commit the application lockfile and SDK pin; review upgrades intentionally.
- Review maintenance, license, platform requirements, native permissions, and security before adding packages.
- Prefer Flutter primitives for simple layouts, forms, and contribution cells. Do not add a dependency for every widget.
- For charts, use native widgets/custom rendering such as `CustomPainter` where needed to meet the shared chart contract. Test semantics, exact-value alternatives, hit testing, reduced motion and repaint/resize behavior. No chart package is selected; do not automatically install `fl_chart` or embed ApexCharts in a WebView. Any optional library still needs explicit review/approval.
- Use the selected Hugeicons Free Stroke Rounded family; validate matching web assets, complete coverage, exact pins and distribution/poster notices before adoption. Do not use Material Icons/Symbols, built-in `Icons.*`/`CupertinoIcons.*`, or implicit widget icon defaults for app-owned artwork; route icons through the shared semantic adapter.
- Do not add a global screen-scaling package as the basis of responsiveness.
- Database encryption needs a validated driver/key-management decision; ordinary Drift/SQLite is not automatically application-level encrypted.

## 3. Platform support and native boundaries

### 3.1 Device targets

- Android phones and tablets.
- iPhone and iPad, including large iPad windows and supported multitasking configurations.
- Portrait and landscape; no application-wide portrait lock.
- Dynamic resizing, keyboard-visible layouts, system text scaling, and tablet pointer/keyboard use.

Minimum Android API level, iOS/iPadOS version, and reference devices must be selected after dependency validation. Minimums in the old applications do not automatically carry over.

### 3.2 Native integration policy

Shared Dart code covers most domain rules, UI, persistence access, and synchronization. Platform configuration or native code may still be required for:
- Notification permissions and notification scheduling.
- APNs/FCM and app lifecycle handling.
- Secure credential storage and encrypted database integration.
- Universal Links/App Links and external sharing.
- Privacy-sensitive app-switcher snapshots and backup rules.

Keep platform-specific behavior behind narrow interfaces. Do not scatter platform checks throughout feature widgets.

Native code does not bypass OS background restrictions. V1 must not depend on keeping an arbitrary Dart process, socket, or timer alive indefinitely.

### 3.3 Development constraints

- Android development/builds can run on the current Windows environment.
- iOS simulator/build/signing and iPad validation require macOS/Xcode or an appropriate macOS CI service.
- Android tablet and iPad behavior must both be checked; an Android emulator alone cannot validate iPad support.
- Native dependencies, entitlements, and privacy declarations must be reviewed before store submissions.

## 4. Architecture and dependency rules

Use a **feature-first, layered modular application**, not mobile microservices and not a separate package per small feature.

```text
Flutter widgets and adaptive views
                |
Riverpod presentation controllers / query providers
                |
Domain rules and repository interfaces
                |
Repository implementations
       |                     |
Drift local storage    REST / realtime adapters
       |
Durable outbox and synchronization coordinator
```

### 4.1 Layer responsibilities

**Presentation:** Screens, reusable widgets, form interaction, navigation, and display states. Widgets must not issue raw SQL, calculate authoritative financial totals, or decide server permissions.

**Domain:** Framework-independent models, invariants, pure calculations, and repository contracts. Keep Flutter, Riverpod, Dio, Drift, and provider-specific SDK types out of domain interfaces.

**Data:** DTO/domain mapping, local queries, API adapters, synchronization metadata, and repository implementations.

**Application composition:** Wire repositories, controllers, session scope, and shared services. Introduce use-case classes when they coordinate meaningful work, not as one-line wrappers around every method.

### 4.2 Dependency boundaries

- Presentation depends on domain contracts and injected application services.
- Data implements domain contracts; domain does not depend on data.
- Feature A must not import Feature B's widgets, internal controller, or DAO to obtain a total.
- Today and Progress compose narrow summary/query contracts exposed by the modes.
- Shared UI contains genuinely reusable primitives, not arbitrary feature logic.
- Shared infrastructure contains database/network/session tools, not an unstructured `utils` dumping ground.
- One application database may contain all feature tables; table ownership and migrations remain explicit.
- Server validation is authoritative. Matching local validation exists for useful feedback/offline operation, not as a replacement.

### 4.3 Source-of-truth rules

- **Personal UI:** Watches the local projection, including clearly identified pending operations.
- **Cross-device canonical records:** Determined by accepted server operations.
- **Social permissions and publishing:** Determined online by the server.
- **Published cards:** Versioned snapshots, never live queries into an entire tracker.
- **Realtime events:** Hints/updates backed by durable server records, not a second independent source of truth.

## 5. Proposed project structure

Suggested eventual repository location: `apps/mobile/`. This is a structure proposal, not a directory already created by this document.

```text
apps/mobile/
  android/
  ios/
  assets/
    fonts/
    images/
  lib/
    main_development.dart
    main_staging.dart
    main_production.dart
    app/
      bootstrap.dart
      app.dart
      router/
      theme/
      localization/
      session_scope/
    core/
      config/
      database/
        tables/
        migrations/
      network/
        generated/
      sync/
      auth/
      notifications/
      security/
      time/
      errors/
      diagnostics/
    shared_ui/
      adaptive/
      components/
      charts/
      states/
    features/
      onboarding/
      today/
      focus/
      read/
      intake/
      money/
      progress/
      cards/
      social/
      messaging/
      profile/
      settings/
  test/
    unit/
    widget/
    data/
    contracts/
    golden/
  integration_test/
```

A substantial feature, such as `money/`, contains `domain/`, `data/`, and `presentation/`. Small presentational features need not have empty layers solely to satisfy a template.

Do not split into multiple Dart packages until there is a real reuse, ownership, or build-time reason. Future Next.js code will share API contracts, not Flutter widget files.

## 6. State management and lifecycle

### 6.1 Riverpod conventions

- Repository/service providers are created at an explicit application or authenticated-user scope.
- Watch Drift-backed streams for persisted lists, totals, and history.
- Use Notifier/AsyncNotifier-style controllers for meaningful feature workflows; choose exact APIs against the pinned Riverpod version.
- Keep transient form focus/animation state local when it does not need cross-screen persistence.
- Represent initial loading, available data, background refresh, empty, failed, and offline/pending states separately where they affect behavior.
- Do not replace an entire screen with a spinner for every background synchronization.
- Keep provider selectors narrow; a water log must not rebuild every bookshelf and chat row.

### 6.2 State lifetime

| State | Required lifetime |
|---|---|
| Active focus session | Persisted; independent of whether its screen is mounted |
| Unsent local record/outbox command | Persisted until accepted, resolved, or explicitly discarded |
| Task/transaction editor draft | Survives layout reflow; sensitive draft persistence policy is explicit |
| Message draft | Scoped to user and conversation; survives navigation/reflow |
| Navigation branch/selected detail | Preserved where practical across adaptive layout changes |
| Current social authorization | Session-bound and revalidated; not an indefinitely trusted offline flag |
| Sensitive decrypted data | Cleared or obscured according to logout/background/privacy policy |

Auto-disposal must not stop a timer, delete a draft, or abandon synchronization work simply because a route is no longer visible.

On logout/account switch, dispose user-scoped providers, sockets, image caches, drafts, and database handles before mounting another user's scope.

## 7. Navigation and deep links

### 7.1 Navigation shell

Use go_router with a state-preserving shell for the proposed destinations Today, Progress, Circle, and You. Messaging has a visible entry point; exact placement remains a design choice.

Compact and expanded navigation must use the same logical route state. Rebuilding the shell at a breakpoint must not create duplicate navigators, repeated API writes, or a second timer.

### 7.2 Illustrative routes

These are mobile route proposals, not approved public URL contracts:

```text
/today
/focus/tasks/:taskId
/focus/session
/read/books/:bookId
/intake/history
/money/accounts/:accountId
/money/transactions/:transactionId
/progress
/cards/compose
/posts/:postId
/profiles/:username
/messages
/messages/:conversationId
/settings
```

A selected item ID belongs in route/state in both layouts. On a phone the detail occupies a route; on a tablet it may appear beside the list without changing the selected entity's identity.

### 7.3 Deep-link requirements

- Support Android App Links and iOS Universal Links once the production domain is approved.
- Validate hosts, paths, identifiers, and auth callbacks. Never treat an arbitrary external URL as a trusted API request.
- When signed out, preserve only the intended destination, authenticate, then fetch and authorize it.
- A notification or DM link cannot grant access by itself.
- Missing/deleted/restricted content has a neutral unavailable state with safe navigation back.
- Account recovery and OAuth callbacks must be tested on cold and warm app launches.

## 8. Responsive and adaptive design

Implements PRD NFR-07 and NFR-08. These rules apply to tracking, settings, social, sharing, and messaging—not just the dashboard.

### 8.1 Window classes

Classify the usable app window in **logical pixels**, after relevant safe-area insets. Nested components must also respect their parent constraints; a narrow pane inside a large window is still narrow.

| Class | Proposed width | Shell | Content behavior |
|---|---|---|---|
| Small | `< 600` | Bottom navigation | One primary pane, stacked cards/forms |
| Medium | `600 <= width < 840` | Rail where height/content permit | Comfortable grids; do not force detail panes |
| Large | `840 <= width < 1200` | Rail or sidebar | Two-pane workflows when minimum pane widths fit |
| Largest | `>= 1200` | Expanded navigation where useful | Bounded dashboard/workspace layouts; no giant stretched feed |

Breakpoints are initial design defaults, not a substitute for checking content, available height, and text scaling. Centralize them in one tested adaptive policy; do not duplicate magic numbers in each screen.

### 8.2 Adaptive primitives

Provide shared components/policies for:
- App shell and navigation selection.
- Constrained page, readable content column, and responsive grid.
- Master/detail layout with fallback to one pane.
- Adaptive sheet/dialog/editor.
- Insets, spacing, and minimum touch targets.
- Consistent loading, empty, error, offline, and unavailable surfaces.

Use `LayoutBuilder` for local constraints, `MediaQuery` for insets/accessibility information, and Flutter's supported text-scaling APIs. Do not base layout solely on `isTablet`, screen diagonal, orientation, or device name.

### 8.3 Layout constraints

- Forms start with a proposed maximum width of 640 logical pixels; feed/text columns start at 720. Refine with design tests.
- Grid column counts derive from available width and minimum useful card width, not fixed tablet guesses.
- Multi-pane layouts must collapse when a pane would become unusable, including with large text.
- Short landscape screens remain scrollable with reachable primary actions.
- Keyboard insets must not cover Save, Send, timer controls, or validation errors.
- No global scaling of every dimension/font to a percentage of screen width.
- Scrollable charts/tables/calendars are intentional and labeled; the entire page must not overflow horizontally accidentally.
- All layout variants use the same controllers, record IDs, validation, and privacy policy.

### 8.4 Feature layouts

| Surface | Small/compact | Expanded |
|---|---|---|
| Today | Stacked shortcuts and summaries | Dashboard grid, grouped by purpose |
| Focus | Task list and timer/detail navigated sequentially | Task list beside timer/selected task |
| Read | List or compact book grid | Adaptive grid and optional book-detail pane |
| Intake | Quick logs above summary/history | Summary and capture beside history |
| Money | Overview, list, and editor as compact flows | Account/history/details together where useful |
| Progress | Compact period/calendar navigation | Calendar and selected-day detail side by side |
| Circle | One readable feed | One bounded feed with optional detail pane, not multiple engagement feeds |
| Messaging | List and thread as separate views | Conversation list beside the selected thread |
| Forms | Sheet/full-screen as appropriate | Bounded dialog or side panel |
| Poster preview | Fit inside the window | Centered bounded preview; output size remains fixed by template |

### 8.5 Resize invariants

Rotation, split-screen changes, and window resizing must not:
- Discard unsaved input or change selected records unexpectedly.
- Recreate active focus sessions or duplicate notification schedules.
- Trigger a transaction/post/message twice.
- Expose hidden Money values because a new column appeared.
- Reset the feed to a different reading position without a deliberate refresh.

## 9. Design system and accessibility

### 9.1 Design tokens

Use Flutter theming/ThemeExtension-style tokens for semantic colors, typography, spacing, radii, elevations, content widths, and motion. Mode accents must not be the only way to identify a mode or state.

Implement the [Your Own design system and component contracts](cookbook/design-system.md), including the zinc-neutral palette, rounded geometry, single-font policy, and light/dark themes. System / Light / Dark appearance is required by PRD NFR-09; default System, persist the local choice, and preserve drafts, timers, focus, and privacy on change. Use explicit light/dark semantic tokens across all widgets, overlays, charts, and states rather than a seeded palette or scattered hardcoded colors.

Bundle approved fonts/assets where practical rather than requiring runtime font downloads for basic rendering. Review licenses.

Follow the [rounded icon contract](cookbook/design-system.md#56-rounded-icon-system) and [chart rendering contract](cookbook/design-system.md#73-chart-rendering-and-platform-ownership). Material widget primitives may still provide behavior, but back/close/picker/menu and other app-owned glyphs must come from the chosen icon family. Native OS share sheets/keyboards retain their system artwork.

### 9.2 Accessibility requirements

- Target the applicable WCAG 2.2 AA expectations in the PRD.
- Respect text scaling, including 200% and platform accessibility settings where supported.
- Minimum primary touch targets: 48 by 48 logical pixels.
- Screen-reader labels for chart points, contribution days, timer state, amounts, units, and card metrics.
- Keyboard focus order must make sense in one- and two-pane layouts.
- No color-only indication of pending/error/goal completion.
- Provide readable alternatives to charts, not hundreds of unstructured accessibility nodes.
- Respect reduced-motion preferences and avoid flashing or guilt-inducing effects.
- Do not announce a countdown every second through a screen reader.
- Verify long English/pseudolocalized labels and locale-formatted dates/numbers without truncating essential meaning. Indonesian remains a later candidate; testing long strings does not claim translated pilot coverage.

## 10. Local persistence and data contracts

### 10.1 Database ownership

Use one versioned Drift database per signed-in user, or an equivalently tested isolation strategy. A per-user database is the recommended baseline because it reduces accidental cross-account queries.

Run database work through a supported background-isolate arrangement where useful. Do not move a connection across isolates in an unsupported way.

Drift provides local SQL, reactive queries, and migrations. It does not supply remote authorization or a complete synchronization protocol.

### 10.2 Common record metadata

Synced entities generally need:
- Stable client-generated ID and owner ID.
- Server revision/version.
- Creation/update times; server ordering is not based solely on an untrusted client clock.
- Deletion/tombstone state where synchronization requires it.
- Local pending/conflict/error state kept separate from canonical domain fields.

Activity records also need the UTC occurrence instant where known, intended local activity date, and IANA timezone context. Preserve the date that was actually recorded; a device timezone change must not rewrite the entire history.

Use typed IDs/enums at boundaries. Avoid passing arbitrary maps throughout the application.

### 10.3 Proposed table groups

This inventory is not a final SQL schema:

| Area | Proposed local records |
|---|---|
| Account/settings | User profile cache, preferences, enabled modes, effective-dated targets |
| Focus | Tasks, labels, focus sessions, persisted active-timer state |
| Read | Books, ordered progress entries, completion state, reading goals |
| Intake | Water entries, coffee entries, water-target history |
| Money | Accounts, categories, transactions/transfers, balance adjustments, monthly plans/allocations, savings goals and goal entries, plan reviews |
| Progress | Derived daily projections and summary caches where justified |
| Cards | Private drafts, explicitly selected snapshot fields, own published-card metadata |
| Social | Minimal authorized profile/feed metadata; private-card caching is restricted |
| Messaging | Conversation metadata, own-participant message cache, drafts, pending sends |
| Infrastructure | Outbox operations, sync cursors, retry metadata, migration metadata |

### 10.4 Numeric rules

**Money:** Use integer minor units with explicit currency metadata; never use `double` for ledger values. Send large integer amounts as decimal strings in JSON to avoid precision loss across JavaScript clients. Confirm range limits and currency exponent/formatting rules with the API. Do not assume every currency uses two display decimals.

**Water:** Store a canonical milliliter quantity; mL is the default unit. Optional US fluid-ounce input/display uses a tested one-time conversion rule, not Imperial ounces; do not repeatedly convert rounded display values back into storage. Exact representation/rounding remains a contract decision.

**Coffee:** Separate cups from shots; no fabricated common caffeine unit.

**Reading:** Integer page positions and derived deltas; unknown total pages remain unknown.

**Focus:** Integer elapsed durations and explicit pause state; break minutes are not focus minutes.

### 10.5 Migrations and derived data

- Version every schema change and test upgrades from all supported released schemas.
- Never use "delete and recreate the database" as a production migration fallback.
- Retain or safely migrate pending operations and drafts.
- Derived summary tables can be rebuilt; source records cannot be discarded to repair a cache.
- Include realistic large-history and partially synced fixtures in migration tests.
- Do not reuse the old apps' database files or local integer IDs as if they were already multi-user/cloud-safe.

## 11. Offline synchronization

### 11.1 Proposed offline boundary

| Action | Offline behavior |
|---|---|
| View own previously stored tracking data | Available locally |
| Task/book/water/coffee capture | Save locally and queue synchronization |
| Focus timer | Operates locally; persist events/state and reconcile later |
| Manual Money transaction/goal/plan changes | Save locally with pending status and revision-aware synchronization |
| Own card preview/private export | May use locally stored data; clearly separate from published content |
| Publish, audience change, follow approval, repost | Online authorization required |
| Like/comment | Online action; no indefinite offline replay under stale permissions |
| DM | Draft/pending state allowed; never claim server acceptance or delivery offline |
| Other people's private card content | Not an offline entitlement; require online access validation |
| Account deletion/security changes | Online confirmation required |

This expands the PRD's proposed offline expectation into a recommended implementation. Confirm scope before building it; do not assume a package delivers it automatically.

### 11.2 Local write/outbox transaction

For a personal mutation:
1. Validate input locally.
2. Create a stable entity ID if needed and a unique operation ID.
3. In **one local database transaction**, write the local projection and its outbox operation.
4. Report "saved on this device / pending sync" only after durable local success.
5. Notify UI through the database stream.
6. Synchronize when authenticated and the API is reachable.
7. Apply the server acknowledgement/canonical revision without duplicating the local action.

A crash between local save and network transmission must not lose the operation. A network response lost after server commit must be safely retried with the same operation ID.

### 11.3 Required server cooperation

The API must support:
- Stable IDs and idempotent operation processing scoped to the authenticated user.
- Expected-revision checks for mutable aggregates.
- Atomic transfers and other coupled writes.
- Incremental changes with a server-issued cursor and deletion tombstones.
- Per-operation accepted/conflict/rejected outcomes.
- Defined idempotency retention and behavior after a long offline period.

Delivery is **at least once with idempotent effects**, not a magical exactly-once network guarantee.

### 11.4 Ordering and retry

- Preserve dependency order: create a book/account/goal before dependent entries.
- Serialize conflicting writes to the same aggregate where necessary.
- Use bounded exponential backoff with jitter for transient failures.
- Treat network-type information only as a hint; actual requests determine reachability.
- Refresh auth once for concurrent expired-token requests, then retry safely.
- Do not retry validation, authorization, or revision conflicts forever.
- Show failed/conflicted operations and allow correction, retry, or informed discard.
- Do not silently erase pending changes when remote data arrives. Reconcile the remote base with remaining local pending operations.

### 11.5 Proposed conflict policy

| Entity/change | Resolution |
|---|---|
| Independent append-only logs | Merge distinct IDs; repeated operation IDs have no additional effect |
| Editing/deleting an existing log | Revision check; conflict requires explicit resolution, not duplicate creation |
| Task fields | Detect concurrent edits; preserve unsent input and offer current/local choices |
| Reading position | Per-book revision check; do not add concurrent page deltas together blindly |
| Money transaction/transfer | Atomic canonical aggregate; no silent last-write-wins on amounts/accounts |
| Monthly finance plan | Revision conflict; preserve the local draft for review |
| Savings goal update | Idempotent goal entries; target edits and invalid withdrawals need revision/validation checks |
| Multiple active focus sessions | Detect overlap and ask for resolution; never count the overlap twice silently |
| Server-deleted record | Tombstone prevents stale offline update from resurrecting it |

Exact merge UI and server contracts remain approval gates. Do not advertise solved multi-device sync until these cases are tested.

### 11.6 Scheduling and visibility

Synchronize at sign-in/bootstrap, resume, successful connectivity recovery, explicit refresh, and while useful foreground activity continues. Background execution is best-effort and platform-dependent.

Provide clear pending/syncing/synced/failed/conflict indicators, with a settings or activity view for unresolved operations. Pending Money values must not look like verified bank balances.

## 12. Authentication and account isolation

### 12.1 Auth abstraction

Expose an AuthRepository/session interface to the app. If Supabase Auth is approved, its adapter handles signup/login/recovery/session refresh; feature code must not depend directly on provider session objects.

The app sends the access token to the business API. The API verifies identity and enforces ownership/audiences. A successful login does not authorize every post or conversation.

### 12.2 Credential storage

- Persist credentials using a reviewed secure-storage integration.
- Verify the auth SDK's actual persistence behavior; adding a secure-storage package does not automatically move the SDK's session out of ordinary preferences.
- Never embed service-role keys, database credentials, signing secrets, or push-service credentials in Flutter.
- Build-time defines and bundled `.env` files are extractable configuration, not secret vaults.

### 12.3 Startup and logout

Startup restores session state and the matching user database without briefly showing another user's cached dashboard.

On logout/account switch:
1. Stop authenticated sync and disconnect realtime.
2. Warn about pending unsynced data and provide a deliberate resolution path.
3. Clear credentials and detach the user's providers/database.
4. Clear sensitive in-memory/image caches and notification routing state.
5. Remove retained data according to the documented local retention choice; never silently abandon unsynced records.

Session expiry offline must not corrupt personal local records. Sensitive online actions remain unavailable until authentication succeeds again.

## 13. API integration

### 13.1 Contract boundaries

Recommended transport: versioned REST described by OpenAPI. NestJS is the confirmed backend framework; Flutter should still depend on the approved contract rather than NestJS-specific implementation details. See the linked backend specification for the proposed conventions and server responsibilities.

Generate or maintain DTOs from the approved contract. Map them to domain types; do not expose transport models everywhere. Review generated integer/date/nullability behavior before trusting it.

### 13.2 Minimum contract requirements

- Authenticated owner identity comes from the verified token, never a freely trusted request owner field.
- Dates/instants use explicit formats and timezone semantics.
- Cursor pagination has deterministic ordering; do not page an active feed solely by mutable offsets.
- Mutations support stable operation IDs/idempotency where retries can duplicate effects.
- Errors include a stable machine code, safe message, optional field errors, and correlation ID.
- Revision conflicts are distinguishable from validation failures.
- Card data contains only viewer-authorized share fields.
- Acknowledgements distinguish accepted work from asynchronous work still preparing.

Illustrative error envelope, subject to API approval:

```json
{
  "error": {
    "code": "REVISION_CONFLICT",
    "message": "This record changed on another device.",
    "fieldErrors": {},
    "correlationId": "opaque-request-id"
  }
}
```

### 13.3 Network behavior

- Centralize base URL, timeouts, auth, correlation IDs, redaction, and error mapping.
- Single-flight token refresh; avoid a refresh storm across many simultaneous calls.
- Respect rate-limit retry guidance.
- Cancel superseded searches/queries where useful; cancellation of a submitted mutation does not prove it was not committed.
- Retry mutations only with their original idempotency identity.
- Map unavailable/deleted/restricted social content to safe UI without revealing hidden record details.
- Keep ordinary authentication/validation failures out of crash reports unless there is an actual application fault.

### 13.4 Uploads and files

Avatar upload, poster download, and export access follow API-issued permissions. Do not turn a storage bucket into a bypass around post visibility.

Validate size/type before upload, strip unnecessary metadata, and handle interruptions. Long-lived public URLs are inappropriate for private posters. Expiring signed URLs can remain valid until expiry; where immediate revocation is required, use a reauthorizing delivery path rather than treating signed links as instant revocation.

## 14. Feature implementation breakdown

The PRD remains the full behavioral specification. The table and subsections below define mobile engineering responsibilities.

| Feature | Main mobile screens | Core data/controller responsibilities |
|---|---|---|
| Onboarding | Auth, profile basics, visibility, mode selection | Session bootstrap, validation, timezone/units, minimal required inputs |
| Today | Personal dashboard and quick capture | Compose mode summaries; scoped actions; pending state |
| Focus | Tasks, Today list, timer, history | Task transitions, durable timer state, summary queries |
| Read | Shelves, add/edit book, detail, progress | Book history, validated page updates, completion confirmation |
| Intake | Water/coffee quick logs, targets, history | Canonical units, dated targets, corrections, reminders |
| Money | Accounts, transaction form/history, plans, savings | Exact amounts, atomic transfers, revision-safe edits, privacy |
| Progress | Overall/per-mode calendars, day detail | Derived summaries, filters, accessible calendar rendering |
| Cards | Compose, privacy fields, preview, export | Allowlisted snapshots, render states, explicit publish |
| Social | Feed, profile, post, comments, follows | Audience-aware queries/actions, finite pagination, revocation |
| Messaging | Requests, conversations, thread | Durable pending sends, deduplication, history, card permissions |
| Settings | Preferences, privacy, notifications, data | User-scoped settings, export/delete requests, blocked accounts |

### 14.1 Today

- Read mode-owned summary streams instead of duplicating calculations in widgets.
- Hide Money values on this shared surface by default.
- Quick-add amounts use saved user preferences and easy correction/undo.
- A successful local write updates the dashboard without waiting for the server.
- Do not request all historical rows whenever one number changes.

### 14.2 Focus tasks

- Keep Today placement distinct from due date.
- Completion/reopening is a state transition; repeated taps/retries do not create repeated achievements.
- Reopening/correcting a task updates affected summaries consistently.
- Task deletion does not silently destroy otherwise valid focus-session duration; preserve session history with an appropriate missing-task state.
- Timer association is optional in both directions.
- No project boards, dependencies, or collaboration engine in V1.

### 14.3 Read

- Store page-position history, not only a mutable current-page number.
- Derive progress from valid ordered entries and recalculate after corrections/deletions.
- Detect concurrent updates to the same book; two offline devices must not double-count pages.
- Validate page bounds where total pages are known.
- Preserve unknown totals and avoid a fabricated percentage.
- Confirm finishing and keep notes private unless deliberately selected.
- Manual book entry and placeholder covers must work without third-party catalog access.

### 14.4 Intake

- Keep Water and Coffee as separate record types/metrics within one mode.
- Quick-add, edit, delete, and history operate through the same repository rules.
- Effective-dated water targets prevent a new target from rewriting past attainment silently.
- Do not import the old water app's negative-removal ledger pattern without reviewing how it fits the PRD's edit/delete behavior.
- Keep cup/shot quantities distinct; no inferred caffeine score or hydration equivalence.
- Reminder configuration is independent of published-card activity.

### 14.5 Money

- Represent income, expense, transfer, opening balance, and adjustment explicitly.
- A transfer is one atomic logical operation, not two independently retried records.
- Keep balances, income/expense reports, and transfer totals semantically distinct.
- Validate and format monetary input without binary floating-point conversion.
- Account archives preserve transaction references and history.
- The monthly plan separates expense budgets and planned savings; plans do not move balances.
- Savings uses the PRD's proposed independent planning ledger until an alternative is approved. It does not reserve funds or add assets.
- Balance adjustments are not regular income/expense.
- Local totals include pending operations visibly; canonical server corrections reconcile the local projection.
- Apply hide-amounts settings consistently to expanded panes, previews, and accessibility labels; visual hiding alone must not leave amounts readable by assistive technology.
- Never add automatic bank access, payment credentials, or financial recommendations under the label of "sync."

### 14.6 Settings and personal-data controls

- User preferences are explicit and user-scoped; hiding a mode does not delete history.
- Export/delete flows require appropriate authentication and confirmation.
- Downloaded personal exports are sensitive temporary files with deliberate external-share warnings and cleanup.
- A server export/deletion job has progress/failure states; do not claim completion before acknowledgement.
- The mobile UI must reflect the final approved retention/message-history policy rather than inventing its own.

## 15. Focus timer engineering

### 15.1 Persistent state machine

Recommended transitions:

| Event | From | To |
|---|---|---|
| Start | Idle | Running |
| Pause | Running | Paused |
| Resume | Paused | Running |
| Countdown reaches its end | Running | Completed |
| User finishes a count-up session | Running or Paused | Completed |
| User saves an interrupted countdown | Running or Paused | Finished early |
| User discards | Running or Paused | Discarded |

Completed, finished-early, and discarded are terminal states. Breaks are distinct from focus sessions. Starting a break or the next interval requires explicit action in V1.

Persist session ID, mode, planned duration if applicable, timing segments/pause information, associated task/label, and terminal state. Finalization must be idempotent.

### 15.2 Timekeeping

- Use persisted timing data to reconstruct the display after restart/resume.
- Use a monotonic clock while actively measuring in-process elapsed time where supported; do not equate each UI tick with one reliably elapsed second.
- Wall-clock changes/reboots can invalidate assumptions. Detect significant anomalies and resolve them visibly rather than claiming verified time.
- A foreground ticker refreshes the display only; it is not the persisted source of truth.
- Countdown focus time stops at its defined end, not when the user next opens the app hours later.
- Count-up behavior after long background periods must be explained; elapsed time is self-reported activity, not proof of attention.
- Exclude pauses and breaks from focus totals; split minutes across local midnight as required by the PRD.

### 15.3 Notifications and multi-device conflicts

Schedule/cancel a local completion notification using the persisted session identity. Pausing, changing, discarding, and finishing must update the schedule without duplicate alerts.

Do not require a permanent background service or special exact-alarm entitlement simply to keep the display correct. Notification timing is subject to device permissions/power management.

Online, use the server's active-session coordination. Offline overlap is reconciled later; retain evidence of conflicting intervals and require a resolution that does not double-count time.

## 16. Progress calendars and summaries

### 16.1 Projection rules

Follow the PRD's proposed overall intensity: count distinct modes with qualifying activity, capped at four. Do not sum pages, currency, drinks, and minutes into one score.

Derive from source records; social interactions do not contribute. Hide/show dashboard settings must not erase historical activity.

A correction/deletion invalidates the relevant days/period summaries. Goal changes use their effective dates. Timezone changes preserve intended historical activity dates.

### 16.2 Query and rendering strategy

- Aggregate by day with indexed queries or tested incrementally maintained projections.
- Query the visible period rather than loading every raw record to render a year.
- Use bounded/lazy rendering or an efficient painter where necessary; preserve hit-testing and accessible day details.
- Allow deliberate horizontal calendar navigation when a year cannot be read at compact width.
- Screen readers receive date, mode activity, and meaningful summary—not only a color description.
- Distinguish recorded activity from meeting a target. Coffee/spending volume must not imply a better life score.

## 17. Progress poster rendering and sharing

### 17.1 Structured snapshot

Create a versioned CardDraft/CardSnapshot model containing only selected shareable fields, such as author attribution, card type, period, allowed metrics, template version, and optional caption.

Do not pass an entire Money account, task object, or reading-note collection to the renderer and merely hide fields visually. Excluded information must be absent from public/accessible payloads and image metadata.

### 17.2 Private preview/export

V1-A can render the user's own local draft with Flutter's rendering/canvas facilities:
- Fixed template dimensions independent of the device's screen size/pixel ratio.
- Approved fonts/assets loaded before rendering.
- Bounded image resolution/memory use; no giant invisible widget tree.
- Equivalent accessible text.
- Explicitly private save/export, not a social post.

Pending/self-entered records must not be presented as verified achievements. Local export does not establish that server publication succeeded.

### 17.3 Published card flow

For social publishing, the proposed backend generates/validates the canonical snapshot from synchronized source references and selected fields, then prepares its final image.

Recommended flow:
1. Synchronize required source records or explain why publication cannot proceed.
2. Submit the draft/source revisions and desired audience for validation.
3. Receive the canonical snapshot/final render or preparation status.
4. Show the exact final content and privacy preview, including any server-corrected values.
5. Confirm publication explicitly; the server rechecks audience/source validity at commit.

A backend worker may produce the image. No AI image model is required. If local and server renderers both exist, version templates and use fixtures/visual tests; never assume two renderers are pixel-identical.

### 17.4 Sharing safeguards

- Own-card external exports use the platform share sheet and a safe temporary file.
- Use the correct share anchor/presentation rectangle on iPad where the sharing plugin requires one; test tablet popovers explicitly.
- Private export warns that the app cannot recall copies/screenshots.
- Other users' cards are shared as authorized references/links in V1, not detached copies.
- Editing/deleting a source warns about existing snapshots and offers the PRD's unpublish/regenerate path.
- No automatic sharing after logging or reaching a goal.

## 18. Social data and cache permissions

### 18.1 Access is separate from identity

Public/private profile visibility does not expose raw trackers. Every profile/post/comment/repost route must use viewer-authorized API responses.

The client does not grant access based solely on a cached `isFollowing` flag or an old signed image URL.

### 18.2 Cache policy

- Own personal tracking records are available offline within the user's protected local store.
- Keep third-party private card previews out of persistent generic disk/image caches in V1.
- Revalidate sensitive social views when entering/resuming them and after relevant access events.
- Clear known-revoked post/card data across feed, profile, detail, notification, and DM preview state.
- On permission uncertainty, show a loading/unavailable state rather than stale private content.
- Server image delivery must honor the same access policy; a public bucket URL is not a private-post solution.

No client can erase a screenshot, exported file, or data already seen on a disconnected device instantaneously. The promise is enforced online access, prompt handling of known revocation, and no deliberate offline entitlement to someone else's private cards—not impossible remote recall.

### 18.3 Feed and engagement

- Cursor-based chronological batches with a clear manual Load Older action.
- No automatic fetch merely because the user reaches the bottom.
- Preserve reading position; offer a deliberate indication of newer content rather than jumping.
- Likes are idempotent desired-state actions, not blindly replayed toggles.
- Comments/replies respect the PRD's one-level reply limit, editing/deletion, reporting, and blocking.
- Reposts reference original content and are suppressed when source eligibility changes.
- A failed authorization restores any optimistic action and removes unauthorized content.
- Access errors use safe copy that does not reveal private titles, financial values, or account state unnecessarily.

## 19. Messaging and realtime

### 19.1 Durable send flow

1. Create a user/conversation-scoped draft and stable client message ID.
2. Show pending after the local send state is stored.
3. Send through the approved API/socket command with that same ID on retries.
4. Server verifies participant/request/blocking permissions and saves the message durably.
5. Acknowledge with server message ID/order information.
6. Reconcile the pending row; a duplicate event/ack must not duplicate the message.

"Sent" means server-accepted, not recipient-read. Delivery/read receipts beyond the PRD are not silently introduced.

### 19.2 Socket lifecycle

- One authenticated connection per active account context, not one per widget.
- Refresh/reconnect safely when credentials change.
- Join only server-authorized conversation scopes.
- Reconnect with backoff and fetch missing history/cursors.
- Order by server sequence or another approved deterministic key; do not rely only on client timestamps.
- Disconnect/stop unnecessary work when appropriate in background; use push for alerts.
- Socket events may be duplicated, delayed, or missed. REST/history reconciliation closes gaps.

### 19.3 Requests, blocking, and shared cards

- Distinguish requests from accepted conversations.
- Accept/decline/block/report require server confirmation.
- Queued sends recheck current permissions when submitted; a stale client must not bypass a later block.
- A shared card is a source reference, not an image copied around access control.
- Card previews revalidate source visibility; unavailable cards preserve only an appropriate neutral placeholder.
- Message text/history retention follows the approved policy. No E2E encryption claim unless actually implemented and evaluated.

## 20. Notifications and device permissions

### 20.1 Local versus remote

| Notification | Delivery mechanism | Important limitation |
|---|---|---|
| Focus completion | Scheduled local notification | OS timing/permissions; timer correctness does not depend on alert delivery |
| Water reminder | User-configured local schedule | Quiet hours, disable/pause, scheduling limits |
| Comment/follow/repost event | Server-triggered push | Check current audience/blocking rules before delivery |
| DM/request | Server-triggered push | Generic preview by default; app reauthorizes linked content |

FCM requires platform setup; iOS delivery uses APNs. Firebase Messaging is not a decision to use Firestore or a second application database.

### 20.2 Permission policy

- Ask for notifications only after explaining a useful action.
- Handle denied/revoked permissions without breaking tracking.
- Use system photo pickers for optional avatars rather than broad library access where supported.
- No contacts, location, microphone, or camera requirement for V1's core flows.
- Do not request restricted exact-alarm/background privileges without a justified requirement and store-policy review.
- Define Android notification channels and iOS categories deliberately; configure required manifests/entitlements against current platform policies during implementation.
- Handle push-token rotation, logout/account reassignment, invalid tokens, and duplicate notifications.
- Quiet hours, notification categories, and sensitive-preview preferences apply consistently.
- Deep-link handling always fetches and authorizes content; notification payloads contain minimal identifiers, not raw financial/message data.

## 21. Security and data lifecycle

### 21.1 Local data

- Store databases/files in app-private locations with appropriate platform data protection.
- Exclude sensitive databases, outbox payloads, exports, and credentials from uncontrolled cloud/device backups as required by the chosen recovery policy.
- Given Money and messaging, application-level database encryption is the recommended production default, subject to a validated Drift/driver integration.
- Validate encryption support, database-isolate compatibility, key creation/storage, migration, lock/unlock behavior, backup implications, and key-loss recovery before using real sensitive data.
- Do not claim SQLite is encrypted merely because the phone has a lock screen or the credentials are in secure storage.
- Protect sensitive content in app-switcher snapshots where supported; hiding amounts is not encryption.

The exact encrypted driver and retention policy are release decisions, not guessed dependencies in this document.

### 21.2 Transport and diagnostics

- HTTPS only for production APIs and media.
- No tokens, full headers, financial amounts/notes, message bodies, or private drafts in ordinary logs.
- Redact crash breadcrumbs and disable automatic screenshots/session replay unless deliberately reviewed and consented to.
- Treat external links, route inputs, downloaded files, and displayed user text as untrusted.
- Do not ship debug bypasses, staging credentials, or permissive TLS overrides.
- Server-side authorization remains mandatory even if the UI hides actions.

### 21.3 Export, deletion, and revocation

- Confirm reauthentication requirements for personal exports and destructive account actions.
- Clear downloaded export files and previews after a documented reasonable lifecycle; external copies cannot be revoked.
- Account deletion must stop sync, invalidate sessions, remove local account state, and reflect the server's processing/retention policy.
- Distinguish deleting a local conversation view from deleting messages for another participant.
- Handle logout with unsynced data explicitly rather than silently deleting records.

## 22. Performance and observability

### 22.1 Performance practices

- Use lazy lists/grids for histories, books, feed, and messages.
- Index queries for owner/date/account/book/conversation lookup patterns as appropriate.
- Aggregate in storage/projections rather than loading every source row into widgets.
- Keep expensive poster preparation and database work off the interactive path where supported.
- Avoid broad provider rebuilds and unnecessary simultaneous dashboard calls.
- Decode images at useful sizes; bound caches and card-render memory.
- Dispose controllers/subscriptions, but retain deliberately app-scoped services.
- Profile release/profile builds on representative devices; debug/simulator timing is not a production benchmark.

### 22.2 Proposed measurement budgets

Set final targets after baseline devices are approved. Initial investigation targets, not measured guarantees:
- Common local quick-log acknowledgement: p95 at or below 200 ms on the agreed reference device/data fixture.
- Smooth interaction within the relevant refresh-rate frame budget; investigate UI/raster jank separately.
- Large-history queries and sync must not block text input/timer controls.
- Poster export must have bounded resolution/memory and a visible cancellable/preparation state where useful.

A slow server request must not make the user believe a failed local write was saved. Instrument local persistence and server acceptance separately.

### 22.3 Operational signals

Measure redacted technical outcomes: crash-free usage, startup stages, local write failures, sync lag/conflicts, duplicate prevention, reconnect failures, and rendering/query latency.

Do not collect exact balances, message contents, notes, or card-private fields in general telemetry. Analytics should support tracking usefulness and reliability, not optimize feed time.

## 23. Testing and acceptance matrix

### 23.1 Test layers

| Layer | Required coverage |
|---|---|
| Pure Dart/unit | Money arithmetic, date/goal rules, reading deltas, timer transitions, card field allowlists |
| Database | Transactions, queries, migrations, outbox durability, tombstones, account isolation |
| Repository/sync | Retry after lost response, conflicts, ordering, merge/rejection, auth expiry |
| Widget | Forms, validation, loading/error/offline states, navigation, semantics |
| Adaptive widget | Each class, boundary widths, short height, large text, keyboard insets, resize state |
| Golden/visual | Key component/layout/template fixtures under deterministic fonts/data |
| API contract | DTO compatibility, integer precision, errors, pagination, revisions |
| Integration/device | Full journeys, background/resume, notifications, deep links, export/share, logout |
| Security/privacy | Viewer matrix, cache revocation, log redaction, account switch, sensitive exports |

Golden tests do not replace semantics or real-device checks. Stub clocks, IDs, network, and notifications through injected interfaces where appropriate.

### 23.2 Adaptive test sizes

At minimum, cover the PRD matrix:
- 320 x 568 and 390 x 844.
- 568 x 320.
- 768 x 1024 and 1024 x 768.
- 1024 x 1366 and 1366 x 1024.
- Split-screen widths and live transitions.
- Widths 599/600, 839/840, and 1199/1200 for the proposed policy.
- Default and large text scaling, including 200% where supported.
- Keyboard-open forms, long labels/content, empty/loading/error states.

Assert primary controls remain reachable and essential data is not clipped. Test that active timers, selected entities, editor input, and message drafts survive reflow.

### 23.3 Critical failure scenarios

- App terminated after local commit but before synchronization.
- Server commits, response is lost, client retries.
- Child operation created before its unsynced parent is uploaded.
- Two devices edit the same transaction or book position.
- Stale offline update targets a deleted record.
- Two offline focus sessions overlap.
- Device timezone/DST changes or wall clock jumps.
- Access token expires during a batch of calls.
- Private card loses permission while open or in a DM preview.
- Account becomes private after its card was reposted.
- Message retry occurs after the recipient blocked the sender.
- Logout/account switch occurs with cached Money data and pending operations.
- Migration occurs with unresolved outbox records.
- Notification permission is denied or scheduling is delayed by the OS.
- Export/share opens on iPad and after a resize.

### 23.4 PRD traceability

| PRD requirements | Mobile verification focus |
|---|---|
| ACC, DAY | Session isolation, usable onboarding, quick durable capture |
| FOC | State machine, pause/break exclusion, lifecycle recovery |
| READ | History correctness, corrections, confirmed completion |
| INT | Canonical units, target history, separate cup/shot measures |
| MON | Exact values, atomic transfer, no double-counted savings |
| PROG | Date/goal projections, edits/deletions, meaningful intensity |
| CARD | Allowlisted data, snapshot semantics, privacy preview/export |
| SOC, FEED | Audience checks, finite chronology, revocation and interaction rules |
| DM | Idempotent durable sends, requests/blocking, authorized card references |
| NOT, SAFE, DATA | Permissions, reporting, retention/export/deletion flows |
| NFR-01 through NFR-09 | Accessibility, integrity, offline behavior, security, performance, all window classes, appearance and theme persistence |

## 24. Tooling and delivery pipeline

### 24.1 Environments

Maintain development, staging, and production configurations with separate API/auth/push resources and application identifiers as appropriate.

Public base URLs and public provider configuration may be build-time settings. Server secrets must never enter the bundle. Show a clear non-production marker in development/staging builds.

### 24.2 Quality checks

After scaffolding and dependency approval, the CI pipeline should run:
- Formatting verification.
- Static analysis.
- Code-generation freshness checks.
- Unit, widget, database, migration, and contract tests.
- Deterministic golden checks on a controlled runner.
- Android build and integration smoke tests.
- iOS build and selected iPhone/iPad checks on macOS.

Illustrative commands, to be finalized when the referenced directories exist:

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --output=none --set-exit-if-changed lib test integration_test
flutter analyze
flutter test --coverage
flutter build appbundle --release --target lib/main_production.dart
# On macOS, a non-signing build check is separate from distribution signing:
flutter build ios --release --no-codesign --target lib/main_production.dart
```

A successful unsigned build is not proof of notification, signing, or store-distribution readiness.

### 24.3 Release controls

- Protect Android signing keys and Apple signing credentials in CI-managed secrets.
- Version database migrations and API compatibility alongside app releases.
- Test staged rollout, minimum supported API versions, and safe mandatory-update behavior if required.
- Validate privacy labels/data-safety disclosures and account-deletion entry points.
- Review authentication provider choices against store sign-in requirements, including Apple rules where applicable.
- Ensure support/report handling exists before public social launch.
- Feature flags may stage incomplete functionality, but must not substitute for backend authorization.

## 25. Existing-app reuse assessment

The completed M00-T03 static audit retains these reference ideas, not source code or dependency selections:

| Repository | Observed technical direction | Candidate reuse |
|---|---|---|
| `personal_finance_tracker` | Riverpod, sqflite, balance service, finance-related tests | Transaction semantics, balance fixtures, forms and reporting interactions |
| `water_intake_logger` | Bloc, Drift, hydration repository | Local storage/query patterns, daily targets, quick capture |
| `coffee_shot_track` | GetX, sqflite, local image-related dependencies | Quick-entry/edit interaction only; rebuild cups/shots model, exclude beans/cafes/orders/photos |
| `book_read_tracker` | Riverpod-coupled repository interface, sqflite implementation | Shelf/progress interactions; rebuild a framework-independent boundary |

The [M00-T03 static audit](cookbook/reference-app-audit.md) and [dependency/provenance register](cookbook/reference-app-licenses.md) record source identities, resolved notices, storage/export/migration paths and final reference-only/rebuild/exclude dispositions. M00-T03 is Verified as an inventory task, not runtime or legal clearance. Some README descriptions lag implementation; source observations and unrun test assertions are not passing application tests. No reference code/assets or dependency tree is adopted; uncleared provenance remains a copying blocker.

Do not:
- Merge four navigation shells or theme systems.
- Preserve three state-management libraries without a concrete need.
- Copy generated database files as if they define the new schema.
- Assume local-only models already handle multi-user IDs, revisions, synchronization, or access control.
- Import old features beyond V1 just because code exists.

Use the recorded domain/test ideas to write new requirement-based synthetic fixtures; do not copy fixture implementations without provenance review. Rebuild shared navigation, design tokens, identity, encrypted storage metadata, exports and sync foundations coherently. Finance's native Apex port does not select a Flutter chart package or establish user-web licensing; obsolete SQLCipher-named dependencies in water do not prove encryption.

Importing users' existing local data is not yet promised. If required, design and test an explicit versioned import rather than silently replacing old app storage.

## 26. Implementation sequence

### Phase 0 — Validate and approve

- Resolve the mobile package/version baseline, OS targets, and backend/auth contract decisions.
- Audit reusable features and identify correctness gaps.
- Spike adaptive shell, Drift migrations/encryption, auth persistence, timer recovery, local notifications, and iPad sharing.
- Approve offline scope and conflict rules before committing to full multi-device behavior.

### Phase 1 — Foundation and first vertical slice

- Scaffold the mobile app, design tokens, adaptive navigation, session scope, and CI.
- Implement per-user storage, repository interfaces, outbox, and basic API adapter.
- Deliver a complete water quick-log slice across all four window classes, including offline/retry/migration tests.
- Validate sync end-to-end before duplicating the pattern across modes.

### Phase 2 — Complete V1-A personal functionality

- Add Read and Focus, including durable timers.
- Add Money with exact-value tests and atomic transfers.
- Integrate Today and Progress from mode-owned queries.
- Add private card previews/exports and personal data controls.
- Pass V1-A acceptance, accessibility, and adaptive checks.

### Phase 3 — V1-B social publishing

- Add canonical card publication and explicit privacy previews.
- Profiles, public/private follows, feed, likes/comments, authorized links/sharing.
- Notification preferences, blocking/reporting, and cache revocation.
- Complete backend moderation/support dependencies before public exposure.

### Phase 4 — V1-C social completion

- Add repost source handling and invalidation.
- Add one-to-one messaging, requests, durable retries, and push integration.
- Test privacy across posts, reposts, notifications, and DM previews.
- Run full device/resizing/lifecycle/recovery acceptance before calling the product full V1.

These are dependency stages, not promised calendar dates. Estimate after the technical spikes and existing-app audit.

## 27. Open decisions and release gates

### Before scaffolding

- Approve Riverpod, Drift, Dio, go_router, and the exact compatible SDK/package set.
- Confirm the repository location and target OS/minimum versions.
- Follow the accepted Android-first pilot order and obtain a macOS testing path; iPhone/iPad validation remains required.
- Approve initial design tokens and validate the proposed breakpoints with real content.

### Before real sensitive data

- Validate encrypted persistence/key management, backup rules, and local retention.
- Approve the auth provider and secure session persistence behavior.
- Define sync idempotency/revision/cursor contracts and conflict UX with the API.
- Validate exact currency representation, timezone/rounding rules and data import expectations. Single currency locked after monetary records and independent savings semantics are accepted in Decision 0003; implementation correctness is not yet verified.

### Before social rollout

- Approve canonical poster rendering, private-media delivery, and cache-revocation behavior.
- Finalize DM requests, message retention, notification previews, and safety/report workflows.
- Confirm age/region/store/privacy obligations from the PRD.
- Pass the PRD privacy matrix and adaptive tests on the released features.

### Definition of mobile technical readiness

The Flutter app is ready for a release stage when its scope is usable across all four window classes, survives ordinary interruption/retry without losing or duplicating records, respects current permissions on every online surface, and passes the stage's tested data/security/accessibility requirements.

**Responsive layouts, offline correctness, and privacy are architectural requirements—not cleanup tasks after the screens are finished.**
