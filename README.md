# Your Own

A mobile-first personal progress app: **Focus, Read, Intake, and Money**, with optional sharing through generated progress cards.

> Track the life you are building. Share the parts you choose. Then get back to living it.

## Current status

**Planning and documentation only.** The repository contains specifications, engineering guides, agent instructions, and an implementation task plan. No application scaffolds, dependency installations, migrations, CI pipelines, or deployments exist yet. Documentation validation is not evidence that application behavior works.

Confirmed frameworks: **Flutter mobile**, **NestJS backend**, and **two separate Next.js applications** for users and staff. [Decision 0004](docs/cookbook/decisions/0004-toolchain-directions-and-icon-family.md) accepts the pnpm/mobile/web supporting-stack directions and **Hugeicons Free Stroke Rounded** family. ApexCharts remains selected for user-web charts but integration is on hold pending licensing clarification; custom Flutter charts remain permitted where needed. Exact pins, compatibility, distribution notices, database/providers, sessions and hosting retain their validation/approval gates.

## Start here

1. Read the [product requirements](docs/PRD.md).
2. Read the [system architecture and application maps](docs/cookbook/architecture.md).
3. Follow the [milestone index and task workflow](docs/milestones/README.md).
4. Continue **M00-T04 — toolchain and workspace review** in [decisions, audits, and approval gates](docs/milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review). The [candidate review](docs/cookbook/toolchain-review.md) records accepted T04-A–D directions and the confirmed ApexCharts hold; The [compatibility follow-up](docs/cookbook/toolchain-compatibility.md) establishes the published Flutter/Dart pair and withdraws EOL ESLint 9; maintained frontend lint coverage, actual runtime verification, final pins and ApexCharts entitlement remain unresolved.
5. Before making changes, read [AGENT.md](AGENT.md). [AGENTS.md](AGENTS.md) is a compatibility pointer to those same instructions.

No install/run command is provided yet because no application or package scripts exist. The foundation milestone must add tested commands and prerequisites to each application README rather than assuming them now. Android development can run on Windows; iOS/iPad build and native validation require a macOS/Xcode path.

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

apps/                         Planned; not scaffolded
  mobile/                     Flutter Android/iPhone/tablet/iPad app
  api/                        NestJS API and worker roles
  web/                        User Next.js website
  admin/                      Separate Next.js staff CMS
packages/                     Optional, introduced for actual sharing needs
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
| [Reference-app audit](docs/cookbook/reference-app-audit.md) | Completed static inventory and reference-only/rebuild/exclude assessment; not runtime verification |
| [Reference dependency/provenance register](docs/cookbook/reference-app-licenses.md) | Resolved direct notices, lockfile identities, asset exclusions and remaining licensing gates |
| [Toolchain/workspace candidate review](docs/cookbook/toolchain-review.md) | Runtime/library candidates, rounded-icon evidence and ApexCharts licensing blocker; not approved pins |
| [Toolchain compatibility follow-up](docs/cookbook/toolchain-compatibility.md) | Published SDK identity, metadata/support checks and proposed disposable probe awaiting authorization |

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

**M00-T01/M00-T02 are verified owner decisions; M00-T03 is a verified static audit. M00-T04 is in progress: directions are accepted, but exact pins, verification and ApexCharts entitlement remain pending.** All application implementation tasks remain unverified. Use the milestone checklists and evidence logs; do not infer implementation from the existence of a specification, decision or folder.
