# M04 — Read Mode

- **Status:** Planned
- **Depends on:** [M03](03-water-vertical-slice.md)
- **Targets:** API `modules/read/`; Flutter `features/read/`; owned schemas/sync and summary contracts
- **Requirements:** READ-01–03; relevant DAY/PROG/NFR
- **Sources:** [Read requirements](../PRD.md#12-read-mode), [Mobile](../MOBILE_TECH_SPEC.md), [Backend Read](../BACKEND_TECH_SPEC.md#14-read-service), [Testing](../cookbook/testing.md)

## Goal

Deliver manual bookshelves and trustworthy page history without depending on a third-party catalog.

## Ordered tasks

- [ ] **M04-T01** — Define book/shelf/progress contracts and migrations. **Verify:** unknown totals, ownership, revisions, completion, dates, and corrections have fixtures; no unapproved catalog or import requirement appears.
- [ ] **M04-T02** — Implement backend book and progress operations. **Verify:** page bounds, completion, correction/delete, concurrency, and derived deltas preserve accurate reading history.
- [ ] **M04-T03** — Add Flutter persistence/repositories and typed sync adapters. **Verify:** offline book/page changes, dependencies, tombstones, retries, and conflict resolution use the verified M03 pattern.
- [ ] **M04-T04** — Implement bookshelf/list/detail/editor screens. **Verify:** manual entry, approved cover handling/fallback, long titles, shelf changes, and optional detail panes remain accessible in both themes.
- [ ] **M04-T05** — Implement quick page updates and finish confirmation. **Verify:** 40→58 records 18 pages; correction/reopening does not fabricate completion or inflate contribution totals; unknown total is not 0%/100%.
- [ ] **M04-T06** — Implement goals/history and summary contracts. **Verify:** optional weekly reading-days and annual finished-books goals respect effective dates; Today/Progress consume narrow mode-owned queries and private notes remain excluded from public projections.
- [ ] **M04-T07** — Verify multi-device and lifecycle cases. **Verify:** concurrent updates, offline retries, source deletion, backdating, restart, and migration preserve coherent history with explicit conflicts.
- [ ] **M04-T08** — Complete UI/contract traceability. **Verify:** four-size, keyboard/screen-reader, large-text, privacy and theme evidence is linked to READ requirements; all code/test/route maps are current.

## Exit gate

A user can manually add, read, correct, complete, and remove eligible book/progress data across devices without duplicate reading totals or leaked notes.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Await M03. |
