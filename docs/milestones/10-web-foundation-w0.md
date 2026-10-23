# M10 — User-Web Foundation and W0 Public Presence

- **Status:** Planned
- **Depends on:** [M00](00-decisions-and-validation.md), [M01](01-foundations.md); may be brought forward with a recorded scheduling decision
- **Targets:** `apps/web/`, approved public assets/routes, shared React/tokens only where useful
- **Requirements:** W0; relevant WEB-02/08 and NFR/security requirements
- **Sources:** [Website](../WEB_PRD.md), [Web file map](../WEB_PRD.md#7-architecture-and-project-boundaries), [Design system](../cookbook/design-system.md), [Deployment](../cookbook/deployment.md)

## Goal

Create honest public presence and a verified responsive web foundation without advertising unfinished browser features or exposing shared private content.

## Ordered tasks

- [ ] **M10-T01** — Confirm W0 content/domain/browser decisions. **Verify:** routes, policy/support owners, product availability, indexing, anonymous/shared-link behavior, hosting and actual launch claims are approved.
- [ ] **M10-T02** — Scaffold the user Next.js app and import boundaries. **Verify:** approved versions/configuration build cleanly; route composition, browser-safe code and server-only modules are separated; public assets contain no private media or secrets.
- [ ] **M10-T03** — Implement web tokens, fonts and appearance. **Verify:** System/Light/Dark persistence, SSR/first-paint/hydration agreement, native color-scheme and CSP-compatible behavior work without relying on the retired style file.
- [ ] **M10-T04** — Implement adaptive shell and shared UI primitives. **Verify:** actual viewport/container fit, navigation, forms/dialogs/focus and all four classes follow the design system without device-specific feature copies.
- [ ] **M10-T05** — Build product/features/policy/support/deletion guidance pages. **Verify:** approved copy, dates/versioning, platform links, metadata, keyboard structure and limited-release labels are accurate; no fabricated social proof or analytics by default.
- [ ] **M10-T06** — Implement safe shared-link resolution. **Verify:** absent/unreleased/unauthorized profiles/posts produce generic states with no private metadata/image leak; anonymous rendering remains disabled unless its policy and backend projection are approved and available.
- [ ] **M10-T07** — Configure approved app links and public caching. **Verify:** allowed hosts/paths, association files and store destinations match actual builds; genuinely public assets cache separately from future session/private routes.
- [ ] **M10-T08** — Add web tests, checks and navigation indexes. **Verify:** unit/component/build, browser/a11y/theme/resize cases and route/component/traceability maps run against actual files; commands and version prerequisites are reproducible.
- [ ] **M10-T09** — Verify public deployment configuration in staging. **Verify:** TLS, CSP/security headers, origins, environment separation, redacted telemetry and accessibility work on the approved server-capable host; no production changes without authorization.
- [ ] **M10-T10** — Obtain and execute the approved W0 release decision. **Verify:** policy/content owners accept the evidence, only declared features are enabled, smoke tests pass, and W1/W2/W3 remain explicitly future scope.

## Exit gate

Public pages are accurate, accessible, and privacy-safe. W0 does not promise login/tracking/social browser functionality before those milestones. Shared-link content depends on the actual approved backend capability, not a marketing deadline.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Eligible after M00/M01; default order keeps mobile personal first. |
