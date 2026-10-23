# M18 — Full-Scope Verification and Rollout

- **Status:** Planned
- **Depends on:** [M09](09-personal-release-readiness.md), [M13](13-mobile-social-v1b.md), [M14](14-web-personal-w1.md), [M15](15-web-social-w2.md), [M16](16-admin-operations-a1.md), [M17](17-reposts-and-messaging.md)
- **Targets:** Combined declared V1 / W3 / A1 readiness; independently versioned artifacts and rollout decisions
- **Requirements:** Full declared PRD/BE/WEB/ADM/SEC scope, excluding unapproved optional A2/future features
- **Sources:** [Full V1 gate](../PRD.md#263-full-v1-gate), [Testing](../cookbook/testing.md), [Security](../cookbook/security.md), [Deployment](../cookbook/deployment.md)

## Goal

Prove the declared end-to-end system and operating capability before calling it complete. Earlier stage releases remain valid only for their verified published scope; optional A2 is not a blocker.

## Ordered tasks

- [ ] **M18-T01** — Reconcile scope and requirement traceability. **Verify:** every required product/backend/web/admin/security item maps to implementation/evidence or an explicitly approved scope decision; deferred work is not counted as verified.
- [ ] **M18-T02** — Run cross-client contract and compatibility suites. **Verify:** supported old mobile versions, current web/admin, generated clients, exact values/dates, personal sync and backward-compatible migrations work together.
- [ ] **M18-T03** — Run full domain/transaction/failure regression. **Verify:** transfers/savings, reading corrections, timers, intake targets, publication, moderation and messaging survive crash/retry/concurrency without loss or duplicate effects.
- [ ] **M18-T04** — Execute the complete authorization/privacy matrix. **Verify:** account/audience/follow/block/staff changes apply across API, SSR/metadata, feed/detail/media, workers, push, reposts, DM previews and restored caches.
- [ ] **M18-T05** — Complete accessibility and supported-device/browser review. **Verify:** four classes, live resize, iPad split view, keyboard/IME, text/zoom, screen readers, native permission/sharing paths and light/dark/system have actual platform evidence.
- [ ] **M18-T06** — Measure approved performance/capacity targets. **Verify:** real device/build/database fixtures, latency/query/pool/frame behavior, queue backlog and pagination stay within approved budgets or documented blockers; no unsupported performance claims.
- [ ] **M18-T07** — Rehearse backup/restore with full social and staff state. **Verify:** post-backup deletion/privacy/block/suspension/staff revocation reconciliation precedes reopening, external effects are controlled, mobile cursors/pending operations recover, and measured RPO/RTO meet policy.
- [ ] **M18-T08** — Complete security/abuse/dependency/secret review. **Verify:** browser sessions/CSRF, trusted staff assurance, rate limits, renderer/storage boundaries, import leaks, telemetry redaction and recovery access have evidence and named remediation owners.
- [ ] **M18-T09** — Reconfirm policy and operational readiness. **Verify:** privacy/terms/community/age/regions/retention, export/deletion, support/appeals, incident ownership, access reviews and signing/secret rotation match actual shipped behavior.
- [ ] **M18-T10** — Rehearse independent deployments and rollback. **Verify:** API/worker, mobile, user web and admin artifacts/configs are identifiable; migrations run once, old clients remain compatible, and failure mitigation preserves accepted/pending data.
- [ ] **M18-T11** — Obtain stage-specific go/no-go decisions. **Verify:** authorized owners accept evidence/known risks and exact rollout scope; any partial-platform release is labeled accurately, and unresolved critical privacy/integrity failures block it.
- [ ] **M18-T12** — Execute the authorized staged rollout and post-release review. **Verify:** smoke checks, alerts/support, incident rollback readiness, observed reliability and user feedback are recorded without private telemetry; follow-up tasks have owners.

## Exit gate

Only the scope with complete evidence and explicit release approval is called ready. Passing the combined gate does not certify security/accessibility universally or promise external screenshot/push recall. Reopen regressed tasks and preserve the audit/evidence trail.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Final review is evidence-based, not a checklist-writing exercise. |
