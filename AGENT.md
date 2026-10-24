# Your Own — Repository Instructions

These are the canonical repository-specific instructions for coding agents and contributors. `AGENTS.md` points here; do not maintain a second conflicting copy. These instructions do not override higher-priority harness/system instructions or an explicitly approved change in project direction.

## 1. Read before working

1. Read [README.md](README.md) and the [milestone index](docs/milestones/README.md).
2. Read the selected milestone, its prerequisites, and the affected specifications.
3. Inspect the actual working tree, package scripts, runtime pins, and relevant source/tests before editing or running commands. Paths in plans may not exist yet.
4. State the bounded task or task IDs being addressed; do not start the entire roadmap automatically.

Documentation authority:
- [PRD](docs/PRD.md): product scope and user behavior.
- [Architecture](docs/cookbook/architecture.md): system boundaries and ownership.
- [Mobile](docs/MOBILE_TECH_SPEC.md), [Backend](docs/BACKEND_TECH_SPEC.md), [Web](docs/WEB_PRD.md), [Admin](docs/ADMIN_CMS_PRD.md): platform-specific contracts and file maps.
- [Design system](docs/cookbook/design-system.md), [Security](docs/cookbook/security.md), [Testing](docs/cookbook/testing.md), [Schema](docs/cookbook/schema.md), [Deployment](docs/cookbook/deployment.md): cross-cutting requirements.
- [Milestones](docs/milestones/README.md): execution order and evidence, not a replacement specification.
- Repository-wide decisions live in `docs/cookbook/decisions/`; [Decision 0001](docs/cookbook/decisions/0001-scope-and-release-tracks.md) records the accepted scope/release priorities and owner-approval process. App-local decisions link to shared records instead of duplicating them.

Resolve conflicts explicitly. Do not silently make a proposal approved by copying it into code or another document. The standalone design system needs no external style-reference file.

## 2. Current implementation state and approval gates

At creation of these instructions, this is a documentation-only repository. Re-check the working tree as implementation progresses; update status documents when reality changes.

Confirmed: Flutter, NestJS, separate Next.js user/admin apps, a monorepo direction, four tracking modes, adaptive layouts, and dark-mode support. [Decision 0004](docs/cookbook/decisions/0004-toolchain-directions-and-icon-family.md) accepts lean pnpm, Node 24 LTS/TypeScript 6 candidate direction, isolated stable Flutter with Riverpod/go_router/Dio/Drift, and App Router/React/Tailwind/TanStack Query/RHF/Zod directions. Exact pins, remaining libraries, database/ORM, provider integrations, deployment details and sensitive policies still require validation/decisions. Direction approval is not installation, spike or scaffold authorization. [Decision 0005](docs/cookbook/decisions/0005-isolated-compatibility-probe.md) separately authorizes an isolated, chart-free temporary download/build/test probe; [Decision 0006](docs/cookbook/decisions/0006-mobile-probe-generator-retry.md) authorizes its mobile generator retry. Neither authorizes global changes, repository app scaffolding or final pin adoption. [Decision 0007](docs/cookbook/decisions/0007-isolated-lint-probe.md) separately authorizes a new external lint experiment with exactly three disclosed ESLint peer exceptions; it does not change production peer policy or permit broader exceptions. [Decision 0008](docs/cookbook/decisions/0008-isolated-combined-js-probe.md) separately authorizes one external combined JS/launcher experiment reusing those same three exact allowances, with monitored storage/free-space thresholds and review-before-execution gates; it does not approve production adoption or scaffolding. That combined attempt stopped at a high-severity Multer advisory before application installation/execution; a dependency override or changed-version retry needs separate explicit authorization, not a generic research continuation.

- Do not invent package scripts, installed tools, completed migrations, test results, or provisioned resources.
- Validate compatibility, then pin approved versions and commit the appropriate lockfiles when scaffolding is authorized.
- Use disposable, explicitly scoped experiments for technical spikes; do not present a prototype as production architecture or a completed feature.
- No cloud provisioning, paid services, production migrations/deployments, external notifications, or privileged staff changes without explicit authorization for that action/environment.
- Do not update global tooling as an incidental part of a feature task.

## 3. Non-negotiable product boundaries

- Focus, Read, Intake, and manual Money are the initial modes. No banking/payments, unrelated social posts, videos/reels, or unlimited engagement feeds.
- Raw personal records stay private. Posters are selected versioned snapshots; links, reposts, notifications, and DMs cannot widen source access.
- More spending, water, coffee, followers, or likes does not equal better personal progress.
- Admin is operational and permission-scoped. No unrestricted tracker/finance/DM viewer; editorial/configuration is optional A2 only after approval.
- Admin A0, required policies, and named operational ownership must be verified before public social launch.

## 4. Architecture and file ownership

- Follow documented app/module/feature paths; create folders with useful slices, not empty scaffolding for the entire roadmap.
- NestJS owns domain authorization, transactions, exact calculations, and canonical accepted records. Controllers and gateways remain thin.
- Web/admin route files compose screens. BFF handlers manage sessions and allowlisted forwarding, not a second ledger or direct domain database access.
- Keep server credentials/modules out of browser bundles/props. Enforce server-only imports; filename suffixes alone are not security.
- Keep user-web and admin sessions separate. Current staff grants/MFA are independently verified by NestJS, not frontend flags.
- Flutter domain rules remain framework-independent; presentation does not issue raw SQL or raw network requests.
- Cross-feature access uses explicit public contracts, not internal widgets/controllers/DAOs. Avoid dumping business logic into `utils`, shared UI, or framework configuration.
- Shared packages contain suitable contracts/primitives/tokens, never application credentials or privileged screens. Do not share Flutter widgets with React.
- There is one backend domain-migration authority. Mobile storage has its own reviewed local migrations; preserve pending operations and drafts.

## 5. Correctness, privacy, and UI

- Money uses exact minor-unit semantics and explicit currency metadata, never floating-point ledger arithmetic. Preserve decimal-string transport for large integers. Transfers are atomic; savings planning does not create assets.
- Retried mutations keep stable operation identity; revisions/conflicts are explicit. Domain rows, receipts, change-stream entries, required audit/outbox writes share the appropriate atomic boundary.
- Treat sockets/connectivity as hints, not durable truth. Do not claim exactly-once external push delivery or guaranteed background execution.
- Reauthorize media, SSR/metadata, caches, workers, previews, and operator actions. Private data must not leak during loading, logout, account switching, resizing, or theme changes.
- Use the semantic design system in both themes. Support all four size classes, usable height, text scaling, keyboard/insets, screen readers, pointer/touch, and preserved drafts/timers.
- Follow [Decision 0002](docs/cookbook/decisions/0002-rounded-icons-and-chart-rendering.md): one complete rounded icon family, never Material/built-in/starter-default glyphs for app-owned UI; ApexCharts for user-web data charts; native/custom Flutter charts where needed. Decision 0004 selects **Hugeicons Free Stroke Rounded only** with first-party Flutter/React packages behind owned semantic adapters; exact pins, coverage, distribution notices and rendering remain unverified. ApexCharts installation/integration stays on hold pending licensing clarification; no supplier outreach or purchase is authorized. Replace implicit component icons too; do not substitute a starter chart package or assume custom painting is accessible.
- No real credentials, private messages, account balances, report evidence, or personal production datasets in source, fixtures, screenshots, logs, or ordinary telemetry. Use synthetic data.

## 6. Change workflow

1. Select one bounded eligible task from the milestone plan, or the user's explicitly requested scope.
2. Check prerequisites and approval evidence. Record blockers instead of bypassing them.
3. Inspect existing implementation and tests. Preserve unrelated user changes; no destructive reset/cleanup, history rewrite, or unrequested commit/push.
4. Implement the smallest coherent change and the relevant tests. Do not rewrite unrelated modules or add dependencies for convenience without review.
5. Update contracts, migrations, documentation links, route/module/component indexes, and traceability affected by the change.
6. Run actual available checks for the affected slice and shared dependents. Use real database/device/browser checks where mocks cannot prove the behavior.
7. Record outcome/evidence and a clear next action. A blocked or untested task stays unchecked.

Generated files must be regenerated from their authoritative source using the selected toolchain, not manually patched. Recheck generated contracts, shared packages, and client compatibility after API/schema changes. Never use delete-and-recreate storage or production schema reset as a migration shortcut.

## 7. Verification and reporting

- Follow the [milestone status/evidence rules](docs/milestones/README.md#task-workflow-and-evidence). Checkboxes mean Verified, not merely coded or reviewed by an agent.
- Approval tasks need an explicit recorded decision; agents do not approve providers, privacy policies, production releases, or their own missing evidence on the owner's behalf.
- Use only commands that exist and are appropriate to the environment. Record exact commands, result, relevant toolchain/environment, and artifact/test paths; sanitize sensitive output.
- Mark skipped/not-run/blocked checks honestly. Documentation/link checks do not prove application behavior, WCAG compliance, database concurrency, security, or deployment readiness.
- iOS/iPad native claims require the approved macOS/Xcode/device evidence; Android-only checks do not cover them.
- End a task with changed paths, task IDs/status, checks actually run, limitations/blockers, and the next eligible task. Do not claim milestones or release stages complete because a checklist was written.
