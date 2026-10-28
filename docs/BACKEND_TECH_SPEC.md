# Your Own — Backend PRD & NestJS Technical Specification

- **Version:** 0.23
- **Status:** Target specification; local NestJS health scaffold exists, domain/provider services not implemented
- **Confirmed backend framework:** NestJS
- **Clients:** Flutter mobile first; confirmed Next.js user website and separate Next.js admin CMS
- **Product authority:** [PRD.md](PRD.md)
- **Engineering overview:** [System architecture and cross-cutting documents](cookbook/architecture.md)
- **Mobile integration:** [MOBILE_TECH_SPEC.md](MOBILE_TECH_SPEC.md)
- **Web integration:** [User website](WEB_PRD.md) · [Admin CMS](ADMIN_CMS_PRD.md)
- **Accepted directions:** PostgreSQL/Prisma, framework-appropriate non-Supabase auth and Cloudflare R2 private storage under Decisions 0013/0016; app integration not implemented
- **Pending approval/validation:** Exact DB/ORM/SDK pins, auth integration/password policy/session protocol/store, API conventions, queues, hosting/regions/costs, numerical limits and operating policies

> One authoritative backend for personal tracking, privacy-conscious progress sharing, and reliable social interactions. Not a separate backend per mode.

## Contents

- [1. Purpose and requirement language](#1-purpose-and-requirement-language)
- [2. Decision status and architecture rationale](#2-decision-status-and-architecture-rationale)
- [3. Scope and release stages](#3-scope-and-release-stages)
- [4. Recommended backend stack](#4-recommended-backend-stack)
- [5. Runtime architecture and transaction boundaries](#5-runtime-architecture-and-transaction-boundaries)
- [6. NestJS module ownership](#6-nestjs-module-ownership)
- [7. Proposed project structure](#7-proposed-project-structure)
- [8. Shared data model and integrity](#8-shared-data-model-and-integrity)
- [9. Authentication and account lifecycle](#9-authentication-and-account-lifecycle)
- [10. Authorization and visibility](#10-authorization-and-visibility)
- [11. API contract and compatibility](#11-api-contract-and-compatibility)
- [12. Profile and preference requirements](#12-profile-and-preference-requirements)
- [13. Focus service](#13-focus-service)
- [14. Read service](#14-read-service)
- [15. Intake service](#15-intake-service)
- [16. Money service](#16-money-service)
- [17. Progress and dashboard queries](#17-progress-and-dashboard-queries)
- [18. Offline synchronization protocol](#18-offline-synchronization-protocol)
- [19. Progress cards and media](#19-progress-cards-and-media)
- [20. Social graph and feed](#20-social-graph-and-feed)
- [21. Messaging and realtime](#21-messaging-and-realtime)
- [22. Jobs and notifications](#22-jobs-and-notifications)
- [23. Safety and moderation](#23-safety-and-moderation)
- [24. Data export, deletion, and retention](#24-data-export-deletion-and-retention)
- [25. Security and abuse prevention](#25-security-and-abuse-prevention)
- [26. Reliability and performance](#26-reliability-and-performance)
- [27. Deployment and operations](#27-deployment-and-operations)
- [28. Observability and analytics](#28-observability-and-analytics)
- [29. Testing and release acceptance](#29-testing-and-release-acceptance)
- [30. Implementation sequence](#30-implementation-sequence)
- [31. Risks and open decisions](#31-risks-and-open-decisions)
- [32. Backend readiness definition](#32-backend-readiness-definition)

## 1. Purpose and requirement language

This document specifies backend responsibilities, domain behavior, data integrity, client contracts, background processing, and release verification for Your Own.

The product PRD remains the source of truth for scope and user-visible behavior. This document supplies proposed engineering decisions and detailed backend acceptance requirements. It must not silently add products such as payments, investment advice, games, or team project management.

**Language:**
- **Confirmed:** Explicitly selected in product discussion.
- **Must:** Required behavior for the corresponding release stage.
- **Recommended/proposed:** Suggested implementation or default, requiring approval before becoming a fixed commitment.
- **Later:** Outside full V1 unless deliberately promoted through scope review.

Endpoint paths, entities, examples, and limits below form a **draft API design**, not a published stable API. Validate them with Flutter client generation and executable contract tests before implementation is considered ready.

## 2. Decision status and architecture rationale

### 2.1 Confirmed

- Flutter is the mobile framework.
- NestJS is the backend framework.
- Next.js is confirmed for the user website and separate internal admin CMS; both consume the same backend authority.
- The backend supports Focus, Read, Intake, and manual Money tracking.
- The social model includes progress cards, public/private accounts, following, likes, comments, sharing, reposts, and one-to-one DMs in full V1.
- Bank integrations, payments, videos/reels, and unrestricted feed posting are not part of the product.

### 2.2 Recommended defaults

- TypeScript with strict settings, a supported Node.js LTS release, and the standard NestJS Express adapter initially.
- A modular monolith with PostgreSQL and Prisma (direction accepted in Decision 0013, implementation unverified).
- Versioned REST and OpenAPI for Dart and TypeScript clients; no tRPC-only public boundary.
- Maintained, framework-appropriate auth integration with one Nest identity authority, plus private Cloudflare R2 storage (Decision 0016 supersedes Supabase; exact libraries/session/private-public policy remain unvalidated).
- Socket.IO for authorized realtime hints; REST/database records remain durable truth.
- A transactional PostgreSQL outbox, with BullMQ/Redis for asynchronous execution when publishing/jobs require it.
- Containerized persistent API and worker processes rather than relying on request-scoped background execution.

These are not all confirmed simply because NestJS was approved. [Decision 0004](cookbook/decisions/0004-toolchain-directions-and-icon-family.md) accepts lean pnpm with Node 24 LTS/TypeScript 6 candidate direction, not exact versions, the Express adapter or the other backend proposals. Decision 0004 alone does not authorize installation or scaffolding. [Decision 0012](cookbook/decisions/0012-local-development-bootstrap.md) now separately permits the [local bootstrap](cookbook/local-development-bootstrap.md), including the tested Nest 12.2.0 Express adapter with Decision 0010's exact Multer override. Full production pins, provider costs and deployment constraints remain separate.

### 2.3 Why a modular monolith

The product has several domains but one initial development/operations team. Keep transactions and deployment comprehensible. Modules are code boundaries, not microservices.

Separate API and worker processes may run from one backend codebase and share tested domain services. Splitting deployment roles does not require separate databases, duplicated business logic, or network calls between every mode.

Future website code must consume the same domain authority. It must not implement a second financial ledger or a different private-post permission model.

## 3. Scope and release stages

| Stage | Required backend capability |
|---|---|
| **V1-A: Personal foundation** | Identity integration, profile/preferences, four tracking domains, personal summaries, synchronization, export/deletion foundations, tested ownership |
| **V1-B: Social publishing** | Canonical cards/media, public/private profiles, follows, finite chronological feed, likes/comments, authorized links, notifications, blocking/reporting and operator review |
| **V1-C: Social completion** | Reposts, one-to-one conversations/requests, durable messages, realtime recovery, messaging safety |

A release of V1-A alone is a limited release, not the complete social product. Each stage must include appropriate privacy, recovery, and operational support before real users receive it.

### Backend non-goals

- Bank synchronization, storing payment credentials, or moving funds.
- Medical advice, inferred caffeine prescriptions, or consumption competitions.
- Video processing, arbitrary post media, recommendation feeds, or trending systems.
- GPS routes, continuous location, training plans, recipes, or games.
- Kafka, Kubernetes, a service per mode, or a separate search cluster without demonstrated need.
- End-to-end encrypted messaging claims; this requires a separate evaluated design.
- Guaranteed instantaneous recall of data already exported, screenshotted, or delivered to a disconnected device.

## 4. Recommended backend stack

| Concern | Proposed selection | Purpose / constraint |
|---|---|---|
| Runtime | Node 24 LTS / strict TypeScript 6 candidate direction accepted | Exact supported compatible pins still require review; do not infer versions from the developer's installed Node |
| HTTP framework | NestJS, Express adapter initially | Modules, controllers, services, guards, exception filters; framework is confirmed, adapter is proposed |
| Contracts | `@nestjs/swagger`, OpenAPI | Versioned REST documentation and Dart/TypeScript client generation |
| Validation | `class-validator`, `class-transformer`, explicit DTOs | Runtime validation and allowlisted fields; TypeScript types alone do not validate network input |
| Database | PostgreSQL | Relational integrity, atomic transactions, version checks, indexes |
| Database access | Prisma | Typed access and reviewed migrations; use deliberate SQL where Prisma cannot represent required constraints/locking |
| Identity | Non-Supabase, maintained framework-appropriate auth integration; exact libraries/protocol pending | One Nest identity/application authority; no separate client password databases or automatic secure framework default |
| Object storage | Cloudflare R2 behind a server-owned storage interface | Private bucket for restricted files, separate public bucket only for deliberately public assets; no client credentials |
| Realtime | `@nestjs/websockets`, Socket.IO | Authenticated user/conversation events; not durable message storage |
| Background jobs | `@nestjs/bullmq`, BullMQ, Redis | Retried rendering, push, exports, cleanup; introduced when needed |
| Commit-to-job reliability | PostgreSQL transactional outbox | Avoid losing work between database commit and queue insertion |
| Push | Firebase Admin SDK | FCM delivery, including configured APNs routing for iOS |
| Poster rendering | Evaluated SVG/layout-to-image stack, candidate Satori + resvg | Deterministic curated templates; no AI and no arbitrary user HTML |
| Logs/metrics | Structured redacted logging, OpenTelemetry-compatible instrumentation where useful | Correlation, latency, failures, queue/sync lag; no sensitive request bodies |
| Tests | Jest, Supertest, real PostgreSQL/Redis integration fixtures, Testcontainers where suitable | Domain, API, transaction, concurrency, and recovery tests |
| Operations | Docker, managed database/storage, CI/CD | Persistent services with explicit lifecycle, health, migrations, backups |

### Selection rules

The [2026-10-26 M00-T06 review](cookbook/provider-baseline-review.md) prepares the PostgreSQL/Prisma and Supabase Auth/private Storage directions for owner decision. It records broad quickstart-role, direct-data exposure, JWT/logout, server-only BFF, SMTP and object-backup limitations. Decision 0013 accepted that historical subset; [Decision 0016](cookbook/decisions/0016-framework-auth-and-r2-storage.md) subsequently withdraws Supabase Auth/Storage in favor of framework-appropriate auth and R2 while retaining PostgreSQL/Prisma and separate server-side web/admin sessions. The [read-only R2/CDN probe](cookbook/r2-connection-check.md) verifies signed metadata access, not private/public file policy or full integration. Exact dependency pins, physical DB/session-store hosting, protocols and operational choices remain pending; no resource or integration is created by acceptance.

- Commit lockfiles and runtime pins only after compatibility review, explicit final-pin approval and scaffold authorization, not speculative version numbers in this document.
- [Decision 0010](cookbook/decisions/0010-conditional-dependency-exceptions.md) permits conditional eligibility of only `@nestjs/platform-express@12.2.0>multer: 2.5.0` for a later approved baseline, with owner/30-day review, fresh graph/security/notice checks, regressions and safe removal. It does not select a production adapter/version, approve installation or waive real Nest upload integration/limit tests; prefer a separately reviewed upstream-fixed adapter when available.
- Confirm Prisma/managed PostgreSQL pooling and migration compatibility against the actual provider.
- NestJS dependency injection does not replace database constraints or durable jobs.
- PostgreSQL is authoritative for application state. Redis is not the only copy of messages, finance records, or accepted jobs.
- No storage SDK, data API or browser session library may expose a second unrestricted path to application records. Keep database/storage privileges least-privileged; never rely on hidden client code.
- If JWT is selected, verification requires approved real issuer/audience/algorithms/key rotation and current-session semantics. A framework auth recipe does not establish these policies.

## 5. Runtime architecture and transaction boundaries

### 5.1 Proposed topology

```text
Flutter mobile             Next.js web / Next.js admin
      |                                  |
      +---------- HTTPS REST ------------+
                         |
                  NestJS API process
            validation / identity / policy
                         |
                Domain application services
                  |                  |
             PostgreSQL         Private storage
                  |
         Domain rows + transactional outbox
                  |
          Outbox dispatcher / job queue
                  |
              NestJS worker
       rendering / push / export / cleanup

Socket.IO: authenticated live hints, followed by authorized reads
Identity provider: supplies identities; does not decide post access
```

### 5.2 Request pipeline

1. Apply request-size, transport, and abuse protections.
2. Establish a correlation ID and route context.
3. Verify identity where required and resolve the active application user.
4. Validate the allowlisted DTO and its typed field rules.
5. Execute the domain transaction with current ownership/policy checks, revision protection, and idempotency; recheck race-sensitive permissions under the relevant locks.
6. Serialize only allowlisted response fields after successful commit.
7. Deliver downstream effects through committed outbox records.

Request cancellation or an HTTP timeout does not prove a transaction was not committed. Clients must be able to retry safely.

### 5.3 Transaction rules

- Domain mutation, revision update, personal change-log entry, idempotency receipt, and required outbox entries must commit together where they belong to the same operation.
- Do not make push, image rendering, provider HTTP calls, or Redis delivery part of an open database transaction.
- Use bounded transactions and a documented lock order; retry safe serialization/deadlock failures without changing operation identity.
- Database outages must not return fake successful saves.
- Queue outages may leave durable pending work if the endpoint contract supports that state; they must not lose a committed request.

## 6. NestJS module ownership

| Module | Owns | Must not do |
|---|---|---|
| Identity | Nest-owned maintained identity integration ports, active-user/credential/session context; external-subject mapping only if an external issuer is later adopted | Implement bespoke password/reset crypto, create parallel client password authorities, or leak private SDK/store details across modules |
| Users | Profile, preferences, lifecycle, visibility epochs | Expose raw trackers through public profiles |
| Staff access | Staff grants/scopes, trusted assurance, operator session context | Promote an ordinary user based on a browser-controlled role/MFA flag |
| Authorization | Reusable policy evaluation and viewer projections | Treat a client flag/role as authoritative |
| Focus | Tasks, labels, sessions, active-session coordination | Create a full project-management platform |
| Read | Books, progress history, completion, goals | Depend on an external catalog for basic operation |
| Intake | Water/coffee records and target history | Combine cups/shots/water into a health score |
| Money | Accounts, ledger aggregates, budgets, savings planning | Connect to banks or conflate savings with new assets |
| Progress | Personal summaries, contribution projections | Read another user's raw records for a public heatmap |
| Sync | Typed command dispatch, personal cursors/tombstones, receipts | Offer arbitrary table names/field updates from clients |
| Cards | Draft validation, allowlisted snapshots, render lifecycle | Publish unreviewed data automatically |
| Media | Storage metadata, upload grants, authorized delivery | Make private buckets publicly readable |
| Social | Follows/requests, likes/comments, feed, repost eligibility | Grant access just because an item exists in a feed cache |
| Messaging | Conversations/requests, messages, unread state | Assume socket membership proves permanent authorization |
| Notifications | Device tokens, preferences, inbox events, delivery decisions | Reveal sensitive values in push previews |
| Jobs | Outbox dispatch, queue adapters, retries, job state | Become the only durable store of accepted work |
| Audit | Minimal operator/security audit records, scoped audit queries | Copy unrestricted evidence or private payloads into ordinary logs |
| Moderation | Reports, restricted review, actions, appeals records | Give every staff account access to all private data |
| Data lifecycle | Export/deletion jobs, retention coordination | Promise external copies can be recalled |

Controllers/gateways remain thin. Modules expose application services/contracts rather than importing one another's private repositories freely. Avoid circular dependencies resolved only by widespread `forwardRef` usage.

## 7. Proposed project structure

### 7.1 Application map

The initial [API scaffold](../apps/api/README.md) now exists at `apps/api/` with local development pins. The [module](../apps/api/docs/MODULE_INDEX.md), [endpoint](../apps/api/docs/ENDPOINT_MAP.md), [job](../apps/api/docs/JOB_MAP.md) and [traceability](../apps/api/docs/TRACEABILITY.md) indexes now navigate current files/evidence. The larger module/provider structure below remains proposed, not implemented. Create modules with their release slices rather than generating every empty folder. See the [cross-application file map](cookbook/architecture.md#51-application-and-shared-package-ownership) for web/admin ownership.

```text
apps/api/
  README.md                            # Setup, entry points, navigation links
  package.json
  nest-cli.json
  tsconfig.json
  .env.example                         # Names/placeholders only; no real secrets
  Dockerfile
  docs/
    MODULE_INDEX.md                    # Module ownership and public contracts
    ENDPOINT_MAP.md                    # Method/path -> controller -> handler
    JOB_MAP.md                         # Job/event -> producer -> processor
    TRACEABILITY.md                    # Requirement -> code -> test -> evidence
    decisions/                         # Backend-specific ADRs
  src/
    main.ts                            # HTTP/realtime process bootstrap
    app.module.ts                      # HTTP/realtime composition root
    worker.ts                          # Worker process bootstrap
    worker.module.ts                   # Worker composition, no HTTP listener
    config/
      environment.schema.ts
      app.config.ts
    common/
      errors/
      serialization/
      observability/
      validation/
      transactions/                    # Shared transaction contracts, not domain rules
    infrastructure/
      database/
        database.module.ts
        prisma.service.ts
        transaction-runner.ts
      identity/                        # Selected maintained identity SDK/store transport
      storage/                         # Private-object storage adapter
      queue/                           # Redis/BullMQ transport, if adopted
      push/                            # FCM/APNs delivery integration
      time/
    modules/
      identity/                        # Application identity/context, not provider SDK
      users/                           # Profiles, preferences, visibility/lifecycle
      staff-access/                    # Current grants and trusted assurance
      authorization/                   # Shared access-policy contracts/evaluation
      focus/
      read/
      intake/
      money/
      progress/                        # Today/progress composition and projections
      sync/
      cards/
      media/
      social/
      messaging/
      notifications/
      jobs/                            # Durable jobs/outbox dispatch and retry policy
      audit/
      moderation/                      # Reports, scoped evidence, actions, appeals
      data-lifecycle/                  # Export, deletion, retention coordination
    health/                            # Process readiness/liveness, safe responses
  prisma/
    schema.prisma                      # One canonical application schema
    migrations/                        # Reviewed SQL and migration history
    seed.ts                            # Synthetic local/test data only
  openapi/
    user.openapi.json                  # Generated user-facing contract projection
    operator.openapi.json              # Generated operator contract projection
  test/
    modules/                           # Mirrors src/modules for isolated tests
    common/
    infrastructure/
    integration/                       # Real database/provider-adapter integration
    contracts/
    concurrency/
    e2e/
    fixtures/                          # Synthetic users, grants, records
    support/
  scripts/                             # Repeatable contract/migration/check tooling
```

Only add a separate dispatcher entry point if deployment needs it; otherwise an explicitly enabled worker role runs dispatch. Do not accidentally start consumers/dispatchers in every API process. Both process roles reuse application modules, with transport modules composed separately. Decision 0004 accepts lean pnpm as the workspace direction; its exact bootstrap/version and runtime pins remain validation/approval gates. Use the chosen workspace lockfile rather than accidental competing JS lockfiles.

### 7.2 Module layout — Money example

```text
src/modules/money/
  README.md                            # Scope, contracts, data ownership, tests
  index.ts                             # Deliberate exported contracts only
  money.module.ts                       # Application/repository dependency wiring
  money.http.module.ts                  # Imports MoneyModule; binds HTTP controllers
  domain/
    entities/
      account.ts
      transaction.ts
      savings-goal.ts
    value-objects/
      money-amount.ts
    rules/
      transfer.rules.ts
    repositories/
      money.repository.ts              # Interface, not Prisma implementation
  application/
    commands/
      create-transaction.handler.ts    # Shared REST/sync mutation handler
    queries/
      get-money-summary.handler.ts
    ports/
      money-summary-reader.ts          # Narrow query contract for other modules
  transport/
    http/
      money-transactions.controller.ts
      money-summary.controller.ts
      dto/
        create-transaction.request.ts
        transaction.response.ts
    sync/
      money-command.adapter.ts         # Typed sync envelope -> same application handler
  infrastructure/
    persistence/
      prisma-money.repository.ts
      money.mapper.ts
```

Add accounts/plans/savings handlers and DTOs as their slices ship. A small query-only module need not receive empty entity/command directories. Use-case/handler classes are for meaningful operations, not one-line wrappers required by ceremony.

| Layer | Owns | Must not own |
|---|---|---|
| `transport/` | REST DTOs/controllers, sync-envelope adapters, gateways where applicable | Ledger calculations, direct database writes, trusting client ownership |
| `application/` | Operation orchestration, transactional authorization, idempotency/revisions, domain coordination | HTTP responses, React/Dart UI, external network work inside a DB transaction |
| `domain/` | Pure entities/value objects, invariants, repository contracts | Nest/Prisma/Dio/provider DTO dependencies |
| Module `infrastructure/` | Owned repository/mappers, feature-specific external adapters | Another module's private tables through an unrestricted shortcut |
| Root `infrastructure/` | Shared database connection/transaction runner and provider transports | Feature-specific permission or financial decisions |
| Module/composition files | Dependency injection and explicit exports | Becoming giant business-service files |

Guards verify request context through identity/staff-access services; race-sensitive ownership, audience, block, and staff checks still happen within the operation's proper transaction/coordination boundary. Public exports are narrow application/query contracts; a barrel is not permission to export all private repositories.

### 7.3 Persistence, jobs, and contracts

- `prisma/schema.prisma` and `prisma/migrations/` are the single domain-schema/migration authority. Feature table ownership is recorded in `MODULE_INDEX.md`; Next.js has no copy of this migration tree. If Prisma is not selected, replace this adapter-specific directory explicitly.
- Keep generated Prisma code in the output convention selected at bootstrap and never edit it by hand. Transport responses are allowlisted DTOs, not raw generated database models.
- Transaction ports/opaque unit-of-work context must allow domain changes, revisions, receipts, owner change-stream entries, outbox records, and required audit writes to share the same atomic transaction. Merely placing them in separate repositories does not establish atomicity.
- `modules/jobs/` owns outbox dispatch, durable job state and eligible retry orchestration; `infrastructure/queue/` owns queue transport. Domain-specific processors live with their owners, for example `modules/cards/jobs/render-card.processor.ts`, `modules/notifications/jobs/send-push.processor.ts`, and `modules/data-lifecycle/jobs/export-user.processor.ts`.
- `worker.module.ts` registers the selected processors and application modules, not the HTTP transport modules. Workers recheck current eligibility and do not implement a second publication/permission model.
- `modules/audit/` owns minimal audit append/query contracts; `modules/moderation/` owns restricted report evidence. An audit reader does not automatically gain access to the evidence payload.
- User and operator OpenAPI artifacts are generated projections of one NestJS contract source, not separately hand-maintained APIs. Preserve stable operation IDs and scope-specific generation/checks. Generated TypeScript clients have separate user/operator entry points; Flutter receives only its approved contract projection.
- Optional editorial/configuration modules are added only after A2 approval; do not scaffold a generic CMS/SQL/template-code editor as part of the initial backend.

### 7.4 Endpoint-to-file map

Paths and filenames below are proposed and inherit the draft API status in section 11. A public URL is not determined by the filesystem in NestJS; decorators/module registration and generated OpenAPI define the actual method/path.

| Method / path | Owning module | Transport file relative to that module | Main responsibility |
|---|---|---|---|
| `POST /v1/money/transactions` | `money/` | `transport/http/money-transactions.controller.ts` | Validate DTO, invoke `application/commands/create-transaction.handler.ts` |
| `GET /v1/money/summary` | `money/` | `transport/http/money-summary.controller.ts` | Own summary query/projection |
| `POST /v1/sync/commands` | `sync/` | `transport/http/sync.controller.ts` | Typed dispatch to mode-owned adapters/handlers, not arbitrary table writes |
| `GET /v1/operator/session` | `staff-access/` | `transport/http/operator-session.controller.ts` | Current grants and trusted assurance context |
| `GET /v1/operator/users/:id` | `users/` | `transport/http/operator-users.controller.ts` | Minimal authorized account projection |
| `GET /v1/operator/reports/:id` | `moderation/` | `transport/http/operator-reports.controller.ts` | Scoped evidence read with access audit |
| `POST /v1/operator/moderation-actions` | `moderation/` | `transport/http/operator-moderation-actions.controller.ts` | Permission/revision-safe decision plus audit |
| `POST /v1/operator/jobs/:id/retries` | `jobs/` | `transport/http/operator-jobs.controller.ts` | Eligible retry, not arbitrary domain replay |
| `GET /v1/operator/audit` | `audit/` | `transport/http/operator-audit.controller.ts` | Scoped safe audit metadata |

No catch-all operator controller should bypass module ownership or return raw Prisma records. Every operator transport requires independently verified staff grants/assurance in NestJS.

### 7.5 Navigation, tests, and change tracking

- Start at `apps/api/README.md`, then `docs/MODULE_INDEX.md` and `docs/ENDPOINT_MAP.md`. Each module README links its transports, public contracts, schema ownership, and tests.
- Example isolated tests: `test/modules/money/domain/transfer.rules.spec.ts` and `test/modules/money/application/create-transaction.handler.spec.ts`.
- Real persistence/concurrency tests live in `test/integration/` and `test/concurrency/`; HTTP journeys in `test/e2e/`. Domain tests do not need to boot NestJS; mocks cannot prove database isolation.
- `docs/JOB_MAP.md` records event/job name, producer, processor, idempotency identity, retry eligibility, and evidence. Do not put secrets or real payload samples in these indexes.
- `docs/TRACEABILITY.md` links existing product/BE/SEC requirement IDs to implementation files, automated/manual evidence, and release stage. Planned, In progress, Implemented, and Verified are distinct; Verified requires evidence.
- These local indexes navigate the root specifications; they are not another copy of requirements or generated contract schemas. Update them in the same change as a route/module/job move.

Separate packages/services only when there is a concrete ownership, reuse, or runtime reason.

## 8. Shared data model and integrity

### 8.1 Common conventions

- UUID entity IDs, including permitted client-generated IDs for offline records.
- Owner/actor references derive from authenticated context, not trusted payload ownership.
- Integer entity revisions for optimistic concurrency; enforce a documented safe serialization range.
- Server-controlled creation/update ordering; client occurrence times are separate self-reported fields.
- UTC instants using appropriate PostgreSQL timestamp types, local activity dates, and IANA timezone context where required.
- Logical deletion/tombstones for synchronized entities, with explicit later purge rules.
- Foreign keys and uniqueness/check constraints for important invariants.
- Amounts use exact integer minor units, not JavaScript floating-point ledger arithmetic.

PostgreSQL BIGINT values exposed to clients must serialize as decimal strings or opaque cursors, not unsafe JSON numbers. Money conversion/formatting uses currency metadata; do not assume two decimals for every currency.

Validate IANA timezone identifiers and instant/local-date consistency for timestamped events. Explicit date-only manual records need distinct semantics rather than a fabricated midnight instant. Day boundaries must handle daylight-saving transitions, not assume every local day contains exactly 24 hours.

### 8.2 Proposed entity inventory

This is a design inventory, not a final Prisma schema:

| Domain | Entities / important constraints |
|---|---|
| Identity/users | Users, external identities unique by issuer+subject, preferences, lifecycle status, visibility generations |
| Focus | Tasks, labels, session segments, sessions, one authoritative active-session slot per user |
| Read | Books, progress entries, reading goals, completion state; updates serialized/versioned per book |
| Intake | Water entries, coffee entries, effective-dated targets |
| Money | Accounts, categories, transaction headers/postings, monthly plans/allocations, savings goals/entries, plan-review events |
| Progress | Daily projections, projection invalidations/rebuild state |
| Sync | Per-owner stream state, change records, tombstones, operation receipts, bootstrap snapshots |
| Cards/media | Card drafts, source references, immutable/versioned snapshots, posts, media metadata/render jobs |
| Social | Follows/requests unique per directed user pair, blocks, likes, comments/replies, repost references |
| Messaging | Unique normalized user pair, participants/requests, messages, per-conversation sequence, per-user hidden/read state |
| Operations | Outbox events, job records, notification events/deliveries, push installations/tokens |
| Safety/lifecycle | Reports/evidence, moderation actions/audit, exports, deletion requests, retention exceptions |

### 8.3 Important uniqueness and ownership constraints

- Case-normalized usernames unique under an approved normalization policy.
- No self-follow, self-block, self-transfer, or self-DM where disallowed by the relevant domain.
- One active follow/request representation per directed pair.
- One like and one active repost per user/source post as applicable.
- One finance plan per owner/month.
- One accepted effect per authenticated operation ID within its defined scope.
- One message per sender/client-message ID, with payload mismatch rejected.
- Referenced accounts/categories/books/goals must belong to the same owner as the operation.

Some partial unique indexes, check constraints, and locking queries require reviewed SQL migrations beyond Prisma's schema syntax. Do not assume the ORM expresses every invariant automatically.

## 9. Authentication and account lifecycle

### 9.1 Identity integration

Decision 0016 withdraws the managed-Supabase assumption. NestJS remains the identity/application authority, using reviewed maintained auth/session/password/MFA integrations rather than the disposable test harness. Exact libraries, token/session/hash protocols, email verification/recovery delivery and operational ownership require review before implementation. Neither NestJS nor the client frameworks enable a complete secure auth service automatically. The [framework-auth review](cookbook/framework-auth-review.md) now recommends evaluating first-party `@nestjs/authentication` 0.1.1 ahead of Better Auth, not adopting it: declared peers/static interfaces fit the direction and the subsequent [authorized real-package memory/loopback phase](cookbook/local-nest-authentication-spike.md) passes 55 Node test entries twice. The subsequent [authorized external Prisma-store phase](cookbook/prisma-auth-store-spike.md) passes 24 published contracts plus five owned DB checks twice, with real barriers/restart/rollback/roles and teardown. The separately authorized [external HTTP composition](cookbook/durable-auth-http-spike.md) now passes 30 entries twice and six expected-red controls with real TOTP completion/step-up, durable session assurance metadata and owned teardown. User/password/lifecycle/grant/mail fixtures are still in memory; already-issued access JWTs survive refresh revoke/password reset until expiry. Its early API, combined product graph, durable account transactions/current-session revocation, complete staff operations and browser/native/BFF policies still require decisions/evidence; no product auth implementation follows.

If JWT is selected, verify its signature, approved algorithm, issuer, audience, expiry and applicable temporal claims against fixed trusted configuration; reject request-supplied keys/issuers and support reviewed rotation/cache behavior. Opaque-session alternatives require equivalent current-session verification.

Bind authentication to a stable internal user identity, never mutable email alone. If an external issuer is later explicitly adopted, map issuer+subject. Email changes or future account linking must not attach another person's tracking records.

### 9.2 Application lifecycle checks

Resolve an application user with status such as Active, Suspended, Deleting, or Deleted. A cryptographically valid token must not bypass an application suspension/deletion state.

Bootstrap must be idempotent and must not recreate a deleted account from an old still-valid token. Retain a minimal lifecycle marker or equivalent provider-aware safeguard under the approved retention policy.

Proposed endpoints:

| Method/path | Purpose |
|---|---|
| `POST /v1/me/bootstrap` | Idempotently resolve/create the application profile after authentication |
| `GET /v1/me` | Own profile and onboarding state |
| `PATCH /v1/me` | Allowlisted own profile changes |
| `GET/PATCH /v1/me/preferences` | Own preferences/units/timezone/mode settings |
| `POST /v1/me/exports` | Reauthenticated personal export request |
| `POST /v1/me/deletion-requests` | Reauthenticated account-deletion request |

Login/recovery routes depend on the reviewed non-Supabase auth integration and protocol; do not implement parallel client password systems or hand-rolled password/reset cryptography simply because NestJS has an Auth module.

### 9.3 Sessions and operator access

[Decision 0015](cookbook/decisions/0015-auth-methods-and-local-protocol-spike.md) accepts initial email/password + verified-email recovery and required staff TOTP as directions. The [synthetic protocol experiment](cookbook/authentication-session-spike.md) passes local invariant checks, not real auth/session/MFA evidence; Decision 0016 subsequently changes the provider direction without validating a replacement implementation. Exact timeout/algorithm/CSRF/revocation/staff-context/store implementation and provider integration remain gates; no application auth endpoint exists. The [review](cookbook/authentication-session-review.md) retains the original proposal/evidence matrix.

- Document token refresh and logout/all-session revocation behavior using the actual approved auth/session model.
- JWT expiry alone is not an immediate per-device revocation design. Resolve this before making such a promise. The [account-transaction/access-invalidation review](cookbook/authentication-transaction-review.md), scoped by [Decision 0021](cookbook/decisions/0021-auth-transaction-design-review.md), proposes a monotonic credential generation plus live revocable grants and one typed unit of work. It explicitly retains opaque access as an alternative and the real library's hashing/event/independent-store transaction blockers. No model/claims/schema is adopted or runtime-proved by this static review. The later [Decision 0022 prototype](cookbook/account-transaction-prototype.md) supplies selected real service/process/SQL evidence: durable synthetic users/grants, typed shared transactions, reset rollback and deferred COMMIT rejection, intended-denial commits and live access invalidation. It does not adopt the disposable coordinator into the app or establish full HTTP/BFF/platform/operational/key-custody/restore acceptance. The [Decision 0023 adoption packet](cookbook/authentication-app-adoption.md) recommends an uncomposed dependency-free identity-contract slice (S0), pending explicit owner scope/order exception. No package/model/route adoption follows; provider/guard integration, idle-cookie store ownership, verified-email projection and the actual combined graph remain gates. The owner subsequently authorized [Decision 0024's S0-only/order exception](cookbook/decisions/0024-local-identity-contract-s0.md): [internal actor/authority contracts and pure access policies](../apps/api/src/modules/identity/README.md) now exist, uncomposed and dependency-free. `IdentityAuthority` is an interface with no implementation; local allowed/denied/unavailable policy verdicts do not verify credentials, current state or trusted provenance. Full M02-T02/T07 remain open.
- Keep mobile credential storage concerns in the mobile spec; server credentials belong only in managed secrets.
- Operator authentication requires MFA, restricted roles/scopes, trusted assurance and fresh step-up where required, and audited actions before public social operations.

The [post-install readiness review](cookbook/auth-integration-readiness.md), scoped by [Decision 0028](cookbook/decisions/0028-auth-integration-readiness-review.md), retains application adoption on hold. Actual frozen dependency selection is not durable guarded-HTTP proof. Static comparison finds the prototype's mandatory refresh grant claims/refusal of late revoked-family inserts incompatible with published optional-claims/tombstone contract cases; resolve this boundary without modifying vendor contracts or hiding failures. Verified-email/capability projection and cookie transaction ownership remain gaps. Proposed I1 external acceptance is Not run/unapproved here; no schema/protocol/provider or M02 scope is adopted.

The later [Decision 0029 I1-only authorization](cookbook/decisions/0029-local-auth-integration-i1.md) now has [I1-A adapter/generation proof](cookbook/auth-integration-adapter-i1-a.md): 24 unchanged published contracts plus 11 owned cases pass twice, with four expected-red controls and generated-client queries in the clean production tree. The new generic persistence accepts absent/arbitrary claims and late successors without clearing revocation tombstones; server-owned account/grant transaction bindings are separate. Initial MFA insert/count concurrency failures are retained and corrected with per-user SQL serialization. This is not credential issuance/current-principal proof: actual durable registered-provider/guarded HTTP, projection, cookie ownership and COMMIT response/denial behavior remain I1-B, not run. No application code/dependency/schema/protocol or full M02 adoption follows.

### 9.4 Next.js browser and staff integration

The proposed Next.js session/BFF model holds provider credentials server-side and uses separate host-only browser session scopes for user web and admin. The BFF forwards authorized actor credentials to NestJS; it is not a broad service-role bypass.

NestJS must independently verify active staff grants and required MFA/freshness using trusted provider/session evidence. A normal user token or browser-controlled `x-admin`/`x-mfa` header is insufficient. Approve the provider-specific proof/session protocol before enabling operator access.

For browser realtime without exposing long-lived provider tokens, a proposed endpoint issues short-lived, audience-scoped connection tickets after normal authentication. Tickets are limited to allowed realtime identity/scopes, have a reviewed expiry/replay policy, and must not authenticate ordinary REST or grant staff powers. Do not place them in URLs/logs. A secure compatible proxy arrangement is an alternative requiring explicit review.

See the web/admin PRDs for browser session, CSRF, caching, and capability workflows. These integration requirements do not select an identity provider or create a new password system.

## 10. Authorization and visibility

### 10.1 Central policy functions

Provide explicit, testable policies such as `canReadPost`, `canInteractWithPost`, `canRepost`, `canSendMessage`, and `canReviewReport`.

Every entry point—REST, worker, gateway, media, notification, link preview, and operator action—must use the relevant policy. A route guard checking only "logged in" is insufficient.

Default deny. Owner queries include owner scope. Return a uniform unavailable response for nonexistent versus unauthorized private resources where distinction would leak existence.

### 10.2 Viewer rules

| Resource | Owner | Approved follower | Other signed-in user | Anonymous |
|---|---|---|---|---|
| Raw tracking/finance records | Allowed | Denied | Denied | Denied |
| Public post on public active account | Allowed | Allowed unless blocked | Allowed unless blocked | Only if anonymous public rendering is approved |
| Followers-only/private-account post | Allowed | Allowed unless blocked | Denied | Denied |
| Minimal discoverable profile | Allowed | Allowed | Allowed unless restricted/blocked | Subject to public-link policy |
| Conversation history | Participant rules | Follow alone grants nothing | Participant rules only | Denied |
| Report evidence | Own submitted view as allowed | Denied | Denied | Denied; restricted reviewer role separately |

Blocking must affect both directions of contact/discovery inside the app. Anonymous public access cannot guarantee that a blocked person never sees already public information outside their signed-in account; do not promise impossible identity enforcement.

### 10.3 Effective audience

A post's readable audience is constrained by all of:
- Current author/account status and account visibility.
- Persisted post audience and publication generation.
- Current approved-follow state where needed.
- Blocking and moderation state.
- Source/repost eligibility where relevant.

Switching public → private must restrict reads synchronously, not after a cache-cleanup job. Historical posts must remain followers-only when the account later becomes public unless the author deliberately widens them.

A proposed implementation uses account publication generations plus per-post audience/generation, or an equivalent transactional downgrade scheme. Validate the exact schema; asynchronous backfilling alone must never create a temporary disclosure window.

### 10.4 Revocation and races

- Authorization is evaluated from authoritative current state at the operation's defined transaction/read point.
- Visibility changes, follower removal, blocks, suspension, and deletion invalidate relevant derived access state.
- Cache deletion is not the only privacy control: check the current policy before serving cached data.
- For interacting users, serialize conflicting block/contact writes through a canonical pair-lock strategy or equivalent tested isolation. A new send/follow must not commit after a previously committed block without noticing it.
- In-flight responses and already exported copies cannot be recalled. Document the boundary honestly.

## 11. API contract and compatibility

### 11.1 Transport conventions

Recommended public boundary: `/v1` REST with OpenAPI. Maintain schemas suitable for generated Dart and TypeScript clients. tRPC is not required for the Flutter client.

- Explicit request/response DTOs; never serialize raw Prisma objects wholesale.
- Strict validation of unknown fields, string lengths, enum values, IDs, numbers, dates, and nested arrays.
- Typed command variants rather than arbitrary table/field mutation payloads.
- Money amounts and large sequences use documented decimal strings.
- Pagination uses opaque cursor tokens with validated scope/query binding.
- UTC instants use an unambiguous format; local dates are distinct date-only fields.
- Owner/actor fields in trusted context cannot be overridden by the client.

### 11.2 Mutation identity and revision

Use a stable operation ID via an approved header/envelope, and `expectedVersion` for mutable aggregates. REST calls and sync commands dispatch into the same application handlers and semantics.

Receipts are unique by authenticated actor and operation scope. Store the normalized payload digest and minimal safe result metadata. Reusing a key for a different operation/payload returns a conflict; a corrected operation receives a new ID.

Authenticate and apply current access policy on replay. An old idempotent response must not become a way to replay private data after revocation. Prefer minimal IDs/revisions/status receipts over snapshots containing sensitive values.

A proposed owner-scoped `GET /v1/me/operations/:operationId` supports browser recovery from unknown mutation outcomes. Return only currently authorized receipt/status metadata under the approved operation scope. A missing receipt does not prove an in-flight original request cannot still commit; recovery must preserve safe retry identity rather than immediately creating another operation.

### 11.3 Responses and errors

| Status | Intended use |
|---|---|
| 200/201 | Accepted synchronous query/mutation/create result |
| 202 | Accepted asynchronous work with an authorized job/status reference |
| 204 | Idempotent removal/no-content operations where no revision payload is needed |
| 400 | Invalid envelope/query syntax or malformed DTO |
| 401 | Missing/invalid/expired authentication |
| 403 | Known policy restriction where disclosure is appropriate |
| 404 | Missing or inaccessible protected resource |
| 409 | Revision conflict, operation-key reuse, conflicting active state |
| 413/422 | Oversized payload / valid shape with invalid domain values, according to final contract |
| 429 | Rate limit with retry guidance |
| 503 | Required dependency unavailable; do not imply a successful save |

Example safe error:

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

Do not attach raw SQL, stack traces, hidden record titles, or financial values to public error details.

### 11.4 Draft operational limits

Proposed starting limits, to validate and configure centrally:
- Sync batch: up to 50 commands, with bounded payload size.
- Ordinary list page: default 20, maximum 100.
- Message text: up to 4,000 characters; card messages use a typed reference instead.
- Post caption/comment/profile limits: explicit per-field policy approved before implementation.
- Avatar upload: up to 5 MiB, decoded-pixel cap, approved raster formats only.

Numeric rate/retention limits are not yet production promises. Treat oversized/decompression workloads separately from encoded byte size.

### 11.5 Mobile compatibility

Old mobile versions remain in use after a server deployment. Prefer additive compatible changes, preserve semantics within `/v1`, and test generated clients. Do not rename enums/remove fields in place without a migration strategy.

Publish approved schemas as CI artifacts. Contract examples must be executable fixtures, not documentation that drifts separately from server validation.

## 12. Profile and preference requirements

Implement the product defaults accepted in [Decision 0003](cookbook/decisions/0003-product-defaults.md): account-required V1 without guest migration, private signup default, followers-only new publication drafts with explicit public selection, and mL/US-fluid-ounce preferences. Raw records remain owner-only. English-first pilot scope does not select a country/timezone/currency; auth/provider and exact numerical contracts remain pending.

- Enforce approved username normalization/uniqueness and safe display-name/bio lengths.
- Store account visibility separately from private tracking data.
- Keep units, mode visibility, timezone, language, notification settings, DM permission, and amount-hiding preferences user-scoped.
- Effective-dated goals/targets preserve historical attainment.
- Changing timezone must not rewrite stored historical activity dates.
- Reject base-currency changes after monetary records exist; never relabel history or supply a destructive reset workaround. V1 has no FX conversion; supported currency metadata remains a contract gate.
- Do not expose complete personal progress, bookshelf, balances, or task lists through a profile DTO.
- People search returns minimal permitted fields and enforces blocking, suspension, and rate limits.

| Method/path | Purpose |
|---|---|
| `GET /v1/users/search` | Limited username/display-name search |
| `GET /v1/users/:userId/profile` | Viewer-authorized profile projection |
| `GET /v1/users/:userId/posts` | Paginated authorized published posts |
| `PUT /v1/me/account-visibility` | Explicit visibility change with current revision |

## 13. Focus service

### 13.1 Tasks and labels

- CRUD for title, optional note, due date, label, Today placement, and completion state.
- Today placement is independent of due date.
- Completion/reopening is revision-aware and updates projections without duplicate achievements.
- Deleting a task preserves valid session durations; linked history has an appropriate missing-task state.
- Task titles/notes stay private unless explicitly selected for a card.

### 13.2 Sessions

- Store actual focus intervals/pause information, planned duration, task/label links, status, and occurrence context.
- Exclude breaks and pauses from focus time.
- Validate nonnegative/bounded durations and valid transition ordering; user timing remains self-reported.
- Finalize once, idempotently. Discarded sessions do not become completed focus time.
- Support one authoritative online active-session slot per user using a transaction/constraint, not an unlocked read-then-insert.
- Define recovery for expired/abandoned slots so an interrupted app cannot block future sessions indefinitely. Recover against persisted timing state; do not fabricate completed count-up time or silently discard an offline session through a generic lock TTL.
- Offline sessions may conflict. Retain a resolvable conflict representation and exclude overlapping disputed time from double-counted summaries until resolved.
- The server does not tick every second or send a push every second. Mobile reconstructs its timer locally.
- Split accepted focused duration across relevant local days; session count belongs to completion day.

| Method/path | Purpose |
|---|---|
| `GET/POST /v1/focus/tasks` | List/create tasks |
| `GET/PATCH/DELETE /v1/focus/tasks/:id` | Own task details/corrections/deletion |
| `GET/POST /v1/focus/labels` | List/create labels; edit/archive routes follow the same ownership rules |
| `GET /v1/focus/sessions` | Own session history |
| `POST /v1/focus/active-session` | Start/coordinate an online session |
| `GET /v1/focus/active-session` | Read authoritative active state |
| `POST /v1/focus/sessions/:id/actions` | Typed pause/resume/finalize/discard action |
| `PATCH/DELETE /v1/focus/sessions/:id` | Allowed metadata correction or deletion |
| `POST /v1/focus/session-conflicts/:id/resolve` | Explicit owner conflict resolution |

Decision 0003 excludes manual historical session creation and duration edits in V1. Allow task/label/private-note correction or deletion only through the permitted paths; metadata edits cannot fabricate timing fields. Editable Pomodoro defaults are 25/5/15 minutes, with explicit interval starts.

**Acceptance:** Two accepted 25-minute intervals yield 50 focus minutes. Replayed finalization yields no extra session, and two concurrent online starts cannot create two authoritative active sessions.

## 14. Read service

- Manual book creation with title, optional author/page total/dates/notes, and approved shelf status.
- Maintain ordered page-position history and per-book revision control.
- Derive page deltas from valid history rather than trusting arbitrary client-supplied total pages read.
- Correcting/deleting an entry recalculates affected history and projections.
- Reject page positions below zero or beyond a known total; unknown totals do not create fake percentages.
- Completion requires an explicit confirmed state transition; do not auto-post.
- One reading history per book entry in V1; reread cycles are later.
- Keep notes private and limit deletion cascades to the owner's intended data.

| Method/path | Purpose |
|---|---|
| `GET/POST /v1/read/books` | List/manual creation |
| `GET/PATCH/DELETE /v1/read/books/:id` | Own book details/status/removal |
| `GET/POST /v1/read/books/:id/progress` | Progress history/update with expected book revision |
| `PATCH/DELETE /v1/read/progress/:id` | Correct/remove history with aggregate checks |
| `POST /v1/read/books/:id/finish` | Explicit completion confirmation |
| `GET/PUT /v1/read/goals` | Own optional reading goals |

**Acceptance:** Page 40 → 58 contributes 18 pages. Two concurrent offline updates to the same base revision do not silently contribute both deltas.

## 15. Intake service

### Water

- Positive canonical milliliter entries, occurrence context, optional approved source label.
- Configurable user target with an effective date, not one mutable value applied to all history.
- Edit/delete recalculates the appropriate day.
- Unit conversions follow the agreed canonical rounding rule.

### Coffee

- Cup and espresso-shot entries remain separate kinds with positive counts.
- Optional timestamp/note; correction/deletion supported.
- No caffeine estimate or water equivalence without a separately approved feature.

| Method/path | Purpose |
|---|---|
| `GET/POST /v1/intake/water` | Water history/create |
| `PATCH/DELETE /v1/intake/water/:id` | Correct/remove own water record |
| `GET/PUT /v1/intake/water-targets` | Read/save effective-dated targets |
| `GET/POST /v1/intake/coffee` | Coffee history/create |
| `PATCH/DELETE /v1/intake/coffee/:id` | Correct/remove own coffee record |

Reminders are primarily device-local. Preference synchronization does not require a backend push job for every glass of water.

**Acceptance:** Changing 250 ml to 200 ml reduces the day by 50 ml exactly. Coffee cannot complete a water target, and exceeding a target does not produce competitive rewards.

## 16. Money service

### 16.1 Money boundaries

This is a manual journal/planner, not a bank ledger verified against institutions. User corrections and deletions are legitimate product operations. Do not impose bank-grade immutable accounting as an accidental restriction, but preserve consistency and appropriate restricted audit metadata.

Every account/transaction/plan/goal belongs to one user and the approved base currency. Exact minor units must remain exact through validation, persistence, aggregation, JSON, export, and card rendering.

### 16.2 Proposed transaction/posting model

Use a transaction header plus signed account postings as an internal representation:

| Type | Posting behavior | Reporting |
|---|---|---|
| Opening balance | One signed opening posting, created with the account | Not income/expense |
| Income | Positive posting to one account | Income |
| Expense | Negative posting to one account | Expense |
| Transfer | Equal opposite postings to distinct same-owner accounts | Neither income nor expense |
| Balance adjustment | Explicit signed correction posting | Separate from ordinary income/expense |

Public income/expense/transfer inputs use positive amounts with direction determined by type. Opening/adjustment semantics are explicit, not negative expenses disguised as ordinary entries.

This is not a claim of a full double-entry accounting system; external counterparties are not modeled as a complete accounting chart in V1.

### 16.3 Integrity requirements

- Create transfer header, both postings, revision/change-log data, and receipt in one transaction.
- Enforce same-owner/same-currency/distinct-account relationships.
- Validate posting count, signs, and equality for transfers in the domain service; add appropriate database constraints/SQL safeguards where practical.
- Lock affected aggregates in deterministic order for concurrent changes.
- If cached balances exist, update them atomically and provide reconciliation against postings. Otherwise derive balances using indexed queries.
- Never count opening balances, adjustments, transfers, or savings-goal entries as ordinary income by accident.
- Account creation writes its opening balance once; do not also add a separate opening field a second time in totals.
- Editing/deleting a transaction updates all associated postings consistently and emits tombstones/revisions as appropriate.
- Archiving preserves history; only delete accounts that satisfy the approved empty-history rule. Define that rule around meaningful activity/references so an automatically created opening row does not make every account permanently undeletable.
- Insufficient recorded balance is a warning, not a fabricated banking denial. Accurate negative balances may be recorded where reality requires it.
- Validate arithmetic ranges/overflow for totals as well as individual inputs.

### 16.4 Monthly finance plans

- One saved plan per owner/month with optional planned-income reference.
- Expense-category allocations and planned savings remain separate.
- Actual category spending derives from accepted expense records for that month under the defined date policy.
- Planned savings does not create a contribution, expense, or transfer.
- Copying a previous plan creates an editable draft/new month, not linked live budgets.
- Plan review is an explicit dated private event, not an automatic contribution from merely opening the screen.
- Percentage cards state their denominator, selected subset, and planned-versus-actual status.

### 16.5 Savings goals

Follow the PRD's accepted independent manual planning ledger:
- Name, positive target amount, optional deadline, and manual contribution/withdrawal history.
- A contribution does not move funds, reserve a wallet balance, create an expense, or increase assets.
- Transfers between real-world wallets are recorded separately.
- Contributions are idempotent; concurrent withdrawals/edits lock/version the goal so progress cannot become negative.
- Progress may exceed the target without automatic publication.
- Do not imply the same funds are verified or exclusively allocated across multiple goals.

### 16.6 Draft endpoints

| Method/path | Purpose |
|---|---|
| `GET/POST /v1/money/accounts` | Accounts and account creation/opening balance |
| `GET/PATCH/DELETE /v1/money/accounts/:id` | Details, rename/archive, eligible empty removal |
| `POST /v1/money/accounts/:id/adjustments` | Explicit reconciliation correction |
| `GET/POST /v1/money/transactions` | Filtered history and income/expense/transfer creation |
| `GET/PATCH/DELETE /v1/money/transactions/:id` | Own aggregate details/correction/removal |
| `GET/POST /v1/money/categories` | Own/default category management |
| `GET/PUT /v1/money/plans/:month` | Monthly plan with expected revision |
| `POST /v1/money/plans/:month/reviews` | Explicit review event |
| `GET/POST /v1/money/savings-goals` | List/create goals |
| `GET/PATCH/DELETE /v1/money/savings-goals/:id` | Goal management under defined history rules |
| `GET/POST /v1/money/savings-goals/:id/entries` | Contribution/withdrawal history and creation |
| `PATCH/DELETE /v1/money/savings-entries/:id` | Correct/remove entries with aggregate validation |
| `GET /v1/money/summary` | Own balances, income/expenses, budgets, savings separately |

**Acceptance:** A transfer of 200 between recorded balances 500 and 1,000 leaves total 1,500. A savings-goal entry of 200 leaves that total unchanged. Failure halfway through transfer creation leaves neither posting committed.

## 17. Progress and dashboard queries

### 17.1 Private summaries

Provide owner-only Today, period summaries, per-mode progress, and contribution-calendar data. Public profile endpoints must not reuse the complete personal DTO.

| Method/path | Purpose |
|---|---|
| `GET /v1/me/today` | Bounded current-day summary and relevant quick-action context |
| `GET /v1/progress/calendar` | Authorized own daily contributions for a bounded period/filter |
| `GET /v1/progress/days/:date` | Own contributing activity details |
| `GET /v1/progress/summary` | Own period/mode aggregates |

### 17.2 Projection rules

Use the PRD's proposed distinct-mode intensity, capped at four. Logging activity is not a wealth/health score. Social likes, messages, views, and reposts never add contributions.

Edits/deletions invalidate affected days. Preserve effective-dated goal context and intended local activity dates. Rebuildable projections must be reproducible from accepted sources.

For V1-A, indexed source queries may be simpler than a complex projection engine. If asynchronous projections are introduced, expose freshness and ensure critical Money balances and canonical card preparation do not rely on stale eventual totals.

### 17.3 Query limits

Bound calendar ranges and history pages. Use owner/date/entity indexes and review query plans. Do not load a lifetime of raw transactions to render one annual calendar, and do not fan out one query per calendar cell.

## 18. Offline synchronization protocol

### 18.1 Scope

Personal tracking mutations synchronize offline. Social publishing, audience changes, follows/approval, reposting, and permission-sensitive interactions require current online authorization. Messaging has its own durable send protocol.

The Sync module dispatches typed personal commands to the same services as ordinary REST writes. No command can name an arbitrary table, owner, SQL condition, or unapproved field.

### 18.2 Proposed endpoints

| Method/path | Purpose |
|---|---|
| `POST /v1/sync/bootstrap` | Create an owner-authorized consistent personal snapshot generation |
| `GET /v1/sync/bootstrap/:snapshotId` | Snapshot status/chunks plus its captured stream watermark |
| `POST /v1/sync/commands` | Bounded typed-command batch with per-command outcomes |
| `GET /v1/sync/changes` | Cursor-based incremental owner changes/tombstones |
| `GET /v1/sync/status` | Protocol version, supported retention horizon, safe resync guidance |

### 18.3 Command envelope

Illustrative request:

```json
{
  "protocolVersion": 1,
  "deviceId": "registered-device-id",
  "commands": [
    {
      "operationId": "0a4c3a04-e86d-40ef-8c8a-ff55ce080526",
      "type": "intake.water.create.v1",
      "entityId": "aa529919-e0ba-471f-ae10-53c2424b546e",
      "expectedVersion": 0,
      "payload": {
        "amountMl": 250,
        "occurredAt": "2026-01-15T02:00:00Z",
        "activityLocalDate": "2026-01-15",
        "activityTimeZone": "Asia/Jakarta"
      }
    }
  ]
}
```

Dates are examples only. `deviceId` is diagnostic/coordination context, never authority to impersonate the authenticated owner.

### 18.4 Batch semantics

- Validate the envelope and resource limits before processing.
- Validate/authorize each typed command and return Accepted, Conflict, Rejected, or Dependency Pending with machine-readable codes.
- Each independent command commits atomically. A whole batch is not implicitly one database transaction.
- A transfer remains one atomic command despite producing multiple rows.
- Parent-dependent commands do not proceed if their prerequisite failed or has not been accepted.
- Accepted receipts include safe canonical IDs/revisions and change positions as appropriate.
- Retrying the same accepted operation produces no new mutation/change event.
- Same operation ID with different payload is rejected, not treated as a correction.

### 18.5 Change-stream correctness

Personal writes must participate in an owner-scoped change stream, including writes made by the future website or direct REST endpoints.

**Proposed ordering:** Lock an owner sync-state row within each relevant mutation transaction, allocate the next owner position, and write the change entry before commit. Keep lock ordering consistent with aggregate locks.

Do not assume a global auto-increment ID is commit-ordered: one transaction can allocate a lower ID and commit after a higher ID has already been pulled. A naive high-water cursor would lose data.

The final strategy must prove that a client advancing a cursor cannot miss a later-committing change. Personal change streams are separate from feed ordering and conversation sequences.

### 18.6 Bootstrap, expiration, and conflicts

- Bootstrap snapshot chunks belong to an immutable generation captured consistently with a stream watermark. Paginating live tables without snapshot semantics is insufficient.
- After installing that snapshot, pull changes after its watermark while preserving local pending operations for reconciliation.
- Cursor/tombstone/idempotency retention horizons must be explicit. A proposed initial offline horizon is 90 days, subject to approval and load/cost tests.
- Expired cursors return a resync-required result; never silently return an incomplete history.
- Rebootstrap must not blindly drop pending local commands or resurrect server-deleted IDs.
- Independent new logs merge by identity; edits require aggregate revisions.
- Money and reading conflicts must not silently use last-write-wins.
- Long-offline commands beyond the supported horizon need review/rebase behavior, not blind replay after receipts have expired.

**Acceptance:** A response lost after commit can be retried without double logging. A transaction that commits late cannot disappear behind a cursor. Deleted records do not return through stale offline updates.

## 19. Progress cards and media

### 19.1 Card preparation

Accept supported source references/revisions, selected fields, period, template version, optional caption, and requested audience. Resolve ownership and calculate metrics server-side from accepted source records.

Do not trust arbitrary client-submitted achievements, totals, account balances, or source ownership. These records are still self-reported; server consistency is not real-world verification.

Allowlist the exact snapshot schema for each template. Financial values, account names, transaction notes, task notes, and unselected records must not survive as hidden JSON/image metadata.

### 19.2 Two-step publication

1. Prepare an owner-only card draft/snapshot from accepted source data.
2. Render its bounded final image asynchronously if required.
3. Return the exact structured preview/render and its version/hash.
4. User explicitly confirms that version and audience.
5. Recheck current eligibility/source versions and publish atomically, or require renewed preview if content changed.

Draft creation/render completion must never publish automatically. A worker must not resurrect content for a deleted/suspended user.

Published snapshots do not silently change when private tracking changes. Caption edits and explicit snapshot regeneration follow PRD edit indicators and privacy preview rules.

### 19.3 Media security

- Store private drafts, posters, and exports in private object storage.
- Media metadata records owner, purpose, content type, size, checksum, storage key, and lifecycle/status.
- Storage keys/unguessable IDs are not authorization.
- Deliver private media through a reauthorizing API/proxy path with suitable no-store behavior, or another design that meets revocation requirements.
- A previously issued signed storage URL may work until expiry. Do not call that immediate revocation.
- For V1, avoid permanently public card image URLs/CDN caches even for currently public posts that may later become private.
- Third-party link-preview caches and exported images are outside guaranteed recall; communicate that distinction.

### 19.4 Rendering and uploads

Use deterministic template data, approved fonts/assets, explicit dimensions, safe text handling, and bounded CPU/memory/time. Do not fetch arbitrary user-supplied URLs or execute user HTML/CSS/SVG in the renderer.

Avatar uploads use limited raster formats, byte/pixel limits, decode/re-encode validation, and metadata stripping. Do not accept arbitrary post-image uploads through the avatar path.

| Method/path | Purpose |
|---|---|
| `POST /v1/cards/drafts` | Prepare canonical owner-only snapshot |
| `GET /v1/cards/drafts/:id` | Authorized preparation/render status and preview |
| `POST /v1/cards/drafts/:id/publish` | Explicit version/audience confirmation |
| `GET/PATCH/DELETE /v1/posts/:id` | Authorized post read, permitted edits/audience changes, removal |
| `POST /v1/posts/:id/regenerations` | Prepare revised snapshot requiring new confirmation |
| `POST /v1/media/avatar-uploads` | Issue owner-scoped limited upload instructions |
| `POST /v1/media/:id/complete` | Validate uploaded object before use |
| `GET /v1/media/:id/content` | Current-context authorization before delivery |

A draft image is owner-only until an associated publication grants access. A media ID must not let someone bypass the post's current audience.

**Acceptance:** A percentage-only savings card exposes no exact amount in JSON, accessible text, image metadata, media URLs, or link preview. Deleting its post invalidates its in-app media/repost/card-preview access.

## 20. Social graph and feed

### 20.1 Following and blocking

- Public follows are accepted immediately unless restricted; private follows create requests.
- Approve/decline/cancel/remove actions are actor/recipient scoped and idempotent.
- Removing a follower revokes followers-only access immediately.
- Blocking removes relevant follow/request relationships and prevents new contact in both directions.
- Unblocking does not silently restore old follows/requests.
- Account privatization retains existing approved followers but narrows public reads.

### 20.2 Feed

Start with query-on-read from followed authors, own posts, and eligible repost references. No per-user fan-out infrastructure is necessary until measurements justify it.

- Chronological ordering by publication/repost time with a stable tie-breaker.
- First-page watermark/cursor semantics prevent new inserts from shifting old pages unpredictably.
- Filter authorization before returning content; hidden/private content must not leak through counts or previews.
- A bounded candidate scan must not falsely declare "caught up" merely because the first candidates were unauthorized; return valid continuation semantics.
- Likes/comments do not change publication sort time.
- Explicit finite pages and caught-up metadata support the anti-doomscrolling UI.
- No trending or engagement ranking.

### 20.3 Likes, comments, and reposts

- Likes use desired-state PUT/DELETE semantics rather than blindly replayed toggle actions.
- One-level comment replies only; validate parent belongs to the same post and is an allowed reply target.
- Author edits/deletes own comments; post owner can remove comments; deletion placeholders must not leak removed text.
- Counts and identity lists are viewer-authorized.
- Repost only a currently public eligible source on a public active account.
- Preserve attribution and reference the source; no detached snapshot or quote-repost editor.
- Revalidate sources when reading reposts, not only at creation time.
- Removal, moderation, privatization, or source restriction suppresses repost content synchronously through read policy.

### 20.4 Draft endpoints

| Method/path | Purpose |
|---|---|
| `PUT/DELETE /v1/users/:id/follow` | Follow/request or unfollow/cancel |
| `GET /v1/me/follow-requests` | Pending requests addressed to owner |
| `POST /v1/follow-requests/:id/approve` | Recipient approval |
| `POST /v1/follow-requests/:id/decline` | Recipient decline |
| `DELETE /v1/me/followers/:userId` | Remove own follower |
| `GET /v1/feed` | Authorized finite chronological batch |
| `PUT/DELETE /v1/posts/:id/like` | Desired like state |
| `GET/POST /v1/posts/:id/comments` | Authorized comments/list/create |
| `PATCH/DELETE /v1/comments/:id` | Author correction or permitted removal |
| `PUT/DELETE /v1/posts/:id/repost` | Create/undo eligible repost |
| `PUT/DELETE /v1/me/blocks/:userId` | Block/unblock |
| `GET /v1/me/blocks` | Own block list |

A share link is a locator, not a new permission grant. Anonymous public-link rendering is an open decision and, if enabled, uses the same effective-public eligibility rules.

**Acceptance:** An old liked post never jumps above a newer one. A repost becomes unavailable after its source author turns private, even if the reposter remains a follower.

## 21. Messaging and realtime

### 21.1 Conversation model

V1 is one-to-one text and authorized card references. Normalize each user pair and enforce one conversation identity per pair, with explicit request/accepted state and participant-owned visibility/unread settings.

Recipient DM settings govern new contact. Proposed default: recipients' followed users may message directly; others go through requests. Private-account status does not itself grant or deny DM consent.

Declines and rate limits must prevent repeated request spam. Group chats, arbitrary files, calls, read receipts, and presence are not required.

### 21.2 Durable message mutation

Recommended canonical send path: HTTP POST, with Socket.IO used for updates. If socket-based sending is later added, it must call the same service with the same idempotency identity.

Within the mutation workflow:
1. Resolve participant identities and target conversation IDs without treating cached permissions as a decision.
2. Acquire the conversation/pair coordination locks within the transaction under the defined order.
3. Re-read and authorize current request/block/account state under that coordination; a pre-lock check alone is insufficient.
4. Detect a duplicate sender/client-message ID; reject payload reuse with different content.
5. Validate a typed text or card-reference payload.
6. For cards, validate the recipient can view the source without granting new rights.
7. Save message and allocate an ordered per-conversation sequence.
8. Update unread/conversation metadata and commit the message, receipt, and outbox work together.
9. Return the durable acknowledgement only after commit.

The sequence is allocated under the conversation transaction, not guessed from client time. Serialize large values safely. A duplicate acknowledgement must not rebroadcast a new message or increment unread twice.

### 21.3 History and blocking

- Only participants can read permitted conversation history.
- Hidden/deleted-for-me state is participant-local and does not erase the other person's copy.
- Blocking stops new messages/requests and suppresses pending contact notifications. Historical messages follow the published retention policy.
- A message accepted before a block is not a new message merely because its acknowledgement is replayed; handle historical receipts minimally without sending/delivering it again.
- Card references are authorized at view time and can become unavailable.
- Mark-read updates the user's own unread cursor; it does not imply a public read receipt feature.

### 21.4 Socket.IO requirements

- Verify handshake identity, active-user state, token expiry, and allowed origins/transports.
- If browser connection tickets are enabled, validate their distinct audience, scope, expiry, and replay policy; never treat a limited realtime ticket as a general API/operator credential.
- Rooms are server-controlled; clients cannot join arbitrary user/conversation IDs.
- Revalidate/reconnect when tokens expire or account access changes; handshake-only validation is insufficient for an indefinitely open connection.
- Prefer minimal event payloads containing IDs/sequences; clients fetch authorized content rather than receiving broad private snapshots through generic broadcasts.
- Reconnect/history fetch handles dropped/duplicated events.
- Multiple API instances require a compatible coordination adapter and tested load-balancer behavior. HTTP long-polling may require affinity; validate the selected transports.
- Redis fan-out does not replace permission checks or database history.

### 21.5 Draft endpoints and events

| Method/path | Purpose |
|---|---|
| `POST /v1/realtime/tickets` | Proposed authenticated limited connection ticket for browser BFF integration |
| `GET/POST /v1/conversations` | List or resolve/create permitted pair/request |
| `GET /v1/me/message-requests` | Requests addressed to owner |
| `POST /v1/conversations/:id/accept` | Accept permitted request |
| `POST /v1/conversations/:id/decline` | Decline request |
| `GET/POST /v1/conversations/:id/messages` | Participant history and durable send |
| `PUT /v1/conversations/:id/read-cursor` | Own unread-state advancement |
| `DELETE /v1/conversations/:id` | Hide/remove for current participant, not both |
| `DELETE /v1/messages/:id/for-me` | Participant-local message removal |

Candidate socket events: `message.available`, `conversation.updated`, `notification.available`, `content.accessChanged`. Use versioned event envelopes with safe IDs and no assumed guaranteed delivery.

**Acceptance:** Retry after lost acknowledgement creates one message. A send that follows a committed block cannot become a new accepted message. Sending a private card to an unauthorized recipient does not grant access.

## 22. Jobs and notifications

### 22.1 Transactional outbox

Save domain state and an outbox event in PostgreSQL together. A dispatcher claims pending events using leases/locking, submits jobs, and records progress safely.

Handle crashes before/after enqueue: stable event/job IDs and idempotent consumers prevent duplicate domain effects. Redis loss must be recoverable from durable pending state.

Do not use in-memory EventEmitter listeners or unawaited promises as the only path for required delivery.

### 22.2 Job categories

- Canonical poster rendering/regeneration.
- Push delivery and appropriate event grouping.
- Personal-data export preparation.
- Account/media cleanup and deletion processing.
- Projection rebuild/invalidation where asynchronous behavior is appropriate.
- Expired draft/upload/export and stale-token cleanup.

Use bounded concurrency, job-specific timeout/retry policies, backoff, stalled-job recovery, and a restricted failed-job review/retry workflow. Sensitive payloads should be referenced by ID rather than copied into queue diagnostics.

### 22.3 Notification delivery

- Maintain user preferences, quiet hours/timezone, installation/token ownership, and inbox/delivery state.
- Check current source visibility, blocking, account status, and notification eligibility at send time.
- No amounts, task notes, transaction details, or message bodies in default push payloads.
- Token reassignment/logout/rotation must not leave one account receiving another account's alerts.
- In-app event identity and device handling prevent duplicate presentation where possible.
- External push providers can accept a send whose response is lost. Exactly-once lock-screen delivery cannot be guaranteed; use stable notification IDs/collapse behavior where appropriate rather than claiming it can.
- Device-local focus/water reminders are not server pushes for every timer tick/drink.

| Method/path | Purpose |
|---|---|
| `PUT/DELETE /v1/me/push-installations/:installationId` | Register/refresh/revoke owner installation/token |
| `GET/PATCH /v1/me/notification-preferences` | Category/quiet-hours/preview settings |
| `GET /v1/me/notifications` | Authorized notification inbox |
| `PUT /v1/me/notifications/read-cursor` | Own read state |
| `GET /v1/jobs/:id` | Owner-authorized public job status only |

## 23. Safety and moderation

- Report accounts, posts, comments, and intentionally selected messages.
- Capture necessary evidence/context while avoiding unrestricted browsing of unrelated private records.
- Restricted roles separate report triage, content action, account restriction, and operational administration.
- Audit reviewer access and moderation decisions, including reasons, timestamps, and appeal linkage.
- Support removal, suspension/restriction, and documented appeal/support processing.
- Moderation changes feed into the same effective-access checks as owner privacy changes.
- Report abuse/spam is itself rate-limited; reports must not reveal whether unrelated private content exists.
- No general-purpose operator endpoint for casually viewing everyone's financial ledger.

| Method/path | Purpose |
|---|---|
| `POST /v1/reports` | Submit supported target/reason and approved evidence |
| `GET /v1/me/reports` | Safe own-submission status where policy permits |
| `GET /v1/operator/reports` | Restricted triage queue |
| `GET /v1/operator/reports/:id` | Authorized evidence review with access audit |
| `POST /v1/operator/moderation-actions` | Role-scoped action with reason/audit |
| `POST /v1/operator/appeal-decisions` | Documented restricted appeal outcome |

The operator dashboard uses the confirmed Next.js framework; its detailed scope and role model are in [ADMIN_CMS_PRD.md](ADMIN_CMS_PRD.md). A secured operational interface/workflow must exist before public social launch; unsecured database-console access is not the product moderation workflow.

Additional candidate operator contracts, requiring explicit schema/capability review before implementation:

| Method/path | Purpose / access boundary |
|---|---|
| `GET /v1/operator/session` | Trusted current staff capabilities, scope, and assurance status |
| `GET /v1/operator/users`, `GET /v1/operator/users/:id` | Minimal field-scoped account lookup, never a raw tracker dashboard |
| `POST /v1/operator/reports/:id/assignment` | Revision-aware claim/reassignment |
| `GET /v1/operator/jobs`, `GET /v1/operator/jobs/:id` | Safe permitted job metadata, not raw payloads |
| `POST /v1/operator/jobs/:id/retries` | Allowlisted eligible retry with reason, revision, and operation ID |
| `GET /v1/operator/data-requests` | Export/deletion status metadata, not export-file access |
| `GET/POST /v1/operator/staff-grants` | Dedicated elevated permission and step-up; no public staff signup |
| `POST /v1/operator/staff-grants/:id/revoke` | Audited revocation and session coordination |
| `GET /v1/operator/audit` | Scope-limited safe audit metadata |

Editorial/configuration extensions are optional and need a separate approved content contract; no arbitrary table, SQL, or renderer-code editor is introduced.

## 24. Data export, deletion, and retention

### 24.1 Export

- Require appropriate authenticated/reauthenticated access.
- Export the user's tracking records, profile/preferences, and published content in documented usable formats.
- Define participant message export rules; do not include another person's unrelated data.
- Use an asynchronous authorized job, private storage, expiry, and audited download access.
- Do not expose raw credential/provider secrets, staff-only notes, or other users' hidden records in an export.

### 24.2 Account deletion

1. Confirm identity/intent and record a durable deletion request.
2. Move the account into a state that denies new normal activity and public content visibility promptly.
3. Revoke/coordinate identity sessions and realtime access under the approved provider model.
4. Stop or invalidate queued publication/notification work for that account.
5. Delete/anonymize domain records, media, social references, device tokens, and exports according to policy.
6. Preserve only justified legal/abuse/backup exceptions with restricted access and expiry.
7. Record completion/status without recreating the user during old-token bootstrap or stale offline replay.

Messages already delivered to other participants require an approved retention/anonymization policy; do not silently promise deletion from every participant's history.

### 24.3 Retention schedule

Before production, approve concrete periods for:
- Active data, logical tombstones, personal sync changes, and operation receipts.
- Expired card drafts, orphan uploads, poster versions, and exports.
- Messages, participant-hidden records, report evidence, and moderation audits.
- Logs/traces, push deliveries, and failed jobs.
- Backups and deletion completion targets.

The proposed 90-day offline horizon is not a blanket retention policy. Align cursor/receipt/tombstone retention so long-offline clients receive a safe rebootstrap response rather than incomplete data or resurrected deletions.

Deletion requirements apply to sensitive payload copies in queues, change logs, audit evidence, and backups—not only main tables. Minimize copied content from the beginning.

## 25. Security and abuse prevention

### 25.1 Required controls

- TLS for public traffic and protected connections to managed services.
- Restricted database/storage/queue credentials and separate environment secrets.
- No service-role/database/push credentials in Flutter or browser bundles.
- Validated SQL/ORM parameters and reviewed raw queries; no interpolation of untrusted SQL fragments.
- Explicit field-level DTOs prevent mass assignment and accidental finance disclosure.
- Context-aware output handling; user captions/comments are untrusted text, not trusted HTML.
- No arbitrary URL fetching by rendering/upload/export services; prevent SSRF.
- Raster validation and decompression/pixel limits for images.
- Tight operator access, MFA, and auditability.
- Body/header redaction and no sensitive data in public stack traces.

### 25.2 Browser and transport controls

- CORS allowlist for approved browser origins; CORS is not authentication and does not protect against non-browser clients.
- If a future web session uses cookies, add an explicit CSRF/session strategy. Mobile bearer authentication does not automatically solve browser security.
- Set suitable security headers and limit request/response sizes.
- Verify provider webhooks with the actual signing protocol and replay protection; do not trust a user-supplied webhook payload.

### 25.3 Rate controls

Apply actor/IP/installation/resource-aware controls to bootstrap/auth-adjacent actions, search, follow requests, publishing/comments, unknown-sender DMs, upload preparation, exports, and reports.

Use stricter unknown-sender request limits than ordinary established conversations. Decide fail-open/fail-closed behavior per operation when the shared limiter is unavailable; security-sensitive new contact/publication should not silently become unlimited.

Exact limits are configuration/product decisions requiring abuse testing. Do not use Redis TTL state as the only evidence of blocked-user policy or account suspension.

### 25.4 Threat model review

Include broken object-level authorization, replay/duplicate writes, stale permissions, account switching, operator misuse, leaked media links, push-token mixups, renderer SSRF, queue payload leakage, and exported sensitive data.

The application must never imply that an internally consistent record proves real-world productivity, health, or financial performance.

## 26. Reliability and performance

### 26.1 Reliability requirements

- A synchronous accepted mutation survives ordinary process restarts through committed storage.
- A required asynchronous effect has durable job/outbox state before acceptance is reported.
- Replays do not duplicate transfers, logs, likes, posts, messages, or unread counters.
- Important derived data is rebuildable and reconcilable with authoritative records.
- Access revocation does not rely solely on eventually expiring caches.
- Dependency failures produce safe degraded states rather than fabricated success.

### 26.2 Proposed starting performance targets

These are investigation budgets, not measured promises or approved SLAs:
- Common indexed owner reads: p95 server response at or below 500 ms under an agreed baseline workload.
- Simple accepted mutations: p95 at or below 750 ms excluding external job execution and client/network latency.
- Published poster render time, queue delay, and export preparation: separate measured budgets and visible pending status.
- Personal change pull must page bounded data and avoid full rescans on each request.
- No cross-user/period N+1 queries for feed/calendar generation.

Set reference hardware, fixture size, concurrency, data distribution, and warm/cold conditions before claiming these targets are met.

### 26.3 Growth strategy

Start with one API instance, appropriately provisioned PostgreSQL, and workers when needed. Scale based on measurements:
1. Fix indexes/query shape/pagination.
2. Bound jobs and external concurrency.
3. Scale API/worker replicas with connection-pool budgets.
4. Add measured caching that preserves authorization.
5. Introduce read models/fan-out only when necessary.

Read replicas can lag privacy changes. Do not route authoritative access decisions to a stale replica without a consistency strategy.

## 27. Deployment and operations

### 27.1 Environments

Separate development, staging, and production databases, provider resources, storage, queues, credentials, and allowed origins. Production data must not be copied casually into development fixtures.

Pin the runtime/build toolchain, commit migrations, and deploy reproducible images. A chosen Node version in CI must be compatible with the selected NestJS/Prisma stack.

### 27.2 Process deployment

- Persistent HTTP API with graceful shutdown/draining.
- Worker/dispatcher role with leases and safe job interruption/recovery.
- Managed PostgreSQL with backups; managed Redis/storage if selected.
- Load balancer configured for selected HTTP/WebSocket transports and timeouts.
- Avoid declaring long-lived socket/worker behavior on a host that only provides short-lived functions.

API and workers may share an image and codebase with separate entry points. No Kubernetes requirement in V1.

### 27.3 Health and dependency state

- `/health/live`: process viability, not a detailed public infrastructure report.
- `/health/ready`: ability to perform its required role safely.
- API readiness depends on required database/config/verification capability; a queue outage can be degraded if durable outbox acceptance still meets the endpoint contract.
- Worker readiness depends on required queue/database/rendering resources.
- Expose protected operational metrics; do not reveal connection strings or private queue payloads.

### 27.4 Database migration/recovery

- Run reviewed migrations as a controlled deployment step, not independently from every replica.
- Prefer expand/migrate/contract changes compatible with old mobile clients and running workers.
- Test migrations on realistic staging volume; no production `db push` shortcut or destructive reset.
- Verify provider pooling, prepared-query behavior, and direct migration connections against the actual stack.
- Establish backup/PITR capability, encrypted backup access, retention, restore drills, and approved RPO/RTO before real user data.
- Reconcile outbox/jobs/media after restore; backup success alone is not proven application recovery.

### 27.5 CI/CD quality gates

Before merge/release, configure a reproducible pipeline to:
- Install from the approved frozen lockfile and generate Prisma types.
- Check formatting, linting, strict TypeScript compilation, and unit tests.
- Apply migrations to real test PostgreSQL and run integration/concurrency tests; test upgrade paths separately from empty-database creation.
- Export OpenAPI, detect unintended breaking changes, and generate/compile representative Dart and TypeScript client fixtures.
- Run privacy/idempotency regression suites and job/recovery tests with controlled database/queue dependencies.
- Build API/worker images and smoke-test configuration, health, graceful shutdown, and role-specific startup.
- Review dependency/security/license findings and scan for accidentally committed secrets.
- Promote through staging with explicit migration/release approval, rather than running destructive schema changes automatically from every application instance.

Exact package-manager commands and CI configuration are defined after scaffolding; none have been executed as part of this documentation work.

## 28. Observability and analytics

### 28.1 Technical signals

Measure:
- Request latency/error codes by safe route/method labels.
- Database/pool health, slow queries, transaction retries/deadlocks.
- Outbox age, dispatch failures, job retries/failures, render/export duration.
- Sync conflict/rejection/duplicate-prevention outcomes and cursor expiration.
- Socket reconnect/gap recovery and notification delivery failures.
- Authorization-denied trends, rate limiting, report workload, deletion backlog.

Avoid high-cardinality sensitive metric labels and request bodies. Correlate safe opaque IDs under restricted retention/access.

### 28.2 Product analytics

Support the PRD's useful-tracking and safety measures without collecting exact balances, transaction notes, messages, private task titles, or sensitive card fields in general events.

Do not optimize backend notification/feed systems for maximum scrolling time. Analytics/consent, retention, and operator access require approval before instrumentation is enabled in production.

## 29. Testing and release acceptance

### 29.1 Test strategy

| Layer | Required coverage |
|---|---|
| Unit/domain | Money arithmetic/postings, savings rules, page deltas, session transitions, goals/dates, snapshot allowlists |
| Persistence/integration | Real PostgreSQL constraints, locking, transactions, migrations, cursor ordering |
| API/e2e | DTO validation, identity/ownership, response shapes, errors, pagination, all supported mutations |
| Concurrency | Simultaneous starts/edits, duplicate operations, transfer rollback, block-versus-send, late commits |
| Contract | Approved OpenAPI generation, Dart/TypeScript client fixtures, exact integers/dates/nullability |
| Jobs/recovery | Commit/enqueue crash windows, duplicate jobs, Redis loss, worker interruption, failed pushes |
| Privacy/security | Viewer matrix, revoked media/caches, reports/operator roles, raw payload/log leakage |
| Operations | Migration compatibility, backup/restore rehearsal, readiness/degraded dependency behavior |

Use real PostgreSQL for transaction/constraint tests. SQLite substitutes do not prove PostgreSQL concurrency behavior. Keep provider mocks for deterministic unit tests and use approved sandbox integration checks separately.

### 29.2 Critical acceptance requirements

| ID | Requirement / proof |
|---|---|
| BE-01 | A user cannot read/write another user's raw record by changing an ID or command owner field |
| BE-02 | Lost-response retries create one accepted log/transaction/message effect |
| BE-03 | Transfer creation/edit/deletion is atomic and combined balance remains correct |
| BE-04 | Savings planning never creates assets, expenses, or actual reserved funds |
| BE-05 | Reading/session corrections update relevant summaries without inflated progress |
| BE-06 | A cursor cannot skip a later-committing personal change; expired cursors force safe resync |
| BE-07 | Stale offline writes cannot resurrect deleted entities or silently overwrite Money conflicts |
| BE-08 | Private-card excluded fields are absent from every public/accessible/media representation |
| BE-09 | Privatization/follower removal/blocking/suspension revoke all relevant online access paths |
| BE-10 | Reposts and DM card previews cannot bypass the original source audience |
| BE-11 | New message writes after a committed block are rejected, including stale-client retries |
| BE-12 | Accepted async work survives API/worker restarts through durable outbox/job state |
| BE-13 | Notifications respect current access/preferences and do not disclose sensitive default previews |
| BE-14 | Operator access/report evidence is restricted and audited; no casual finance browsing |
| BE-15 | Account deletion blocks rebootstrap/republication and follows tested retention/export behavior |
| BE-16 | Old supported Flutter clients can use the API after compatible server deployment |
| BE-17 | Ordinary/low-assurance/revoked staff sessions cannot reach operator data or actions; required capabilities and assurance are checked by NestJS |
| BE-18 | Browser realtime tickets, if enabled, cannot authenticate general REST, impersonate another actor, or grant operator permissions |

### 29.3 Privacy matrix

Repeat post/profile/feed/comment/repost/media/link/notification/DM checks for owner, approved follower, non-follower, pending requester, removed follower, blocked user, suspended user, and anonymous viewer where enabled.

Repeat after audience narrowing, public→private→public transitions, post deletion, source edits, account suspension/deletion, and cache warming. Include a worker that started before permissions changed and finishes afterwards.

### 29.4 PRD traceability

| PRD area | Backend responsibility |
|---|---|
| ACC, DAY | Identity/lifecycle, private preferences, bounded own summaries |
| FOC | Task/session integrity, active coordination, conflict resolution |
| READ | Validated history and completion/goals |
| INT | Separate records, canonical units, target history |
| MON | Exact money, atomic postings, monthly plans, separate savings ledger |
| PROG | Correct dates/projections and meaningful contribution semantics |
| CARD | Canonical allowlisted snapshots, explicit publication, private media |
| SOC, FEED | Effective audiences, graph, finite chronology, engagement/repost constraints |
| DM | Durable sends, participant/request/block policy, realtime recovery |
| NOT, SAFE, DATA | Private notifications, reports, operator restrictions, export/deletion |
| NFR | Integrity, offline contracts, security, reliability and client-safe data |

Flutter's screen adaptation is client-side, but the API must provide paginated/structured data and accessible card text rather than fixed device-sized HTML layouts.

## 30. Implementation sequence

### Phase 0 — Contract and risk validation

- Approve Node/Nest adapter, PostgreSQL/Prisma, identity/storage, jobs, and hosting baseline.
- Define JWT/lifecycle behavior and prevent direct database API bypass.
- Spike OpenAPI→Dart generation, BIGINT/date serialization, managed database pooling, transaction locks, and sync cursor ordering.
- Confirm offline horizon, limits, retention, threat model, and numerical performance baselines.

### Phase 1 — Personal vertical slice

- Scaffold modules, configuration, validation, auth, policies, migrations, errors, and CI.
- Implement one complete water-record path: owner-scoped REST, idempotent command, change stream, tombstone, summary, retry/conflict tests.
- Integrate the Flutter slice before copying patterns to every mode.

### Phase 2 — Complete V1-A

- Add Read, Focus, and Money with domain/concurrency tests.
- Add private dashboard/progress and bootstrap/incremental sync.
- Implement data-lifecycle foundations and verified restore procedures.
- Pass personal integrity/ownership gates before inviting real sensitive records.

### Phase 3 — V1-B social publishing

- Add canonical card preparation/rendering/publication and private media.
- Add profiles/follows/feed/likes/comments/authorized links.
- Add durable notifications, blocking, reporting, restricted operator workflow, and privacy tests.
- No public social launch without moderation ownership and retention/privacy policies.

### Phase 4 — V1-C social completion

- Add repost source validation/invalidation.
- Add conversation requests, durable sends, Socket.IO hints, and recovery.
- Validate contact/block races, private-card references, push-token isolation, and cross-device client behavior.
- Pass the full V1 acceptance suite and operational readiness review.

These are implementation dependencies, not calendar estimates. Estimate after the high-risk spikes and provider decisions.

## 31. Risks and open decisions

### 31.1 Main risks

| Risk | Mitigation |
|---|---|
| Four domains plus social overwhelm delivery | Thin coherent slices and PRD stage gates |
| NestJS is mistaken for automatic correctness | Domain invariants, SQL constraints, transaction/concurrency tests |
| Offline sync loses or duplicates data | Stable operations, commit-safe cursors, receipts, tombstones, tested rebootstrap |
| Privacy leaks through media/cache/jobs | Current authoritative policies, private delivery, snapshot allowlists, worker rechecks |
| Manual money becomes misleading accounting | Exact explicit semantics; distinguish recorded balances, plans, and savings |
| Messaging abuse or moderation overload | Requests, rate controls, blocking, restricted evidence review |
| Managed-provider defaults expose tables/tokens | Privilege review, explicit token verification, secure server secrets |
| Async work is lost or repeated | Transactional outbox, idempotent consumers, provider-aware duplicate handling |
| Premature infrastructure growth | One modular codebase, measured scaling, no service per feature |

### 31.2 Decisions before scaffold/contract approval

1. Approve TypeScript/runtime baseline, Express adapter, dependency set, and package manager.
2. Approve PostgreSQL/Prisma and managed hosting/pooling/migration approach.
3. Select identity/storage providers; confirm token revocation and public-data exposure settings.
4. Approve REST/OpenAPI conventions, exact integer/date schemas, operation/revision rules, and client generation.
5. Approve the owner change-stream/snapshot design and offline retention horizon.
6. Confirm Money posting model, savings semantics, currency metadata, and reading/focus conflict UX.

### 31.3 Decisions before social/public production

7. Select Redis/BullMQ/Socket.IO/rendering and their deployment sizing/limits.
8. Approve account/post visibility-generation behavior and revocable media delivery.
9. Finalize public-link/anonymous rendering policy and third-party preview warnings.
10. Define DM request defaults, limits, message-history retention, and block race handling.
11. Approve age/region obligations, operator roles/MFA, moderation staffing, support/appeals.
12. Publish concrete export/deletion/backup/receipt/tombstone/log retention periods.
13. Set numerical rate limits, service targets, alert thresholds, RPO/RTO, and restore-drill cadence.
14. Approve analytics/consent, redaction, incident response, and signing/secret rotation procedures.

## 32. Backend readiness definition

A backend stage is ready when its supported clients can record and retrieve authorized data reliably, retries and concurrency cannot corrupt the defined domain invariants, privacy holds across every delivery surface, and the operational team can observe, recover, moderate, export, and delete data according to published policy.

**NestJS organizes the system. Tested contracts, transactions, and authorization make it trustworthy.**
