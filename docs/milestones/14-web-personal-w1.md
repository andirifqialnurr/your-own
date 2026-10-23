# M14 — Personal User Website (W1)

- **Status:** Planned
- **Depends on:** [M09](09-personal-release-readiness.md), [M10](10-web-foundation-w0.md)
- **Targets:** User-web server sessions/BFF and personal feature modules; existing NestJS authority
- **Requirements:** W1; WEB-01/03–08/11/14; relevant ACC/DAY/FOC/READ/INT/MON/PROG/CARD/DATA/NFR
- **Sources:** [Website](../WEB_PRD.md), [Web file map](../WEB_PRD.md#7-architecture-and-project-boundaries), [Testing](../cookbook/testing.md), [Security](../cookbook/security.md)

## Goal

Deliver online-first browser tracking that shares accepted data and semantics with mobile, without duplicating a backend or promising Flutter's offline/background guarantees.

## Ordered tasks

- [ ] **M14-T01** — Approve W1-specific browser/session limitations and contracts. **Verify:** supported browsers, offline/draft policy, timer behavior, auth/store/session timeouts, reauth and recovery semantics are recorded and match current APIs.
- [ ] **M14-T02** — Implement user sessions and approved auth/onboarding flows. **Verify:** opaque secure host-only cookies, server-held tokens, callback/CSRF/Origin protection, safe redirects, logout and user/admin separation pass browser/server tests.
- [ ] **M14-T03** — Implement explicit BFF and server read adapters. **Verify:** fixed destinations, method/field validation, safe serialization, operation identity/revision forwarding and no-store/private SSR avoid database or open-proxy shortcuts.
- [ ] **M14-T04** — Implement authenticated shell/query scopes and draft lifetime. **Verify:** route/selection, query clearing, unavailable states, resize/theme/keyboard behavior and account switching cannot leak or discard another user's data.
- [ ] **M14-T05** — Implement Today and personal quick capture. **Verify:** narrow backend summaries, hidden Money values, low-friction logging, pending/unknown response handling and targeted invalidation work without downloading full histories.
- [ ] **M14-T06** — Implement browser Focus tasks/timer/history. **Verify:** reload/tab throttling/multi-tab conflicts use persisted timing/backend coordination; pause/break exclusion and platform limitations are honest, with no duplicate session.
- [ ] **M14-T07** — Implement Read and Intake workflows. **Verify:** manual shelves/page correction/completion, water/coffee separation, targets/units/history and validation match backend/mobile results and preserve input on failures.
- [ ] **M14-T08** — Implement Money accounts/transactions/plans/savings. **Verify:** exact string entry/display, transfer semantics, revisions, hidden amounts, bounded forms/tables and uncertain retries never create a browser ledger or duplicate assets.
- [ ] **M14-T09** — Implement Progress and own private poster preparation/preview/export. **Verify:** implement the approved private rendering capability if not already available; calendar/value alternatives, selected snapshot fields, fixed template versions/dimensions and authorized downloads match product semantics. Compare renderer fixtures rather than assuming pixel identity with Flutter; publishing waits for W2.
- [ ] **M14-T10** — Complete settings, export/deletion and support flows. **Verify:** approved privacy/units/preferences, truthful async status, reauthentication, unsupported capabilities and server lifecycle responses are reflected safely.
- [ ] **M14-T11** — Verify browser/mobile consistency and privacy. **Verify:** accepted web edits appear once in Flutter sync; lost responses, stale revisions, SSR/RSC/metadata/images, back-forward restoration, large text and real supported-browser cases pass.
- [ ] **M14-T12** — Complete traceability and approve the W1 release. **Verify:** actual build/CI/staging evidence, documented commands/route maps, policies, recovery/monitoring and explicit authorized rollout cover declared W1 scope only.

## Exit gate

Private browser use is complete without social participation, and cross-client data remains coherent. All sensitive data/session/cache paths are tested; a working client-side screen is not sufficient evidence.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Await personal backend readiness and W0 foundation. |
