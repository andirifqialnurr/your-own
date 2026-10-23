# M03 — Water Logging End-to-End Slice

- **Status:** Planned
- **Depends on:** [M02](02-identity-and-data-foundation.md)
- **Targets:** API Intake/Sync/Progress contracts; Flutter Intake capture, local queries, outbox, and synchronization
- **Requirements:** INT-01; DAY-02; applicable PROG/NFR and backend integrity requirements
- **Sources:** [Mobile implementation sequence](../MOBILE_TECH_SPEC.md#26-implementation-sequence), [Backend sync](../BACKEND_TECH_SPEC.md#18-offline-synchronization-protocol), [Testing](../cookbook/testing.md)

## Goal

Prove create → local acknowledgement → sync → canonical read → correction/delete → restart/recovery for one real feature before expanding the pattern.

## Ordered tasks

- [ ] **M03-T01** — Define water record/value and contract fixtures. **Verify:** units, canonical milliliters, occurrence/date context, owner, operation identity, revision, and validation match approved semantics.
- [ ] **M03-T02** — Implement backend water persistence and owned CRUD. **Verify:** create/read/correct/delete and daily totals work with real database constraints, ownership checks, revisions, and no duplicated quantities on retry.
- [ ] **M03-T03** — Implement Flutter water tables/DAO/repository. **Verify:** immediate local projections, durable outbox writes, correction/delete metadata, and restart behavior use one transactional path.
- [ ] **M03-T04** — Add quick-log and history/editor UI. **Verify:** preset/manual amounts, units, correction path, pending labels, and Today entry are usable across sizes/themes; no fake server-success or hydration ranking.
- [ ] **M03-T05** — Implement typed command dispatch. **Verify:** REST and `/v1/sync/commands` share the same water application semantics; accept/conflict/reject/dependency outcomes never permit arbitrary table mutation.
- [ ] **M03-T06** — Implement incremental pull and tombstone application. **Verify:** local pending overlays remain distinguishable, deleted rows cannot resurrect, and delayed commits cannot be skipped by the cursor.
- [ ] **M03-T07** — Implement consistent bootstrap/resume. **Verify:** snapshot generation/watermark remains stable across paging, concurrent writes, interruption, and reconnect without missed/duplicated records.
- [ ] **M03-T08** — Implement client sync scheduling/status and resolution UI. **Verify:** reconnect/restart, backoff, expired credentials, explicit conflict resolution, and pending/failed indicators preserve operations without relying on connectivity hints as proof.
- [ ] **M03-T09** — Test lost responses and crash windows. **Verify:** crashes before/after local/server commit and replay with changed payload produce one valid effect or a clear rejection; no silent quantity inflation.
- [ ] **M03-T10** — Test multi-device edits and expired sync horizons. **Verify:** conflicting revisions, backdated correction, tombstones, and rebootstrap preserve resolvable local work and canonical totals.
- [ ] **M03-T11** — Test date/unit/accessibility boundaries. **Verify:** timezone/day changes, supported conversions, large text, keyboard, screen reader, small phone, iPad resize, and both themes preserve accurate amounts and reachable actions.
- [ ] **M03-T12** — Review the slice as the reusable implementation pattern. **Verify:** evidence covers API, Flutter, real persistence, sync and contracts; record shortcomings before copying the pattern to Read/Focus/Intake/Money.

## Exit gate

A complete water journey survives offline use, restart, correction/delete, retry, and concurrent changes with accurate totals and explicit status. Screens alone or mock-only sync tests do not pass this milestone.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Await M02; do not fan out feature scaffolding before this proof. |
