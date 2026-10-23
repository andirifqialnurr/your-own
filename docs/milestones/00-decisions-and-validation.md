# M00 — Decisions, Audit, and Validation

- **Status:** Planned; no approval task is complete merely because this plan exists
- **Depends on:** None
- **Next:** [M01](01-foundations.md) only after the scaffold gate below
- **Targets:** Approved decision records and disposable spike evidence, not production application scaffolding
- **Sources:** [PRD open decisions](../PRD.md#30-decisions-to-resolve-before-implementation-or-launch), [Mobile gates](../MOBILE_TECH_SPEC.md#27-open-decisions-and-release-gates), [Backend gates](../BACKEND_TECH_SPEC.md#31-risks-and-open-decisions), [Architecture](../cookbook/architecture.md)

## Goal

Resolve the decisions that would otherwise force risky rewrites. Distinguish confirmed frameworks from proposed supporting choices. All decisions need an owner, rationale, and explicit acceptance; experiments do not implicitly select a dependency.

## Ordered tasks

- [ ] **M00-T01** — Review scope and independent release tracks with the owner. **Verify:** record V1-A/B/C, W0–W3, A0/A1 boundaries, optional A2, launch priorities, and the location/ownership of decision records.
- [ ] **M00-T02** — Approve remaining product defaults. **Verify:** decisions cover account/post visibility, guest policy, labels/languages/units, task fields, historical timer edits, Money currency/savings semantics, and required poster templates; unresolved items remain explicit blockers.
- [ ] **M00-T03** — Audit the four reference Flutter repositories. **Verify:** inventory features, dependencies/licenses, storage, tests, reusable rules/fixtures, rebuild decisions, and whether any data import is actually promised; do not merge their navigation/state stacks.
- [ ] **M00-T04** — Evaluate and select toolchain/workspace candidates. **Verify:** compatible Flutter/Dart and Node/TypeScript/framework versions, package manager, proposed libraries, licensing/maintenance, and a reproducible version-pin plan are reviewed.
- [ ] **M00-T05** — Define supported environments and device/browser coverage. **Verify:** OS/browser minimums, Android phone/tablet and iPhone/iPad coverage, a macOS/Xcode path, accessibility targets, performance budgets, and test ownership are approved.
- [ ] **M00-T06** — Approve infrastructure and provider baseline. **Verify:** database/ORM, identity, private storage, session-store approach, hosting/regions/cost ceiling, environment isolation, secret ownership, and recovery targets are recorded without provisioning resources implicitly.
- [ ] **M00-T07** — Spike identity and browser/staff assurance. **Verify:** token verification/revocation, user/admin session separation, CSRF/Origin handling, current staff grants, trusted MFA/freshness, and provider limitations have concrete synthetic evidence or a blocking redesign.
- [ ] **M00-T08** — Spike mobile persistence and lifecycle risks. **Verify:** chosen encryption/driver/key handling, migration preservation, auth restart, timer recovery, denied notifications, iPad sharing, and split-view behavior have recorded findings; Android-only results are not iOS proof.
- [ ] **M00-T09** — Validate the visual system with representative prototypes. **Verify:** Today on a small phone, Money on a large iPad, and a poster demonstrate approved font assets, both themes, large text, useful density, and all four window classes.
- [ ] **M00-T10** — Approve core API and schema contracts. **Verify:** OpenAPI-to-Dart/TypeScript generation, exact integer/date/null handling, errors, ownership, operation IDs, revisions, transaction boundaries, and Money posting constraints have fixtures and review evidence.
- [ ] **M00-T11** — Spike synchronization correctness. **Verify:** demonstrate commit-safe owner ordering, consistent bootstrap watermark, receipts, tombstones, lost-response retry, conflict handling, and expired-cursor recovery; approve offline/retention horizons.
- [ ] **M00-T12** — Approve lifecycle and privacy baseline. **Verify:** personal export/deletion scope, encrypted local retention, backup handling, future DM-history treatment, sensitive-media delivery, and no-private-telemetry rules have owners and decisions; launch-only policy details retain explicit deadlines/gates.
- [ ] **M00-T13** — Review later social/operations risks without enabling them. **Verify:** rendering, queue/outbox, realtime browser credentials, visibility generations, staff recovery, and contact/block coordination have a selected baseline or a documented prerequisite before the affected milestone.
- [ ] **M00-T14** — Obtain the scaffold go/no-go decision. **Verify:** the owner accepts the baseline and applicable spike evidence, blockers are listed, and specs/decision links agree; no unresolved foundation choice is silently treated as approved.

## Exit gate

M01 can start only after its supporting stack, personal contract/schema, encrypted mobile approach, session model, targets, and design baseline have approved answers. A later-stage decision may be deferred only with an explicit affected-task blocker; it cannot weaken the scaffold gate. Disposable spike code is not counted as shipped implementation.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence). Record actual approvals, owners, commands/environments, and sanitized results.

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Start with M00-T01; no approvals are implied. |
