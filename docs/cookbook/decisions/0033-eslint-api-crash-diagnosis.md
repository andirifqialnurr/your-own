# Decision 0033 — Bounded ESLint/TypeScript API-crash diagnosis

- **Status:** Diagnosis completed; repeated-file single-run fallback reproduced; no remediation/adoption sign-off
- **Owner / authorization:** Project owner, 2026-11-01 UTC after `c2f1a4b`
- **Tasks:** Preparatory M00-T04; full task unchecked, seven tasks checked, full M02 Planned
- **Input:** [Decision 0032](0032-minimatch-tooling-adoption.md), [retained API failures and incomplete tooling adoption](../minimatch-tooling-adoption.md)
- **Result:** [Causal comparisons, public program evidence and proposed next scope](../eslint-api-crash-diagnosis.md)

## Explicit answer and limits

The assistant asked **“May I investigate that crash only, without further dependency or application changes?”** The owner replied **“continue”**. Authorize bounded diagnosis only: preserve/reproduce the supplemental public ESLint/TypeScript API crash, compare public CLI/API calls and controlled invocation/sequence/environment/path differences, inspect exact published source as data and exercise relevant public semantic/compiler APIs. Minimize only in new C:-only diagnostic files/mirrors, with the installed reviewed fixed graph and unchanged rule implementations/options. Record causal evidence or uncertainty; do not retry merely to obtain green.

No dependency resolution/install/update, manifest/lock/override/parser/rule/application change, vendor patch/private runtime import, guard/assertion/timeout waiver, upstream issue posting or production risk acceptance. Existing three exact overrides/policy B, all tool pins and November 23 latest policy deadline stay unchanged. Original failures and prior fixtures/snapshots remain immutable; owner .env files remain ignored/untracked/byte-preserved and never loaded into probes. Auth integration stays paused (0/5); no DB/Docker/engine/generation/R2/mail/cloud/native/browser/Flutter/hosted or global-tool/host-setting action.

Require fresh actual-graph advisory and installed-integrity preflight before package execution. Use existing pinned Node 24.18.0/pnpm 12.8.1/TypeScript 6.0.3 and script-denied policies; do not repeat the historical Corepack fetch. New allocations C:-only, **<3 GiB additional /≥20 GiB free**, bounded child/log/time limits and ownership-scoped cleanup. C:-only mirrors may reuse existing reviewed installations through owned junctions, without changing package graphs or prior fixtures. Synthetic contexts are not a new application parser policy.

## Recorded diagnosis

Default CI inference selects single-run mode. A second typed parse of the same file with legacy project/no projectService takes the published module-level counter's isolated-program branch. Public services show 687-file/full-project →one-file/noResolve/empty-directory context; semantic/type operations reproduce the TypeScript crash. Two ESLint instances do not reset that counter. A child-only explicit long-lived mode retains 687-file project services and lets the unmodified original/reordered probes return with their existing assertions in repeated controlled comparisons. No rule, dependency or repository parser policy changes. Inline, direct-parser and source/sequence controls narrow the cause without claiming a universal fix or upstream support.

The earlier reordered probe lacked a marker for its second typed glob call; the initial-scan interpretation was unsupported. A stage-only copy demonstrates first scan returned /second typed scan crashed. Preserve the original failed logs and corrected interpretation. Full adoption validation/negative controls and auth remain paused; propose a separately authorized new external harness worker-mode correction and revalidation only.

This scope permits diagnosis/evidence and a normal scoped documentation commit/push, **not** an automatic fix, completed adoption revalidation, resumed I1 or task/milestone closure. A proposed harness correction, policy/configuration change, dependency fix, explicit limitation disposition or adoption sign-off must be distinguished and separately scoped where needed.
