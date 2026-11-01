# ESLint/TypeScript API-crash diagnosis

- **Recorded:** 2026-11-01 UTC after `c2f1a4b`
- **Authority:** [Decision 0033](decisions/0033-eslint-api-crash-diagnosis.md), diagnosis only
- **Result:** Repeated typed parsing under inferred single-run mode selects an isolated program; causal mechanism reproduced. **No fix or adoption sign-off applied.**
- **Tasks:** Preparatory M00-T04 only; seven tasks checked, full M02 Planned; five auth tasks still 0/5

## 1. Scope and preservation

The owner answered **“continue”** to **API-crash investigation only / no further dependency or application changes**. All new diagnostics/evidence are C:-only. The actual 201-identity lock, three exact minimatch overrides/policy B, Node **24.18.0**, pnpm **12.8.1**, TypeScript **6.0.3**, ESLint **10.13.0**, typescript-eslint/parser **8.72.0**, rules, parser configuration, application/S0, mobile and ignored private files remain unchanged. No install/resolution, vendor patch/private runtime import, cache-clearing hook, global environment/tool change, app/source canary, DB/HTTP/auth/native/cloud action or old-fixture rewrite occurs.

Fresh actual-graph npm/OSV responses are empty at preflight and all **6,747 installed archive files** are rehashed against the reviewed inventory before package execution. These are prerequisites, not legal/security certification or adoption approval. Normal root `pnpm check`/build/176-entry results remain the **previous** task's evidence; this phase does not rerun those suites or Flutter/native/hosted lanes.

## 2. Causal mechanism

The actual config uses legacy **parserOptions.project**, not projectService. Exact installed published source, inspected as data and hash-recorded:

1. `inferSingleRun.js` infers a one-time run from **CI=true** unless explicitly told otherwise. The published options declarations describe automatic inference and its public control; the implemented `TSESTREE_SINGLE_RUN=false` branch is explicit.
2. `parser.js` keeps a **module-level per-file parse count**. With `singleRun`, a repeated file and no projectService, it assumes an ESLint fix cycle and calls `createIsolatedProgram` rather than the cached full project. This happens even when the file text is unchanged and even across two `new ESLint(...)` instances in the same process.
3. `createIsolatedProgram.js` supplies a one-file/noResolve context and a host current directory of `''`. Public parser/compiler services expose that change directly. TypeScript 6.0.3 then throws from `normalizeSlashes → getNormalizedAbsolutePath → getLocalModuleSpecifier` in the observed semantic/type operations; the typed rules encounter the same stack. No private helper is imported/called or patched.

Public **parseForESLint** observations for two identical parses of real `app.ts`, repeated in fresh independent processes:

| Diagnostic mode, CI kept true | First program | Second program | Observed result |
|---|---|---|---|
| Default automatic inference | 687 files; real tsconfig; noResolve false | **1 file; configFilePath null; noResolve true; currentDirectory empty** | Same TypeScript includes-of-undefined failure |
| Explicit single-run true | Same full first program | Same isolated second program | Same failure |
| Explicit long-lived worker (`TSESTREE_SINGLE_RUN=false`) | 687 files; real tsconfig | **687 files; same tsconfig; noResolve false** | Both semantic checks return zero diagnostics; type remains ExpressAdapter |

The public parser probe initially let the compiler exception escape before it wrote the report; that original failure is retained. A new capture-only revision records program metadata before semantic calls and **keeps runtime compiler failures nonzero**. It does not make the failing default/single-run cases pass.

The direct parser reproducer uses **no ESLint discovery or minimatch matching**, no virtual source changes and no glob input. This identifies the relevant parser/program-lifecycle mechanism in this pinned graph; it is not proof of a new minimatch defect, universal upstream compatibility or a tested fix in another version. No vulnerable minimatch baseline, package upgrade or upstream issue posting is used.

## 3. Controlled comparisons

All calls use reviewed public package APIs/CLI exports and the unchanged repository config. Diagnostic-only worker mode differences are confined to child environments, not owner .env, workspace policy or persistent configuration.

- Minimal one-file/all-file scans and config inspection + one scan return cleanly; actual discovery is **31 files**. Direct ESLint CLI and the existing .CMD shim both return cleanly.
- Repeated parsing of **one identical typed file** fails on the **second** scan under default CI inference. Creating a second ESLint instance in the same process still fails; it does not reset the parser module's count.
- New process boundaries preserve default CI/configuration and let each independent single scan return cleanly. These observations alone are not a completed replacement validation harness.
- The original and reordered [adoption probes](minimatch-tooling-adoption.md) reproduce the failure with new/old isolated home paths and with/without the actual shim NODE_PATH. Consumer-resolution/config-inspection/git preambles are unnecessary: independent ablations return cleanly until a repeated typed scan is added.
- An inline diagnostic entry launched on D: also fails on the second scan; a C:-resident script location is not necessary. No source mirror or package install is needed.
- A registered confirmation matrix repeats **default/explicit-single/explicit-long-lived × repeated ESLint/public-parser cases twice**. Default/single cases fail; long-lived cases retain full project services and return cleanly. No rule/severity/compiler-option/guard/assertion/timeout is changed.
- Unmodified original and reordered full probes, through an owned lifecycle wrapper, fail under default mode and **return with their existing assertions under long-lived mode**, each twice. Effective **64-JS/118-TS** configs, 31-file discovery, six ignore checks, type-aware/JS diagnostics and the typed glob assertions remain intact. These are mode-comparison experiments, **not completion of the previously paused matching/resource/negative-control/adoption matrix**.

Watch-host processes are terminated only after synchronous diagnostic output, preserving nonzero failure status. No private cache-clear utility, global error handler or logger suppression is used. Reproduced runtime failures remain failures, not relabeled successful lint runs. This phase closes **54 bounded diagnostic child invocations: 29 exit zero, 25 nonzero failure reproductions**; it does not claim “54 passing tests.”

## 4. Correction of the earlier stage interpretation

The [previous report](minimatch-tooling-adoption.md) initially described the reordered attempt as failing in the initial scan. Its logging marked the initial scan and virtual-text phase, **but did not mark the intervening second typed glob scan**. Absence of the virtual-text marker did not locate the failure in the first call.

A new copy with **stage markers only** shows:

```text
phase: actual filesystem scan
diagnostic: first scan completed
diagnostic: second typed scan begins
TypeError: Cannot read properties of undefined (reading 'includes')
```

The original source/logs remain unchanged; the corrected interpretation is **second typed scan**, not initial scan. The earlier reordering attempt still failed, and the old mixed-virtual-text hypothesis was not the cause: repeated identical disk input suffices. Nothing here retroactively makes a failed attempt pass.

## 5. Proposed next step — not applied

Create a **new external validation driver**, preserving old fixtures, that declares its multi-pass API worker as long-lived with the documented public mode control. Keep the repository CLI/default CI behavior, manifests/lock/overrides/parser options/rules and all existing assertions/timeouts unchanged. Require public program/type evidence so expected type-aware diagnostics cannot be mistaken for diagnostics from a degraded isolated program. A fresh process per typed operation is an alternative, but virtual-text/project consistency needs its own checks; merely constructing a new ESLint instance is insufficient.

Only after separately authorized full revalidation should the paused **Decision 0032 tooling verification** be reconsidered. Its six expected-red controls/restored/repeat stages were not completed by this diagnosis. Do not set the variable globally, change the application parser to projectService, call private clearCaches functions, suppress typed rules or update TypeScript to conceal the failure. Autofix, arbitrary multi-pass/IDE use, production support, native/CI/shipping and the unsupported ^10→11 parent edges retain their gates. No policy review/renewal or release acceptance follows.

**Requested next owner scope:** external-harness worker-mode correction and the unfinished tooling validation only, with no dependency/policy/application changes and auth still paused. Do not resume I1-B2–B6 or patch historical integration fixtures automatically.

## 6. Evidence

**`C:/Users/HP/AppData/Local/Temp/your-own-eslint-diagnosis-6ijmtlp1/`**:

- `baseline.json`, `prior-hashes.json`, fresh preflight advisory responses/integrity record, `common.py` and bounded process logs.
- `probe.mjs`, initial CLI/API/config/shim comparisons, `reproduce.py` and immutable-original probe results, `ablate.mjs`/ablation outcomes.
- `parser-probe-before-capture.mjs`, original parser exception, capture-only `parser-probe.mjs`, `modes.py`, two-round confirmation reports and public program/compiler metadata.
- `full-and-inline.py`, unchanged original/reordered probe comparisons, inline entry results, stage-only `reordered-staged.mjs` and failed/returned traces.
- `source-references.json`, exact installed source hashes, original .CMD NODE_PATH data, preservation/redaction/resource/cleanup/documentation records.

Fresh post-diagnosis npm/OSV responses over the same **201 identities** are empty at **2026-11-01T17:14 UTC**; all **6,747 installed files** are rehashed again. These dated responses do not clear the pending adoption/unsupported-parent/shipping gates. At a fresh-stat deduplicated capture, new evidence occupies **598,793 bytes**, C: has **34,170,265,600 bytes free** and D: **211,946,668,032 bytes free**. Volume free space changes independently; no diagnostic data is allocated on D:. The **<3 GiB additional /≥20 GiB free** bounds remain satisfied. All **685 prior adoption evidence files** hash unchanged; old scripts/logs are read but never rewritten.

Documentation validation passes **132 Markdown /2,042 local links /four JSON examples /34 owned JS/TS/JSON whitespace checks**. No new dependency or application artifact is committed; exactly eleven diagnosis/authority/status documentation paths change. Preserve **13 immutable snapshots /67 requirements /224 tasks /20 plans /seven checked tasks**, full M02 Planned and **2026-11-23 UTC latest policy deadline**. Five integration tasks remain 0/5; adoption sign-off stays pending the separately scoped validation.
