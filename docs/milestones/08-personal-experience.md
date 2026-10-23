# M08 — Today, Progress, Private Cards, and Data Controls

- **Status:** Planned
- **Depends on:** [M04](04-read-mode.md), [M05](05-focus-mode.md), [M06](06-intake-mode.md), [M07](07-money-mode.md); approved rendering/storage/lifecycle baseline
- **Targets:** API Progress/Cards/Media/Jobs/Data lifecycle; Flutter Today/Progress/Cards/Settings
- **Requirements:** DAY-01–03; PROG-01–04; CARD-01–07 for private preview/export; DATA-01–04; relevant ACC/NOT/NFR
- **Sources:** [PRD](../PRD.md), [Card rendering](../MOBILE_TECH_SPEC.md#17-progress-poster-rendering-and-sharing), [Backend cards](../BACKEND_TECH_SPEC.md#19-progress-cards-and-media), [Design system](../cookbook/design-system.md), [Security](../cookbook/security.md)

## Goal

Complete useful private tracking without requiring social participation. Public publication, follows, and messaging remain unavailable until their stages pass.

## Ordered tasks

- [ ] **M08-T01** — Implement Today composition from mode-owned queries. **Verify:** priority/tasks, active timer/book, quick capture, date and summaries work without fetching all history; common saved quick actions meet the PRD's two-interaction target and Money values are hidden on shared-screen surfaces by default.
- [ ] **M08-T02** — Implement overall/per-mode contribution projections. **Verify:** qualifying activity, 0–4 distinct-mode meaning, corrections/deletion, effective goals, timezone/week boundaries and hidden modes match the PRD.
- [ ] **M08-T03** — Build accessible Progress/calendar/day detail. **Verify:** legend/value alternatives, month/day/list access, filters, unknown/rest states and responsive panes work without hundreds of unusable accessibility nodes.
- [ ] **M08-T04** — Define/version approved poster snapshot schemas and templates. **Verify:** types, selected fields, units/period, attribution, accessible text, font/assets, overflow and fixed export dimensions have approved fixtures; no arbitrary graphic editor.
- [ ] **M08-T05** — Implement mobile private snapshot rendering/export. **Verify:** selected-field allowlists, loaded fonts/assets, bounded memory/resolution, accessible text and private storage work with approved local/offline behavior; pending/self-entered data is not called server-verified. If server rendering is selected, verify current owner access and durable, idempotent jobs/outbox for asynchronous work; local export never implies publication.
- [ ] **M08-T06** — Build private card composer and exact preview. **Verify:** source/template selection, omissions, amount hiding, optional reflection, chosen Light/Dark variant and pending/error states match rendered content; no publication occurs on rendering completion.
- [ ] **M08-T07** — Implement mobile export/share integration. **Verify:** selected pixels/text only, fixed dimensions independent of screen/DPR/theme, safe temporary-file cleanup, iPad popover placement, cancellation/error, and external-copy warnings.
- [ ] **M08-T08** — Complete settings and user record controls. **Verify:** profile/visibility, appearance, units/timezone, mode visibility, reminders, data correction and safe sign-out preserve approved scope; hiding modes does not delete history.
- [ ] **M08-T09** — Implement personal-data export workflow. **Verify:** owner/reauth checks, documented format, async status, private expiring download and cleanup work with truthful failure/ready states; no staff/public blanket access.
- [ ] **M08-T10** — Implement account deletion and retention workflow. **Verify:** confirmation, access revocation, pending-job cancellation/eligibility checks, local cleanup, backend/storage cleanup and approved backup/retention exceptions are documented and tested.
- [ ] **M08-T11** — Verify private-data boundaries and optional telemetry. **Verify:** no raw private values leak into logs/fixtures/metadata/posters; analytics is disabled unless approved purpose/events/consent and redaction are implemented.
- [ ] **M08-T12** — Run complete private-use journeys. **Verify:** all four trackers, Today, Progress, private export and data controls work without follows/posts across offline/retry, restart, resize, light/dark/system and large text; link evidence to affected requirements.

## Exit gate

V1-A functionality is implemented and verified with synthetic data. Real-user release still requires M09's deployment, policy, recovery, device and operational evidence. Unsupported/unreleased social controls are not falsely advertised.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Await all personal modes and approved render/lifecycle choices. |
