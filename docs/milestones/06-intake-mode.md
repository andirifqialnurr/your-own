# M06 — Complete Intake

- **Status:** Planned
- **Depends on:** [M03](03-water-vertical-slice.md)
- **Targets:** API Intake; Flutter water/coffee, targets, history, reminders and settings
- **Requirements:** INT-01–04; applicable DAY/PROG/NOT/NFR
- **Sources:** [Intake requirements](../PRD.md#13-intake-mode), [Backend Intake](../BACKEND_TECH_SPEC.md#15-intake-service), [Mobile](../MOBILE_TECH_SPEC.md), [Design system](../cookbook/design-system.md)

## Goal

Extend the verified water slice into complete water/coffee tracking without conflating the two or encouraging unlimited consumption.

## Ordered tasks

- [ ] **M06-T01** — Implement coffee models/contracts and persistence. **Verify:** cup/shot quantities and permitted fields remain separate from water; no unapproved caffeine inference or meal/recipe scope.
- [ ] **M06-T02** — Implement coffee CRUD and typed sync. **Verify:** ownership, corrections/deletion, revisions, offline replay, and daily/history totals remain correct across devices.
- [ ] **M06-T03** — Implement effective-dated water targets. **Verify:** target changes do not silently rewrite historical goal attainment; optional/unset targets and valid units are handled explicitly.
- [ ] **M06-T04** — Complete quick presets, units and capture screens. **Verify:** water/coffee actions are labeled, common capture is low-friction, correction is available, and repeated taps/retries do not duplicate records.
- [ ] **M06-T05** — Implement history, filters and editors. **Verify:** date/unit formatting, backdating/correction, local pending states, and narrow/expanded layouts preserve meaning and selected records.
- [ ] **M06-T06** — Implement optional reminder preferences/scheduling. **Verify:** denied permissions, quiet timing, timezone changes, logout, duplicate scheduling, and system-setting help work without blocking basic tracking.
- [ ] **M06-T07** — Expose safe summary/card-source contracts. **Verify:** Today/Progress use owned queries; water target visuals stop escalating at attainment; coffee does not become hydration or a competitive score. Public sharing waits for its milestone.
- [ ] **M06-T08** — Verify the completed mode. **Verify:** unit conversions, target history, offline conflicts, all four sizes, dark/light/system, screen readers, and approved notification devices have linked acceptance evidence.

## Exit gate

Water and coffee support trustworthy capture/history/correction and optional reminders. No consumption leaderboard, medical advice, or automatic publication is introduced.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Await the verified water slice. |
