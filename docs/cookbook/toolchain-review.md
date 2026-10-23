# Toolchain and Workspace — Candidate Review

- **Version:** 0.3
- **Observed:** 2026-10-23 UTC, Windows / Git Bash
- **Task:** [M00-T04](../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), In progress / not Verified
- **Authority:** [Decision 0004](decisions/0004-toolchain-directions-and-icon-family.md) accepts T04-A–D directions and the ApexCharts hold; this review records research, not approved pins or installation permission
- **Related:** [Architecture](architecture.md), [Decision 0002](decisions/0002-rounded-icons-and-chart-rendering.md), [design system](design-system.md), [reference audit](reference-app-audit.md)
- **Follow-up:** [SDK identity, support/constraint findings and proposed chart-free probe](toolchain-compatibility.md); published Flutter/Dart pair established, ESLint 9 recommendation withdrawn, runtime verification still pending

## 1. Recommendation and approval boundary

The owner accepted a small pnpm workspace for the confirmed NestJS / separate Next.js applications and an independently pinned Flutter application. Investigate current supported stable SDKs rather than inheriting the reference apps' lockfiles. **Hugeicons Free — Stroke Rounded** is the selected icon family; package pins, visual/native validation and distribution-notice handling remain open.

**Do not install the latest version of every package together.** Published metadata exposed incompatible TypeScript, ESLint and Dart-generator combinations. The candidate revisions below address specific range conflicts, not complete compatibility. The follow-up withdraws ESLint 9 because it is EOL; a maintained frontend lint graph remains unresolved. No complete dependency resolution, build, security audit or native/browser integration has run.

**ApexCharts remains selected in principle, but not cleared for integration.** Its current core and React-wrapper notices are not MIT. The official OEM conditions may affect Your Own's interactive user website even if it is free and small. Obtain an applicable entitlement determination before installation or a chart spike; do not silently substitute another engine or an old license/version.

On 2026-10-23 UTC the owner replied **"yes"** to approving T04-A–D directions while keeping ApexCharts integration on hold. Decision 0004 records that bounded acceptance. It refines Decision 0002's icon-family selection without waiving its constraints or changing Decisions 0001/0003. Unresolved pins, rights and verification stay blockers; no installation, scaffold, purchase or supplier outreach is authorized.

## 2. Local observations, not project pins

| Item | Observed | Limit |
|---|---|---|
| Node | `node --version` returned `v24.18.0`; executable under `C:/nvm4w/nodejs` | Installed version is not an approved application baseline or current security patch |
| Flutter checkout | `C:/Users/HP/develop/flutter`, clean at stable tag `3.38.9` | Git/static inspection only; Flutter was not executed |
| Bundled Dart metadata | Existing `bin/cache/flutter.version.json` reports `3.10.8` | Cached metadata, not a fresh SDK command or native build |
| npm / Corepack / pnpm | Commands present; inspected `pnpm` launcher delegates to Corepack | No pnpm version established; invoking the shim may download a manager, so it was not run |
| Repository | Specifications only; no `apps/`, `packages/`, manifests or application lockfiles | Proposed commands, CI and runtime pins do not exist yet |

The global Flutter checkout also serves other projects. Any eventual upgrade must be explicitly authorized and isolated; do not run `flutter upgrade`, update global Node/Corepack, or alter reference repositories as a side effect. M00-T05 still owns the macOS/Xcode path and supported device/browser baselines.

## 3. Runtime and workspace candidate matrix

Exact numbers are **observed candidate versions**, not automatically approved pins. Registry `latest` tags and upstream branches can move; revalidate before a permitted experiment and before committing lockfiles.

| Area | Candidate / alternatives | Evidence and disposition |
|---|---|---|
| Node | **24.22.1 LTS** rather than installed 24.18.0; do not jump to Node 26 merely because it is newer | [Official releases](https://nodejs.org/dist/index.json) list 24.22.1 as a security release. [Schedule](https://github.com/nodejs/Release/blob/main/schedule.json) puts Node 24 in maintenance through 2028-04-30; Node 26 LTS begins 2026-10-28, after this observation. Upgrade not executed |
| Flutter / Dart | **3.47.7 / bundled Dart 3.13.5 candidate pair**, established from release metadata and pinned source | [Follow-up evidence](toolchain-compatibility.md#2-flutterdart-identity-and-archive-path-correction) resolves earlier 404s by following the archive page's current release-JSON path. Four published archive identities recorded; actual SDK bytes, version execution and native behavior remain unverified. No SDK download or final pin approval |
| Existing Flutter fallback | 3.38.9 / cached Dart 3.10.8 | Not the recommendation for a new baseline: current Riverpod and go_router candidates require Dart 3.12, and go_router requires Flutter 3.44. Older package candidates exist, but retaining an older SDK needs a separate support/security rationale |
| Workspace manager | **pnpm 12.15.0 candidate**, versus npm workspaces | [Metadata](https://registry.npmjs.org/pnpm/12.15.0), [installation](https://pnpm.io/installation), [workspaces](https://pnpm.io/workspaces). Prefer explicit workspace dependencies and a shared JS lockfile. Current pnpm documentation describes a native executable and Node ≥22.13 for npm-based installation, while registry engine metadata says ≥18; Node 24 meets both, but bootstrap/Corepack behavior remains untested |
| TypeScript | **6.0.3 candidate**, strict application configs | [Exact metadata](https://registry.npmjs.org/typescript/6.0.3). Registry latest was 7.0.2, but Swagger 12.0.3 accepts TS 5.5/6, typescript-eslint 8.72.0 requires `<6.1.0`, and ts-jest 29.4.15 requires `<7`. Nest CLI 12.0.10 depends on `~6.0.2`. Do not force incompatible peers |
| NestJS | Core/common/platform-express **12.2.0**, CLI **12.0.10**, Swagger **12.0.3** | [Core](https://registry.npmjs.org/@nestjs%2Fcore/12.2.0), [CLI](https://registry.npmjs.org/@nestjs%2Fcli/12.0.10), [Swagger](https://registry.npmjs.org/@nestjs%2Fswagger/12.0.3). Framework family and inspected Node/TS ranges align with candidates. CLI/schema generation, decorators, Express behavior and production builds remain untested |
| Next.js / React | Next **16.4.2**, React and React DOM **19.3.1**, both applications independently configured | [Next metadata](https://registry.npmjs.org/next/16.4.2), [React DOM](https://registry.npmjs.org/react-dom/19.3.1), [installation requirements](https://nextjs.org/docs/app/getting-started/installation). Next requires Node ≥20.9 and accepts React 19; React DOM requires React `^19.3.1`. These declarations are not SSR/session compatibility evidence |
| Lint | **ESLint 9.39.4 recommendation withdrawn**; ESLint 10.13.0 current-line candidate, frontend graph unresolved | [Support policy](https://eslint.org/version-support/) places ESLint 9 EOL on 2026-08-06. [Follow-up](toolchain-compatibility.md#4-support-and-security-findings) records three React/import/accessibility plugins excluding ESLint 10. Do not force peers, waive rules or assume paid support; versions/configuration remain unselected |
| Tests | Flutter SDK tests; API Jest **30.5.2** / ts-jest **29.4.15**; browser Playwright **1.64.1** candidates | [Jest](https://registry.npmjs.org/jest/30.5.2), [ts-jest](https://registry.npmjs.org/ts-jest/29.4.15), [Playwright](https://registry.npmjs.org/@playwright%2Ftest/1.64.1). Inspected ts-jest declares Jest 29/30 support. Component-test runner choice remains open; Vitest 5.0.5 was inventoried, not selected. No test runner/browser binaries installed |

### Accepted workspace direction, implementation pending

- One private root JS workspace with explicit `apps/api`, `apps/web`, `apps/admin` and only useful shared JS packages. Flutter retains its own `pubspec.yaml` and application `pubspec.lock`; it is not a Node workspace package merely to make a diagram uniform.
- Pin the approved package-manager version and runtime; one committed `pnpm-lock.yaml` for JS, frozen installs in CI, explicit `workspace:` relationships, and no npm/yarn companion lockfile. Select and test the manager bootstrap mechanism rather than assuming the existing Corepack shim proves availability.
- Start with pnpm filtering and ordinary app-local scripts. **No Nx, Turborepo, Melos, remote build cache or global SDK manager by default.** Add orchestration only when measured needs justify it. A project-isolated SDK path/pin can precede choosing a version-manager dependency.
- Review dependency lifecycle/build scripts and explicitly allow only necessary ones; never blanket-approve unknown install scripts. Exact pnpm settings and native binary provenance need validation against the selected version. A frozen graph is not a security review.
- Keep application builds, env files, sessions, credentials and deploy artifacts separate. Shared packages must not import API database adapters or expose staff-only modules to user web. One lockfile does not combine authorization boundaries.
- Preserve canonical `AGENT.md` and the compatibility pointer. A starter-generated `AGENTS.md`, chart component, default icon bank, cache policy or telemetry setting is not authoritative.

## 4. Supporting-library candidates and conflicts

Decision 0004 accepts the named mobile/web directions in T04-B/C, not every helper, generator, test tool or exact version below. Licenses shown for ordinary libraries come from registry metadata or prior targeted notice review, not a newly cleared complete dependency graph. Reinspect notices for the exact graph before adoption. Provider SDKs and ORM/storage-driver choices are deliberately not bundled into this approval.

| Area | Candidate versions / direction | Rationale and remaining gate |
|---|---|---|
| Mobile state | [flutter_riverpod 3.4.3](https://pub.dev/packages/flutter_riverpod/versions/3.4.3) | Scoped application/presentation state; domain remains framework-independent. Requires Dart `^3.12.0`; not compatible with installed Dart 3.10.8. Use ordinary providers first; do not add generator tooling without a need |
| Mobile routing / HTTP | [go_router 18.1.1](https://pub.dev/packages/go_router/versions/18.1.1), [Dio 5.11.1](https://pub.dev/packages/dio/versions/5.11.1) | Declarative routing, explicit session guards, controlled transport/retry. go_router requires Flutter ≥3.44 / Dart 3.12. Route redirects are not backend authorization; no non-idempotent automatic retries |
| Local persistence | [Drift 2.35.2](https://pub.dev/packages/drift/versions/2.35.2), [drift_dev 2.35.1](https://pub.dev/packages/drift_dev/versions/2.35.1) | Typed local schema/queries with separately reviewed migrations. Their patch numbers need not be identical: drift_dev accepts Drift `>=2.30.0 <2.36.0`. Encryption, native SQLite build, key storage and connection setup are **M00-T08 blockers**, not solved by choosing Drift |
| SQLite connection helper | [drift_flutter 0.3.1](https://pub.dev/packages/drift_flutter/versions/0.3.1), **not yet recommended for the encrypted connection path** | Still declares the SQLCipher/SQLite no-op compatibility packages documented in the reference audit. Package names are not encryption evidence; choosing the helper must not accidentally select plaintext storage |
| Dart code generation | [build_runner 2.17.0](https://pub.dev/packages/build_runner/versions/2.17.0), [json_serializable 6.15.2](https://pub.dev/packages/json_serializable/versions/6.15.2) candidates | Latest build_runner 2.17.1 requires `build >=5 <5.1`, conflicting with drift_dev's `build <5`. 2.17.0 uses `build ^4.1.0`; its analyzer range intersects the inspected generators' ranges. Full pub resolution/code generation still required; no dependency override to conceal conflicts |
| Web styling | [Tailwind 4.3.3](https://registry.npmjs.org/tailwindcss/4.3.3); owned accessible components and semantic tokens | Its [browser requirements](https://tailwindcss.com/docs/compatibility) include Chrome 111, Safari 16.4, Firefox 128; M00-T05 must accept the combined browser baseline before final version selection. shadcn/ui is an owned-source approach, not approval of its current starter, icon defaults, charts or every underlying primitive |
| Web server state | [TanStack Query 5.104.5](https://registry.npmjs.org/@tanstack%2Freact-query/5.104.5) | React 18/19 peer declaration fits. Cache/session scoping, disposal and SSR ownership still require implementation evidence; not a parallel source of backend truth |
| Web forms | [React Hook Form 7.90.0](https://registry.npmjs.org/react-hook-form/7.90.0), [resolvers 6.0.0](https://registry.npmjs.org/@hookform%2Fresolvers/6.0.0), [Zod 4.6.7](https://registry.npmjs.org/zod/4.6.7) | Declared selected peers align; import only needed adapters. Client validation supplements backend rules. Exact Money strings, dates and nullable contracts remain M00-T10 work |
| Shared API client | REST/OpenAPI generation; generator not selected | Validate decimal strings, nullability, errors and auth adapters in M00-T10, before promising generated Dart/TS parity |
| Database / providers / jobs | PostgreSQL/Prisma, auth/storage provider, Redis/BullMQ, push and realtime remain proposals | M00-T06/T07/T13 own these decisions. No version, service, spend or deployment selected by this document |

Next 16's production build does not run lint automatically. Future CI must run lint and type checks explicitly rather than declaring `next build` sufficient. Backend decorator compilation and test transforms also need explicit proof; accepting Node/TS peer ranges does not validate them.

## 5. Rounded icons — selected family and coverage evidence

### Comparison

| Candidate | Evidence | Assessment |
|---|---|---|
| **Hugeicons Free — Stroke Rounded** | Official first-party [repository](https://github.com/hugeicons/hugeicons), React renderer + free data, Flutter SVG-backed renderer. Exact inspected packages: `@hugeicons/react 1.1.10`, `@hugeicons/core-free-icons 4.3.5`, `hugeicons 1.2.0` | Selected family under Decision 0004: explicitly rounded style, broad free inventory and first-party cross-platform packages; exact pins remain pending. Choose only this style, not Pro/sharp/solid packs or a mixed-family fallback |
| Lucide | `lucide-react 1.61.0` metadata; official [license](https://lucide.dev/license) is ISC with MIT notices for Feather-derived icons | Plausible alternative; preserve both notice sets, not merely a third-party Flutter port's MIT file. Flutter adapter/version parity and visual fit need independent review. Not inherited just because a component starter uses it |
| Tabler Outline | `@tabler/icons-react 3.49.0` metadata and upstream [MIT notice](https://github.com/tabler/tabler-icons/blob/main/LICENSE) | Plausible broad outline alternative; exact Flutter path, rounded visual acceptance and complete catalog not audited. Do not combine its missing glyphs with Hugeicons |

### Exact static inventory

The three Hugeicons package archives were fetched into temporary research storage, **not installed or added to the repository**. Registry integrity matched. Flutter declares 6,063 `strokeRounded` constants; the React data package has 6,026 export lines, including aliases. These are different inventory measurements, **not proof of one-to-one parity or a promise that every glyph is needed**.

A 76-name cross-platform presence probe found `WifiOff` missing in Flutter even though React exports it. Replacing that proposed mapping with the explicitly available **`WifiDisconnected01`** yields 76 common candidate names. Do not infer vendor names mechanically from another platform. The names below are candidate catalog entries, not approved UX labels or a fully rendered component audit. Flutter uses `HugeIcons.strokeRounded<Name>`; React uses the verified `<Name>Icon` exports from the free data package.

| Required area | Common candidate names |
|---|---|
| Navigation / modes | `Home01`, `ChartLineData01`, `UserCircle`, `Settings01`, `Timer01`, `Book01`, `Droplet`, `Coffee01`, `Wallet01` |
| Focus / Read / Money actions | `Play`, `Pause`, `Stop`, `Target01`, `Bookmark01`, `Money03`, `Exchange01`, `PiggyBank`, `Invoice01`, `Task01` |
| CRUD / menus / pickers | `Add01`, `MinusSign`, `Edit01`, `Delete01`, `Copy01`, `Search01`, `MoreHorizontal`, `Menu01`, `Cancel01`, `ArrowLeft01`, `ArrowRight01`, `ArrowDown01`, `ArrowUp01`, `Calendar03`, `Clock01`, `FilterHorizontal`, `Sorting05` |
| Privacy / status / auth | `LockKey`, `Lock`, `SquareLock01`, `View`, `ViewOff`, `Globe02`, `CheckmarkCircle02`, `InformationCircle`, `Alert02`, `Loading03`, `Login01`, `Logout01`, `Key01` |
| Social / messaging / safety | `UserGroup`, `UserAdd01`, `UserRemove01`, `UserBlock01`, `UserCheck01`, `Shield01`, `ShieldKey`, `Flag01`, `ThumbsUp`, `Comment01`, `Share08`, `Repeat`, `Message01`, `Sent`, `Notification01` |
| Staff / data / appearance | `Database01`, `File01`, `Link01`, `Download01`, `Upload01`, `CloudUpload`, `CloudDownload`, `WifiDisconnected01`, `ArrowReloadHorizontal`, `Sun03`, `Moon02`, `Computer` |

Representative `Home01`, `Timer01` and `Wallet01` path data were inspected on both platforms: matching path strings, `strokeLinecap/Linejoin: round`, and 1.5-unit source strokes. This establishes a plausible rounded source style, **not** pixel/rendering parity for the entire catalog. Test 20/24 visuals inside ≥48×48 targets, selected/disabled/error states, both themes, large text and poster output in M00-T09.

The Flutter renderer builds local SVG strings from bundled data and uses `SvgPicture.string`; it is not a font-backed `IconData` replacement. It does not expose an explicit semantic-label parameter in the inspected render path. An owned semantic adapter must supply or deliberately exclude semantics as appropriate, with the interactive control owning its name, focus, state and hit area. Its Material/Cupertino theme/color imports are not use of prohibited built-in artwork. `flutter_svg 2.3.0` is a compatible-looking renderer candidate by declared ranges, not an approved native result.

### Rights and distribution

The exact React renderer/free-data archives include MIT notices (Hugeicons, 2025); the Flutter archive includes MIT (Halal Labs, 2024). The supplier's [license agreement](https://hugeicons.com/license-agreement), effective 2026-09-14, explicitly separates free Stroke Rounded MIT icons from Pro restrictions: free use/modification/redistribution, no seat/key/account, retain copyright/permission notices with source copies. This supports the **free** family selected in Decision 0004 for apps and composed posters; it is not permission to redistribute Pro packs.

Before adoption, retain both applicable notices in the repository/distributed notices and settle notice handling for exported standalone assets/posters. Do not claim that a general app credits screen automatically satisfies every export case. Do not package an icon marketplace, fetch runtime icons remotely, or put keys in bundles. Poster/notice presentation and actual bundled subset remain design/release checks. No icon source bytes have been copied into this project.

### Remaining coverage gate

M00-T09 must render a semantic catalog and audit app bars, dialogs, date/time pickers, search clearing, dropdowns, pagination, password reveal, navigation/back controls, uploaders, tables, staff tools, chat and chart toolbars. Explicitly replace implicit default artwork. Where a widget cannot accept the selected SVG-backed icon, choose an accessible composable replacement or record a blocker—never silently fall back to Material/Cupertino, emoji, Lucide or a vendor logo. OS-owned controls and legitimate provider marks retain Decision 0002's exceptions.

## 6. ApexCharts — version evidence and licensing blocker

### Inspected candidates

- Core **`apexcharts 8.4.1`** and wrapper **`react-apexcharts 2.1.1`**; exact registry archives and notices inspected, no installation or execution.
- Wrapper peers are React `>=16.8.0` and ApexCharts `>=5.10.1`; proposed React 19.3.1/core 8.4.1 satisfy those declarations. Core's Node range accepts Node 24. These broad declarations do **not** prove Next 16 production compatibility, feature entitlement, hydration or Strict Mode cleanup.
- Core notice: `SEE LICENSE IN LICENSE.md`; wrapper: `SEE LICENSE IN LICENSE`. Both contain Community/Commercial/OEM conditions. The MIT notice in the unrelated `apexcharts_flutter 0.1.2` reference package grants no rights to these JS packages.

### Why entitlement is unresolved

[Official overview](https://apexcharts.com/license/), [Community](https://apexcharts.com/license/community/), [Commercial](https://apexcharts.com/license/commercial/) and [OEM](https://apexcharts.com/license/oem/) pages were read, together with exact package notices.

1. Current core/site Community criteria include revenue, operating budget, funding or equivalent resources below USD 2 million, including related entities. The wrapper notice uses older revenue-focused wording. Do not assume a personal project or free app establishes eligibility or resolves these differences.
2. The core notice says embedding in a product/platform used by others needs OEM regardless of size, except static charts users cannot configure/interact with. The OEM page mentions users who interact with, configure **or benefit from** charting, then describes a view-only/static-or-predefined exception. Do not decide that date filters, tooltips, keyboard selection, drilldowns or exports fall within that exception without clarification.
3. The inspected OEM page quotes **USD 14,999 per application per year**, with unlimited developer seats, renewal conditions and separate application licensing. This is a dated published quote, **not** an approved cost, final offer or determination that this exact plan applies. The view-only exception also mentions per-developer Pro/Premium terms; cheap/free eligibility cannot be inferred from one paragraph.
4. There are separately licensed opt-in features/chart types in the same core package. Do not import premium features, bypass watermarks/checks, select an old MIT release to avoid review, or remove notices. Check expiry and continued redistribution obligations before any deployment.

**Required owner/vendor clarification:** Describe private personal dashboards, predefined chart types, date/category filters, hover/touch/keyboard interactions, exact-value alternatives, image exports, intended users, web origins, development/staging/production and any later admin use. Establish the applicable license for both exact packages, organization eligibility, application/seat scope, expiry/renewal and distribution rights. No supplier contact, account creation, purchase or disclosure of private business information has occurred. The owner must authorize any outreach.

If acceptable rights cannot be obtained, request an explicit amendment to Decision 0002. Do not weaken accessible interactions or quietly replace the mandated chart engine to evade the gate. Admin has not been silently included in a user-web entitlement.

### Required client-only integration proof after clearance

- Keep any browser-dependent wrapper/core imports behind a dedicated Client Component. [Next's lazy-loading guidance](https://nextjs.org/docs/app/guides/lazy-loading) requires `dynamic(..., { ssr: false })` inside a Client Component, not a Server Component. A `'use client'` declaration alone is not proof that server prerender cannot evaluate a browser-only import.
- After permitted installation, prove a production build/start, direct route load, server prerender, hydration, navigation/remount and development Strict Mode cleanup. No duplicate chart instances, global listeners, stale tooltips or private data after unmount/logout/account switching.
- Give every chart an accessible title/summary and exact-value table. Test keyboard/touch, all four size classes, large text, reduced motion, both themes, empty data and long histories. Charts may approximate coordinates, never authoritative Money values.
- Hidden Money must not enter chart series, props, DOM, accessibility text, tooltips, downloaded images or retained caches. Disable unapproved toolbar/zoom/download/context-menu controls; use the selected icon family for any enabled app-owned controls.
- Inspect actual bundles, network requests, local assets, CSP behavior, licensing checks and render costs. Do not claim tree shaking, no telemetry, safe exports or acceptable performance from metadata/package size. Public pages should not eagerly load personal charts.

These are required tests, **not tests already run**. M00-T04 remains unchecked; the representative M00-T09 prototype cannot proceed past an unresolved rights gate.

## 7. Owner review and next actions

| ID | Accepted direction / hold | State |
|---|---|---|
| T04-A | Lean pnpm workspace, separate Flutter lockfile/SDK pin, no extra monorepo orchestrator; Node 24 LTS and TypeScript 6 candidate direction | Direction accepted; bootstrap, exact pins and graph validation pending |
| T04-B | Move toward current stable Flutter in an isolated SDK location; Riverpod/go_router/Dio and Drift directions, without inheriting reference versions | Direction accepted; published Flutter/Dart pair established in follow-up, actual SDK/graph/native proof pending; no upgrade/installation authorized, encryption separately gated |
| T04-C | Next App Router/React with semantic Tailwind styling, scoped TanStack Query and RHF/Zod; owned accessible components rather than unreviewed starter output | Direction accepted; exact graph, primitive choice and browser baseline pending |
| T04-D | Hugeicons **Free Stroke Rounded only**, using first-party Flutter/React adapters and preserved notices; native/custom Flutter charts remain unchanged | Family selected; pins, export-notice handling and visual/implicit-glyph validation pending |
| T04-E | Keep ApexCharts integration on hold; seek an applicable written entitlement determination before any install/spike, or explicitly revisit the owner requirement | Hold confirmed; entitlement remains blocked, no purchase or outreach approved |

The recorded approval of directions does not certify the untested candidate versions, supply missing rights, approve an installation/global upgrade or open M01. The next work is **still M00-T04**: validate the published Flutter/Dart candidate in an explicitly authorized isolated environment, resolve maintained frontend lint coverage, review the remaining graph/notices and request the [chart-free compatibility probe](toolchain-compatibility.md#6-proposed-chart-free-compatibility-probe--awaiting-authorization). No executable probe has been authorized or run. Full prototype/device evidence stays with M00-T05/T08/T09, and final scaffold authorization stays M00-T14.

## 8. Evidence and reproducibility

Public GET requests used Python's standard library/curl; no credentials, private records or project files were uploaded. Registry JSON, official documentation, selected license/source text and **five package archives for static inspection** were downloaded to `C:/Users/HP/AppData/Local/Temp/your-own-toolchain-review-so4nyten/`, not into the app or Pub/npm caches. Archive integrity was checked against registry-supplied SHA-512 (npm) or SHA-256 (pub); this is byte identity, **not** publisher-signature verification, a security audit or legal clearance. No third-party package code or install script was executed.

| Exact inspected archive | Archive SHA-256 | Root notice SHA-256 |
|---|---|---|
| `@hugeicons/react 1.1.10` | `45192b4957c6d54b00f9e83b310dcac2c9ef22809bededb7a3884d838c444208` | `1658d8213209df7b9b86dfc05d724ede48d00dbc27abc15976ec7adec9601cde` |
| `@hugeicons/core-free-icons 4.3.5` | `c95cc346815518a2a9f91edf8c194d497ba6e4e3ecb3f20a38e034f72d756b5f` | `1658d8213209df7b9b86dfc05d724ede48d00dbc27abc15976ec7adec9601cde` |
| `hugeicons 1.2.0` | `a5953782b6065e16b56ea832229135a548fd46022d7df56b985c7b1be2883ca9` | `6e2dddec58190205b66a1ac9fa7555f3cfb3fcde332e9cfad81b153283a25c28` |
| `apexcharts 8.4.1` | `abb5d287482c0dbb526d1c4adc1d7a7d3aac01cf71acb143f1bd0f0cb27a3eec` | `dd05797238932cd2642116e30053475933182873beb0624b6a788919afe0ef8d` |
| `react-apexcharts 2.1.1` | `6407a63e18e945418792c2e682c22d5dec234c71691e65f484fcc8a102f23e23` | `534b059f0ff483b8867a270938e707e22af2cd3b6d51340765ceff70b7f1a44d` |

Additional raw-response SHA-256 identities: Hugeicons license-agreement page `5f3314fe24f91bda7be39bc13cb8b58816604725d41f7ef042cd5ac2c538d397`; ApexCharts overview `1de630f302adbfee7a97dcdffc09bd07340b35ca3ecfaa9397c75ac4c90fb54c`; OEM page `4b14c7c000030c008f43d4d6bcbf789fcf1cc9a0b2cb3683a5175e05782892b7`. Pages can change; retain approved notices/evidence in durable project/release records before adoption rather than relying on this machine's temporary files.

Research manifests: `metadata-summary.json`, `page-manifest.json`, `followup-manifest.json`, `followup2-manifest.json`, `lint-manifest.json`, `archive-manifest.json`, and `icon-coverage.json`. Some guessed upstream paths returned 404 and were replaced with published/tagged notices where available. At that initial review, Flutter release metadata retrieval was unresolved. The follow-up subsequently established the published pair through the archive page's current release endpoint and pinned source; actual SDK/runtime verification is still not claimed. Research-helper output/encoding errors did not constitute application failures; saved responses were inspected separately.

Not run: installs/resolution, Flutter/Dart SDK commands, application lint/type/tests, generated clients, SSR/hydration, device/emulator journeys, native builds, full vulnerability audit/publisher-signature verification, encryption spikes, CI or deployments. The follow-up adds only targeted advisory-range checks, not a full security result. Documentation checks establish only the consistency of this review and its navigation/status pointers.
