# External worker correction and completed tooling validation

- **Recorded:** 2026-11-02 UTC after `d593e0e`
- **Authority:** [Decision 0034](decisions/0034-tooling-harness-revalidation.md), external-worker correction/unfinished tooling checks only
- **Result:** **Specific local repository tooling validation stop closed** under [Decision 0032](decisions/0032-minimatch-tooling-adoption.md); no new dependency/policy/application change
- **Tasks:** Preparatory M00-T04 only; seven tasks checked, full M02 Planned; auth I1-B2–B6 still **0/5**

## 1. Exact correction, not a rule or repository workaround

The owner answered **“continue”** to **correct only the external validation harness's worker mode and finish the paused tooling checks**. A new C:-only multi-pass API worker sets **TSESTREE_SINGLE_RUN=false in that child only**, with CI=true, before importing the parser. The normal repository CLI/default CI environment, actual ESLint/parser policy, application source and all pins/manifests/overrides/locks stay unchanged. No private cache-clearing helper, vendor patch/import, global variable, suppressed rule or assertion/timeout relaxation.

The old [failed adoption probes](minimatch-tooling-adoption.md) and [single-run diagnosis](eslint-api-crash-diagnosis.md) remain preserved, not rewritten to pass. This corrects the **validation worker lifecycle**, not TypeScript's isolated-program behavior universally. Autofix, arbitrary multi-pass/IDE configurations and upstream support are not inferred.

## 2. Fresh prerequisites and immutable graph

Before execution, fresh official metadata for **all 201 actual identities** matches the reviewed pinned integrity/dependency/peer/engine/script/license fields, with no deprecations; existing official archives are rehashed against SRI/SHA-256. The two new BlueOak-1.0.0 **LICENSE.md** files retain their reviewed bytes. Fresh npm/OSV actual-version responses are empty at **2026-11-02T05:52 UTC**, again at **06:09 UTC** after execution. Latest parent metadata is captured separately; no parent is automatically upgraded and their incompatible declarations are not converted into an upstream support promise.

Actual installed inventories before/after match exact file sets and hashes: **201 packages /6,747 files /52,561,322 payload bytes**. The original lock SHA-256 remains **`d8c89796f325d709013d84793445739f5743655dbbd8be7ae542de92901ceb23`**. Only minimatch **11.0.3**, helper **@isaacs/nonrecursive-glob-match 1.0.3** and the already accepted exact three parent overrides are in use; no 10.2.6 remains in the installed tree. Historical/inactive caches and old external graphs are preserved, not relabeled clean.

Strict peers/engines, automatic peers off, scripts denied, `verifyDepsBeforeRun:error`, policy B and C's exact selectors remain. Use hash-checked installed **pnpm 12.8.1 native /Node 24.18.0 /TypeScript 6.0.3**, isolated auth/home/state paths and Corepack network disabled. No new tool/package identity is installed and no hook/native/Prisma engine is executed. Existing notice/native/WASM/delivery-bundle/support obligations remain shipping gates.

## 3. Completed paused matrix and real type-service proof

- **173 expected matching tuples**, unchanged from E1, run across public CJS/ESM exports twice, followed by restored positives. Real consumer contexts resolve fixed minimatch. Dot/negation/partial/globstar/empty segments/Windows roots/UNC/case/Unicode and public utility/API-shape assertions remain unchanged. No vulnerable-baseline exploit or RegExp/AST compatibility shim.
- Strict public **.mts/.cts** fixtures compile twice and after the expected-red type control; strict optional/index checks and library checking remain. The deliberate invalid option fails **TS2322**, not missing-module/any typing.
- **Eight bounded fixed-version resource children** (four cases, twice), each retaining the 3-second process timeout, 128-MiB old-space option and 1,500-ms compute assertion. Max compute: **12.6178 ms**. Unmodified Node/V8 coverage verifies cap-reaching **128 rows** and the **1,100-row** pairwise-pass skip. These are deterministic small safety checks, not universal complexity/capacity policy.
- Corrected API worker positives run twice, then restored after controls. Actual discovery stays **31 clean files**; six ignored/unconfigured paths and the ten-file typed glob remain exact. Full normalized **64 JS /118 TS rule configurations/options** match E1, including parser/project root and globals. No source canaries are written to D:.
- Each successful worker records **eight public program checkpoints** before/after repeated scans, virtual text and disk restoration: **687 source files /ten project roots**, real unchanged tsconfig, noResolve false, skipLibCheck false, standard ES2024/Node types present, exact supplied text and zero semantic diagnostics. The actual adapter type remains **ExpressAdapter, not any**. The unsafe JSON.parse initializer is genuine any with the expected **no-unsafe-assignment** diagnostic; an added **Number.isFinite boolean** companion has a real non-any type and no lint error. Restored real main/adapter source is checked again. This prevents a degraded isolated-program diagnostic from masquerading as type-aware coverage.

**Seven assertion-specific expected-red controls** all fail at their intended markers, with vendor code/rules and assertions intact:

1. Invalid public option →TS2322.
2. Dot option changed only in the owned matcher adapter →DOT_DEFAULT_MUST_DENY.
3. Partial flag dropped only in the owned adapter →PARTIAL_MUST_NOT_DROP_FLAG.
4. Windows-root mode changed only in the owned adapter →WINDOWS_ROOT_MUST_NOT_ESCAPE.
5. Actual included-file result removed only in the owned collector →ACTUAL_FILE_DISCOVERY.
6. Actual typed diagnostic removed only in the owned collector →TYPE_AWARE_DIAGNOSTIC, while its report confirms the real rule produced it with full services.
7. Omit the worker's long-lived mode →**FULL_PROJECT_PROGRAM_entry-second**. Public metadata shows the one-file/noResolve fallback and the guard refuses it before treating it as valid typed coverage.

The first six finish the controls previously not reached in Decision 0032; the seventh guards the diagnosed lifecycle explicitly. Type/matching/API positives are restored after controls. Failed controls are deliberate test outcomes, not green lint invocations or rule removals.

## 4. Actual default-profile repository checks and retained failures

The worker-only mode variable is **absent** from all normal repository pnpm invocations. The immutable current graph passes an explicit frozen lock-only metadata verification and two **warm-cache offline/frozen/script-denied** lock checks without lock drift, new package identities or scripts.

**Unchanged full repository pnpm check passes on one unchanged retry and an independent repeat; pnpm build passes after each.** Each passing check contains **176 existing entries** (21 tooling +14 design/artwork +99 boundaries +42 API), lint/types and **41-source /137-directive** scanning, plus token/font/artwork consistency. Existing health/multipart HTTP tests retain normal teardown; no new auth/provider/DB composition or Flutter/native/hosted lane is exercised.

Two non-control failed invocations remain explicitly retained:

- The first offline lock-only check in the **new empty isolated metadata cache** fails **ERR_PNPM_NO_OFFLINE_META**, for required full registry metadata. It is not a pass. An **explicit, named online frozen lock-only metadata prerequisite** then verifies the same reviewed 201-entry graph and populates only the owned cache; there is no silent offline fallback, policy exception, new resolution or new dependency identity. Warm-cache offline checks subsequently pass.
- The first full repository check hits the **previously recorded 10-second API child-start signature**, `null !== 1` in environment.test.mjs (42 API entries:41 pass/one fail). It remains a failed run. One unchanged retry and the planned independent repeat pass all 176 entries. No timeout/assertion/serialization/source change, inferred root cause, global logger suppression or performance/native acceptance follows. This pre-existing intermittent failure remains a foundation/CI limitation.

The earlier TypeScript API failures are **not erased**, and the compiler's single-run repeated-parse behavior remains as diagnosed. The corrected harness +full project proof resolves this **specific validation blocker**; it does not certify arbitrary parser modes or hide the cold-cache/known-timeout failures.

## 5. Disposition and next boundary

Decision 0032's exact conditional **local repository tooling** adoption now has the previously missing repeated/control/restored evidence and fresh normal repository checks. Close only that local tooling validation stop. Keep owner accountability, independent safe-removal/review triggers, strictness and **2026-11-23 UTC latest review deadline**; this technical checkpoint does not renew/broaden policies A/B/C or remove unsupported-parent/shipping gates. Full M00-T04, native/hosted CI/full foundation exit and full M02 remain open.

**Auth remains paused and five integration tasks remain 0/5.** No auth/Prisma dependency, application principal producer, schema/protocol, DB/container or new route is adopted. Earlier external 344-identity fixtures are still historical inputs with their own security stop; do not edit them or infer that repository verification clears them. Any future I1-B2 continuation needs separately bounded authorization, a fresh patched combined-graph/security/install prerequisite and the existing provider/privacy/resource/transaction gates.

## 6. Evidence and preservation

Evidence root: **`C:/Users/HP/AppData/Local/Temp/your-own-tooling-validation-iri7eh5r/`**, baseline **2026-11-02T05:48:48.943665+00:00**.

- `baseline.json`, `prior-hashes.json`, exact metadata/archive/notice review, before/after advisory and exact installed inventories.
- `lint-worker.mjs`, complete first/repeat/restored program/config/discovery reports, seven targeted control logs/reports, `run-checks.py`, reused matching/type/resource source hashes and V8 cap/skip review.
- Normal-profile frozen/metadata/root-check/build logs, `attempt-0-cold-offline.log`, `attempt-1-root-timeout.log`, unchanged retry/repeat evidence and bounded child/cleanup records.
- Preservation/redaction/resource/documentation validation and publication record. All old fixture/failure files and all 13 repository snapshots remain immutable.

At a fresh-stat deduplicated capture, evidence occupies **99,869,135 bytes** (including the isolated pnpm metadata cache), C: has **32,441,389,056 bytes free** and D: **221,927,931,904 bytes free**. All **829 prior adoption/diagnosis evidence files** hash unchanged. Documentation passes **134 Markdown /2,069 local links /four JSON examples /34 owned JS/TS/JSON whitespace checks**; independent preservation/redaction validation covers exactly **13 documentation paths** with repository source/dependency/policy/private bytes unchanged.

No source/private .env value is copied/loaded into probes. Actual source/configuration/dependency/lock/policy/mobile/pin bytes remain unchanged; only authorization/evidence/status documentation is committed. Preserve 67 requirements /224 unique tasks /20 plans /seven checked tasks and unrelated services/caches. No Docker, DB/engine/generation, R2/mail/cloud/browser/native/Flutter/hosted or global-tool/host-setting change occurs. New supplemental allocations stay C:-only under **<3 GiB additional /≥20 GiB free**; ordinary authorized repository builds use existing D: dist without source changes or cache pruning.
