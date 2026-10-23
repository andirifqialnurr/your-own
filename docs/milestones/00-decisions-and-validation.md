# M00 — Decisions, Audit, and Validation

- **Status:** In progress — M00-T01 through M00-T03 Verified; M00-T04 in progress, all later tasks unchecked
- **Depends on:** None
- **Next:** [M01](01-foundations.md) only after the scaffold gate below
- **Targets:** Approved decision records and disposable spike evidence, not production application scaffolding
- **Sources:** [PRD open decisions](../PRD.md#30-decisions-to-resolve-before-implementation-or-launch), [Mobile gates](../MOBILE_TECH_SPEC.md#27-open-decisions-and-release-gates), [Backend gates](../BACKEND_TECH_SPEC.md#31-risks-and-open-decisions), [Architecture](../cookbook/architecture.md)

## Goal

Resolve the decisions that would otherwise force risky rewrites. Distinguish confirmed frameworks from proposed supporting choices. All decisions need an owner, rationale, and explicit acceptance; experiments do not implicitly select a dependency.

## Ordered tasks

- [x] **M00-T01** — Review scope and independent release tracks with the owner. **Verify:** record V1-A/B/C, W0–W3, A0/A1 boundaries, optional A2, launch priorities, and the location/ownership of decision records.
- [x] **M00-T02** — Approve remaining product defaults. **Verify:** decisions cover account/post visibility, guest policy, labels/languages/units, task fields, historical timer edits, Money currency/savings semantics, and required poster templates; unresolved items remain explicit blockers.
- [x] **M00-T03** — Audit the four reference Flutter repositories. **Verify:** inventory features, dependencies/licenses, storage, tests, reusable rules/fixtures, rebuild decisions, and whether any data import is actually promised; do not merge their navigation/state stacks.
- [ ] **M00-T04** — Evaluate and select toolchain/workspace candidates. **Verify:** compatible Flutter/Dart and Node/TypeScript/framework versions, package manager, libraries and version pins are reviewed; select the complete rounded icon family with Flutter/React coverage/license evidence and validate selected ApexCharts versions, license/entitlements and client-only integration per Decision 0002.
- [ ] **M00-T05** — Define supported environments and device/browser coverage. **Verify:** OS/browser minimums, Android phone/tablet and iPhone/iPad coverage, a macOS/Xcode path, accessibility targets, performance budgets, and test ownership are approved.
- [ ] **M00-T06** — Approve infrastructure and provider baseline. **Verify:** database/ORM, identity, private storage, session-store approach, hosting/regions/cost ceiling, environment isolation, secret ownership, and recovery targets are recorded without provisioning resources implicitly.
- [ ] **M00-T07** — Spike identity and browser/staff assurance. **Verify:** token verification/revocation, user/admin session separation, CSRF/Origin handling, current staff grants, trusted MFA/freshness, and provider limitations have concrete synthetic evidence or a blocking redesign.
- [ ] **M00-T08** — Spike mobile persistence and lifecycle risks. **Verify:** chosen encryption/driver/key handling, migration preservation, auth restart, timer recovery, denied notifications, iPad sharing, and split-view behavior have recorded findings; Android-only results are not iOS proof.
- [ ] **M00-T09** — Validate the visual system with representative prototypes. **Verify:** Today on a small phone, Money on a large iPad, and a poster demonstrate approved font/icon assets, both themes, large text, useful density, and all four window classes; a rounded-icon catalog, ApexCharts browser prototype and any custom Flutter chart prove coverage, accessible values, privacy and responsive behavior.
- [ ] **M00-T10** — Approve core API and schema contracts. **Verify:** OpenAPI-to-Dart/TypeScript generation, exact integer/date/null handling, errors, ownership, operation IDs, revisions, transaction boundaries, and Money posting constraints have fixtures and review evidence.
- [ ] **M00-T11** — Spike synchronization correctness. **Verify:** demonstrate commit-safe owner ordering, consistent bootstrap watermark, receipts, tombstones, lost-response retry, conflict handling, and expired-cursor recovery; approve offline/retention horizons.
- [ ] **M00-T12** — Approve lifecycle and privacy baseline. **Verify:** personal export/deletion scope, encrypted local retention, backup handling, future DM-history treatment, sensitive-media delivery, and no-private-telemetry rules have owners and decisions; launch-only policy details retain explicit deadlines/gates.
- [ ] **M00-T13** — Review later social/operations risks without enabling them. **Verify:** rendering, queue/outbox, realtime browser credentials, visibility generations, staff recovery, and contact/block coordination have a selected baseline or a documented prerequisite before the affected milestone.
- [ ] **M00-T14** — Obtain the scaffold go/no-go decision. **Verify:** the owner accepts the baseline and applicable spike evidence, blockers are listed, and specs/decision links agree; no unresolved foundation choice is silently treated as approved.

## M00-T01 — Scope and release review

**Review state:** Accepted on 2026-10-23 (UTC). The owner replied, **"Approve all - Android First."** [Decision 0001](../cookbook/decisions/0001-scope-and-release-tracks.md) records the three accepted answers, their limits and ownership. M00-T01 is Verified as an approval task. M00-T02 was accepted separately in Decision 0003 below.

### Established boundaries

The [confirmed product direction](../PRD.md#31-confirmed-through-discussion) remains unchanged: Flutter mobile, one NestJS domain backend, separate Next.js user/admin apps, and Focus, Read, Intake, manual Money. Raw records stay private; selected progress cards are the sharing format. Four adaptive window classes and System/Light/Dark remain required. No banking/payments, arbitrary feed posts, videos/reels, or engagement-ranked endless feed.

The monorepo is an organizational direction, not authorization to install libraries, create all application trees, or combine deployments/sessions. Supporting packages/providers still need their later M00 decisions; product defaults were accepted separately in Decision 0003.

### Accepted release boundaries

These summarize the existing specifications; they do not add or remove scope.

| Track | Declared scope | Gate / relationship |
|---|---|---|
| V1-A | Accounts, all four personal modes, Today/Progress, private cards/exports, data controls | Verified private journeys and M09 readiness; a limited release, not full V1 |
| V1-B | Profiles/follows, deliberate publishing, finite feed, likes/comments/sharing, notifications and safety | A0 moderation and applicable policies/operators ready before public exposure |
| V1-C | Reposts, one-to-one text/card DMs, requests and messaging safety | Durable delivery, current source/contact permissions and full V1 acceptance |
| W0 | Product/policy/support pages, app links, safe shared-link resolution | Approved copy/domain and applicable link policy; no claim of unfinished web features |
| W1 | Browser personal tracking, progress/private cards, settings/data controls | Personal backend and browser-session/private-export readiness; no assumed mobile offline parity |
| W2 | Browser social publishing and interactions | Social backend plus operational A0; browser rendering/cache privacy verified |
| W3 | Browser reposts, DMs/requests and realtime recovery | Messaging backend plus browser-specific delivery/privacy evidence |
| A0 | Staff access, minimal lookup, reports/evidence, moderation, audit and basic support/status | Mandatory before public social on either mobile or web |
| A1 | Safe jobs/retries, appeals, staff UI, data-request monitoring and operational overview | Expand with operating needs; not dependent on complete user-web delivery |
| A2 | Editorial/configuration extensions | Optional, not scheduled, and requires separate approval |

Sources: [Product stages](../PRD.md#7-release-scope-and-staging), [backend stages](../BACKEND_TECH_SPEC.md#3-scope-and-release-stages), [web stages](../WEB_PRD.md#4-website-scope-and-release-stages), [admin stages](../ADMIN_CMS_PRD.md#4-release-scope-and-sequencing), [release gates](../PRD.md#26-release-acceptance-gates).

### Accepted launch priorities

1. Finish M00 approvals/spikes, then build the API/mobile foundation and verified water slice before expanding the other modes.
2. Deliver a limited mobile personal pilot after the full V1-A gate, without social or mandatory browser parity. Use synthetic data until the real-personal-data gate passes.
3. Establish A0 before opening V1-B social. W0 may be brought forward after its prerequisites; W1/W2 can follow mobile delivery, and A1 follows actual operating needs.
4. Deliver V1-C/W3 after their own gates. Platforms may ship independently with recorded task-level evidence; M18 is the combined declared-scope review, not a requirement to synchronize every release date.
5. Keep A2 and other future features out of the initial required delivery.

**Accepted pilot platform:** Android first for the limited pilot. iPhone/iPad remain required targets, and all four window classes remain part of the design from the foundation. Android-first does not verify iOS/iPad or waive their work and existing gates; actual OS minimums, devices and macOS/Xcode access belong to M00-T05.

### Accepted decision records and ownership

- Store repository-wide decisions under `docs/cookbook/decisions/`, keeping cross-cutting records with the cookbook. The first accepted record now exists there.
- Use stable numbered filenames, starting with `0001-scope-and-release-tracks.md`. Record context, selected answer, rationale, affected specs/tasks, approver, actual approval date/evidence, and any superseding decision.
- The project owner (you) approves scope, product defaults, stack/provider choices and releases, or explicitly delegates a named decision. Agents may investigate, recommend, implement authorized work and record evidence, but cannot supply owner approval.
- App-local decision documents may reference the repository-wide record; do not create conflicting copies. Update affected authoritative specifications when an accepted decision changes their content.
- Preserve actual approval evidence in the decision record and task log. This review summarizes the accepted record, not a separate source of conflicting decisions.

### Owner answers recorded

| Decision | Accepted answer | Approval |
|---|---|---|
| Scope and delivery priority | Keep the stage boundaries above; mobile personal pilot first, A0 before public social, web on its independent track, A2 optional | Owner approved, 2026-10-23 UTC |
| First limited mobile pilot | Android first; iPhone/iPad stay required, with their release separately gated | Owner approved, 2026-10-23 UTC |
| Decision location and authority | `docs/cookbook/decisions/`; owner approves, agents draft and record | Owner approved, 2026-10-23 UTC |

No supporting dependency, hosting vendor, budget, privacy default, production action or release date is approved by M00-T01. Continue with the separate product-default review below.

## M00-T02 — Product defaults review

**Status:** Verified. On 2026-10-23 UTC the owner replied **"Approve defaults"** to P01–P11. [Decision 0003](../cookbook/decisions/0003-product-defaults.md) records the accepted defaults and remaining boundaries. This approval is separate from M00-T01 and the icon/chart decision.

### Accepted owner-directed visual constraints

The owner's subsequent icon/chart instruction is recorded separately in [Decision 0002](../cookbook/decisions/0002-rounded-icons-and-chart-rendering.md): one complete rounded icon family rather than Material/built-in/starter icons; ApexCharts for user-web charts; custom Flutter rendering where needed. Decision 0004 subsequently selected Hugeicons Free Stroke Rounded; exact pins, distribution notices, full coverage and integration evidence remain M00-T04/M00-T09 work, not completed tasks. That scoped instruction did not approve P01–P11; the owner has now approved them separately in Decision 0003.

### Accepted product defaults

| ID | Decision | Accepted default | Answer |
|---|---|---|---|
| P01 | Account visibility | Private signup default with an explained public/private choice. Raw tracker data stays private in either case. | Approved |
| P02 | Post audiences | Permit followers-only posts on public accounts. Start each new publication draft followers-only; public publication requires explicit selection and preview. Private accounts cannot publish publicly without an explicit account-visibility change. Private save/export never creates a post. | Approved |
| P03 | Guest use | Require an account for personal tracking in V1; no guest mode or guest-to-account migration. This does not require connectivity for every mobile log: authorized offline behavior is finalized in the auth/sync tasks. | Approved |
| P04 | Names and navigation defaults | Use Focus, Read, Intake, Money; Circle names the social destination, not a group feature. Today is the default landing screen; one account covers selected modes, and hiding a mode preserves history. | Approved |
| P05 | Initial UI language | English-first for the Android pilot, with localizable strings from the start. Indonesian remains a later candidate, not promised pilot coverage. Language does not select a launch country or currency. | Approved |
| P06 | Units and locale | Milliliters by default, optional explicitly labeled **US fluid ounces** (not Imperial); retain canonical volume without repeated rounding. Coffee cups/shots stay separate. Suggest device timezone/formatting, allow correction, and never hardcode one country/timezone. | Approved |
| P07 | Tasks and timer defaults | Required task title; optional note, due date and label; Today membership independent of due date. Work/Study/Personal plus custom labels. Editable Pomodoro defaults of 25-minute focus, 5-minute short break, 15-minute long break after four focus intervals; breaks/next intervals start explicitly. | Approved |
| P08 | Historical focus edits | No manual historical session creation or duration edits in V1. Allow task/label/private-note corrections and deletion; recorded duration excludes pauses/breaks and is not a claim of verified attention. | Approved |
| P09 | Currency and budgets | One user-selected base currency across wallets; amount-based monthly category budgets, with planned savings separate. No FX or multi-currency totals. Do not allow changing the base currency after monetary records exist; never silently relabel history or use a destructive reset workaround. | Approved |
| P10 | Savings | Independent manual planning ledger. Contributions/withdrawals do not move wallet funds, reserve money or create assets/expenses. Progress cannot go below zero; targets may be exceeded. | Approved |
| P11 | Required card coverage | Cover every CARD-07 output for private preview/export in V1-A, then enable deliberate publication in V1-B. Reuse curated layouts; no full editor. Exact Money amounts stay hidden unless explicitly selected and previewed. | Approved |

**P11 coverage:** Focus daily/weekly summaries and selected task/session milestones; Read page updates, finished books and recaps; Intake water/coffee daily/weekly recaps; Money monthly plans, savings milestones and selected monthly recaps; combined daily/weekly recaps. Reflections attach to a supported recap/plan, including a difficult week; no standalone status posts. Export dimensions/font/rendering details still require M00-T09 and the rendering contracts.

### Review boundaries and next action

- Sources: [onboarding/settings](../PRD.md#9-account-onboarding-and-settings), [Focus](../PRD.md#11-focus-mode), [Intake](../PRD.md#13-intake-mode), [Money](../PRD.md#14-money-mode), [card coverage](../PRD.md#card-07--initial-template-coverage), [visibility](../PRD.md#17-profiles-following-and-visibility), and [open decisions](../PRD.md#30-decisions-to-resolve-before-implementation-or-launch).
- P01–P11 are approved as recorded in Decision 0003. English-first is now an owner-approved pilot choice; later changes require a new/superseding decision.
- Exact supported currency codes/precision and conversion constraints remain a M00-T10 contract gate; neither IDR nor USD is silently selected for every user.
- Authentication methods/providers, detailed offline/session policy, anonymous public links, DM contact defaults, lifecycle/retention, age/regions, numerical limits and hosting are not selected here. They remain in their designated later decision/validation tasks.
- Decision 0003 records the approval; affected specifications are synchronized. Continue with M00-T03's read-only reference-app audit. No application scaffolding is authorized yet.

## M00-T03 — Reference-app audit

**Status:** Verified on 2026-10-23 UTC as a read-only static inventory/assessment, not application verification or an owner-approved dependency selection. Four source trees, complete lockfiles, direct dependency notices, representative storage/migration/export paths and test assertions were inspected without modifying the references, installing packages, executing migrations or opening personal databases.

The [static audit](../cookbook/reference-app-audit.md) records features, 36 test files, migration/export gaps and requirement-linked reference-only/rebuild/exclude dispositions. The [dependency/provenance register](../cookbook/reference-app-licenses.md) records all 22 distinct direct hosted package/version notices, four lockfile digests, targeted nested obligations and explicit non-reuse of uncleared source/assets or inherited graphs. Unknown permissions remain copying blockers; they are not declared safe by closing an inventory task.

No navigation/state stack or source/asset copy is selected. Test ideas will be newly implemented against Your Own's approved contracts; no runtime test result is inherited. Legacy data import remains **unpromised**. M00-T04 independently selects the new supporting stack and validates its licenses/compatibility.

## M00-T04 — Toolchain and workspace review

**Status:** In progress — T04-A–D directions accepted and ApexCharts integration hold confirmed on 2026-10-23 UTC; exact pins and verification remain open. No package installation or application scaffolding authorized. Review compatible runtime/framework/package versions, package manager/workspace tooling, a complete rounded icon family, and user-web ApexCharts core/React versions, applicable license/entitlements and client-only integration. The reference audit supplies warnings and inventory, not approved pins.

The [candidate review](../cookbook/toolchain-review.md) records installed-tool observations, official registry/documentation research, runtime/library/workspace options, inspected Hugeicons Free Stroke Rounded coverage/notices, and exact ApexCharts core/wrapper licensing conditions. The owner's **"yes"** to accepting T04-A–D directions while holding ApexCharts is recorded in [Decision 0004](../cookbook/decisions/0004-toolchain-directions-and-icon-family.md). Lean pnpm, the named mobile/web directions and Hugeicons Free Stroke Rounded are accepted; T04-E confirms only the hold, not outreach or spending. Current TypeScript/ESLint/generator metadata exposes incompatible latest-version combinations; adjusted candidates are not a resolved or tested graph. The [compatibility follow-up](../cookbook/toolchain-compatibility.md) establishes published Flutter 3.47.7 / Dart 3.13.5 from official release metadata and pinned source, but not installed SDK/native compatibility. It withdraws the EOL ESLint 9 recommendation; a maintained frontend lint graph and ApexCharts entitlement remain unresolved.

Provider/infrastructure choices, encrypted persistence/native behavior and representative design prototypes retain their separate M00 gates. Do not install dependencies, copy the reference graph, purchase licenses or scaffold applications merely because the audit or candidate research is complete. The next action remains M00-T04: review exact supported pins/notices and maintained lint coverage, resolve ApexCharts entitlement and obtain separate authorization for the proposed chart-free disposable compatibility probe. Published SDK identity alone does not authorize a download or verify runtime behavior. Approval of directions does not complete this task or advance to M00-T05/M01.

## Exit gate

M01 can start only after its supporting stack, personal contract/schema, encrypted mobile approach, session model, targets, and design baseline have approved answers. A later-stage decision may be deferred only with an explicit affected-task blocker; it cannot weaken the scaffold gate. Disposable spike code is not counted as shipped implementation.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence). Record actual approvals, owners, commands/environments, and sanitized results.

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| M00-T01 | In progress | Coding agent (review preparation) / 2026-10-23 UTC | [Scope/release review](#m00-t01--scope-and-release-review); repository and relevant product/platform specifications inspected | Historical event: review prepared; owner answers were pending at this point. |
| M00-T01 | Verified | Project owner (approval); coding agent (recording) / 2026-10-23 UTC | [Decision 0001](../cookbook/decisions/0001-scope-and-release-tracks.md), including the exact approval response | All three M00-T01 answers accepted; Android-first order and decision ownership/location synchronized. This verifies a decision, not application behavior. |
| M00-T02 | In progress | Coding agent (review preparation) / 2026-10-23 UTC | [Product-default recommendations P01–P11](#m00-t02--product-defaults-review) | Historical event: explicit owner answers were pending; M00-T03 had not started. |
| M00-T02 | In progress | Project owner (visual direction); coding agent (documentation) / 2026-10-23 UTC | [Decision 0002](../cookbook/decisions/0002-rounded-icons-and-chart-rendering.md) | Historical event: visual constraints accepted while P01–P11 were still pending. |
| M00-T02 | Verified | Project owner (approval); coding agent (recording) / 2026-10-23 UTC | [Decision 0003](../cookbook/decisions/0003-product-defaults.md), exact response "Approve defaults" | All P01–P11 accepted; no dependency/provider/implementation approval implied. |
| M00-T03 | In progress | Coding agent / 2026-10-23 UTC | [Audit scope](#m00-t03--reference-app-audit); four reference working trees inventoried | Read-only audit begun; preserve finance/water clean trees and existing coffee/book local changes. No tests or installs run. |
| M00-T03 | In progress | Coding agent / 2026-10-23 UTC | [Audit working notes](../cookbook/reference-app-audit.md): manifest/lockfile SDK constraints, 36 test-file inventory, representative source/test reads and rebuild risks | Historical event: license/provenance register and final export/import/reuse assessment were still required. No reference files changed, personal databases opened or runtime tests executed. |
| M00-T03 | Verified | Coding agent (static audit and checks) / 2026-10-23 UTC | [Final audit](../cookbook/reference-app-audit.md), [resolved notices/provenance](../cookbook/reference-app-licenses.md); source/lockfile/license reads and inline inventory/hash checks | Complete inventory and non-reuse dispositions; no runtime/legal/dependency clearance. M00-T04 is next, not started. No reference app or personal database modified. |
| M00-T04 | In progress | Coding agent / 2026-10-23 UTC | [Toolchain review scope](#m00-t04--toolchain-and-workspace-review); installed tool paths and SDK metadata inspected | Historical event: initial research scope recorded. No installation, global tooling update or scaffold authorized. |
| M00-T04 | In progress | Coding agent (candidate research) / 2026-10-23 UTC | [Candidate matrix, owner choices and evidence](../cookbook/toolchain-review.md); official registry/docs/notice reads; five temporary archive integrity checks and cross-platform icon-name inspection | Historical event: no selection approval or runtime verification at this point. Current Flutter/Dart pairing, full dependency resolution, visual/native proof and ApexCharts entitlement remained open. Owner review was next; no package install, supplier contact, purchase or scaffold occurred. |
| M00-T04 | In progress | Project owner (direction approval); coding agent (recording) / 2026-10-23 UTC | [Decision 0004](../cookbook/decisions/0004-toolchain-directions-and-icon-family.md), including exact question and owner response "yes"; affected specifications/status pointers synchronized | T04-A–D directions accepted; Hugeicons Free Stroke Rounded selected; ApexCharts hold confirmed. Exact pins, runtime/native/visual proof and entitlement remain unresolved. Task stays unchecked; no install, upgrade, executable spike, outreach, purchase or scaffold authorized. |
| M00-T04 | In progress | Coding agent (read-only compatibility follow-up) / 2026-10-23 UTC | [Published SDK chain, support findings, 88 declared-range assertions and probe proposal](../cookbook/toolchain-compatibility.md); official metadata/source GETs and temporary local checker | Flutter/Dart published pair established; ESLint 9 candidate withdrawn as EOL; three frontend plugins reject ESLint 10. No full resolution, SDK download, candidate execution, ApexCharts clearance or task completion. Request separately scoped probe authorization; do not infer it from "continue". |

Historical pre-approval review preparation checks (2026-10-23 UTC, current Windows/Git Bash checkout): `git diff --check` passed with Git line-ending notices only; `python -` ran an inline standard-library validator and passed 35 Markdown files, 517 local links/anchors, fence/whitespace/table checks, and 224 unique unchecked tasks across 20 plans. Active-task/status pointers agree. At that time, the proposed decision directory did not exist. These are documentation checks, not product, device, security or deployment tests. The inline validator command/output is recorded in this agent session; no application test runner or tooling was installed.

Post-approval checks (2026-10-23 UTC, Windows/Git Bash checkout): `git diff --check` passed with line-ending notices only. `python -` ran an inline standard-library validator: 36 Markdown files, 547 local links/anchors, four JSON examples, changed tables, fences and whitespace passed; requirement ID sets were preserved against Git HEAD. All 224 task IDs remain unique, only M00-T01 is checked, M00-T02 is active with P01–P11 pending, and milestone dependencies agree. The accepted decision contains the owner's exact approval; no application/package scaffold exists. Command/output is in this agent session. No application, native-device, security or deployment tests were run.

Icon/chart documentation checks (2026-10-23 UTC, Windows/Git Bash checkout): `git diff --check` passed with line-ending notices only; inline `python -` validation passed 37 Markdown files, 570 local links/anchors, four JSON examples, tables/fences/whitespace, unchanged requirement ID sets and milestone dependency consistency. All 224 task IDs remain unique, only M00-T01 is checked, and P01–P11 remain pending. Superseded generic chart-library recommendations were removed. No icon bank, package version, commercial entitlement or live rendering integration was validated or installed; those remain explicit follow-up gates.

Historical product-default approval and audit-progress checks (2026-10-23 UTC, Windows/Git Bash): `git -c core.safecrlf=false diff --check` passed. The first inline `python -` validator attempt stopped on a validator regex error; after correction, it passed 39 Markdown files, 604 local links/anchors, four JSON examples, tables/fences/whitespace and preservation of 67 heading requirement IDs against Git HEAD. All 224 task IDs remain unique across 20 plans; only M00-T01/M00-T02 are checked, all P01–P11 rows are Approved, and M00-T03 remains active/unchecked. No `apps/` or `packages/` scaffold exists. A subsequent dependency-index check caught M07's missing Money-decision qualifier in the index; that summary was synchronized with the existing M07 prerequisite, without changing task scope. Reference tests, builds, device checks and license/entitlement verification were not run/completed; the audit notes explicitly retain the remaining work. Commands/output are recorded in this agent session.

M00-T03 final static-audit checks (2026-10-23 UTC, Windows/Git Bash): `git -c core.safecrlf=false diff --check` passed. Inline standard-library `python -` passed 40 Markdown files, 613 local links/anchors, four JSON examples, tables/fences/whitespace, 67 preserved heading requirement IDs, milestone dependency/index consistency and all 224 unique tasks. Only M00-T01/T02/T03 are checked; 221 remain unchecked, and M00-T04 is next/planned. Inventory validation matched all four inspected lockfile SHA-256 values, all 22 direct resolved package/version LICENSE rows/hashes and the 165 hosted-pair union. Reference HEADs and status-entry counts remained finance 0, water 0, coffee 37 and book 1; no audit write commands targeted those repositories. No application tests, installs, native builds, migrations, personal-data access or online licensing verification occurred. Direct notices and targeted nested notices were reviewed, but unused/uncleared source/assets and inherited dependency graphs remain excluded, not legally or technically approved. No application scaffold exists.

M00-T04 candidate-review checks (2026-10-23 UTC, Windows/Git Bash): `python C:/Users/HP/AppData/Local/Temp/your-own-toolchain-review-so4nyten/validate_review.py` passed 41 Markdown files, 624 local links/anchors, four JSON examples, tables/fences/whitespace and 67 preserved heading requirement IDs. All 224 task IDs remain unique across 20 plans; only M00-T01/T02/T03 are checked, prerequisite summaries agree, and no scaffold exists. Static checks matched all five downloaded archive/notice SHA-256 rows, 76 common Flutter/React icon names after the explicit WifiOff mapping correction, and three representative icon-data arrays. `git -c core.safecrlf=false diff --check` passed. Reference HEADs and status-entry counts remained unchanged (finance 0, water 0, coffee 37, book 1). Public registry/docs/archives were fetched only into temporary research storage; no package install/resolution, SDK upgrade, application/device tests, supplier contact, purchase or deployment occurred. This evidence validates the candidate document/static observations, not dependency compatibility, full icon coverage, licensing entitlement or application behavior. Owner review and remaining M00-T04 validation are next.

M00-T04 direction-approval checks (2026-10-23 UTC, Windows/Git Bash): the same `validate_review.py` passed 42 Markdown files, 651 local links/anchors, four JSON examples, tables/fences/whitespace, 67 preserved requirement heading IDs and consistent milestone prerequisites. All 224 tasks remain unique; only M00-T01/T02/T03 are checked. Existing five archive/notice hashes, 76 common icon names and three representative icon-data arrays still match the saved research. `git -c core.safecrlf=false diff --check` passed. Decision 0004 records the exact approval question and response, accepts directions only and keeps ApexCharts on hold; specifications and current-status pointers agree. No new network research, package installs/resolution, SDK changes, executable integration spikes, application/native tests, supplier contact, purchase or scaffold occurred in recording this approval. Next remains M00-T04's unresolved pairing/pins/compatibility and entitlement review.

M00-T04 metadata/support follow-up checks (2026-10-23 UTC, Windows/Git Bash): `node C:/Users/HP/AppData/Local/Temp/your-own-toolchain-followup-zfc00p6m/check_constraints.cjs` passed 88 declared-range assertions (76 accepted ranges, 12 expected non-matches), the explicit Dart generator-range conflict and four published SDK identity records. This ran on installed Node 24.18.0 with existing semver 7.8.1, not on candidate Node 24.22.1. The existing `validate_review.py` passed 43 Markdown files, 666 local links/anchors, four JSON examples, tables/fences/whitespace, 67 preserved requirement IDs, prerequisite consistency and all 224 unique tasks; only M00-T01/T02/T03 remain checked. Inline Python matched the new report/source hashes and published archive identities; these are metadata hashes, not verification of downloaded SDK bytes. `git -c core.safecrlf=false diff --check` passed. Reference HEADs/status counts and the installed clean Flutter 3.38.9 checkout remained unchanged. A precise-edit attempt was rejected without changes, then corrected; no application failure occurred. No SDK/package binary download, installation/resolution, native/browser application test, supplier contact or scaffold ran. Published Flutter/Dart identity is established; maintained frontend lint coverage, runtime/final-pin evidence and ApexCharts rights remain unresolved. Next action is explicit authorization of the documented chart-free temporary probe, not milestone completion.
