# M12 — Admin Safety Workflows (A0)

- **Status:** Planned
- **Depends on:** [M11](11-social-backend.md); approved staff sessions, scope, and operating ownership
- **Targets:** `apps/admin/`; actual staff workflow against NestJS operator APIs
- **Requirements:** A0; ADM-01–08/10/12–15 as applicable; SAFE-03; SEC staff/privacy controls
- **Sources:** [Admin specification](../ADMIN_CMS_PRD.md), [Admin file map](../ADMIN_CMS_PRD.md#9-architecture-and-shared-code-boundaries), [Security](../cookbook/security.md), [Deployment](../cookbook/deployment.md)

## Goal

Provide usable, accountable moderation/support before public social launch. Staff visibility is limited by current backend capability and evidence scope, not a broad admin flag.

## Ordered tasks

- [ ] **M12-T01** — Confirm A0 roles, evidence policy and named operators. **Verify:** capabilities/scopes, MFA/freshness, allowed actions/reasons, report handling, minimal lookup fields, appeal/support channel, offboarding and recovery ownership are approved.
- [ ] **M12-T02** — Scaffold the independent admin Next.js app. **Verify:** build/origin/configuration and static assets are separate; no public signup or private data in assets; shared primitives never import another app's sessions/evidence.
- [ ] **M12-T03** — Implement staff session, callback, MFA and expiry flows. **Verify:** opaque host-only cookie, server-held credentials, session rotation, step-up, revocation and safe redirects work against trusted backend assurance without bypass headers.
- [ ] **M12-T04** — Implement allowlisted operator BFF/server adapters. **Verify:** Origin/CSRF, methods/body limits, safe errors, no-store, current access, operation IDs and revisions survive direct calls; no domain Prisma or arbitrary proxy path.
- [ ] **M12-T05** — Build the adaptive staff shell and state components. **Verify:** environment/context, permitted navigation, System/Light/Dark, tables/forms/dialogs, keyboard and all four sizes work with the shared rounded icon family rather than starter defaults; hidden navigation is not treated as authorization.
- [ ] **M12-T06** — Implement minimal account lookup and basic support/status. **Verify:** authorized fields only, sensitive search not leaked into URLs/logs, no tracker/finance browser, and clear denied/unavailable states.
- [ ] **M12-T07** — Implement report queue, assignment and evidence detail. **Verify:** server pagination/filters, revision-safe claim, scoped evidence, audit, redaction, and no private-media cache/metadata leakage.
- [ ] **M12-T08** — Implement moderation decisions and confirmations. **Verify:** target/effect/environment/reason remain visible; assurance and stale-revision errors preserve drafts; uncertain retries produce one accepted action and audit effect.
- [ ] **M12-T09** — Implement accessible audit/context and escalation access. **Verify:** staff can review permitted decision history and follow the approved appeal/support process without unrelated evidence or raw private exports.
- [ ] **M12-T10** — Test denial, cache, concurrency and session boundaries. **Verify:** ordinary/low-assurance/revoked accounts, two reviewers, CSRF, logout/account switch, browser back/forward, keyboard/zoom and private SSR/media all pass.
- [ ] **M12-T11** — Rehearse staff operations and document indexes/runbooks. **Verify:** named operators complete a synthetic report-to-action journey, offboarding/recovery, escalation and incident exercise; route/capability/requirement evidence maps are current.
- [ ] **M12-T12** — Approve and deploy the declared A0 scope. **Verify:** explicit environment/action authorization, separate sessions/secrets, staging checks, staff onboarding and support coverage exist; the social release gate can reference actual operational readiness.

## Exit gate

Required staff workflows are live in the authorized environment and staffed, not only mocked. No unrestricted private tracker/DM access or automatic A2 editorial features are present. A0 readiness is necessary but not alone sufficient for public social release.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Await gated operator APIs and staff-policy approval. |
