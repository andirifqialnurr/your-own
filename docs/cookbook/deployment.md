# Your Own — Deployment & Operations Plan

- **Version:** 0.3
- **Status:** Proposed runbook/topology; no cloud resources, containers, workflows, or store builds provisioned
- **Related:** [Architecture](architecture.md) · [Schema](schema.md) · [Security](security.md) · [Testing](testing.md)

Hosting vendors, regions, resource sizes, exact versions, numerical service targets, RPO/RTO, retention, and costs require approval. This is not a copy-and-run production installation guide. The [M00-T06 baseline review](provider-baseline-review.md#4-full-t06-acceptance-register) tracks the stack and pending hosting/region/budget/secret/recovery answers. [Decision 0013](decisions/0013-provider-and-session-directions.md) subsequently accepts scoped DB/ORM/provider/session directions; physical hosting/session store, exact versions and operations remain undecided. No resource is provisioned.

## Contents

- [1. Deployment units](#1-deployment-units)
- [2. Environments and domains](#2-environments-and-domains)
- [3. Configuration and secrets](#3-configuration-and-secrets)
- [4. Build and CI pipeline](#4-build-and-ci-pipeline)
- [5. Release and migration order](#5-release-and-migration-order)
- [6. Health and graceful degradation](#6-health-and-graceful-degradation)
- [7. Workers, schedules, and realtime](#7-workers-schedules-and-realtime)
- [8. Storage and delivery](#8-storage-and-delivery)
- [9. Mobile distribution](#9-mobile-distribution)
- [10. Backups and restore](#10-backups-and-restore)
- [11. Rollback and incidents](#11-rollback-and-incidents)
- [12. Capacity and launch checklist](#12-capacity-and-launch-checklist)

## 1. Deployment units

| Unit | Runtime | Lifecycle |
|---|---|---|
| Flutter | Android/iOS application | Signed versioned store/test distribution |
| NestJS API | Persistent Node process/container | Stateless request instances plus DB-backed domain state |
| NestJS worker/dispatcher | Persistent process from shared backend codebase | Durable leases, bounded jobs, graceful interruption |
| User web | Next.js server-capable deployment | Public pages + authenticated rendering/session/BFF |
| Admin | Separate Next.js server-capable deployment | Staff session/BFF and restricted workflow UI |
| PostgreSQL | Proposed managed DB | Backups/PITR, migrations, connection budgets |
| Redis/BullMQ | Proposed queue/coordination service | Added when workloads require; not domain truth |
| Identity/storage/push | Approved managed services | Explicit environment policies, credentials, and ownership |

Start with a simple persistent API, managed persistence, and a worker when required. No V1 Kubernetes/service-per-mode requirement. Next.js can use suitable serverless hosting, but NestJS sockets/workers do not become request-scoped functions as a result. Static web export is insufficient for the proposed session/BFF model.

## 2. Environments and domains

| Environment | Purpose | Data/access rules |
|---|---|---|
| Local | Developer feedback and synthetic fixtures | No production credentials/private dataset copies |
| CI | Isolated reproducible tests | Ephemeral DB/queue namespaces, disposable credentials |
| Staging | Integration/release rehearsal | Separate identity/storage/push, synthetic accounts, restricted access |
| Production | Real user operation | Approved region/privacy policy, least privilege, monitored access |

Illustrative domains, not registered/configured resources:
- User website: `your-domain.com`.
- Admin: `admin.your-domain.com`.
- API/realtime: `api.your-domain.com`.

Set explicit TLS, DNS, allowed origins, callback/redirect URLs, cookie host scope, CSP connect sources, media routes, and mobile association files. Separate subdomains do not establish authorization. Staging and preview deployments must not reuse production sessions or automatically gain production API access.

Public marketing pages can remain in the user website; no third frontend is required. Admin A0 must be available before public social release even when full user web is deferred.

## 3. Configuration and secrets

Names below are illustrative categories, not an existing `.env` contract:

| Category | Examples | Recipients |
|---|---|---|
| Public configuration | Environment label, API origin where needed, approved public identity metadata, app links | Appropriate clients/builds; never mistaken for secrets |
| Database | Runtime connection URL, separate migration connection | API/worker versus controlled migration identity |
| Queue | Redis credentials, queue namespace | Authorized API/dispatcher/worker/coordination roles |
| Identity | Trusted issuer/audience/JWKS config, restricted admin credentials if needed | Verifier/admin adapters only |
| Browser sessions | Separate web/admin session secrets and store credentials | Corresponding Next.js server only |
| Storage | Private endpoint/bucket and scoped credentials | API/media/worker as required |
| Push | Restricted FCM service credentials/APNs configuration | Server delivery/platform configuration, never mobile bundles |
| Diagnostics | Restricted collector settings/tokens | Redacted environment-specific telemetry |

- Keep secrets in the deployment platform's secret manager; no source control, logs, Flutter defines, `NEXT_PUBLIC_*`, container build layers, or public artifacts.
- Public build-time variables may be baked into Next.js/client assets. Environment promotion must account for that rather than assuming every setting changes at runtime.
- Rotate with a tested transition/revocation plan. Invalidated browser sessions need safe reauthentication; mobile pending records must not be deleted because credentials changed.
- Validate required config at startup and fail safely. No permissive production defaults for issuer, origins, TLS, or staff bypass.

## 4. Build and CI pipeline

1. Use pinned compatible Node/package-manager and Flutter/Dart toolchains plus committed lockfiles.
2. Frozen install and reviewed code generation for API clients, Prisma, Drift, and serialization as applicable.
3. Formatting/lint/types, unit/component tests, relevant real DB/queue tests, contract compatibility, and secrets/dependency review.
4. Build production API/worker artifacts and separate web/admin artifacts. Validate container/Prisma/native-library compatibility on the deployment architecture.
5. Build/test Flutter Android; use macOS/Xcode for iOS/iPad builds and native checks.
6. Deploy staging, migrate in a controlled step, run smoke/cross-client/security/adaptive checks.
7. Record artifact/version/config references and approve promotion for the relevant stage.

The [local host verification scripts](local-verification.md) now exist and run API build/tests plus Flutter analysis/widget checks; no Dockerfile, hosted CI workflow or deployment command is implied to exist. Do not run speculative commands against production. Establish artifact retention, signing ownership, and permissions before implementing the pipeline.

## 5. Release and migration order

Recommended sequence:
1. Back up and verify the migration/recovery plan.
2. Apply backward-compatible expansion migrations once through the controlled migration identity.
3. Deploy compatible API/worker changes with required feature availability guarded.
4. Run readiness and owner/permission/idempotency smoke tests.
5. Deploy compatible web/admin changes; verify sessions, cookies, private media, and operator roles.
6. Release mobile through test/staged store channels; old supported clients continue to work.
7. Enable the intended feature stage only after operational gates pass.
8. Remove obsolete schema/contracts only after migration and client compatibility windows are satisfied.

Never run schema resets/`db push` as the production migration procedure, or let every replica race to apply migrations. New browser code must not require an incompatible mobile upgrade instantly. App database migrations preserve pending operations/drafts and must not use delete-and-recreate fallback.

## 6. Health and graceful degradation

| Check/state | Behavior |
|---|---|
| Liveness | Process viability; no public infrastructure secrets |
| API readiness | Required DB/config/verification capability; cannot fake accepted writes |
| Worker readiness | Required DB/queue/render resources and ability to claim work safely |
| Queue outage | API may accept durable outbox-backed pending work if contract permits; show backlog, not ready completion |
| Identity/JWKS outage | Follow approved trusted-key cache policy; never accept unverifiable identity |
| Storage/render outage | Private preparation/export reports pending/failed; no automatic publication |
| Rate-limiter outage | Endpoint-specific safe policy; do not make posting/new contact unlimited |

Graceful shutdown drains requests, stops new job claims, finishes or safely relinquishes leases, and closes DB/socket resources within configured bounds. Do not acknowledge work as complete merely because the process is shutting down.

Alert on DB/pool failures, queue/outbox age, failed renders/exports, sync conflict anomalies, authorization denials, deletion backlog, and staff access changes. Numerical thresholds are set after baseline testing with named responders.

## 7. Workers, schedules, and realtime

- Queue consumers use stable event/job IDs and idempotent effects.
- Outbox/job state survives Redis loss; dispatch can reconstruct pending requirements without replaying completed domain mutations.
- Schedule cleanup/rebuilds through coordinated durable scheduling or leases, not unguarded cron on every replica.
- Bound CPU/memory/concurrency for poster/export jobs independently from interactive API capacity.
- Renew/expire leases safely and test termination mid-job.
- Socket.IO scaling uses a compatible adapter and tested load-balancer transports. Long-polling may need affinity; validate upgrade/reconnect behavior.
- Browser session/BFF credentials remain server-side; approved scoped realtime tickets or proxy integration handle browser connections.
- Active focus coordination/blocks/messages remain database truth, not Redis TTL state.
- Push-provider uncertainty can duplicate an external alert; application-level event dedupe must not be advertised as guaranteed exactly-once lock-screen delivery.

## 8. Storage and delivery

- Private buckets for drafts, cards, and personal exports, with least-privilege credentials and explicit object metadata.
- Current-context authorization before private media delivery; no permanent public poster URLs or inadvertent Next.js image-optimizer/CDN cache.
- Static code/assets/approved editorial pages may be cached separately.
- Signed links retain their actual expiry/revocation limitations; do not promise instant recall.
- Validate uploaded raster bytes/dimensions/types before use; isolate untrusted uploads until validation completes.
- Object removal is not a SQL transaction. Deny access first, then perform idempotent storage cleanup with durable status/retry tracking.
- Lifecycle rules handle expired drafts/uploads/exports under approved retention; do not automatically delete currently referenced content.
- Reconcile orphaned/missing objects during recovery without making missing private media public or recreating deleted publications.

## 9. Mobile distribution

- Separate development/staging/production application IDs/configuration where appropriate.
- Protect Android signing and Apple certificates/profiles/API credentials in restricted CI/platform storage.
- Configure APNs/FCM, notification capabilities, callback schemes, Universal Links/App Links, and approved native permissions.
- Validate on Android phone/tablet and iPhone/iPad; Windows Android builds do not validate iOS behavior.
- Test app restart/background, denied permissions, iPad sharing popovers, split-screen/rotation, keyboard behavior, and schema upgrade with pending writes.
- Store privacy/data-safety disclosures and account-deletion/support links must match actual behavior.
- Review provider sign-in choices against relevant store requirements.
- Use staged rollout and rollback/feature mitigation options; binary distribution rollback is not the same as instant API rollback.

## 10. Backups and restore

Approve backup cadence, PITR, encryption/access, retention, regions, RPO/RTO, and restore ownership before real user data. “Backup succeeded” is not proof of product recovery.

### Restore rehearsal

1. Restore PostgreSQL into an isolated environment with outbound push/publication disabled.
2. Verify migration compatibility, identity mapping, domain integrity, coupled transactions, receipts, stream positions, and outbox/job consistency.
3. Reconcile storage objects and externally executed work; do not blindly resend every job.
4. Reapply/reconcile post-backup deletion, privatization, blocking, suspension, and staff-revocation knowledge before traffic.
5. Validate old mobile cursors/pending operations and browser sessions against the restored state; force safe resync/reauth where needed.
6. Run critical authorization/idempotency/cross-client smoke tests, quantify the loss window, and approve reopening.

The recovery design needs retained trustworthy lifecycle/revocation knowledge beyond the restored snapshot, for example an independently protected recovery journal/checkpoint. If unavailable, remain restricted and reconcile manually; an old backup must not silently make formerly private/deleted/staff-revoked data accessible again.

Record measured recovery results and required user/incident communication. External pushes/screenshots/exports already delivered cannot be rolled back by restoring a database.

## 11. Rollback and incidents

- Prefer disabling the affected capability safely, stopping unsafe delivery, or rolling back compatible application code over destructive schema reversal.
- An older API must not run against incompatible contracted schema blindly.
- Preserve evidence, accepted operations, and pending local data during mitigation.
- Revoke/rotate compromised credentials/grants; preserve least-privilege role boundaries.
- Coordinate public/user communication and legal obligations using the approved incident policy.
- After recovery, add regression tests for the failure and record artifact/config/schema versions.

Named owners, escalation contacts, access recovery, and moderator/support coverage must be defined before launch. An admin “retry” button is not a substitute for an incident runbook.

## 12. Capacity and launch checklist

### Capacity

Budget for API, worker, PostgreSQL, optional Redis, two Next.js deployments, private storage/egress, identity/push services, CI/macOS/device testing, monitoring, and backups. No price estimate or free-tier capacity claim is made here.

Measure query/index behavior and connection budgets before adding replicas. Keep policy checks on sufficiently current data; a lagging replica can disclose revoked access. Add caches/fan-out/search infrastructure only when demonstrated need justifies their consistency cost.

### Launch gate

- Approved supporting stack/provider/region, pinned versions, secret ownership, and recovery path.
- Tested migrations, compatibility, private media, sessions/CSRF, staff MFA, and four-size UI behavior.
- Critical [testing.md](testing.md) evidence available and unresolved risks owned.
- Published privacy/retention/age/region/community policies and support/deletion flows.
- Admin A0 ready before public social features.
- Metrics/alerts/on-call ownership plus proven restore and revocation reconciliation.
- Clear statement of released scope versus future stages; documentation alone is not production readiness.
