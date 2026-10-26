# Your Own — Milestone and Task Index

- **Version:** 1.25
- **Status:** M00 remains open; M01-T01/T02/T04 locally verified and T08 documentation verified; T03 shell, T05 appearance, T06 adaptive navigation, T07 shared catalog, T09 local automation and T10 fresh-checkout review implemented/host-tested with native/CI foundation exit still blocked.
- **Current review:** [M00-T06 — Infrastructure/provider baseline](../cookbook/provider-baseline-review.md), **partially accepted under Decision 0013**, full operational baseline/execution still blocked; [M01 — foundations](01-foundations.md) remains open under [Decision 0012](../cookbook/decisions/0012-local-development-bootstrap.md)
- **Latest completed task:** M01-T08 app-local [API](../../apps/api/docs/MODULE_INDEX.md) / [mobile](../../apps/mobile/docs/FEATURE_INDEX.md) navigation and traceability indexes, verified for documentation scope under Decision 0012. **Latest reviewed slice: M01-T10 [fresh-checkout reproduction](../cookbook/fresh-checkout-review.md)** — initial 320-test reproduction found pre-script pnpm installation; corrected Node bootstrap and fail-closed dependency policy pass 321 tests plus synthetic CLI startup/HTTP/teardown. T10's full foundation exit stays unchecked. Hosted CI and approved macOS/native lanes remain blocked, so T09 stays unchecked. T07's shared UI/native accessibility/IME/rendering checks also remain open. T05/T06 were separately committed/pushed as `983de74` / `df3a85c`; T07 was separately committed/pushed as `c07236e`. T03/T05/T06 native checks remain open. T08 was separately committed/pushed as `b4c4f0c`; T09 was separately committed/pushed as `28c5e2f`. **Latest decision packet: M00-T06 [provider-baseline review](../cookbook/provider-baseline-review.md)** — the owner's “continue” to the direction question now accepts INF-01–04 and the separate server-side session approach in [Decision 0013](../cookbook/decisions/0013-provider-and-session-directions.md), not physical session-store hosting or full T06. The prior review was published as `eb30d49`. Next action: separately authorize the [local PostgreSQL/Prisma probe](../cookbook/local-database-spike-plan.md); it is planned/not run and no implementation task is running. T10 was separately committed/pushed as `7b9fc4e`; M01's remaining gates are recorded, not waived. No M02, hosted/native execution or release approval follows.
- **Retained review:** [M00-T05 — Supported-environment review](00-decisions-and-validation.md#m00-t05--supported-environment-review), **Blocked / unchecked** under [Decision 0011](../cookbook/decisions/0011-supported-environment-review-order.md)'s bounded review scope. The owner reports **“belum ada.”**: no test devices or Mac access yet. [Review and next steps](../cookbook/supported-environments-review.md#7-owner-availability-and-next-steps) retain unresolved access, target/budget choices and test ownership; the [Windows/emulator plan](../cookbook/windows-emulator-validation-plan.md) now records the separately authorized non-admin, no-network P0 inventory. Eight metadata groups observed; acceleration/readiness unverified, setup/eight synthetic cases Not run. The [P1 review](../cookbook/windows-emulator-feasibility.md) holds setup on unresolved WHPX/GPU/native-tool evidence and an unaccepted resource envelope. That review's proposed next host read is now deferred by the owner's setup instruction. Decision 0012 permits local scaffolding, not an emulator/native-readiness waiver or acceptance of the proposed storage envelope.
- **Open preceding task:** [M00-T04 — Toolchain and workspace review](00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), Blocked/open and paused during local bootstrap; target/rights/library/production-pin blockers retained. T04-A–D directions accepted and ApexCharts hold confirmed in Decision 0004. The [candidate review](../cookbook/toolchain-review.md) and [compatibility follow-up](../cookbook/toolchain-compatibility.md) establish the published SDK pair, withdraw EOL ESLint 9 and retain unresolved frontend lint coverage, runtime/final-pin validation and ApexCharts entitlement. Decision 0005 authorized the [isolated chart-free probe](../cookbook/toolchain-probe.md): tool versions and limited JS build/HTTP checks passed; mobile resolution rejected retracted build_runner 2.17.0. The 2.16.2 retry authorized by [Decision 0006](../cookbook/decisions/0006-mobile-probe-generator-retry.md) passed resolution, generation, analysis and six host tests, without production scaffolding. [Decision 0007](../cookbook/decisions/0007-isolated-lint-probe.md) authorized the [separate lint experiment](../cookbook/toolchain-lint-probe.md) with exactly three temporary peer exceptions: 668 focused diagnostic checks and both apps' clean lint/strict type checks passed using Next's original rules. This is an exception-based result, not production peer-policy approval. The [notice/readiness review](../cookbook/toolchain-notices.md) records 16 missing-file dispositions (14 text/declaration mappings; two partial), separate graph/embedded inventories and bootstrap/support recommendations. The [trace follow-up](../cookbook/toolchain-notice-trace.md) identifies existing upstream requests, triages all 17 missing-sibling paths and prepared the bounded combined-graph/launcher plan subsequently authorized by [Decision 0008](../cookbook/decisions/0008-isolated-combined-js-probe.md). The [combined attempt](../cookbook/toolchain-combined-probe.md) passed tool/lock-only resolution checks but stopped before application installation/build/lint on a high Multer advisory. [Decision 0009](../cookbook/decisions/0009-isolated-multer-override-retry.md) subsequently authorized the exact-parent Multer 2.5.0 [retry](../cookbook/toolchain-multer-retry.md): ten regressions, combined build/HTTP checks, 668 lint expectations, 16 clean files and frozen equality passed; fresh audits reported zero known advisories. Embedded/native notices, ApexCharts rights and final pins remain open; no production adoption follows from the retry. [Decision 0010](../cookbook/decisions/0010-conditional-dependency-exceptions.md) separately accepts the [adoption packet's](../cookbook/toolchain-adoption-review.md) exact A/B policies and project-owner/30-day review/revalidation/removal controls. Next policy review: **2026-11-23 UTC at the latest**, or an earlier adoption/change/release trigger. No baseline adoption, new execution, final pins or task advancement is approved by Decision 0010. The [static audit](../cookbook/reference-app-audit.md) and [license/provenance register](../cookbook/reference-app-licenses.md) are complete; no reference code/assets or dependency tree adopted.
- **Accepted decisions:** [0001 — Android-first pilot and release tracks](../cookbook/decisions/0001-scope-and-release-tracks.md) · [0002 — Rounded icons and chart rendering](../cookbook/decisions/0002-rounded-icons-and-chart-rendering.md) · [0003 — Product defaults](../cookbook/decisions/0003-product-defaults.md) · [0004 — Toolchain directions and icon family](../cookbook/decisions/0004-toolchain-directions-and-icon-family.md). [0005 — Isolated chart-free probe](../cookbook/decisions/0005-isolated-compatibility-probe.md), [0006 — Mobile retry](../cookbook/decisions/0006-mobile-probe-generator-retry.md) and [0007 — Isolated lint experiment](../cookbook/decisions/0007-isolated-lint-probe.md) authorize only their bounded temporary execution, including 0007's three exact peer exceptions. [0008 — Combined JS/launcher probe](../cookbook/decisions/0008-isolated-combined-js-probe.md) separately authorized the same three allowances for one combined attempt, now stopped at its security gate. [0009 — Multer override retry](../cookbook/decisions/0009-isolated-multer-override-retry.md) separately authorized only the exact-parent fixed-version experiment, whose bounded checks passed; that experiment did not approve production policy or pins. [0010 — Conditional dependency exceptions](../cookbook/decisions/0010-conditional-dependency-exceptions.md) separately accepts eligibility of the exact A/B policies and maintenance controls, not a production baseline, final pins or new execution. [0011 — Supported-environment review order](../cookbook/decisions/0011-supported-environment-review-order.md) brings forward only T05 review with T04 still open, not target acceptance. [0012 — Local development bootstrap](../cookbook/decisions/0012-local-development-bootstrap.md) subsequently permits initial API/mobile scaffolding with installed tools; it does not complete full dependency/design/native/release validation.
- **Latest direction decision:** [0013 — Provider/session directions](../cookbook/decisions/0013-provider-and-session-directions.md). Exact dependencies, hosted resources, auth method/protocol, physical session store, budget/regions/keys/recovery and local probe execution are not approved by this decision; T06 stays unchecked.
- **Authority:** [PRD](../PRD.md), [Architecture](../cookbook/architecture.md), and the platform specifications. This plan sequences that scope; it does not approve pending technologies or add features.
- **Repository entry:** [README](../../README.md) · [Agent instructions](../../AGENT.md)

## How to use this plan

Work through one bounded task at a time. The numbered files give a recommended order; the dependency column identifies real prerequisites. A later independent track can be brought forward with a recorded decision, but never skip a safety/approval gate to make the schedule look complete.

The initial plan contains **20 milestone files and 224 tasks**, including optional M19. Checkboxes start unchecked and change only with evidence: **M00-T01 through M00-T03 and local M01-T01/T02/T04/T08 are verified; the other 217 tasks remain unchecked**. Plans alone do not prove completed code, tests, infrastructure or approvals and do not promise dates. Application and evidence paths are targets until those artifacts exist.

## Milestone map

| ID | Milestone / task file | Required prerequisites | Product track | Current status |
|---|---|---|---|---|
| M00 | [Decisions, audit, and validation](00-decisions-and-validation.md) | None | Approval gate | In progress |
| M01 | [Repository and app foundations](01-foundations.md) | M00; initial local bootstrap brought forward by Decision 0012 | API/mobile foundation | In progress |
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

**Task prerequisites:** Unless stated otherwise, each task requires the milestone's listed prerequisites and preceding required tasks in its ordered checklist. Record finer-grained dependencies before parallel work or an approved deferral; neither can waive an exit/safety gate. **Recorded exception:** Decision 0011 permits only M00-T05 review before M00-T04 completion because final pins need target constraints. T05 remains blocked and T04 paused/open. Decision 0012 additionally permits the initial M01-T01–T03 local setup and its later recorded T04/T05/T06/T07/T08/T09/T10 continuations before full M00/T14 completion. T03's missing native prerequisites remain open and do not block those local coding tasks; T03/T05/T06/T07 do not gain a native pass from host tests. Decision 0012's subsequent provider-review continuation permits only M00-T06 decision preparation before T04/T05 and M01 exit; Decision 0013 subsequently accepts scoped technical directions, not full T06; exact selections, spike execution, provisioning and M02 remain gated. Remaining task/milestone prerequisites are unchanged. Requirement labels identify affected scope, not a claim that every aspect is finished in that milestone. Maintain the detailed requirement → code → test/evidence map as implementation begins.

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

- **Local scaffold exception:** Decision 0012 explicitly permits the initial API/mobile bootstrap using installed tools before full M00 completion. This is not approval of every proposed library or of a production baseline. Full M00/T14 and integration/design/native evidence remain required before affected real-data, production or release work.
- **Before real personal data:** encrypted persistence/key management, authenticated ownership, migrations, export/deletion/retention, backups/restore, and relevant security/device tests are verified.
- **Before public social:** A0 operational moderation, trusted staff MFA/grants, private-media revocation, age/region/privacy/community policies, named support/operators, and the full affected privacy matrix are verified.
- **Before messaging/reposts:** source permissions, contact/block races, durable retries/order, safe previews, abuse controls, and message export/deletion policy are verified.
- **Before production changes:** explicit environment/action authorization, compatible artifacts/migrations, rollback/recovery evidence, and release scope approval exist.
- **Optional work:** A2 and future trackers/games/banking/richer messaging are not automatically part of this plan. A2 needs its explicit approval; prohibited product expansions remain prohibited.
