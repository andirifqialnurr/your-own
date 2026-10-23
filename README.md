# Your Own

A mobile-first personal progress app: **Focus, Read, Intake, and Money**, with optional sharing through generated progress cards.

> Track the life you are building. Share the parts you choose. Then get back to living it.

## Current status

**Planning and documentation only.** The repository contains specifications, engineering guides, agent instructions, and an implementation task plan. No application scaffolds, dependency installations, migrations, CI pipelines, or deployments exist yet. Documentation validation is not evidence that application behavior works.

Confirmed frameworks: **Flutter mobile**, **NestJS backend**, and **two separate Next.js applications** for users and staff. Supporting packages, exact versions, database/providers, sessions, and hosting still require the recorded approval gates.

## Start here

1. Read the [product requirements](docs/PRD.md).
2. Read the [system architecture and application maps](docs/cookbook/architecture.md).
3. Follow the [milestone index and task workflow](docs/milestones/README.md).
4. Start with **M00-T01** in [decisions, audits, and approval gates](docs/milestones/00-decisions-and-validation.md).
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

## Product boundaries

- Money is manual tracking/planning only: no bank connections, payments, or real fund movement.
- Private tracker data stays private regardless of account visibility; publishing uses deliberately selected snapshots.
- Social content is progress cards, not arbitrary posts, videos/reels, or an endless ranked feed.
- Support Small, Medium, Large, and Largest usable windows, including resizing and iPad split view.
- System / Light / Dark appearance follows the standalone design system. The retired original style-reference file is not required.
- Staff access is capability-scoped and audited; admin is not a general private-finance or DM browser.

## Delivery approach

Build one verified vertical slice before copying its architecture to other modes. The product progresses through **V1-A personal → V1-B social publishing → V1-C reposts/messaging**. User web progresses through **W0–W3**; admin through **A0 safety → A1 operations**, with **A2 editorial/configuration optional**.

Admin A0 and operational policies must be ready before public social launch. Each application can release independently after its own stage gates; the milestone order is a dependency-aware working plan, not a promise of simultaneous releases or delivery dates.

All implementation tasks currently remain unverified. Use the milestone checklists and evidence logs; do not infer completion from the existence of a specification or folder.
