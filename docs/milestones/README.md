# Your Own — Milestone and Task Index

- **Version:** 0.9
- **Status:** M00 in progress; M00-T01/T02 owner decisions and M00-T03 static audit verified; all application implementation tasks unverified
- **Current milestone:** [M00 — Decisions and validation](00-decisions-and-validation.md)
- **Active task:** [M00-T04 — Toolchain and workspace review](00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), In progress; T04-A–D directions accepted and ApexCharts hold confirmed in Decision 0004. The [candidate review](../cookbook/toolchain-review.md) and [compatibility follow-up](../cookbook/toolchain-compatibility.md) establish the published SDK pair, withdraw EOL ESLint 9 and retain unresolved frontend lint coverage, runtime/final-pin validation and ApexCharts entitlement. A chart-free disposable probe is proposed, not authorized. The [static audit](../cookbook/reference-app-audit.md) and [license/provenance register](../cookbook/reference-app-licenses.md) are complete; no reference code/assets or dependency tree adopted.
- **Accepted decisions:** [0001 — Android-first pilot and release tracks](../cookbook/decisions/0001-scope-and-release-tracks.md) · [0002 — Rounded icons and chart rendering](../cookbook/decisions/0002-rounded-icons-and-chart-rendering.md) · [0003 — Product defaults](../cookbook/decisions/0003-product-defaults.md) · [0004 — Toolchain directions and icon family](../cookbook/decisions/0004-toolchain-directions-and-icon-family.md). These decisions do not complete dependency/design validation or authorize installation, spikes or scaffolding.
- **Authority:** [PRD](../PRD.md), [Architecture](../cookbook/architecture.md), and the platform specifications. This plan sequences that scope; it does not approve pending technologies or add features.
- **Repository entry:** [README](../../README.md) · [Agent instructions](../../AGENT.md)

## How to use this plan

Work through one bounded task at a time. The numbered files give a recommended order; the dependency column identifies real prerequisites. A later independent track can be brought forward with a recorded decision, but never skip a safety/approval gate to make the schedule look complete.

The initial plan contains **20 milestone files and 224 tasks**, including optional M19. Checkboxes start unchecked and change only with evidence: **M00-T01 through M00-T03 are verified; the other 221 tasks remain unchecked**. Plans alone do not prove completed code, tests, infrastructure or approvals and do not promise dates. Application and evidence paths are targets until those artifacts exist.

## Milestone map

| ID | Milestone / task file | Required prerequisites | Product track | Current status |
|---|---|---|---|---|
| M00 | [Decisions, audit, and validation](00-decisions-and-validation.md) | None | Approval gate | In progress |
| M01 | [Repository and app foundations](01-foundations.md) | M00 | API/mobile foundation | Planned |
| M02 | [Identity and personal data foundation](02-identity-and-data-foundation.md) | M01 | V1-A foundation | Planned |
| M03 | [Water logging end-to-end slice](03-water-vertical-slice.md) | M02 | First verified V1-A slice | Planned |
| M04 | [Read mode](04-read-mode.md) | M03 | V1-A | Planned |
| M05 | [Focus mode and durable timer](05-focus-mode.md) | M03 | V1-A | Planned |
| M06 | [Complete Intake](06-intake-mode.md) | M03 | V1-A | Planned |
| M07 | [Manual Money](07-money-mode.md) | M03; approved Money/currency/savings decisions from M00 | V1-A | Planned |
| M08 | [Today, Progress, private cards, data controls](08-personal-experience.md) | M04, M05, M06, M07 | V1-A completion | Planned |
| M09 | [Personal release and recovery readiness](09-personal-release-readiness.md) | M08 | V1-A release gate | Planned |
| M10 | [User-web foundation and public presence](10-web-foundation-w0.md) | M00, M01 | W0 | Planned |
| M11 | [Gated social backend and staff contracts](11-social-backend.md) | M08, M09 | V1-B/A0 backend; no public launch | Planned |
| M12 | [Admin safety workflows](12-admin-safety-a0.md) | M11 | A0; required before public social | Planned |
| M13 | [Mobile social publishing](13-mobile-social-v1b.md) | M09, M11, M12 | V1-B release gate | Planned |
| M14 | [Personal user website](14-web-personal-w1.md) | M09, M10 | W1 | Planned |
| M15 | [Social user website](15-web-social-w2.md) | M11, M12, M14 | W2 release gate | Planned |
| M16 | [Admin operational completion](16-admin-operations-a1.md) | M11, M12 | A1 | Planned |
| M17 | [Reposts and one-to-one messaging](17-reposts-and-messaging.md) | M11, M12, M13, M15 | V1-C / W3 | Planned |
| M18 | [Full-scope verification and rollout](18-full-release-readiness.md) | M09, M13, M14, M15, M16, M17 | Declared V1 / W3 / A1 delivery | Planned |
| M19 | [Optional editorial/configuration CMS](19-optional-editorial-a2.md) | M16 plus explicit scope approval | Optional A2; not a V1 launch blocker | Not scheduled |

M10 may run earlier after its listed prerequisites; M16 does not depend on completion of the user website. The default ordering deliberately prioritizes mobile personal utility and safety before broader web parity. M11 can be tested with synthetic data behind closed release controls; public social requires M12 and the applicable release gate.

Mobile V1-A/B/C, web W0–W3, and admin A0/A1 are separate release tracks. A platform can ship a verified subset before the combined M18 review when its own published scope and all safety/operations gates pass. M17 groups related cross-client work for tracking; it does not require withholding a ready mobile release merely because a browser UI is still unfinished. Any such split must be recorded with task-level prerequisites and platform evidence.

## Task workflow and evidence

Task IDs are stable: **M00-T01**, **M00-T02**, and so on. Keep IDs when reordering or renaming. If a task is too large, add linked subtasks such as `M07-T03.1` and preserve the parent; do not silently remove acceptance requirements.

**Task prerequisites:** Unless stated otherwise, each task requires the milestone's listed prerequisites and preceding required tasks in its ordered checklist. Record finer-grained dependencies before parallel work or an approved deferral; neither can waive an exit/safety gate. Requirement labels identify affected scope, not a claim that every aspect is finished in that milestone. Maintain the detailed requirement → code → test/evidence map as implementation begins.

1. Read the task's sources and dependencies. Check actual code/tooling and the latest evidence log.
2. Record the selected task as **In progress** in that file's log and update the active-task pointer here. Default to one active task; record intentional parallel ownership explicitly.
3. Implement or resolve the requested decision without broad unrelated changes.
4. Add/update tests, indexes, contracts, and docs that the change affects.
5. Run the required checks or record a blocker. Capture evidence without private data.
6. Mark **Implemented** when artifacts exist but required verification/approval is outstanding; leave its checkbox unchecked.
7. Mark **Verified** and check the task only when its stated proof and applicable checks exist. Approval/release tasks require the authorized owner's recorded decision, not agent inference.
8. Finish with changed paths, actual checks/results, remaining risks, and the next eligible task. Update milestone status only when every required task and exit gate is verified.

| Status | Meaning | Checkbox |
|---|---|---|
| Not scheduled | Optional track awaits an explicit scope/go decision | Unchecked |
| Planned | Not started; prerequisites may still be pending | Unchecked |
| In progress | Named current work | Unchecked |
| Blocked | Missing decision, dependency, environment, or failing check; record unblock action | Unchecked |
| Implemented | Work exists, but verification/approval is incomplete | Unchecked |
| Verified | Required acceptance evidence and approvals recorded | Checked |
| Deferred | Explicitly approved scope/order change, with reason and impact | Unchecked; not silently counted as complete |

Keep evidence in the relevant milestone log, linking commits/diffs, test paths, sanitized CI artifacts, reports, or approved decisions. Do not fabricate commit hashes, test outputs, screenshots, or approval dates. Logs may append several events for one task; the latest event describes its current state. If a verified task regresses, reopen it and record why.

Suggested task-log row:

```text
Task | Status | Owner / date | Evidence | Notes / next action
Mxx-Tnn | In progress | actual owner / actual date | existing artifact link | current scope
```

Repository-wide decisions live in `docs/cookbook/decisions/`, as accepted in [Decision 0001](../cookbook/decisions/0001-scope-and-release-tracks.md). The project owner approves; agents investigate and record evidence. App-local `docs/decisions/` may hold genuinely local decisions and reference shared records, never conflicting copies. Root specs remain the source of requirements; task logs and app-local `TRACEABILITY.md` link them to code/evidence.

## Checks required throughout

These apply to every affected slice, not just the final milestone:

- Relevant unit/component tests, lint/type/format checks, and real integration tests where needed.
- Ownership/privacy, stable operation IDs, revisions/conflicts, exact Money semantics, and safe migration behavior.
- Light/Dark/System, all four usable size classes, short height, 200% text, applicable browser zoom, keyboard/screen-reader behavior, and preserved drafts/timers.
- No secret/private-data leakage through logs, fixtures, images, SSR/metadata, caches, workers, or exported artifacts.
- User/admin session separation, current staff assurance, and the finite-feed/product boundaries.
- Updated affected route/module/component/job indexes and requirement-to-test traceability.

Formatting/link validation is sufficient evidence for a documentation-only task when that is its stated scope; it never verifies application behavior or production readiness. Numerical budgets, providers, OS/browser targets, retention, and recovery policies must be approved and then tested—not guessed.

## Gates that cannot be bypassed

- **Before scaffold:** M00 baseline decisions and risky integration/design spikes have evidence. One approved framework does not approve every proposed library.
- **Before real personal data:** encrypted persistence/key management, authenticated ownership, migrations, export/deletion/retention, backups/restore, and relevant security/device tests are verified.
- **Before public social:** A0 operational moderation, trusted staff MFA/grants, private-media revocation, age/region/privacy/community policies, named support/operators, and the full affected privacy matrix are verified.
- **Before messaging/reposts:** source permissions, contact/block races, durable retries/order, safe previews, abuse controls, and message export/deletion policy are verified.
- **Before production changes:** explicit environment/action authorization, compatible artifacts/migrations, rollback/recovery evidence, and release scope approval exist.
- **Optional work:** A2 and future trackers/games/banking/richer messaging are not automatically part of this plan. A2 needs its explicit approval; prohibited product expansions remain prohibited.
