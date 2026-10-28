# Your Own

A mobile-first personal progress app: **Focus, Read, Intake, and Money**, with optional sharing through generated progress cards.

> Track the life you are building. Share the parts you choose. Then get back to living it.

## Current status

**Local development has started.** The pnpm workspace, a loopback-only NestJS API and a Flutter adaptive development shell now exist under [Decision 0012](docs/cookbook/decisions/0012-local-development-bootstrap.md). The setup uses the laptop's existing tools. Flutter now includes [semantic zinc tokens, bundled DM Sans and System/Light/Dark selection](docs/cookbook/mobile-appearance-foundation.md), with a single non-sensitive preference adapter. The [adaptive shell](docs/cookbook/mobile-adaptive-shell.md) adds Today / Progress / Circle / You, preserved branch state and a clearly unavailable Messages entry. A [debug-only shared UI catalog](docs/cookbook/mobile-shared-ui.md) now exercises controls, fields, cards, dialogs and 28 rounded icon aliases with synthetic data and host goldens. No personal database, authentication, tracking features, Docker services, hosted CI or deployment exists yet. Android/iOS device builds remain unverified; local coding does not need to wait for full release validation.

Confirmed frameworks: **Flutter mobile**, **NestJS backend**, and **two separate Next.js applications** for users and staff. [Decision 0004](docs/cookbook/decisions/0004-toolchain-directions-and-icon-family.md) accepts the pnpm/mobile/web supporting-stack directions and **Hugeicons Free Stroke Rounded** family. ApexCharts remains selected for user-web charts but integration is on hold pending licensing clarification; custom Flutter charts remain permitted where needed. Exact pins, compatibility, distribution notices, database/providers, sessions and hosting retain their validation/approval gates.

Current directions: **PostgreSQL + Prisma**, **Cloudflare R2 for private files**, framework-appropriate **non-Supabase auth**, and separate server-side web/admin sessions. [Decision 0016](docs/cookbook/decisions/0016-framework-auth-and-r2-storage.md) supersedes Decision 0013's Supabase Auth/Storage choices. Exact auth libraries/session protocols, private/public bucket isolation, hosting, costs/regions and recovery remain open. The separately authorized [local DB probe](docs/cookbook/local-database-spike.md) initially passed ten driver cases and hit engine-checksum 403. The [same-revision verified retry](docs/cookbook/prisma-engine-follow-up.md) now passes Prisma Generate/build, two-database migration/repeat/status and seven generated-client cases. Its containers/ports are gone; Desktop/image/package caches and verified engine evidence remain. No application database or M02 runtime is enabled; only the separately authorized S0 preparation below exists. The owner subsequently provided separate private/public R2 buckets. [Decision 0017's synthetic upload test](docs/cookbook/r2-upload-check.md) now passes API PUT/GET/DELETE on both; test files were removed, retaining only zero-byte `public/assets/.keep` / `private/assets/.keep` organization markers. The script's CDN GET returned 403, while the owner subsequently [reports successfully downloading the public marker in their browser](docs/cookbook/r2-upload-check.md#7-subsequent-owner-browser-report). Keep those results separate; automated delivery parity and complete private public-path settings remain unverified; no bucket policy or application integration changed. A public bucket must not hold private application files.

[Decision 0015](docs/cookbook/decisions/0015-auth-methods-and-local-protocol-spike.md) accepts initial email/password + verified-email recovery and required staff TOTP as directions. The [isolated synthetic protocol spike](docs/cookbook/authentication-session-spike.md) passes 92 cases twice plus six expected-red guard controls. No application login, SDK/provider account, real TOTP/email, durable store or browser/native auth integration is enabled.

The next bounded [non-Supabase authentication review](docs/cookbook/framework-auth-review.md) recommends evaluating **first-party Nest authentication**, with Better Auth as an alternative. [Decision 0018's isolated real-package phase](docs/cookbook/local-nest-authentication-spike.md) now passes 55 Node test entries twice, with five expected-red guard controls and verified listener teardown. That is not app package adoption: [Decision 0019's real PostgreSQL/Prisma-store test](docs/cookbook/prisma-auth-store-spike.md) now passes 29 cases twice, explicit lock barriers, rollback/role/restart checks and four expected-red controls, with owned DB/volume teardown. [Decision 0020's external HTTP composition](docs/cookbook/durable-auth-http-spike.md) now passes 30 entries twice and six expected-red controls, with real TOTP completion/step-up, PostgreSQL sessions and verified teardown. Users/grants/mail remain memory fixtures; issued access JWTs survive refresh revoke/password reset until expiry. Durable account transactions, browser/native/BFF and production policy acceptance remain open. The next [account-transaction/access-invalidation review](docs/cookbook/authentication-transaction-review.md) is prepared under [Decision 0021](docs/cookbook/decisions/0021-auth-transaction-design-review.md): its recommendations did not adopt a product model. The separately authorized [Decision 0022 prototype](docs/cookbook/account-transaction-prototype.md) now passes 30 entries twice and six negative controls, with durable synthetic account transactions/live revocation and owned-resource cleanup. These are external service/process tests, not full HTTP/platform/operational acceptance or package adoption. The [app-adoption packet](docs/cookbook/authentication-app-adoption.md), prepared under [Decision 0023](docs/cookbook/decisions/0023-auth-app-adoption-review.md), recommends a dependency-free, uncomposed identity-contract slice (S0) as the next explicit owner choice. It does not authorize that slice or adopt packages/protocols; provider/guarded HTTP and the combined graph still need proof. The owner subsequently authorized [S0 only in Decision 0024](docs/cookbook/decisions/0024-local-identity-contract-s0.md): [internal identity contracts/pure policies and synthetic tests](apps/api/src/modules/identity/README.md) now exist, uncomposed into the API. This is not credential verification or full M02. No application auth route, dependency or schema is enabled. The subsequent [combined auth/database tooling review](docs/cookbook/auth-database-graph-review.md), scoped by [Decision 0025](docs/cookbook/decisions/0025-auth-database-graph-review.md), proposes root-development CLI/peer placement but has not resolved or installed a combined graph. The separately authorized [Decision 0026 lock-only phase](docs/cookbook/auth-database-lock-only.md) now resolves 344 packages in an external two-importer workspace with frozen repeats and dated advisory checks, without installing packages. Optional CLI/Studio/React reachability and changed lint peer contexts remain explicit; production artifacts, runtime/installation-engine behavior and adoption are still unverified.

## Start here

1. Read the [product requirements](docs/PRD.md).
2. Read the [system architecture and application maps](docs/cookbook/architecture.md).
3. Follow the [milestone index and task workflow](docs/milestones/README.md).
4. Use the setup commands below and the [M01 foundation task log](docs/milestones/01-foundations.md).
5. Navigate implementation through the [API module/endpoint indexes](apps/api/docs/MODULE_INDEX.md) and [mobile feature/route/component indexes](apps/mobile/docs/FEATURE_INDEX.md); follow [API](apps/api/docs/TRACEABILITY.md) / [mobile](apps/mobile/docs/TRACEABILITY.md) requirement evidence without treating planned features as implemented.
6. Read [AGENT.md](AGENT.md) before changing code; [AGENTS.md](AGENTS.md) points to the same instructions.

## Local setup

For the complete current **Windows host** lane, bootstrap a fresh checkout with `node scripts/check-local.mjs` (or append `--offline` with populated caches). This entry needs no installed project dependencies. After setup, `pnpm check:local` remains a convenient alias; `verifyDepsBeforeRun: error` prevents pnpm from implicitly installing before the script's guards. It verifies tool pins, frozen installs, generated content, documentation, API build/tests and Flutter analysis/format/widget/golden checks sequentially. See [scope, commands and CI/native blockers](docs/cookbook/local-verification.md). It does not install SDKs, build native targets or claim an iOS pass. The individual commands remain below.

Installed-tool baseline: **Node 24.18.0 · pnpm 12.8.1 · Flutter 3.38.9 / Dart 3.10.8**. No global upgrade or extra workspace orchestrator is needed.

```bash
pnpm install --frozen-lockfile
pnpm check
test -e apps/api/.env || cp apps/api/.env.example apps/api/.env
pnpm dev:api
```

The guarded copy above uses Bash and **never overwrites an existing `.env`**; see the [PowerShell equivalent](apps/api/README.md#run). This laptop's original checkout already has its local copy. Never copy private configuration from another checkout. The [fresh-checkout review](docs/cookbook/fresh-checkout-review.md) records actual reproduction, the pnpm bootstrap correction and remaining native/CI blockers. The API serves `http://127.0.0.1:3000/v1/health/live`; readiness deliberately returns 503 until application services exist. Stop with Ctrl+C. `dev:api` compiles and starts, without hot reload.

```bash
cd apps/mobile
flutter pub get --enforce-lockfile
flutter gen-l10n
flutter analyze --no-pub
flutter test --no-pub
```

See [API setup](apps/api/README.md), [mobile setup and native prerequisites](apps/mobile/README.md), and the [bootstrap results](docs/cookbook/local-development-bootstrap.md). Docker is authorized if later needed, but is unnecessary for this shell. `pnpm check` also enforces the [API/Flutter import boundaries](docs/cookbook/import-boundaries.md), generated-token consistency, font/license hashes and the mobile artwork guard. Edit `design/tokens.json` and run `pnpm tokens:generate` to update the Flutter token adapter. Next.js web/admin remain later roadmap work.

<details>
<summary>Historical planning context before local setup</summary>

The previous active work was **M00-T05 — supported-environment review**, brought forward by [Decision 0011](docs/cookbook/decisions/0011-supported-environment-review-order.md). The [review](docs/cookbook/supported-environments-review.md) separates published constraints from proposed targets, device/browser coverage, macOS access, accessibility and performance. The owner reports **no test devices or Mac access yet**; T05 is **Blocked / unchecked**, with target/access/budget choices still unapproved. The [Windows/emulator plan](docs/cookbook/windows-emulator-validation-plan.md) now records the separately authorized read-only P0 host inventory. Metadata was collected without admin or network; acceleration, compatibility and resource budgets remain unverified. The [P1 static review](docs/cookbook/windows-emulator-feasibility.md) now holds setup on unresolved WHPX/GPU/native-tool evidence and an unaccepted storage proposal. The next narrow host-read proposal needs separate permission; all eight synthetic cases remain Not run. **M00-T04 stays open/unchecked**, paused with its blockers retained in [the milestone](docs/milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review). The [candidate review](docs/cookbook/toolchain-review.md) records accepted T04-A–D directions and the confirmed ApexCharts hold; the [executed probe](docs/cookbook/toolchain-probe.md) verified isolated Windows tools and limited Nest/Next build/HTTP behavior, and the separately authorized mobile 2.16.2 retry passed generation, analysis and six host tests after the initial 2.17.0 retraction failure. [Decision 0007](docs/cookbook/decisions/0007-isolated-lint-probe.md) separately authorized the [lint experiment](docs/cookbook/toolchain-lint-probe.md): 668 focused diagnostic checks and both synthetic apps' clean lint/strict type checks passed using Next's original rules with three exact temporary peer exceptions. This is not an unqualified strict-peer pass or approval for production exceptions. The [notice/readiness follow-up](docs/cookbook/toolchain-notices.md) traces 16 missing-file cases: 14 have text/declaration mappings; `client-only` and `stable-hash` retain attribution gaps. The [trace follow-up](docs/cookbook/toolchain-notice-trace.md) locates existing upstream requests, triages 17 embedded paths and proposed the combined-graph/launcher check subsequently authorized by [Decision 0008](docs/cookbook/decisions/0008-isolated-combined-js-probe.md). That [combined attempt](docs/cookbook/toolchain-combined-probe.md) passed tool/lock-only resolution checks but stopped before installation/build/lint when the fresh audit reported a high-severity Multer advisory. [Decision 0009](docs/cookbook/decisions/0009-isolated-multer-override-retry.md) subsequently authorized the exact-parent Multer 2.5.0 [retry](docs/cookbook/toolchain-multer-retry.md): ten regressions, combined builds/HTTP, 668 lint expectations, 16 clean files and frozen equality passed; fresh audits reported zero known advisories. Embedded/native notices, final pins and ApexCharts rights remain unresolved. [Decision 0010](docs/cookbook/decisions/0010-conditional-dependency-exceptions.md) separately accepts both exact policies and the [adoption packet's controls](docs/cookbook/toolchain-adoption-review.md): project-owner accountability, at-most-30-day review, revalidation and safe removal. Next policy review is due **2026-11-23 UTC**, or before adoption/change/release if earlier. Decision 0010 does not approve a baseline, final pins, new execution, installation, deployment, scaffolding or task advancement; Decision 0011 separately permits only the early T05 review.
This historical review did not authorize coding; the owner's later explicit setup request in Decision 0012 does. It does not mark those outstanding reviews complete.

</details>

## Repository layout

Existing documentation and intended application locations:

```text
README.md                     Repository entry point
AGENT.md                      Canonical development/agent instructions
AGENTS.md                     Pointer to AGENT.md

docs/
  PRD.md
  MOBILE_TECH_SPEC.md
  BACKEND_TECH_SPEC.md
  WEB_PRD.md
  ADMIN_CMS_PRD.md
  cookbook/                   Cross-cutting engineering guides
    decisions/                Repository-wide decision records
  milestones/                 Ordered task plans, dependencies, evidence logs

apps/
  mobile/                     Flutter shell; native wrappers generated, not device-tested
  api/                        NestJS local health API; no workers/domain services yet
  web/                        Planned, not created
  admin/                      Planned, not created
design/tokens.json            Implemented platform-neutral foundation tokens
scripts/                      Import, token-generation and asset checks
packages/                     Planned only; introduced for actual sharing needs
  api-client/
  web-ui/
  design-tokens/
```

One repository does not mean one deployment, one session, or one unrestricted code boundary. NestJS owns business rules and domain migrations; web/admin have separate sessions and narrow backend-for-frontend (BFF) layers. Flutter and React share contracts/design semantics, not widget implementations.

## Specifications and guides

| Document | Purpose |
|---|---|
| [Product PRD](docs/PRD.md) | Scope, behavior, privacy, and release stages |
| [Mobile specification](docs/MOBILE_TECH_SPEC.md) | Flutter architecture, local storage, sync, adaptive behavior |
| [Backend specification](docs/BACKEND_TECH_SPEC.md) | NestJS modules, proposed contracts, integrity and jobs |
| [Website specification](docs/WEB_PRD.md) | User-web routes, file map, sessions and browser behavior |
| [Admin specification](docs/ADMIN_CMS_PRD.md) | Staff routes, file map, capability and evidence boundaries |
| [Architecture](docs/cookbook/architecture.md) | End-to-end system and ownership map |
| [Schema](docs/cookbook/schema.md) | Proposed logical data model and constraints |
| [Security](docs/cookbook/security.md) | Trust boundaries and required controls |
| [Testing](docs/cookbook/testing.md) | Verification strategy and release evidence |
| [Deployment](docs/cookbook/deployment.md) | Environments, release, backup, restore and incident rules |
| [Design system](docs/cookbook/design-system.md) | Standalone visual system, components, light/dark themes and sizes |
| [Milestones](docs/milestones/README.md) | What to do next, prerequisites, task IDs and completion evidence |
| [Decision 0001](docs/cookbook/decisions/0001-scope-and-release-tracks.md) | Accepted release priorities, Android-first pilot, decision location and authority |
| [Decision 0002](docs/cookbook/decisions/0002-rounded-icons-and-chart-rendering.md) | Rounded icon-bank requirement, ApexCharts for user web, custom Flutter charts where needed |
| [Decision 0003](docs/cookbook/decisions/0003-product-defaults.md) | Accepted privacy, account, language/unit, Focus, Money and card defaults |
| [Decision 0004](docs/cookbook/decisions/0004-toolchain-directions-and-icon-family.md) | Accepted workspace/mobile/web directions and Hugeicons Free Stroke Rounded; ApexCharts integration hold |
| [Decision 0005](docs/cookbook/decisions/0005-isolated-compatibility-probe.md) | Authorized isolated chart-free download/build/test experiment; no final pins or repository scaffolding |
| [Decision 0006](docs/cookbook/decisions/0006-mobile-probe-generator-retry.md) | Authorized mobile generator retry only; no production app development or final-pin approval |
| [Decision 0007](docs/cookbook/decisions/0007-isolated-lint-probe.md) | Authorized isolated lint experiment with exactly three temporary peer exceptions; no production policy change |
| [Decision 0008](docs/cookbook/decisions/0008-isolated-combined-js-probe.md) | Authorized unchanged combined attempt; stopped at the security gate, no override authorized by that decision |
| [Decision 0009](docs/cookbook/decisions/0009-isolated-multer-override-retry.md) | Separate exact-parent Multer 2.5.0 retry authorization; no production override or scaffold approval |
| [Decision 0010](docs/cookbook/decisions/0010-conditional-dependency-exceptions.md) | Accepted conditional eligibility of exact lint allowances/Multer override and maintenance controls; no baseline adoption or new execution |
| [Decision 0011](docs/cookbook/decisions/0011-supported-environment-review-order.md) | Accepted early M00-T05 review/order adjustment; T04 blockers retained, no target or execution approval |
| [Decision 0012 — Local development bootstrap](docs/cookbook/decisions/0012-local-development-bootstrap.md) | Owner-directed setup now using installed tools; separate from production/native readiness |
| [Bootstrap results](docs/cookbook/local-development-bootstrap.md) | Actual source, tests, local commands, dependency checks and remaining limitations |
| [Supported-environment review](docs/cookbook/supported-environments-review.md) | Published constraints, proposed coverage and measurement plan; owner reports no test devices/Mac access yet, completion and target approval blocked |
| [Windows/emulator validation plan](docs/cookbook/windows-emulator-validation-plan.md) | Completed P0 inventory, P1 review with setup held and eight not-run synthetic cases; no setup or physical-device replacement |
| [Windows emulator feasibility](docs/cookbook/windows-emulator-feasibility.md) | Official host/tool constraints, unresolved WHPX/GPU evidence and unaccepted per-volume budget; no new host query or installation |
| [Reference-app audit](docs/cookbook/reference-app-audit.md) | Completed static inventory and reference-only/rebuild/exclude assessment; not runtime verification |
| [Reference dependency/provenance register](docs/cookbook/reference-app-licenses.md) | Resolved direct notices, lockfile identities, asset exclusions and remaining licensing gates |
| [Toolchain/workspace candidate review](docs/cookbook/toolchain-review.md) | Runtime/library candidates, rounded-icon evidence and ApexCharts licensing blocker; not approved pins |
| [Toolchain compatibility follow-up](docs/cookbook/toolchain-compatibility.md) | Historical SDK/constraint/support research, corrections and bounded probe scope |
| [Toolchain probe results](docs/cookbook/toolchain-probe.md) | Tool/JS checks, initial failures, successful mobile host retry and durable evidence; not approved production pins |
| [Frontend lint review](docs/cookbook/toolchain-lint-review.md) | Historical static coverage map and proposal that preceded the separately authorized experiment |
| [Frontend lint probe](docs/cookbook/toolchain-lint-probe.md) | Exception-based installation, actual diagnostic/effective-config checks and clean lint/type results; not production adoption |
| [Dependency notices and adoption readiness](docs/cookbook/toolchain-notices.md) | Sixteen notice dispositions, embedded/native inventory, support/bootstrap recommendation and remaining approval queue; no new installation or policy acceptance |
| [Attribution trace and next validation plan](docs/cookbook/toolchain-notice-trace.md) | Existing upstream requests, 17 embedded-path dispositions, distribution boundaries and the historical combined-graph/launcher proposal |
| [Combined JS probe and security blocker](docs/cookbook/toolchain-combined-probe.md) | Preserved original audit stop and static remediation proposal; no application execution in that root |
| [Multer override retry](docs/cookbook/toolchain-multer-retry.md) | Separately authorized regression/combined build/HTTP/lint results and durable evidence; production adoption still gated |
| [Toolchain adoption decision packet](docs/cookbook/toolchain-adoption-review.md) | Conditionally accepted lint/override policies, maintenance/removal controls, saved-graph notice paths and remaining gates; baseline adoption still unapproved |

## Product boundaries

- Money is manual tracking/planning only: no bank connections, payments, or real fund movement.
- Private tracker data stays private regardless of account visibility; publishing uses deliberately selected snapshots.
- Social content is progress cards, not arbitrary posts, videos/reels, or an endless ranked feed.
- Support Small, Medium, Large, and Largest usable windows, including resizing and iPad split view.
- System / Light / Dark appearance follows the standalone design system. The retired original style-reference file is not required.
- Staff access is capability-scoped and audited; admin is not a general private-finance or DM browser.

## Delivery approach

Build one verified vertical slice before copying its architecture to other modes. The product progresses through **V1-A personal → V1-B social publishing → V1-C reposts/messaging**. User web progresses through **W0–W3**; admin through **A0 safety → A1 operations**, with **A2 editorial/configuration optional**.

The accepted first distribution is an **Android-first limited personal pilot**, after its readiness gate. iPhone/iPad remain required targets; Android results do not verify them. No release date or actual deployment is authorized by this sequencing decision.

Admin A0 and operational policies must be ready before public social launch. Each application can release independently after its own stage gates; the milestone order is a dependency-aware working plan, not a promise of simultaneous releases or delivery dates.

**Current work: M01 local API/mobile foundations under Decision 0012.** M00-T04/T05 and full T14 acceptance remain open; local development pins are not a release baseline. The [task log](docs/milestones/01-foundations.md) separates verified local setup from pending native/platform work. No product feature or release is complete merely because scaffolds and host tests exist.
