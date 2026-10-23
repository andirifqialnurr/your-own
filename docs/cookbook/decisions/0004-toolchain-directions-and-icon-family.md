# Decision 0004 — Toolchain Directions and Icon Family

- **Status:** Accepted directions and ApexCharts integration hold; exact pins and verification pending
- **Task:** [M00-T04](../../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), still In progress / unchecked
- **Approved by:** Project owner (user in this conversation)
- **Approval recorded:** 2026-10-23 UTC
- **Recorded by:** Coding agent, not the approver
- **Refines:** [Decision 0002](0002-rounded-icons-and-chart-rendering.md) by selecting the icon family and recording the chart hold; does not replace its visual/accessibility constraints or Decisions 0001/0003
- **Evidence:** [Toolchain/workspace review](../toolchain-review.md), including candidate versions, static icon coverage/notices and unresolved ApexCharts entitlement

## Approval and scope

The owner was asked:

> Approve the T04-A–D directions, while keeping ApexCharts integration on hold pending licensing clarification?

The owner replied:

> yes

This accepts **directions**, not all exact versions in the research matrix, a resolved dependency graph, application implementation or permission to install/scaffold. The approval also confirms the **hold** described by T04-E; it does not authorize supplier outreach, disclosure of business information or a license purchase.

## Accepted directions

| ID | Accepted direction | Remaining boundary |
|---|---|---|
| T04-A | Lean **pnpm workspace** for the JS/TS applications and useful shared packages; separate Flutter SDK pin/application lockfile; no extra monorepo orchestrator by default. Follow the **Node 24 LTS / TypeScript 6** candidate direction | Exact runtime/manager/compiler pins, bootstrap mechanism, support/security checks and full compatibility remain unverified. No global tool changes |
| T04-B | Work toward a current compatible stable Flutter SDK in an **isolated SDK location**. Use **Riverpod, go_router, Dio and Drift** as the mobile supporting-stack directions; do not inherit reference lockfiles | Exact Flutter/Dart pairing, package graph and native behavior remain open. Drift does not select an encrypted SQLite driver, connection helper or key-management solution |
| T04-C | **Next.js App Router / React**, strict TypeScript, semantic **Tailwind** styling, scoped **TanStack Query**, **React Hook Form / Zod**, and owned accessible components | Exact versions, browser baseline, component primitives, testing tools, sessions, provider integrations and generated-client tooling remain separate reviews. No unreviewed starter adoption |
| T04-D | **Hugeicons Free — Stroke Rounded only** as the shared family across Flutter, user web, admin and icon-bearing posters, using first-party Flutter/React packages behind owned semantic adapters and preserving notices | Package pins, complete explicit/implicit glyph coverage, export-notice handling, visual/native accessibility and bundle behavior still require validation. No Pro packs, mixed-family fallbacks or runtime icon CDN. Native/custom Flutter chart direction is unchanged |
| T04-E — hold only | Keep **ApexCharts integration on hold pending licensing clarification**; it remains the selected user-web chart direction | No installation, integration spike, purchase or replacement engine approved. Applicable core/wrapper entitlement and any eventual outreach require explicit resolution/authorization |

The pnpm direction means one JS workspace lockfile and explicit internal dependencies when scaffolding is authorized, without merging deployments, sessions or credentials. Flutter remains independently built and pinned. No Nx, Turborepo, Melos, remote build cache or global SDK manager is introduced by default.

The icon-family decision is not a claim that the 76-name static probe proves every workflow or rendered state. Retain both applicable MIT notices, validate poster/distribution notice handling, and audit implicit widget/component icons. Prohibitions on Material/built-in/starter-default artwork and the OS-owned/provider-mark exceptions in Decision 0002 remain intact.

## Rationale

A lean workspace avoids unnecessary orchestration while preserving independent application boundaries. Named mobile/web directions narrow the compatibility investigation without inheriting four unrelated Flutter dependency graphs. The review found incompatible latest-version combinations, so exact pins must follow evidence rather than automatic upgrades.

Hugeicons Free Stroke Rounded supplies a consistent rounded style, first-party Flutter/React coverage and inspected free-package notices. Selection is bounded to that free style; catalog parity and real rendering still need proof.

ApexCharts' inspected core/wrapper and OEM terms do not establish Your Own's entitlement. Holding integration preserves the owner's chart choice without assuming free eligibility, accepting a cost or weakening accessible interactions to avoid licensing conditions.

## Not approved or verified

- Exact Flutter/Dart, Node, pnpm, TypeScript, NestJS, Next.js, React or supporting-package pins; no candidate matrix row becomes a tested configuration by this approval.
- Dependency installation/resolution, SDK downloads/upgrades, global tooling changes, disposable executable spikes or application scaffolding. Those actions require their scoped authorization and prerequisites.
- Full dependency-license/security clearance, icon source adoption, complete icon coverage, poster/export notice compliance, SSR/hydration or native/platform behavior.
- ApexCharts free/commercial/OEM eligibility, spending, supplier contact, account creation, alternate chart engines or broader admin-chart scope.
- Database/ORM, identity/storage/session providers, encryption/keys, API/sync/numerical contracts, OS/browser targets, hosting, policy or operational choices assigned to later M00 tasks.
- Completion of M00-T04, advancement past its dependencies, M01 go-ahead or any release/deployment.

## Follow-up and authority

Synchronize [architecture](../architecture.md), [design system](../design-system.md), [mobile](../../MOBILE_TECH_SPEC.md), [backend](../../BACKEND_TECH_SPEC.md), [web](../../WEB_PRD.md), [admin](../../ADMIN_CMS_PRD.md), root guidance and milestone status. The [review](../toolchain-review.md) retains dated research and unapproved candidate versions; this record owns the acceptance scope.

**Next eligible work remains M00-T04:** establish the exact Flutter/Dart pair and compatible supported candidate graph, review remaining notices and define any separately authorized compatibility experiment. ApexCharts stays blocked until entitlement is resolved or the owner explicitly changes the requirement. M00-T05/T08/T09 retain their device, encrypted-lifecycle and representative visual checks; M00-T14 still owns the scaffold go/no-go.

## Supersession history

This decision supersedes only pending approval for T04-A–T04-D, the unselected icon-family wording and uncertainty about whether to hold ApexCharts integration. It does not waive unresolved technical/legal gates or supersede the product/release defaults. Future changes to these accepted directions must link a new or superseding owner decision.
