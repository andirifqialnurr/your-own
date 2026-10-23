# M11 — Gated Social Backend and Staff Contracts

- **Status:** Planned; no public social launch in this milestone
- **Depends on:** [M08](08-personal-experience.md), [M09](09-personal-release-readiness.md); approved later-stage integrations/policies
- **Targets:** API Users/Staff access/Authorization/Cards/Media/Social/Notifications/Moderation/Audit/Jobs
- **Requirements:** CARD/SOC/FEED/SAFE/NOT; applicable BE/SEC and A0 backend dependencies
- **Sources:** [Backend](../BACKEND_TECH_SPEC.md), [Admin requirements](../ADMIN_CMS_PRD.md), [Schema](../cookbook/schema.md), [Security](../cookbook/security.md), [Testing](../cookbook/testing.md)

## Goal

Implement social authority and the operator APIs needed for safety, tested with synthetic users behind closed availability controls. M12 and the client release gate are prerequisites to public exposure.

## Ordered tasks

- [ ] **M11-T01** — Approve detailed social and operator contracts. **Verify:** audiences/visibility generations, anonymous-link policy, permitted metadata, rate limits, rendering/queue choices, staff scopes/assurance, report evidence/action taxonomy and relevant retention are recorded.
- [ ] **M11-T02** — Implement trusted staff-access and audit foundations. **Verify:** ordinary/low-assurance/revoked credentials fail operator calls; current grants, fresh step-up, scoped audit append/query, and secure provisioning/recovery have integration evidence.
- [ ] **M11-T03** — Add social/card/report migrations and lifecycle projections. **Verify:** constraints/indexes, publication generations, selected snapshot references, blocks/follows, audit/evidence ownership and migration compatibility are tested.
- [ ] **M11-T04** — Implement follow/request/remove/block and visibility transitions. **Verify:** follow approval is explicit where required; public→private→public cannot republish old restricted generations accidentally; current privacy checks cover race-sensitive changes.
- [ ] **M11-T05** — Implement canonical publication and snapshot lifecycle. **Verify:** prepare/render/preview/publish uses selected fields and explicit confirmation; caption edits are identified, metric updates require a new preview, source correction/deletion supports warnings and unpublish/regenerate, and post deletion revokes delivery. Jobs never auto-publish or resurrect revoked content.
- [ ] **M11-T06** — Implement reauthorizing media/link delivery. **Verify:** source revocation applies to bytes, previews, metadata, caches and workers; private objects are not exposed through public buckets/optimizers, and external-copy limits are honest.
- [ ] **M11-T07** — Implement profiles, people search, finite feed, likes and comments. **Verify:** viewer projections exclude raw trackers, pagination is chronological/bounded, reactions/comments respect current audience, and duplicate writes/rate abuse are controlled.
- [ ] **M11-T08** — Implement durable notification decisions/inbox/push integration. **Verify:** outbox/job identity, current eligibility, device-token ownership, quiet preferences and generic sensitive previews survive retries/provider uncertainty without claiming exactly-once external delivery.
- [ ] **M11-T09** — Implement reports and scoped evidence reads. **Verify:** selected supported targets, safe own-status, restricted queue/assignment, evidence access audit and abuse limits work without a generic private-record viewer.
- [ ] **M11-T10** — Implement permitted moderation and account restrictions. **Verify:** current capability/assurance, reasons, target revision, operation identity, atomic audit and shared delivery revocation prevent conflicting/duplicate decisions.
- [ ] **M11-T11** — Complete minimal A0 operator support/status contracts. **Verify:** account lookup, audit, safe lifecycle status and approved appeal channel integrations expose only authorized metadata; missing contracts cannot be bypassed through SQL/storage keys.
- [ ] **M11-T12** — Run social/worker/privacy/concurrency regressions. **Verify:** full viewer matrix, revoked media, delayed jobs, queue loss, stale permissions, staff revocation and conflicting requests are tested with real adapters where required.
- [ ] **M11-T13** — Generate reviewed clients and hand off the gated APIs. **Verify:** user/operator contracts remain separate, endpoint/job/capability traceability is current, staging contains synthetic data, and public social remains disabled pending A0/client readiness.

## Exit gate

Backend social and A0 contracts are proven and available only in the approved gated environment. Implementation of moderation APIs is not proof that staffed operational workflows exist; M12 is mandatory before public social.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Await personal readiness and social/staff contract approval. |
