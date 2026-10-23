# M09 — Personal Release and Recovery Readiness

- **Status:** Planned
- **Depends on:** [M08](08-personal-experience.md)
- **Targets:** API/worker and mobile release pipeline, environment isolation, monitoring, recovery, policies, signed distribution
- **Requirements:** V1-A acceptance; DATA/NFR; applicable BE/SEC controls
- **Sources:** [Personal gate](../PRD.md#261-personal-foundation-gate), [Deployment](../cookbook/deployment.md), [Testing](../cookbook/testing.md), [Security](../cookbook/security.md)

## Goal

Make the verified private product safe to operate with real data. Actual provisioning, production changes, and distribution require explicit environment/action authorization; this task plan alone is not permission.

## Ordered tasks

- [ ] **M09-T01** — Approve the intended limited-release scope and operating policies. **Verify:** platform availability, age/regions, privacy/export/deletion/retention, support ownership, analytics/consent, costs, and measurable recovery/service targets match real behavior.
- [ ] **M09-T02** — Provision approved isolated staging resources. **Verify:** identity, database, storage, API/worker, secrets, TLS/origins and app configuration do not reuse production data/credentials; every resource/change has authorized ownership.
- [ ] **M09-T03** — Implement reproducible artifacts and migration deployment. **Verify:** frozen installs, generation checks, production builds, controlled migrations, readiness, backward-compatible API changes and preserved mobile pending records pass staging tests.
- [ ] **M09-T04** — Configure and verify private storage/security controls. **Verify:** database exposure, token verification, least privilege, upload/render limits, cache policy, secret scanning/rotation path, logs and personal export access have evidence.
- [ ] **M09-T05** — Implement monitoring and safe operational runbooks. **Verify:** health, sync/job/deletion backlog, redacted diagnostics, budgets, alert routing and named responders distinguish degradation from false successful saves.
- [ ] **M09-T06** — Configure backups and perform an isolated restore. **Verify:** identity/data/storage consistency, receipts/cursors/outbox, privacy/deletion reconciliation, safe resync and measured RPO/RTO work; outbound effects stay disabled until authorized reopening.
- [ ] **M09-T07** — Rehearse upgrade/rollback and incident mitigation. **Verify:** compatible old clients, failed migrations/jobs, credential rotation, restart and feature disable do not require destructive schema rollback or discard pending local work.
- [ ] **M09-T08** — Run supported native-device and accessibility coverage. **Verify:** Android phones/tablets and approved iPhone/iPad targets cover rotation/split view, keyboard, app lifecycle, notifications/share sheets, both themes and screen readers; missing device evidence remains a blocker.
- [ ] **M09-T09** — Run final personal integrity and privacy regression. **Verify:** all V1-A requirements, real concurrency, exact Money, corrected projections, exported snapshots, account isolation, export/deletion and performance targets pass with linked evidence.
- [ ] **M09-T10** — Prepare signed builds and truthful store/support material. **Verify:** signing access, entitlements, privacy/data-safety disclosures, approved identity methods, support/deletion links and released-feature descriptions match the app.
- [ ] **M09-T11** — Hold the explicit personal-release go/no-go review. **Verify:** authorized reviewers accept evidence, risks, rollback/incident ownership and rollout boundaries; a no-go leaves release blocked rather than checking it as ready.
- [ ] **M09-T12** — Execute only the approved staged distribution and smoke checks. **Verify:** released artifact/config/schema references, critical owner/write/export flows, monitoring and rollback readiness are recorded; public social remains disabled.

## Exit gate

A declared V1-A release has actual deployment/device/security/recovery evidence and authorized rollout. Passing this gate does not authorize social publishing or imply complete user-web parity. Repeat relevant controls for every later release.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Await M08; no resources or releases are authorized by this file. |
