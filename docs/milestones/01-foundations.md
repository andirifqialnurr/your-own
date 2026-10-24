# M01 — Repository and App Foundations

- **Status:** In progress — local workspace/API verified; Flutter shell implemented, native verification pending
- **Depends on:** [M00](00-decisions-and-validation.md); [Decision 0012](../cookbook/decisions/0012-local-development-bootstrap.md) brings forward only the first three local setup tasks
- **Targets:** Repository tooling; `apps/api/`; `apps/mobile/`; later web/admin scaffolds stay in M10/M12
- **Sources:** [Architecture file map](../cookbook/architecture.md#5-repository-and-code-boundaries), [Backend structure](../BACKEND_TECH_SPEC.md#7-proposed-project-structure), [Mobile structure](../MOBILE_TECH_SPEC.md#5-proposed-project-structure), [Design system](../cookbook/design-system.md), [Testing](../cookbook/testing.md)

## Goal

Create a reproducible, navigable foundation for one API/mobile slice. Do not generate every future module or claim unfinished applications are available.

## Ordered tasks

- [x] **M01-T01** — Establish the approved monorepo tooling. **Verify:** runtime pins, workspace configuration, ignore rules, safe environment examples, and lockfile ownership reproduce clean installs without real secrets or generated build artifacts in Git.
- [x] **M01-T02** — Scaffold the NestJS API entry and configuration. **Verify:** startup validates required settings, safe liveness/readiness behavior works, and HTTP/worker composition boundaries are documented; no accidental queue consumers run in API instances.
- [ ] **M01-T03** — Scaffold the Flutter application and environment entry points. **Verify:** development/staging/production configuration cannot silently connect test builds to production; actual Android and approved iOS build prerequisites are recorded.
- [ ] **M01-T04** — Add feature/module boundaries and import checks. **Verify:** pure domain code avoids framework/transport dependencies; cross-feature APIs are explicit; code is not duplicated into device-specific application trees.
- [ ] **M01-T05** — Implement Flutter semantic tokens and appearance selection. **Verify:** approved fonts, zinc palette, System/Light/Dark persistence, component states, and system-bar contrast follow the design system without hardcoded feature palettes.
- [ ] **M01-T06** — Implement the adaptive app shell and route state. **Verify:** Small/Medium/Large/Largest, short landscape, keyboard insets, navigation selection, text scaling, and live resize work without losing synthetic draft/timer state.
- [ ] **M01-T07** — Build the first shared UI primitives and development catalog. **Verify:** the selected rounded `AppIcon` adapter/catalog and buttons, fields, cards, dialogs, loading/empty/error/focus states have synthetic fixtures and widget/visual/semantic checks in both themes; explicit and implicit controls have no Material/built-in icon fallback.
- [ ] **M01-T08** — Create app-local navigation and traceability indexes. **Verify:** READMEs, module/feature/route/component maps, and requirement-to-test indexes point to real initial files and the root specs; future items are labeled planned.
- [ ] **M01-T09** — Add reproducible test/CI foundations. **Verify:** documented commands run actual formatting/lint/type/unit/widget/build checks for existing apps, isolate fixtures, check generated changes when present, and include an approved macOS path rather than a false iOS pass.
- [ ] **M01-T10** — Review the foundation from a fresh checkout. **Verify:** setup instructions reproduce the API and mobile shell, failures are understandable, no application secrets are exposed, and all unresolved native/environment blockers are recorded before M02.

## Exit gate

API/mobile shells and their documented checks run with approved versions. Appearance/adaptive behavior is tested before feature screens multiply. No deployment or product functionality is implied by successful scaffolding.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| M01-T01 | Verified for local bootstrap | Coding agent / 2026-10-24 UTC | [Decision 0012](../cookbook/decisions/0012-local-development-bootstrap.md); [bootstrap report](../cookbook/local-development-bootstrap.md); root manifests, tool pins, ignore rules and separate generated lockfiles | Initial clean dependency setup and frozen/offline repeats passed using installed tools; `.env`/build outputs ignored. Not a production baseline or full M00 completion. |
| M01-T02 | Verified for local bootstrap | Coding agent / 2026-10-24 UTC | [API source/test map](../../apps/api/README.md); `pnpm check`, actual CLI startup/loopback HTTP and teardown | Strict lint/types/build and 19 tests passed. Live 200, readiness deliberately 503, invalid deployment settings rejected; no worker/provider/domain writes. |
| M01-T03 | Implemented; native verification pending | Coding agent / 2026-10-24 UTC | [Mobile source/test map](../../apps/mobile/README.md); analysis, formatting and 12 passing host tests | Localized shell and Android/iOS wrappers exist; staging/production fail closed. Native build/device/Mac prerequisites remain unverified. No emulator installation or real-data feature. |

The owner's local-setup authorization does not mark the whole foundation milestone complete. M01-T04–T10, full design/navigation, native checks and the fresh-checkout review remain outstanding. Do not resume the optional host inventory as a prerequisite to ordinary local coding; return to native/access gates when needed for that work.
