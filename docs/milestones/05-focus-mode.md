# M05 — Focus Mode and Durable Timer

- **Status:** Planned
- **Depends on:** [M03](03-water-vertical-slice.md)
- **Targets:** API Focus; Flutter Focus tasks/session engine, local notifications, history and summary contracts
- **Requirements:** FOC-01–04; relevant DAY/PROG/NOT/NFR
- **Sources:** [Focus requirements](../PRD.md#11-focus-mode), [Timer engineering](../MOBILE_TECH_SPEC.md#15-focus-timer-engineering), [Backend Focus](../BACKEND_TECH_SPEC.md#13-focus-service), [Testing](../cookbook/testing.md)

## Goal

Deliver lightweight tasks and a recoverable timer whose truth is not the lifetime of a screen or a per-second callback.

## Ordered tasks

- [ ] **M05-T01** — Implement task/label models, migrations, and contracts. **Verify:** Today placement is distinct from due date; task fields and allowed historical edits follow recorded decisions, without projects/dependencies/complex recurrence.
- [ ] **M05-T02** — Implement task mutation and sync behavior. **Verify:** create/edit/complete/reopen/delete, repeated taps, revisions, and lost-response retries produce accurate history and summaries.
- [ ] **M05-T03** — Build task list/detail/editor and label controls. **Verify:** Today/upcoming/overdue/completed filters, quick capture, editable labels, long titles, keyboard entry, and compact/expanded selection use one state model.
- [ ] **M05-T04** — Implement persisted timer state transitions. **Verify:** countdown/count-up, configurable durations, running/paused/break/finish/cancel, optional task/label association, and allowed restart transitions have deterministic tests; breaks and subsequent intervals require explicit start.
- [ ] **M05-T05** — Implement elapsed-time recovery and session finalization. **Verify:** pause/break exclusion, process death, clock changes, midnight/timezone boundaries, and interrupted finalization do not lose or duplicate duration.
- [ ] **M05-T06** — Implement backend active-session coordination. **Verify:** two online devices cannot silently establish conflicting active sessions; offline overlap is preserved for explicit resolution, not discarded or double-counted.
- [ ] **M05-T07** — Add native completion notifications and lifecycle handling. **Verify:** permissions, reschedule/cancel/dedupe, background restrictions, restart, and iOS/Android differences are tested without promising an immortal background process.
- [ ] **M05-T08** — Build timer/history, summaries and optional focus goals. **Verify:** effective-dated daily targets/weekday schedules and session correction/deletion preserve history; resize/theme changes cannot restart a timer; task deletion preserves sessions and controls remain reachable in short landscape and large text.
- [ ] **M05-T09** — Verify sync, concurrency, and accessibility. **Verify:** accepted/pending sessions reconcile, conflicts remain recoverable, screen readers avoid per-second announcements, and approved real-device cases have evidence.
- [ ] **M05-T10** — Complete Focus traceability and review. **Verify:** FOC requirements map to domain, persistence, native, and four-size/theme tests; actual background/recovery limitations are documented for users and future web work.

## Exit gate

Task changes and timed sessions survive normal interruption/retry without duplicate progress. Native notification delivery is described honestly; a passing widget timer alone is insufficient.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Await M03. |
