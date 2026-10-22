# Your Own — Admin CMS PRD & Next.js Specification

- **Version:** 0.3
- **Status:** Detailed draft; no admin scaffold implemented
- **Confirmed framework:** Next.js, as a separate application from the user website
- **Backend authority:** NestJS operator services; no direct domain-database access from the dashboard
- **Product authority:** [PRD.md](PRD.md)
- **Engineering overview:** [System architecture and cross-cutting documents](cookbook/architecture.md)
- **Related specifications:** [Backend](BACKEND_TECH_SPEC.md) · [User website](WEB_PRD.md) · [Mobile](MOBILE_TECH_SPEC.md)
- **Pending approval:** Role assignments, identity/MFA/session protocol, supporting packages, hosting, operating policies, and optional editorial CMS scope

> Operate and protect the product without turning administrative access into unrestricted access to people's private lives.

## Contents

- [1. Purpose and CMS definition](#1-purpose-and-cms-definition)
- [2. Confirmed direction and non-goals](#2-confirmed-direction-and-non-goals)
- [3. Staff users and jobs](#3-staff-users-and-jobs)
- [4. Release scope and sequencing](#4-release-scope-and-sequencing)
- [5. Roles and permission model](#5-roles-and-permission-model)
- [6. Staff authentication and sessions](#6-staff-authentication-and-sessions)
- [7. Information architecture](#7-information-architecture)
- [8. Recommended technical stack](#8-recommended-technical-stack)
- [9. Architecture and shared-code boundaries](#9-architecture-and-shared-code-boundaries)
- [10. Operational overview](#10-operational-overview)
- [11. User and account management](#11-user-and-account-management)
- [12. Report queue and evidence](#12-report-queue-and-evidence)
- [13. Moderation actions and appeals](#13-moderation-actions-and-appeals)
- [14. Support and data-request workflows](#14-support-and-data-request-workflows)
- [15. Job and delivery operations](#15-job-and-delivery-operations)
- [16. Staff administration and audit](#16-staff-administration-and-audit)
- [17. Optional editorial content management](#17-optional-editorial-content-management)
- [18. Configuration and template governance](#18-configuration-and-template-governance)
- [19. Responsive UX and accessibility](#19-responsive-ux-and-accessibility)
- [20. API integration and safe mutations](#20-api-integration-and-safe-mutations)
- [21. Privacy, rendering, and caching](#21-privacy-rendering-and-caching)
- [22. Security and production safeguards](#22-security-and-production-safeguards)
- [23. Observability and success measures](#23-observability-and-success-measures)
- [24. Testing and acceptance criteria](#24-testing-and-acceptance-criteria)
- [25. Deployment and delivery](#25-deployment-and-delivery)
- [26. Backend dependencies and open decisions](#26-backend-dependencies-and-open-decisions)
- [27. Admin readiness definition](#27-admin-readiness-definition)

## 1. Purpose and CMS definition

This document defines the internal web application used to operate Your Own. It is separate from the public/user-facing website but uses the same NestJS backend and authoritative product records.

**For the initial scope, “CMS” means an operational admin dashboard/back office:** users, moderation, reports, support, safe operations, and audit. A full editorial CMS for articles/help/policy publishing is an optional separately approved extension, not silently assumed from the word CMS.

The main PRD owns user behavior. The backend spec owns domain integrity and authorization. This document defines staff workflows, UI boundaries, security requirements, and proposed Next.js implementation.

**Must** applies when the corresponding capability ships. **Proposed** means a reviewable design/default. **Optional/later** does not become a launch commitment without approval.

## 2. Confirmed direction and non-goals

### Confirmed

- Next.js for both web experiences, implemented as separate applications.
- NestJS remains the backend for mobile, user web, and admin.
- Operational moderation/reporting must exist before public social launch.
- Administrative actions must respect private tracking data and appropriate review access.

### Non-goals

- A second backend, direct browser/database console, or unrestricted table editor.
- A place for staff to view/edit everyone's finances, tasks, water logs, or book notes.
- Searching all private DMs or impersonating users by default.
- Editing users' achievements, fabricating contributions, or silently changing goals.
- Public staff signup, client-selected roles, or an “admin” query parameter.
- Global bulk sanctions or a send-to-all notification tool in the first operational release.
- Arbitrary JavaScript/HTML/CSS execution through a CMS editor or poster template.
- An app-store console, cloud-provider console, secret manager, or replacement for production incident tooling.
- Blog, recipes, unrestricted page building, or advanced editorial publishing unless explicitly approved.

## 3. Staff users and jobs

| Staff audience | Jobs |
|---|---|
| Support | Find the correct account/case, see safe status, guide recovery/export/deletion, escalate |
| Moderator | Review assigned reports/evidence, record a policy decision, apply allowed actions |
| Operations | Inspect safe system/job status, retry eligible failures, escalate incidents |
| Administrator | Provision authorized staff, manage permitted roles, oversee restricted actions |
| Auditor | Review permitted audit metadata without automatic access to report contents/private data |
| Content editor, optional | Draft approved editorial material without gaining moderation or user-data access |

Primary journeys:
1. A moderator signs in with required MFA, claims a report, views only permitted evidence, applies a reasoned action, and leaves an audit trail.
2. Support locates a user by an approved identifier, sees account/recovery/deletion status, and provides guidance without seeing their balances.
3. Operations retries an eligible failed poster job without changing its snapshot or republishing content automatically.
4. An administrator revokes a staff grant and subsequent API calls fail even if the old page is still open.
5. An appeal reviewer evaluates the prior decision and records an approved reversal/uphold action.

## 4. Release scope and sequencing

Admin stages are independent of the user website's W0–W3 stages.

| Stage | Required capability | Release dependency |
|---|---|---|
| **A0: Safe social operations** | Staff bootstrap/access, MFA/session controls, minimal user lookup, reports/evidence, permitted moderation, audit, basic support/status | Required before public social features in mobile or web |
| **A1: Operational completion** | Safe job/delivery status, eligible retries, appeals workflow, staff management UI, data-request monitoring, operational overview | Expand alongside actual operating needs; staff provisioning remains secure even before its UI exists |
| **A2: Editorial/configuration extensions** | Approved pages/help/policy drafts, controlled template/flag interfaces | Optional; not required for core social launch |

A0 may use an audited out-of-band process for initial staff grants and a documented support/appeals channel. It must not use an unauthenticated dashboard, shared staff passwords, or unrestricted database browsing as a substitute.

Essential user-facing privacy/terms/support content can be code-managed initially; building an editorial CMS is not a dependency for publishing approved legal pages.

## 5. Roles and permission model

### 5.1 Authorization model

Use named server-side capabilities and scope, not frontend checks against a broad `isAdmin` boolean. The role names below are proposed groupings; NestJS returns the effective approved capabilities for the staff session.

Examples: `users.lookup`, `reports.read`, `reports.evidence.read`, `reports.assign`, `moderation.content.act`, `moderation.account.act`, `appeals.decide`, `jobs.read`, `jobs.retry`, `staff.manage`, `audit.read`, `content.publish`.

Grant least privilege. Staff approval/MFA does not automatically grant every capability. NestJS independently enforces role, target scope, current grant, and required assurance for each operation.

### 5.2 Proposed capability matrix

| Capability | Support | Moderator | Operations | Administrator | Auditor | Editor, optional |
|---|---|---|---|---|---|---|
| Minimal user lookup/status | Yes | Scoped | Scoped identifiers | With grant | No by default | No |
| Report evidence | No by default | Assigned/approved scope | No | Separate explicit grant | Metadata only | No |
| Remove/restrict content | No | With grant | No | With grant | No | No |
| Suspend/restore accounts | No | Separate elevated grant | No | With grant | No | No |
| Inspect safe job status | Scoped support view | No by default | Yes | With grant | Audit metadata | No |
| Retry eligible jobs | No | No | With grant | With grant | No | No |
| Manage staff grants | No | No | No | Dedicated elevated grant | No | No |
| Read audit metadata | Own/case scope | Case scope | Operations scope | With grant | Yes | Own content scope |
| Publish editorial content | No | No | No | Separate explicit grant | No | With grant |
| Browse raw finance/tracker records | No | No | No | No by default | No | No |
| Browse unrelated private messages | No | No | No | No by default | No | No |

Do not implement a broad Administrator override that bypasses the last two rows. Any future exceptional incident access requires a separately approved break-glass policy, restricted mechanism, and audit—not a hidden “view everything” screen.

### 5.3 Immediate effects

Changing/revoking a staff grant must affect subsequent backend operations promptly. A cached role in a browser cookie, localStorage, or layout is not continuing authorization.

Prevent self-escalation, uncontrolled self-approval, and removal of the last required recovery administrator under the approved policy. Initial privileged accounts are provisioned through a restricted audited process, not public signup.

## 6. Staff authentication and sessions

### Required controls

- Dedicated admin sign-in/entry with server-verified staff eligibility.
- Required MFA before access to operational private data/actions; no public social operations with an unaudited MFA bypass.
- Secure, HttpOnly, host-only admin session cookie, distinct from the user website session scope.
- Provider credentials held server-side, not browser localStorage or client-readable “admin tokens.”
- Session rotation, inactivity/absolute expiry, logout, and grant/session revocation.
- Fresh step-up assurance for high-impact actions such as staff grants or major account restrictions.
- Safe redirects and verified OAuth/recovery callback state.
- Strict Origin/CSRF protection for cookie-authenticated mutations. SameSite does not fully isolate sibling subdomains.

**Proposed starting session policy:** 15-minute idle timeout, 8-hour absolute session, and fresh authentication within 5 minutes for selected high-impact actions. Validate operational usability/provider support before adopting these numbers.

### Backend assurance boundary

A normal user JWT or a frontend claim that MFA succeeded must not authorize operator endpoints. NestJS must validate current staff grants and trusted identity/session evidence of required MFA/freshness.

If the provider cannot supply the required evidence directly, approve a backend-verified staff-session mechanism. Do not forward browser-controlled `x-admin`/`x-mfa` headers and treat them as trusted.

Sign-in failure, expired assurance, revoked role, and restricted scope need safe distinct workflows without revealing private account existence to unauthenticated visitors.

## 7. Information architecture

Proposed admin origin: `admin.your-domain.com`; actual domains remain open. Separate deployment is recommended, not a substitute for server authorization.

| Illustrative route | Surface |
|---|---|
| `/login`, `/auth/callback`, `/verify` | Staff identity/assurance flows |
| `/dashboard` | Role-scoped operational overview |
| `/users`, `/users/:userId` | Minimal permitted account lookup/status/actions |
| `/reports`, `/reports/:reportId` | Queue, assignment, evidence, decision |
| `/moderation/actions/:actionId` | Decision details/timeline |
| `/appeals`, `/appeals/:appealId` | Approved appeal workflow |
| `/operations/jobs`, `/operations/jobs/:jobId` | Safe job state and permitted retry |
| `/operations/health` | Restricted aggregate service indicators |
| `/data/requests` | Export/deletion status metadata, not users' export contents |
| `/staff`, `/staff/:staffId` | Dedicated staff-management permission |
| `/audit` | Authorized audit search/view |
| `/content`, `/content/:documentId` | Optional editorial module |
| `/configuration` | Optional governed configuration, never secrets |

Navigation includes only granted capabilities, but hidden navigation never replaces backend denial. Direct URLs and stale browser tabs must receive the same checks.

Keep raw emails, private evidence, reasons containing personal information, secrets, and sensitive search terms out of URLs/history/analytics. Use appropriately protected search requests and in-memory filter state where needed.

## 8. Recommended technical stack

| Concern | Proposal | Constraint |
|---|---|---|
| Framework | Next.js App Router | Framework confirmed; exact version compatibility pending |
| Language | TypeScript strict | Runtime operator requests remain validated by NestJS |
| Styling/components | Tailwind CSS, shadcn/ui, owned semantic tokens | Reuse primitives without importing user-app session behavior |
| Server state | TanStack Query | Session/capability-scoped caches cleared on expiry/revocation |
| Forms | React Hook Form + Zod | Reasons, confirmations, field validation; not authorization |
| Tables | TanStack Table where useful | Server pagination/filtering; no full-database downloads |
| API | Generated TypeScript OpenAPI client | Operator contracts; explicit safe response DTOs |
| Staff sessions | Reviewed provider-aware server adapter/store | MFA/assurance verified independently by NestJS |
| Tests | Component tests, Playwright, accessibility checks | Role, CSRF, evidence, concurrency, safe operations |
| Diagnostics | Redacted technical telemetry | No report/evidence/body/session replay by default |

Use the same approved compatible frontend baseline as the user website when practical, while permitting independent releases. Supporting libraries and exact versions remain proposals.

## 9. Architecture and shared-code boundaries

```text
Staff browser
     |
Next.js admin: protected rendering + narrow session/BFF layer
     |
NestJS operator APIs
     |
Current staff grant + MFA assurance + capability/scope checks
     |
Restricted application services, audit, permitted evidence/status
```

### 9.1 Application map

Recommended location: `apps/admin/`, with an independent origin, build, and staff session. These paths are proposals, not scaffolded files. A0/A1/A2 remain staged; optional folders are not a commitment to build an editorial CMS now. See the [cross-application ownership map](cookbook/architecture.md#51-application-and-shared-package-ownership).

```text
apps/admin/
  README.md                            # Setup, staff-access boundaries, navigation
  package.json
  next.config.ts                       # Matched to the selected Next.js version
  tsconfig.json
  .env.example                         # Placeholders only; no staff credentials
  public/
    fonts/
    images/                            # Public static assets; never evidence/exports
  docs/
    FEATURE_INDEX.md
    ROUTE_MAP.md                       # Screen/BFF -> operator operation
    CAPABILITY_MAP.md                  # Operation -> capability/scope/assurance
    COMPONENT_CATALOG.md
    TRACEABILITY.md
    decisions/
  src/
    app/
      layout.tsx
      page.tsx                         # / -> dashboard or sign-in using staff context
      not-found.tsx
      global-error.tsx
      (auth)/
        login/page.tsx
        verify/page.tsx                # Selected MFA/step-up flow
      auth/callback/route.ts
      (protected)/
        layout.tsx                     # Staff shell; not sole access enforcement
        loading.tsx
        error.tsx
        dashboard/page.tsx
        users/
          page.tsx
          [userId]/page.tsx
        reports/
          page.tsx
          [reportId]/page.tsx
        moderation/actions/[actionId]/page.tsx
        appeals/
          page.tsx
          [appealId]/page.tsx
        operations/
          health/page.tsx
          jobs/
            page.tsx
            [jobId]/page.tsx
        data/requests/page.tsx
        staff/
          page.tsx
          [staffId]/page.tsx
        audit/page.tsx
        content/                       # Optional A2 only
          page.tsx
          [documentId]/page.tsx
        configuration/page.tsx         # Optional A2 only
      api/
        session/route.ts
        bff/                           # Explicit staff-only operations
          reports/
            route.ts
            [reportId]/route.ts
          moderation-actions/route.ts
          operations/jobs/[jobId]/retries/route.ts
    features/
      auth/
      dashboard/
      users/                           # Minimal authorized account status/support
      reports/                         # Queue, assignment, scoped evidence
      moderation/                      # Decision form/results, not policy engine
      appeals/
      operations/
      data-requests/
      staff/
      audit/
      content/                         # Optional A2
      configuration/                   # Optional A2
    components/
      shell/
      navigation/
      adaptive/
      ui/
      tables/
      forms/
      confirmations/
      states/
    server/                            # Server-only modules with import enforcement
      api/
        operator-client.server.ts      # Fixed backend origin; staff contract entry
      auth/
        staff-session.server.ts
        staff-session-store.server.ts
        callback.server.ts
      access/
        require-staff.server.ts
        require-capability.server.ts   # Uses trusted current backend context
        require-assurance.server.ts
      bff/
        staff-mutation-guard.server.ts # Session, Origin/CSRF, methods/body limits
        response-mapper.server.ts
      security/
      config/
      preferences/                     # Admin-only appearance preference context
      diagnostics/
    lib/                               # Browser-safe helpers, never access authority
      http/
        admin-bff.client.ts
      query/
      formatting/
    providers/
      query-provider.client.tsx
    theme/
      appearance-provider.client.tsx
      appearance-preference.ts
    styles/
      globals.css
      tokens.css                       # Same semantic design system, admin density
  test/
    app/
    features/
    components/
    server/
    contracts/
    e2e/
    fixtures/                          # Synthetic staff/cases only
    support/
  scripts/
```

`(protected)` is a route group, not a URL prefix or a security boundary: the report page is `/reports/:reportId`, not `/protected/reports/:reportId`. Every loader/BFF/mutation checks the current staff context and NestJS independently enforces the operation. No public staff-signup route exists. Add further BFF/detail routes only with approved operator contracts and record them in `ROUTE_MAP.md`.

### 9.2 Feature layout — reports and moderation

```text
src/features/reports/
  README.md
  index.ts                             # Deliberate browser-safe exports only
  types.ts                             # Safe report-view types, not raw message records
  screens/
    report-queue-screen.client.tsx
    report-detail-screen.tsx
  components/
    report-table.client.tsx
    evidence-panel.tsx
    case-timeline.tsx
  forms/
    assignment-form.client.tsx
  hooks/
    use-report-queue.ts
  api/
    reports.client.ts                  # Same-origin admin BFF only
  server/
    get-report.server.ts               # Current scoped operator read
    list-reports.server.ts
  mappers/
    report-view.mapper.ts

src/features/moderation/
  README.md
  index.ts                             # Approved decision-panel public UI contract
  types.ts
  components/
    moderation-decision-panel.client.tsx
  forms/
    moderation-action-form.client.tsx
    moderation-action.schema.ts        # Input feedback, never permission authority
  hooks/
    use-submit-moderation-action.ts
  api/
    moderation.client.ts
  server/
    submit-moderation-action.server.ts # Validated forwarding to operator API
```

Reports owns queue/evidence presentation; Moderation owns decision-form/result presentation. A report screen composes the exported moderation panel rather than importing its private hooks/server loader. The backend `modules/moderation/` remains the single authority for both workflows; frontend feature boundaries do not create backend microservices.

| Concern | Owner | Boundary |
|---|---|---|
| Page routing and safe initial rendering | `src/app/` | Thin composition, not a case-management service |
| Queue, evidence and decision UI | `src/features/` | Display only currently permitted projections; no unrestricted private records |
| Staff session/assurance/BFF | `src/server/` | Credentials stay server-side; backend verification remains mandatory |
| Generic tables/forms/confirmation UI | `src/components/` | Reusable presentation, not an `isAdmin` authorization policy |
| Capability-based navigation | Shell plus safe capability projection | Visibility hint only; direct requests are independently checked |
| Evidence/audit persistence and decisions | NestJS modules | No Prisma/domain database access from Next.js |

Server entry modules use `import 'server-only'` and tested import boundaries. Interactive components use `'use client'`; file suffixes document intent but do not enforce security. Never export server-only modules from a client-facing barrel or serialize credentials/whole evidence objects to an unrelated component.

### 9.3 Route and operator mapping

Routes and contracts remain draft. Missing backend detail queries must be approved before their frontend pages are enabled; do not work around a missing API with database access.

| Browser URL / method | Next.js path under `src/app/` | Owner / backend connection |
|---|---|---|
| `/` | `page.tsx` | Safe redirect to dashboard or sign-in using current staff context |
| `/login`, `/verify` | `(auth)/login/page.tsx`, `(auth)/verify/page.tsx` | Staff identity and approved assurance flow |
| `/reports` | `(protected)/reports/page.tsx` | `features/reports/`; `GET /v1/operator/reports` |
| `/reports/:reportId` | `(protected)/reports/[reportId]/page.tsx` | Scoped `GET /v1/operator/reports/:id` |
| `/users/:userId` | `(protected)/users/[userId]/page.tsx` | Minimal `GET /v1/operator/users/:id`, not a tracker dashboard |
| `/operations/jobs/:jobId` | `(protected)/operations/jobs/[jobId]/page.tsx` | Safe `GET /v1/operator/jobs/:id` |
| `/staff/:staffId` | `(protected)/staff/[staffId]/page.tsx` | Dedicated staff-management contract/capability; detail contract approval required |
| `/audit` | `(protected)/audit/page.tsx` | Scoped `GET /v1/operator/audit` |
| `POST /api/bff/moderation-actions` | `api/bff/moderation-actions/route.ts` | `POST /v1/operator/moderation-actions` |
| `POST /api/bff/operations/jobs/:jobId/retries` | `api/bff/operations/jobs/[jobId]/retries/route.ts` | `POST /v1/operator/jobs/:id/retries` |

A schema/capability entry is required for each method, not just each URL. `CAPABILITY_MAP.md` documents the approved backend capability, scope, assurance/freshness, audit expectation, and failure behavior. It does not create an independent frontend role system.

### 9.4 Review and decision paths

**Server-rendered evidence read:**

```text
app/(protected)/reports/[reportId]/page.tsx
  -> features/reports/server/get-report.server.ts
  -> server/access/require-staff.server.ts
  -> server/api/operator-client.server.ts
  -> NestJS moderation transport
  -> current grant + assurance + evidence scope + access audit
  -> minimal authorized report view
```

**Browser decision:**

```text
features/moderation/forms/moderation-action-form.client.tsx
  -> hooks/use-submit-moderation-action.ts -> api/moderation.client.ts
  -> app/api/bff/moderation-actions/route.ts
  -> server/bff/staff-mutation-guard.server.ts
  -> features/moderation/server/submit-moderation-action.server.ts
  -> server/api/operator-client.server.ts
  -> NestJS POST /v1/operator/moderation-actions
  -> authorized application transaction + audit
```

- Preserve target, required reason, expected revision, and stable operation ID. A frontend check or a stale layout grant never authorizes a backend decision.
- Cookie-authenticated handlers enforce Origin/CSRF, method/body constraints, and fixed allowlisted destinations. No arbitrary operator-path proxy and no browser-controlled MFA/role headers treated as trusted evidence.
- Staff credentials/session-store adapters remain separate from the user website. A least-privilege session store is not permission to read domain tables; never import the backend Prisma client here.
- Server Components use the operator adapter directly rather than HTTP-looping through their own BFF. Evidence and operational reads follow explicit private/no-store/session-safe policies; no static public evidence generation or public image optimizer.
- Shared UI packages cannot import staff screens, evidence loaders, capability services, cookies, or credentials. Shared API contracts have explicit operator entry points; the user website must not import them.
- Small/tablet/desktop layouts share the same case selection, reason draft, query state, and backend permissions. Do not create independent device-specific feature implementations.
- Optional Server Actions receive the same security/idempotency controls as BFF handlers. Do not add tRPC or a separate headless CMS backend merely to duplicate NestJS services.

### 9.5 Tests and traceability

- Examples: `test/features/moderation/forms/moderation-action-form.test.tsx`, `test/server/access/require-assurance.test.ts`, `test/app/api/bff/moderation-actions/route.test.ts`, and `test/e2e/report-review.spec.ts`.
- Browser/security tests include low assurance, revoked staff grants, scope denial, stale case revision, conflicting reviewers, CSRF, no-store/back-forward restoration, and unknown mutation outcomes.
- `FEATURE_INDEX.md` maps features and A0/A1/A2 stages; `ROUTE_MAP.md` maps page/BFF paths to feature and operator contracts. `COMPONENT_CATALOG.md` links shared design families to admin/local implementations and tests.
- `TRACEABILITY.md` links ADM/BE/SEC/product requirements to files, tests/evidence, and release stage. Planned/In progress/Implemented/Verified are distinct; Verified needs actual evidence, not only a screenshot.
- Feature READMEs and navigation indexes link root specifications rather than copying capability rules or retention policies. Update them with route/module/contract changes and use synthetic fixtures only.

## 10. Operational overview

Show role-authorized aggregate indicators:
- Pending/aged reports and assigned workload.
- Moderation/appeal status counts.
- Failed/lagging jobs and deletion/export request status.
- Safe API/worker/storage delivery health indicators where available.
- Links to the permitted action queues.

No individual wealth rankings, private habit analytics, top spenders, message-content trends, or admin feed of everyone's activity.

Distinguish stale/unavailable metrics from zero. Read-only widgets must not trigger retries or policy actions simply by rendering. All environment-sensitive pages display an unmistakable environment indicator.

## 11. User and account management

### Minimal lookup

Approved fields may include user ID, username/display name, account visibility/lifecycle status, creation date, and scoped support/moderation history. Email or identity-provider status requires an explicit support permission and masked display where possible.

- Search is rate-limited, purposeful, and backend-scoped.
- No bulk full-user download or unbounded autocomplete.
- Results contain only permitted fields; hiding a column in CSS is not data minimization.
- Account detail is operational context, not a mirror of the user's private dashboard.

### Permitted actions

Depending on capability: restrict posting/contact, suspend/restore account access, remove prohibited profile content, or escalate a support issue through approved backend workflows.

Each action specifies target, current state/revision, reason/policy code, case reference where applicable, intended effect, and operation ID. High-impact actions require confirmation and current assurance.

Do not:
- Reset a user's savings, alter transactions, complete tasks, or change their water target.
- Reveal or set passwords directly.
- Log in as the user or export their private data by default.
- Confuse suspension with account deletion.
- Restore a role/follow relationship automatically when undoing a restriction.

## 12. Report queue and evidence

### Queue

Support server-paginated filtering by approved target type, status, severity, assigned staff, and date. Keep sensitive free-text search out of browser URLs/logs.

Proposed case states: New, Assigned, In Review, Actioned, Dismissed, Escalated. Appeal state is a linked process, not an automatic rewrite of the original case history.

Claim/reassign uses revision-aware backend actions. Two reviewers cannot unknowingly own conflicting edits based on the same case revision.

### Evidence view

- Show reported target and necessary approved context only.
- Private DM evidence is intentionally submitted/approved material, not an unrestricted conversation search.
- Raw tracking records remain unavailable even if a public progress card was reported.
- Historical report snapshots and current source visibility are distinguished clearly.
- Deleted/changed content has accurate availability indicators; do not resurrect it into the public app.
- Access to sensitive evidence is authorized and audited at the backend.
- Untrusted text is escaped/sanitized; no active HTML/remote embeds in evidence.
- Do not put evidence bodies in generic logs, browser persistence, notifications, or analytics.

The reporter's identity/contact details are shown only when needed and permitted. Reviewers must not infer guilt from a report count alone.

## 13. Moderation actions and appeals

### Decision flow

1. Claim/open a permitted case and verify target/context.
2. Select an allowed policy outcome/action.
3. Enter the required reason and any separate user-facing explanation.
4. Preview exact target, effect, duration if supported, and restoration implications.
5. Complete step-up confirmation if required.
6. Submit with stable operation identity and expected current revision.
7. Display accepted action/audit reference or a recoverable conflict; do not silently repeat it.

Actions can include dismiss/escalate, remove/hide violating content, apply an approved account restriction, and permitted reversal/restoration. The exact action catalog/severity policy must be approved before implementation.

### Appeals

- Link the appeal to the original action, reason, and permitted evidence.
- Record reviewer, rationale, outcome, and any new reversal action.
- Preserve original audit history; an appeal does not erase the prior decision record.
- Require a different reviewer for designated high-impact decisions if that policy is approved.
- Do not reveal unrelated private content while investigating an appeal.

### Safety controls

No broad bulk-sanction UI in A0. Prevent actions on the wrong target after a table refresh, keyboard selection change, or stale detail pane. User-facing explanations must not accidentally reveal private report evidence or staff-only notes.

## 14. Support and data-request workflows

Support can view permitted account/case status and guide the user through recovery, visibility, notification, export, or deletion flows.

For exports/deletion:
- Show request ID, owner reference, status, timestamps, safe failure category, and approved next action.
- Do not provide staff a default link to download the user's export contents.
- Do not generate a personal export on behalf of anyone merely because a staff member can look up the account.
- Require authenticated owner workflows and appropriate backend policy for actual data release.
- Escalation/retry preserves the original request/operation identity and audit context.
- Cancellation/restoration is available only if the approved lifecycle policy genuinely supports it.

Contact/support tickets and appeal intake may use an approved external system initially. Integrating a full ticketing suite or global user impersonation is not required.

## 15. Job and delivery operations

### Safe inspection

Show job ID/type, owner/case reference where permitted, state, attempt count, timestamps, safe error category/correlation ID, and permitted next actions.

Never expose raw queue payloads, provider credentials, private message bodies, financial source fields, internal stack traces containing secrets, or unrestricted storage URLs.

### Retry/cancel policy

- Retry only approved job categories through NestJS, with reason, operation ID, current job state, and required capability.
- Reject stale/already-completed/ineligible retries rather than creating duplicate effects.
- Render retry operates on the approved immutable snapshot/template version; it must not change user metrics or publish a draft automatically.
- Push retry rechecks current permissions/preferences/blocking; duplicate provider delivery limitations remain documented.
- Export/deletion retries follow the lifecycle service's rules, not a generic “run again” command.
- Cancel only states/job types where safe cancellation exists. It must not pretend to roll back an accepted financial transaction.
- API/worker incident escalation is distinct from job retry.

No arbitrary command execution, SQL console, freeform job payload editor, or unrestricted cloud-console link that bypasses staff roles.

## 16. Staff administration and audit

### Staff lifecycle

Dedicated capability holders can invite/approve staff, assign permitted roles/scopes, revoke grants/sessions, and inspect safe access history.

- No public staff registration or email-domain-only automatic promotion.
- Initial privileged access is provisioned out-of-band with audit and recovery planning.
- Role changes require fresh assurance, explicit capability, and a reason.
- A staff member cannot grant themselves broader permissions through profile edits or client data.
- Prevent accidental loss of the last required recovery administrator.
- High-impact approval/dual-control rules are policy decisions; implement them before enabling the affected action.

### Audit records

Record actor/staff grant/session context, target type/ID, action, timestamp, safe reason/reference, outcome, and permitted minimal before/after state.

- Audit records are append-only at the application/API permission boundary.
- Do not claim cryptographic tamper-proof storage; database administrator access requires separate operational controls.
- Never include tokens, full financial payloads, message bodies, or unneeded evidence copies in ordinary audit events.
- Audit viewing/export is permission-scoped and itself audited where required.
- No ordinary UI for deleting or rewriting past actions.

## 17. Optional editorial content management

**Not automatically part of A0/A1.** Approve this module only if the team wants editors to maintain content without code releases.

Candidate content types:
- Help/FAQ articles.
- Approved product-information sections.
- Versioned privacy/terms/support documents with named policy ownership.
- Carefully controlled service notices.

Candidate workflow: Draft → Review → Approved → Published → Archived, with version history, preview, attribution, timestamps, and explicit rollback/new-version semantics.

Requirements if enabled:
- Dedicated content capabilities; an editor does not gain user/moderation access.
- Sanitized Markdown or constrained blocks, not arbitrary executable code.
- Reviewed links/assets, no unrestricted iframes/scripts, safe image handling.
- Private authenticated previews with no public indexing/caching of drafts.
- Scheduled publication only through durable jobs and approved timezone behavior.
- Public Next.js pages read approved published versions through an explicit content contract.
- Legal/policy documents require designated approval and truthful effective dates; ordinary copy edits cannot silently replace historical legal versions.

Do not add a second general backend simply to build a text editor. A headless CMS product may be evaluated later against actual editorial needs; its identity/data boundaries would require a separate decision.

## 18. Configuration and template governance

Configuration management is optional and must use a typed allowlist, not an unrestricted key-value database editor.

Potential reviewed capabilities:
- Read approved feature availability/kill-switch state.
- Inspect template/version catalog and rendering availability.
- Manage approved default catalogs for new users.
- Configure safe operational notice templates under permission/review.

Safeguards:
- Feature flags never replace backend authorization or mutate existing private records.
- Global defaults must not silently overwrite existing user goals, budgets, currency, or target history.
- Old mobile versions and API compatibility are considered before enabling a feature.
- Poster templates remain reviewed code/assets/schema versions; no user-entered renderer JavaScript/SQL.
- Secrets, credentials, raw connection strings, and private keys remain outside the CMS.
- No generic send-to-all notification button in initial scope. Any later broadcast needs approved audience, purpose, rate limits, quiet-hours behavior, and audit.
- Production changes require confirmation/version checks and a documented rollback plan.

## 19. Responsive UX and accessibility

Use the [Your Own design system and admin component coverage](cookbook/design-system.md#102-admin-component-coverage), including the light/dark themes. Provide System / Light / Dark with an admin-origin-local preference, separate from user-web sessions/preferences. Theme tables, evidence views, confirmations, severity labels, and all operational states; preserve selected case, drafts, focus, and permission boundaries on change. Neutral severity styling requires explicit words/icons, not shade alone.

Support the four proposed size classes using available **CSS pixels**: Small below 600, Medium 600–839, Large 840–1199, Largest 1200+.

- Small: drawer/compact navigation, stacked case details, card-like row views or deliberate table scrolling.
- Medium: rail where usable, compact split panes only when content fits.
- Large/Largest: bounded table/detail workspaces with readable evidence and confirmation forms.
- Do not stretch evidence text across an entire large monitor or force every table column into a phone viewport.
- Core review/support actions remain reachable on phone/tablet; no hover-only action menus.
- Preserve selected case, filters, entered reason, and unsaved decision draft across resizing.
- Sticky controls cannot hide content/validation under virtual keyboards or short landscape windows.
- Keep environment/target/effect visible during high-impact confirmation.
- Semantic headings/landmarks, keyboard focus, labels, dialog focus restoration, readable contrast, reduced motion, and accessible statuses.
- Target applicable WCAG 2.2 AA, 200% text/zoom and reflow checks; primary touch controls follow the shared accessible target policy.
- Every icon-only action has a meaningful label and irreversible actions are not distinguished by color alone.

Exact table density and shortcuts are usability decisions, not reasons to drop accessibility or server permissions.

## 20. API integration and safe mutations

Use the same approved generated API infrastructure as the user website, with distinct operator DTOs and session context. Normal public endpoints do not become privileged through a frontend flag.

- Backend validates staff capability, target scope, MFA/freshness, and current resource revision.
- Reasons/action codes are required and length/content validated.
- Stable operation IDs protect uncertain-result retries.
- Revision conflicts preserve the staff draft and require current-state review.
- Disable duplicate submission while pending, but do not rely on disabled buttons as idempotency.
- Confirmation shows exact target/effect; network failure does not imply the action failed to commit.
- Bulk operations are disabled until separate permission, review, and rollback/partial-result design exists.
- Poll job/case status with bounded intervals; no realtime requirement for initial admin.
- Paginate/filter on the backend; never download all users/messages to filter client-side.
- Log technical correlation IDs, not raw request/evidence bodies.

Next.js BFF endpoints are allowlisted and do not accept arbitrary backend URLs or elevated service-role requests from browser-supplied parameters.

## 21. Privacy, rendering, and caching

All staff HTML/API/evidence responses use authenticated dynamic/private handling with an explicit no-store policy appropriate to the selected Next.js version. Static fingerprinted code/assets may be cacheable; they must contain no embedded staff/private data.

- No global cached staff/session/evidence query results.
- No evidence in static generation, shared layouts, metadata, JSON-LD, image optimizer URLs, or public prefetch payloads.
- Query clients/dehydrated state are request/session scoped and minimized.
- Clear known-revoked staff state immediately and revalidate on focus/resume as appropriate.
- Logout, account switch, browser back/forward, and stale tabs must not restore sensitive content before access is checked.
- No persistent localStorage/IndexedDB evidence/draft cache by default; in-memory unsaved reasons are cleared under the approved session policy.
- Private evidence/media uses backend-authorized delivery, not permanent bucket URLs.
- No service worker caching of admin data.
- Disable third-party input capture, automatic screenshots, and session replay on sensitive screens.

Robots/noindex directives apply to admin pages, but are not a security boundary. DNS obscurity and a separate subdomain do not secure an operator API.

## 22. Security and production safeguards

- MFA, least-privilege grants, fresh step-up, secure separate sessions, CSRF/Origin checks, safe redirects.
- NestJS independently verifies staff assurance/grants, even if Next.js route protection is bypassed.
- Never put an operator service key in the browser or use one broad server key to impersonate arbitrary staff without scoped authorization.
- Restrictive reviewed CSP, safe text rendering, controlled assets/connect origins, no arbitrary embeds.
- Separate development/staging/production sessions/resources and conspicuous environment labels.
- Optional network/IP/VPN restrictions are defense in depth, not substitutes for staff identity/authorization.
- Audit sensitive views/actions and alert on suspicious repeated denials or privilege changes.
- Session timeout warning preserves permitted input only as policy allows; it must not allow continuing an action after expiry.
- High-impact actions require the approved confirmation/step-up/approval controls.
- Access reviews, staff offboarding, incident escalation, and emergency recovery are documented before production.

## 23. Observability and success measures

### Technical signals

Redacted page/action failures, API error codes, session/assurance failures, job-status latency, stale revision conflicts, and denied actions. No evidence bodies, private search strings, secrets, or broad screen recording.

### Operational outcomes

- Report time-to-triage/time-to-decision, grouped by relevant case class.
- Appeal handling and reversal/error rates.
- Failed-job backlog and safe recovery outcomes.
- Deletion/export request aging and support resolution.
- Staff access-review/offboarding completion and unauthorized-action prevention.

Numeric staffing/service targets require approval. Do not incentivize moderators solely to close cases quickly or maximize sanctions. Audited decision quality and privacy matter alongside throughput.

## 24. Testing and acceptance criteria

### Required coverage

- Capability matrix tested against real backend denial, not only hidden UI.
- Ordinary user credentials, low-assurance staff sessions, expired sessions, and revoked grants cannot access operator data/actions.
- CSRF, sibling-subdomain Origin checks, callback/redirect validation, no client token leakage.
- Queue claim/decision concurrency, lost-response retries, stale action targets/revisions.
- Restricted evidence scope, safe rendering, private-media access, audit minimization.
- Safe job retry eligibility/idempotency; no duplicate publications or repeated financial effects.
- No-store/SSR/metadata/client-cache/back-forward/session-switch privacy.
- Responsive/adaptive matrices including 320 px, tablet, large monitor, breakpoint boundaries, large text/zoom, keyboard-only review, and short-height forms.
- Staff offboarding, production environment indicators, supported restore/recovery procedures.

| ID | Required proof |
|---|---|
| ADM-01 | Public/ordinary user sessions cannot access staff data by visiting direct URLs or invoking APIs |
| ADM-02 | Required MFA/fresh assurance and current capabilities are verified server-side |
| ADM-03 | Minimal user lookup does not expose raw finance/tracking records |
| ADM-04 | Report evidence is scoped and sensitive evidence access is audited |
| ADM-05 | Two reviewers/stale tabs cannot silently overwrite a case decision |
| ADM-06 | Retrying an uncertain moderation action produces one accepted action/audit effect |
| ADM-07 | Blocking/removal/suspension uses the shared backend policy and affects user delivery surfaces |
| ADM-08 | Staff cannot edit user achievements, transactions, goals, or unrelated private DMs |
| ADM-09 | Eligible job retries preserve identity/current permissions and cannot republish/change a user's card silently |
| ADM-10 | Revoked staff grants stop subsequent backend actions despite an open browser tab |
| ADM-11 | Staff administration prevents self-escalation and follows required recovery/approval safeguards |
| ADM-12 | Sensitive content does not leak through SSR/caches/metadata/logs/local persistence |
| ADM-13 | Logout/session expiry/back-forward restoration does not reveal previous staff evidence |
| ADM-14 | Core workflows remain accessible across the four sizes, keyboard navigation, and large text |
| ADM-15 | Export/deletion status monitoring does not grant access to users' export files |
| ADM-16 | Optional content/configuration, if enabled, is versioned/sanitized/governed and cannot execute arbitrary code |

These are acceptance requirements, not tests executed by writing this document.

## 25. Deployment and delivery

- Separate `apps/admin` deployment/origin from `apps/web`, sharing only reviewed packages.
- Next.js server/session/BFF runtime is required for the proposed model; a static export is insufficient.
- NestJS owns operator business services, permissions, durable actions, and audit.
- Sessions/secrets/allowed origins are environment- and application-specific.
- Configure cookies, headers, no-store behavior, identity callback URLs, private media, and restricted diagnostics deliberately.
- CI: frozen install, lint/format/type checks, unit/component tests, contract generation, production build, Playwright role/CSRF/cache/adaptive suites, dependency/secret review.
- Test staging with synthetic reports/users, not copied private production datasets.
- A0 production review includes staff onboarding/MFA, support/moderation ownership, report handling, audit access, incident escalation, and a recovery path.
- Admin can ship before the full user website; it does not need a second NestJS service or a separate financial database.

No application folders, package installations, domains, or provider resources have been created as part of this specification.

## 26. Backend dependencies and open decisions

### Backend capabilities required

Some are already outlined in the backend draft; others need contract extension before implementation:
- Trusted staff session/capability/assurance resolution and secure provisioning/revocation.
- Minimal staff account lookup with field-level policies.
- Report queue, assignment/revisions, restricted evidence access, moderation/appeal actions.
- Safe operational job/status/retry controls and account-data-request status metadata.
- Restricted audit query/view and evidence-access auditing.
- Optional editorial/configuration APIs only after scope approval.

New operator endpoint names must be approved in the backend contract. The dashboard must not work around a missing capability by querying domain tables or using broad storage keys directly.

### Decisions before A0

1. Approve roles/capabilities/scopes, MFA provider evidence, session/step-up policy, and staff recovery/provisioning.
2. Approve report taxonomy, permitted action catalog, reasons, evidence context, assignment/conflict behavior, and appeal channel.
3. Approve minimal lookup fields and support/privacy boundaries.
4. Approve Next.js supporting packages/version, browser baseline, domains/hosting, no-store/CSRF integration, and admin origin.
5. Establish named moderation/support operators, audit retention, offboarding, access reviews, and incident handling.

### Decisions before extensions

6. Approve job retry/cancel catalog, support/data-request actions, and required operational dashboards.
7. Decide whether editorial CMS is needed and which content types/workflow/owners are authorized.
8. Approve any configuration/template/notice capability with versioning, review, rollback, and privacy checks.
9. Set quantitative service targets, staffing expectations, monitoring, and privileged-action approval thresholds.

## 27. Admin readiness definition

An admin stage is ready when authorized staff can perform its declared workflows safely, inappropriate access is rejected by NestJS, sensitive evidence stays scoped and audited, actions survive retries without duplication, and the operating team has a usable support/moderation/recovery process.

**Two web applications. One authoritative backend. Administrative power is limited, explicit, and accountable.**
