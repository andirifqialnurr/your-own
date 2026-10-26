# Your Own — Testing & Quality Strategy

- **Version:** 0.16
- **Status:** Verification strategy; initial API and Flutter host suites exist, native/product/CI coverage still pending
- **Related:** [Architecture](architecture.md) · [Schema](schema.md) · [Security](security.md) · [Deployment](deployment.md) · [Design system](design-system.md)

The goal is evidence of correct behavior across clients and failure modes, not only a high line-coverage percentage. This file consolidates shared tests; detailed acceptance IDs remain in the product/mobile/backend/web/admin specifications.

## Contents

- [1. Test ownership and tools](#1-test-ownership-and-tools)
- [2. Deterministic environments and fixtures](#2-deterministic-environments-and-fixtures)
- [3. Domain correctness](#3-domain-correctness)
- [4. Transactions and synchronization](#4-transactions-and-synchronization)
- [5. Authorization and privacy matrix](#5-authorization-and-privacy-matrix)
- [6. Browser and staff security](#6-browser-and-staff-security)
- [7. Realtime, jobs, and notifications](#7-realtime-jobs-and-notifications)
- [8. Adaptive UI and accessibility](#8-adaptive-ui-and-accessibility)
- [9. Contract and cross-client compatibility](#9-contract-and-cross-client-compatibility)
- [10. Performance and recovery](#10-performance-and-recovery)
- [11. CI and release gates](#11-ci-and-release-gates)
- [12. Evidence and traceability](#12-evidence-and-traceability)

## 1. Test ownership and tools

| Layer | Proposed tools | What it proves |
|---|---|---|
| Pure Dart/domain | Dart/Flutter tests, injected clock/IDs | Local calculations, timer rules, field selection |
| Flutter persistence | Drift tests and real supported SQLite/encryption integration | Atomic local writes, migration/outbox preservation |
| Flutter UI/device | Widget, golden, integration tests; Android/iOS devices/simulators | Adaptive flows, semantics, lifecycle/native integrations |
| NestJS domain/API | Node built-in runner and loopback HTTP for the initial shell; Jest/Supertest remain later candidates | Initial config/health behavior now; domain/policy coverage later |
| Database/concurrency | Real PostgreSQL fixtures/Testcontainers where appropriate | Actual constraints, locks, isolation, commit-order behavior |
| Queues/recovery | Real selected Redis/worker integration plus controlled failures | Durable outbox, retries, duplicate handling |
| React/browser | Unit/component tests, Testing Library, Playwright | Forms, sessions, cache safety, browser journeys |
| Accessibility | Automated checks plus keyboard/screen-reader review | Real usability beyond snapshots |
| Contracts | OpenAPI generation and Dart/TypeScript compile fixtures | Compatible schemas, precision, errors, dates |

[Decision 0011](decisions/0011-supported-environment-review-order.md) permits an early [supported-environment review](supported-environments-review.md) to resolve targets needed by final toolchain selection. Its device/browser lanes, accountable test assignments and measurement budgets are proposals, not available equipment or approved environments. Record exact accepted tuples and human test ownership before claiming coverage; neither a host test nor a WebKit runner substitutes for native iPad/Safari evidence.

The [Windows/emulator plan](windows-emulator-validation-plan.md) records a separately authorized read-only P0 host inventory, resource/isolation prerequisites and eight future synthetic cases. Metadata collection is complete and the [P1 static feasibility review](windows-emulator-feasibility.md) holds setup on unresolved constraints and an unaccepted budget; all eight cases remain Not run. Neither the plan, inventory nor source comparison authorizes SDK installation or emulator execution. Emulator ABI/lifecycle/timing results remain supplementary to physical Android/iOS/iPad and actual browser evidence.

[Decision 0012](decisions/0012-local-development-bootstrap.md) authorizes local coding independently of the emulator investigation. See the [bootstrap report](local-development-bootstrap.md), [API tests](../../apps/api/README.md#check) and [Flutter checks](../../apps/mobile/README.md#host-setup-and-checks) for actual commands and coverage. Node's built-in runner avoids adding a test framework for the initial API shell; Flutter uses its SDK test runner. The [appearance checkpoint](mobile-appearance-foundation.md#verification-and-traceability) adds real-font widget/semantic/contrast checks and strict preference-adapter doubles; those doubles do not prove native persistence or system-bar rendering. The [adaptive checkpoint](mobile-adaptive-shell.md#verification-and-traceability) adds actual go_router branch/detail fixtures, 19 viewport cases in both themes/100–200% text, insets, long labels, keyboard/focus, safe Back and icon mapping. It does not prove native rotation, IME, screen readers, process-death restoration or real tracker/privacy workflows. Further package versions and runners remain pending. SQLite/in-memory mocks cannot prove PostgreSQL locking. Golden images cannot prove authorization or accessibility. Provider mocks do not prove real APNs, identity callback, or storage behavior.

## 2. Deterministic environments and fixtures

- Synthetic users with explicit roles/relationships, never casually copied production records.
- Owner, approved follower, non-follower, pending requester, removed follower, blocked user, suspended/deleting user, anonymous viewer if enabled, and scoped staff identities.
- Default/fresh/stale/expired MFA and staff-grant states.
- Injected clock/UUID/network/provider adapters for repeatable tests; deterministic fonts/assets and explicit locales/timezones.
- Small fixtures for correctness plus approved large-history datasets for query/render/migration tests.
- Multi-device/tab clients with retained old revisions and controlled offline operations.
- Failure injection at local commit, server commit, response delivery, enqueue, provider acceptance, worker completion, and restore boundaries.

Use UTC plus representative IANA zones including a DST-transition zone. Do not base tests on the runner's local date/timezone. Namespace test IDs/databases/queues so parallel runs cannot contaminate each other.

## 3. Domain correctness

### Money

- Opening 500 + 1,000; transfer 200 leaves combined 1,500 and no income/expense increment.
- Income/expense/adjustment/opening classifications remain separate.
- Savings contribution/withdrawal changes only planning progress, never assets or account balance.
- Budget planned savings does not create a transaction; card percentages label the correct denominator/subset.
- Exact decimal-string/minor-unit round trips include values beyond JavaScript's safe integer range and explicit range rejection.
- Same-account, cross-owner/currency transfer, invalid signs/posting counts, partial edits, and overflow are rejected consistently.
- Deleting/correcting savings history cannot create invalid negative goal progression under the approved ordering rule.

### Focus, Read, Intake, Progress

- Countdown/count-up transitions, finalization idempotency, pause/break exclusion, clock anomalies, crossing local midnight, and abandoned slot recovery.
- Page 40→58 contributes 18; corrections/deletions/backdating recompute valid reading history, unknown totals stay unknown, finish is explicit.
- Water 250→200 reduces the date by 50; ounce conversion occurs once under the approved rule; cups/shots do not affect water target.
- Effective-dated goals preserve historical attainment; hiding a mode does not delete contributions.
- Overall intensity counts distinct qualifying modes, not volume/spending/likes/messages.
- Rest/restart/empty states use neutral semantics, not false failure or achievement claims.

## 4. Transactions and synchronization

| Scenario | Required result |
|---|---|
| Crash after local record save | Matching durable outbox command exists, or neither was committed |
| Crash before server commit | No accepted partial mutation/receipt/change |
| Server commit succeeds, response lost | Same operation retry returns accepted identity without duplicate effect |
| Same operation ID with changed payload | Conflict; not accepted as a correction |
| Transfer fails during posting creation | Header/postings/receipt/change roll back consistently |
| Child before unsynced parent | Safe dependency-pending result; no orphan |
| Two edits to same book/transaction base revision | Explicit conflict, no silent total inflation/overwrite |
| Two online focus starts | One authoritative active session |
| Offline overlapping sessions | Preserved resolvable conflict; no double-counted overlap |
| Deleted source receives stale update | Tombstone prevents resurrection |
| Low sequence allocated but late commit | Client cursor cannot skip the eventual change |
| Bootstrap while writes occur | Immutable consistent generation/watermark followed by complete delta pull |
| Cursor/receipt horizon expired | Safe resync/rebase with local pending input preserved |
| Remote projection arrives with newer local pending edits | No blind overwrite/discard of pending operations |

Use real concurrent connections/barriers to force ordering, not a test that happens to send requests sequentially. Exercise all mutation paths, including website REST writes that must enter the mobile personal change stream.

## 5. Authorization and privacy matrix

For every relevant resource, exercise direct API, feed/profile, detail, comments/reactions, repost, media bytes, metadata/HTML/RSC, notification, worker, and DM preview.

| Viewer/state | Required distinction |
|---|---|
| Owner | Own private records; not authority over another user |
| Approved follower | Allowed selected follower content, never raw trackers |
| Non-follower/pending/removed | No follower-only fields/previews |
| Blocked user | No new contact; authenticated discovery/interactions respect block |
| Suspended/deleting/deleted account | Lifecycle denial; no queued publication or stale-token resurrection |
| Anonymous, if approved | Only currently effective-public projection |
| Staff | Current scoped capability/evidence, no unrestricted finance/DM browsing |

Repeat after public→private→public, post deletion, audience narrowing, follower removal, block/unblock, suspension, staff revocation, and cache warming. Verify old public generations do not become public again without explicit widening.

Use known synthetic private field canaries to inspect unauthorized responses, metadata, snapshots, ordinary logs, image output, and accessible text. Expected owner-only export/own-screen output is a different context, not a blanket ban on showing a user's own data.

## 6. Browser and staff security

The [framework-auth candidate matrix](framework-auth-review.md#4-proposed-ownership-and-next-local-evidence) remains **Not run**. First-party Nest package source/peer/notice review is not execution of its services or concurrency contract suite. The proposed first real-module spike would use synthetic users/mail sinks outside the app only after scoped authorization; Prisma/PostgreSQL races, actual browser/native behavior and staff TOTP freshness need later separate evidence.

The [owner-authorized R2/CDN checks](r2-connection-check.md) establish signed metadata/list access only: 200 twice, empty listing; public base and absent-object HEAD return 403. No existing-object delivery, PUT/GET/DELETE, browser CORS, private/public bucket isolation, expiry/revocation/cache/deletion or backup proof exists. Connection success does not verify media authorization or the auth integration.

The [M00-T06/T07 review matrix](authentication-session-review.md#4-required-evidence-matrix-for-t07) remains the full required proof, not a checked-off list. [Decision 0015's](decisions/0015-auth-methods-and-local-protocol-spike.md) authorized [local synthetic phase](authentication-session-spike.md) now passes 92 cases twice with six expected-red guard-removal controls. Real signed-token/loopback HTTP and explicit barriers exercise a disposable protocol with in-memory authorities; real auth revocation/MFA, actual browser cookie/CSRF and native callback/storage proof remain unrun. Decision 0016 subsequently withdraws Supabase; those historical provider-specific assumptions must not be carried into a replacement implementation without review. Neither health nor DB probes nor these doubles establish full identity acceptance.

- CSRF from unrelated origins and hostile sibling subdomains; missing/invalid tokens/Origin must follow the approved policy.
- OAuth state/PKCE/nonce, safe redirects, replayed callbacks, session fixation/rotation.
- Provider tokens/service keys absent from browser storage, bundles, URLs, RSC props, and diagnostics.
- Distinct web/admin sessions; normal user and low-assurance/revoked staff contexts cannot call operator APIs.
- Logout/account switch/back-forward restore never reveals another user's cached Money/evidence.
- Private images avoid public optimizer/CDN paths; SSR/cache hits still enforce current viewer access.
- Malicious captions/comments/evidence/link URLs cannot execute scripts or trigger renderer SSRF.
- Restricted evidence views audited; staff cannot turn report or export-status permissions into broad private-data access.
- Conflicting reviewers and stale target/reason forms cannot silently overwrite a case decision or sanction the wrong account.
- Staff changes require capability/assurance; self-escalation and last-admin recovery protections work.

## 7. Realtime, jobs, and notifications

- Durable message acknowledgement, duplicate send/event reconciliation, server ordering, reconnect/history gap recovery.
- Commit a block between initial request and lock acquisition: new contact must recheck and fail.
- Card references never grant recipient source access; revoked/deleted source becomes unavailable.
- Connection ticket, if adopted, cannot authenticate REST, select another actor, or confer staff rights; expiry/replay/room scope tested.
- API commit before enqueue crash, enqueue before dispatcher acknowledgement crash, worker retry, Redis loss, lease expiry, and restart.
- Rendering finishes after source/account eligibility changes: no automatic/unauthorized publication.
- Push response lost after provider acceptance: stable application event/deduplication, no false exactly-once guarantee.
- Token rotation/account reassignment, quiet hours, denied notifications, delayed local alerts, and generic sensitive previews.
- Operator retry uses eligible current state and cannot modify metrics, publish drafts, or replay financial commands.

Real push/Universal Links/iPad sharing checks need approved device/sandbox validation beyond mocks.

## 8. Adaptive UI and accessibility

| Target | Representative coverage |
|---|---|
| Small phone | 320×568, 390×844 |
| Short landscape | 568×320 with keyboard/error states |
| Tablet | 768×1024 and 1024×768 |
| Large iPad | 1024×1366 and 1366×1024 |
| Boundary transitions | 599/600, 839/840, 1199/1200 |
| Web/admin | 560×900, 800×900, 1280×800, 1440×900, 1920×1080, 2560×1440; high-zoom reflow |
| Short-height transition | 479/480 available interactive height, including keyboard and safe-area effects |
| Appearance | Light / Dark at every class; System tracking and explicit override |

Use the full [design-system viewport matrix](design-system.md#43-mobile-tablet-and-desktop-verification-matrix) and [component contract](design-system.md#51-universal-component-contract). Flutter sizes are logical pixels; web uses CSS pixels, not raw display resolution. Test split-screen/live resize, enlarged text, supported zoom/reflow, long localized labels, pointer/keyboard, and safe/keyboard insets.

Assert accessible primary actions, no unintended overflow, meaningful screen-reader navigation, focus restoration, contrast/reduced motion, calendar text alternatives, and no second timer/write on reflow. Preserve selected records, message/editor drafts, and practical scroll context.

The [T07 checkpoint](mobile-shared-ui.md#verification-and-traceability) adds shared-control semantic/layout/interaction cases and [ten host golden baselines](../../apps/mobile/test/goldens/README.md). Actual font/SVG loading is awaited, not replaced with placeholders. Source/implicit-glyph checks supplement rendered controls; neither proves all future SDK defaults are safe.

Use automated screenshots/goldens plus real keyboard/screen-reader/device review. Do not disable text scaling to make a test pass. Essential intentional chart/table scrolling is treated differently from broken page overflow.

Theme/component acceptance also covers:
- All applicable default/hover/pressed/focus/selected/disabled/read-only/loading/invalid/unavailable variants in Light and Dark, including dialogs, menus, pickers, charts, tables, messaging, and admin evidence.
- Persisted System/Light/Dark across restart/refresh; explicit choice wins; System follows OS changes; independent user-web/admin preference boundaries.
- Web server HTML, pre-hydration paint, hydrated controls, and native `color-scheme` agree under the actual CSP; no wrong-theme flash or hydration mismatch hidden by suppression.
- Neutral status/error/severity states remain distinguishable through labels/icons/semantics, not shades alone. Contrast tests include composited states, focus adjacency, and forced-colors mode.
- Theme changes preserve drafts, timer state, focus, scroll, selected records, hidden amounts, and source permissions without domain writes.
- Poster preview/export retains fixed dimensions and chosen template-version appearance regardless of viewer theme/size; avatars/covers retain original pixels.
- Font fallback/large text/long localization, 48-unit targets, keyboard/IME entry, and screen-reader navigation remain usable across the inventory.
- One rounded icon family covers explicit and implicit controls, including back/close/pickers, tables, dialogs and retained chart toolbars. Check source/asset provenance for Material/built-in/starter fallbacks, and inspect actual glyphs/weights/coverage; a rounded container alone does not pass. Check licenses, accessible names and decorative semantics.
- User-web ApexCharts has tested client-only loading, production build/hydration, theme/resize/selection, keyboard/touch/value alternatives and reduced motion. Verify private values do not leak through tooltips, hidden DOM, summaries or unapproved exports; clear chart state on account changes. Test zero/negative/large/missing values and exact Money labels separately from approximate plotting coordinates.
- Flutter custom charts have explicit semantics/data alternatives, interactive hit-testing where applicable, bounded repaint performance, text scaling and all four sizes/themes. Pixel goldens alone cannot pass a canvas accessibility check. See the [chart contract](design-system.md#73-chart-rendering-and-platform-ownership).

The documented palette ratios are calculations, not executed component/accessibility tests. Synthetic visual fixtures and implementation evidence must be added as components ship.

## 9. Contract and cross-client compatibility

- Generate/compile representative Dart and TypeScript clients from the approved OpenAPI artifact.
- Test exact integer strings, optional/null fields, dates/local dates, enums, safe error envelopes, cursors, command outcomes, and async job states.
- Exercise old supported mobile versions against the candidate API, including pending local operations across app/database upgrades.
- Breakage in generated contracts blocks release or requires explicit versioned migration; documentation alone is not compatibility evidence.
- Verify a web mutation appears once in Flutter sync and that all clients calculate/display the same accepted values.
- Confirm mobile offline features are not silently assumed on the online-first website or admin.

## 10. Performance and recovery

Benchmark agreed profile/release builds and actual database query plans with documented device/hardware, fixture size, concurrency, and network conditions.

Existing investigation budgets—mobile local acknowledgement p95 200 ms, backend common read p95 500 ms/simple mutation p95 750 ms—are proposals, not measured guarantees. Separately measure client/network latency, queue wait, image rendering, and export time.

Rehearse migrations, database restore, outbox/job/media reconciliation, identity mapping, and post-backup deletion/suspension/staff revocation recovery. Keep restored environments isolated until authorization/lifecycle state is safe. Measure actual RPO/RTO before approving targets.

## 11. CI and release gates

The [M01-T09 local lane](local-verification.md) now provides `node scripts/check-local.mjs` for dependency-free fresh bootstrap (`pnpm check:local` after setup), with pinned/frozen, generated-drift, documentation, formatting/lint/types, API build/unit/HTTP and Flutter widget/golden checks on the reviewed Windows host. Its initial 20 helper tests use isolated synthetic temp fixtures; [T10](fresh-checkout-review.md) adds a real-pnpm missing-dependency regression with public manifest/lock copies and no private configuration. No hosted workflow or native/macOS lane is configured; T09 remains unchecked until those applicable requirements are satisfied. Local results are not CI/native/release acceptance.

| Gate | Evidence |
|---|---|
| Pull request | Formatting/lint/types, unit/component tests, relevant integration/contract checks, secret/dependency review |
| Backend integration | Real DB constraints/concurrency, queue recovery, permissions, compatible migrations |
| Mobile build | Pinned SDK/dependencies, generated code freshness, migration/widget/device checks |
| Web/admin build | Production build, session/CSRF/cache/role/browser/adaptive suites |
| Staging | Cross-client journeys, sandbox integrations, representative performance and operational rehearsal |
| Production stage | Required tests pass, policies/operators ready, safe rollback/recovery and known-risk review |

A disabled/unreleased optional module need not block unrelated delivery. Fundamental privacy/data-integrity failures block the affected release stage; do not waive them because the UI looks finished. Coverage targets can be set after baselining; a percentage alone is never the acceptance criterion.

## 12. Evidence and traceability

Maintain a test/evidence registry linked to:
- Product requirements ACC/DAY/FOC/READ/INT/MON/PROG/CARD/SOC/FEED/DM/NOT/SAFE/DATA/NFR.
- Backend BE-01 through BE-18 in [BACKEND_TECH_SPEC.md](../BACKEND_TECH_SPEC.md).
- Web WEB-01 through WEB-14 in [WEB_PRD.md](../WEB_PRD.md).
- Admin ADM-01 through ADM-16 in [ADMIN_CMS_PRD.md](../ADMIN_CMS_PRD.md).
- Security SEC-01 through SEC-12 in [security.md](security.md).

Each executed check records version/environment, synthetic fixture, result, responsible owner, and relevant logs/artifacts. Restrict artifact retention/access and exclude real private screenshots/credentials. Until implementation exists, these remain planned acceptance scenarios—not executed application tests.
