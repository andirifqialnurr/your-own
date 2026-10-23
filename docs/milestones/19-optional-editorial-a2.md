# M19 — Optional Editorial and Configuration CMS (A2)

- **Status:** Not scheduled; optional and not a V1/W3/A1 launch blocker
- **Depends on:** [M16](16-admin-operations-a1.md) plus explicit product/security scope approval
- **Targets:** Only approved backend editorial/configuration contracts and admin A2 surfaces; corresponding public content consumers if approved
- **Requirements:** Optional A2; ADM-16 and applicable security/governance requirements only if enabled
- **Sources:** [Editorial scope](../ADMIN_CMS_PRD.md#17-optional-editorial-content-management), [Configuration governance](../ADMIN_CMS_PRD.md#18-configuration-and-template-governance), [Security](../cookbook/security.md)

## Goal

Add controlled editorial/configuration functionality only when there is a demonstrated need. Approved code-managed policy/product pages can continue without this milestone.

## Conditional tasks

- [ ] **M19-T01** — Record the explicit A2 go/no-go and content model. **Verify:** approved content types, users, workflow, review/publish/rollback owners, localization and risk boundaries exist; a no-go keeps remaining work not scheduled.
- [ ] **M19-T02** — Design approved backend contracts and migrations. **Verify:** separate scoped capabilities, versions, sanitized fields, asset ownership and audit boundaries do not expose arbitrary tables/SQL/renderer code.
- [ ] **M19-T03** — Implement draft/review/versioned publication services. **Verify:** conflicts, approvals, rollback/new-version semantics, safe asset validation and current publishing authority work through tested NestJS operations.
- [ ] **M19-T04** — Build structured admin editing and exact preview. **Verify:** accessible forms, selected content schemas, safe preview, sanitized output, error/draft preservation and current capability checks work in both themes and all sizes.
- [ ] **M19-T05** — Add only approved configuration/template interfaces. **Verify:** allowlisted values, impact confirmation, versioning and rollback are enforced; no secrets, arbitrary code, global notification blast, or unrestricted graphic editor is introduced.
- [ ] **M19-T06** — Integrate approved public content delivery. **Verify:** published versions and cache invalidation work without mixing editorial caches with private posts, staff evidence or user-session data.
- [ ] **M19-T07** — Test governance/security/concurrency and operations. **Verify:** unauthorized publish, stored script injection, unsafe uploads, stale revisions, rollback, audit, accessibility and recovery have evidence with synthetic fixtures.
- [ ] **M19-T08** — Approve and deploy the optional extension. **Verify:** stage-specific contracts, named owners, monitored rollout, rollback policy and traceability reflect the actually approved A2 scope rather than an assumed general CMS.

## Exit gate

A2 is delivered only after explicit approval and verification. Leaving this milestone unstarted does not make the core product incomplete. Training, games, meals, banks/payments, richer messaging and other future features require separate scope decisions, not additions hidden in this checklist.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not scheduled | — | — | Do not start without explicit A2 approval. |
