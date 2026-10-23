# M16 — Admin Operational Completion (A1)

- **Status:** Planned
- **Depends on:** [M11](11-social-backend.md), [M12](12-admin-safety-a0.md); may be scheduled before user-web completion
- **Targets:** API Jobs/Staff access/Audit/Moderation/Data lifecycle and admin operational feature modules
- **Requirements:** A1; ADM-01–15 as applicable; BE/SEC operational safeguards
- **Sources:** [Admin](../ADMIN_CMS_PRD.md), [Backend](../BACKEND_TECH_SPEC.md), [Deployment](../cookbook/deployment.md), [Security](../cookbook/security.md)

## Goal

Give authorized operators the status, recovery, appeal and staff-management tools they need without creating unrestricted backend powers.

## Ordered tasks

- [ ] **M16-T01** — Approve the A1 operation/capability catalog. **Verify:** job retry/cancel eligibility, support actions, appeal decisions, staff grants, recovery/dual-control rules and safe exposed fields are explicit before endpoints/screens expand.
- [ ] **M16-T02** — Implement or complete the approved operator contracts. **Verify:** NestJS checks current grants/assurance/scope, target revisions, stable operation IDs and minimal audit effects independently of frontend controls.
- [ ] **M16-T03** — Build safe operational dashboard/health views. **Verify:** real aggregate status, stale/loading/denied states, environment markers and alert links reveal no credentials, raw payloads or private tracker records.
- [ ] **M16-T04** — Build job list/detail/attempt/retry flows. **Verify:** server pagination, approved metadata, reason/target confirmation and eligibility checks cannot replay a financial command, alter a snapshot or republish a post.
- [ ] **M16-T05** — Implement data-request monitoring. **Verify:** export/deletion progress and failures are visible only within capability scope and do not grant staff the user's export-file contents.
- [ ] **M16-T06** — Implement staff management and revocation UI. **Verify:** trusted MFA/freshness, least privilege, explicit reasons, no self-escalation, last-recovery-admin protections and prompt backend denial after revocation work.
- [ ] **M16-T07** — Implement approved appeal-review workflow. **Verify:** prior decision context, assignment/reviewer policy, uphold/reversal effects and audit preservation do not erase original history or expose unrelated evidence.
- [ ] **M16-T08** — Complete scoped audit queries and safe support tools. **Verify:** search/filter/privacy boundaries, current/previous state, field minimization and allowed support actions are usable without a generic table editor or user impersonation.
- [ ] **M16-T09** — Verify security, concurrency and adaptive operation. **Verify:** revoked/low-assurance sessions, two operators, unknown retries, unsafe jobs, no-store restoration, both themes, all sizes and keyboard/large-text cases pass.
- [ ] **M16-T10** — Rehearse operations/offboarding and update evidence maps. **Verify:** named operators can handle a failed eligible job, appeal, deletion backlog and staff loss/recovery; endpoint/capability/job/audit traceability is current.
- [ ] **M16-T11** — Approve and deliver the A1 release independently. **Verify:** authorized deployment, compatible backend contracts, monitored smoke checks and operating ownership are recorded; optional content/configuration remains out of scope.

## Exit gate

A1 workflows are restricted, audited, retry-safe and operationally useful. Public social already required A0; A1 does not retroactively substitute for an earlier missing safety gate. A2 remains optional.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Can follow A0 without waiting for W1/W2. |
