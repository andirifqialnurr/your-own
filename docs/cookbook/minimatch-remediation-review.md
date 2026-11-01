# Minimatch remediation — Review and proposed external validation

- **Prepared:** 2026-11-01 UTC after `2ca882e`
- **Authority:** [Decision 0030](decisions/0030-minimatch-remediation-review.md), review only
- **Status:** Recommendation prepared; **no remediation implemented or graph resolved**
- **Tasks:** Preparatory M00-T04/T06/T07; seven tasks checked, full M02 Planned

## 1. Recommendation

**Keep the [security stop](auth-integration-batch-security-stop.md). Request E1 only: an isolated compatibility/security experiment for three exact parent-scoped overrides to minimatch 11.0.3, with no application changes.** Do not automatically update parents, globally override minimatch, suppress the advisory or resume the five I1 tasks. This review does not accept an unsupported dependency combination as production policy.

The newly reviewed common caller surface makes a controlled experiment reasonable, not a drop-in upgrade proved safe. If the owner prefers to wait for maintained parents/backports, keep the gate blocked rather than substitute a new stack or patch vendor code.

## 2. Maintained options checked

Official registry metadata at capture:

| Package | Current repository | Latest checked | Relevant latest dependency / finding |
|---|---|---|---|
| `eslint` | 10.13.0 | 10.14.0 | `minimatch ^10.2.6`; still does not resolve the advisory |
| `@eslint/config-array` | 0.23.5 | 0.23.5 | `minimatch ^10.2.4` |
| `typescript-eslint` | 8.72.0 | 8.72.1 | Parser/plugin cohort remains on estree 8.72.1, not a fixed minimatch parent |
| `@typescript-eslint/typescript-estree` | 8.72.0 | 8.72.1 | `minimatch ^10.2.2` |
| `@typescript-eslint/parser` / plugin | 8.72.0 | 8.72.1 | No independent supported 11.x edge found in this cohort |
| `@eslint/js` | 10.0.1 | 10.0.1 | No relevant minimatch remediation |
| `minimatch` | 10.2.6 | **11.0.3** | Highest published stable 10.x remains **10.2.6**; no compatible newer backport found |

These are observed versions, **not selected upgrades**. New parent versions would introduce unrelated change without removing the finding, so they are not the proposed minimal experiment. Existing Node **24.18.0**, pnpm **12.8.1**, TypeScript **6.0.3**, Nest/auth/Prisma/driver and Flutter pins remain unchanged. Registry engine/peer metadata is not runtime compatibility evidence.

Current declarations all exclude 11.x: ESLint 10.13.0 requires `^10.2.5`, config-array 0.23.5 `^10.2.4`, estree 8.72.0 `^10.2.2`. An override would be an explicitly owned unsupported dependency-range experiment—not an upstream-supported semver update or a peer waiver.

## 3. Artifact/source findings—data, not execution

Four official archives were downloaded **for byte/static inspection only**, each SHA-512 checked against its official registry metadata; 154 regular files / **415,684 compressed bytes /1,765,555 payload bytes** in total. Safe archive paths, one root, exact package name/version, bounded sizes and no link entries were checked. Inspection copies use inert `.txt` filenames; no install, candidate JS import/native/WASM execution, package-manager resolution, lifecycle hook or upstream test runs.

| Artifact | Files | Runtime dependencies | Declared engine / license |
|---|---:|---|---|
| minimatch 10.2.6 | 53 | `brace-expansion ^5.0.8` | Node 18, 20, or ≥22 / BlueOak-1.0.0 |
| minimatch 11.0.1 | 37 | `brace-expansion ^5.0.12`, new helper `^1.0.1` | Same engine/license |
| minimatch 11.0.3 | 37 | `brace-expansion ^5.0.12`, new helper `^1.0.3` | Same engine/license |
| `@isaacs/nonrecursive-glob-match 1.0.3` | 27 | None declared | No engine declaration / BlueOak-1.0.0 |

The existing lock already has brace-expansion **5.0.12**. A minimal same-graph candidate would replace one minimatch identity and add the helper: **201 versus 200 repository identities /345 versus 344 combined identities are static expectations only**, not resolved package/snapshot or installed-production counts. Stop if a later resolution differs without further review. Helper 1.0.3 is the reviewed proposed target; its `^1.0.3` edge must not silently select an unreviewed newer version.

Minimatch's CJS/ESM entry points and public typings remain published. Its 11.x implementation replaces RegExp path segments with the helper's `Matcher`. Static declaration/changelog comparison records:

- Removed `makeRe`, `MMRegExp`, `AST`, public `matchOne`, `slashSplit`, `levelTwoFileOptimize`, `regexp`, `debug` and `maxExtglobRecursion` surfaces.
- `Minimatch.set` entries change from RegExp to Matcher objects.
- Empty path-segment/extglob, globstar partial matching, Windows drive/UNC/parent normalization and related semantics change; Unicode normalization is added. A passing import alone cannot validate file discovery or ignore behavior.
- Both 11.0.1 and 11.0.3 published implementations contain the advisory fix's pattern-growth limit and large-set deduplication cutoff. The advisory-linked commit and gitHead-specific changelog support this static finding; no resource-bound exploit/benchmark is executed.
- The helper adds new implementation/maintenance surface and no declared engine floor. Its README's performance/security descriptions are upstream claims, not an independent audit or Node 24 acceptance.

The four license files were inspected. Minimatch's license text is byte-identical across the three versions; the helper carries its own Blue Oak text. Recipients must receive that text or the specified license link. This is a scoped notice inventory, not legal/shipping clearance. Declared prepare/build/test/publish hooks remain unexecuted; the helper's source build mentions bash/esbuild, but registry artifacts already contain JS/types. No hook or SDK permission follows.

## 4. Actual caller compatibility review

Current installed sources were read and hashed as data, without importing ESLint or minimatch:

| Caller | Observed minimatch use | Consequence |
|---|---|---|
| ESLint `lib/eslint/eslint-helpers.js` | `new Minimatch`, `.match(path)`, `.match(path, true)`, `.pattern`; `{dot:true}` | Common APIs remain, but changed partial semantics can alter directory traversal/file discovery |
| config-array `dist/esm/index.js` | Named `Minimatch`, `.match`, cached patterns, `{dot:true}` plus options including negation | Positive/negative files/ignores and cache behavior need executable tests |
| estree `useProgramFromProjectService.js` | Named `minimatch(filePath, pattern, {dot:true})` for allowDefaultProject | Common function remains; project inclusion/default-project boundaries need tests |

No removed RegExp/AST API or explicit optimizationLevel ≥2 is observed in these three reviewed call sites. This is **not exhaustive reachability proof**, an exploitability ruling or grounds to waive the package finding. Matching API names does not establish equivalent semantics or upstream support.

## 5. Current security evidence and its limits

Fresh checks retain the positive finding for original minimatch 10.2.6, [GHSA-g3hv-75wg-m249](https://github.com/advisories/GHSA-g3hv-75wg-m249). An exact-version OSV batch reports that finding for 10.2.6 and no finding for 11.0.1/11.0.3; the helper 1.0.3 OSV query is empty at capture.

A **hypothetical list** formed from the saved 344-version inventory, replacing minimatch with 11.0.3 and adding helper 1.0.3 (**345 tuples**), returns an empty npm bulk response. This is not a resolved lock, installed tree, complete changed-transitive audit or release certification. An earlier replacement-only query omitted the newly identified helper; the final 345-tuple query explicitly includes it. Actual resolved identities/integrities/advisories must be rechecked before any future installation/execution. Earlier 119-package production exclusion remains historical selection, not permission to skip full-tooling validation.

## 6. E1 proposal—requires explicit authorization

**No action in this section has run or is approved.** Proposed experiment-only additions, alongside unchanged policy B, in new external workspaces:

```yaml
overrides:
  '@nestjs/platform-express@12.2.0>multer': 2.5.0
  'eslint@10.13.0>minimatch': 11.0.3
  '@eslint/config-array@0.23.5>minimatch': 11.0.3
  '@typescript-eslint/typescript-estree@8.72.0>minimatch': 11.0.3
```

No bare/global minimatch selector, peer allowance, other parent update, vendor patch, private import, script enabling or application edit. These three dependency overrides are **not** part of Decision 0010's accepted policies and would be authorized for E1 only.

Required order and acceptance:

1. Fresh C:/D: preflight, C:-only **<3 GiB additional /≥20 GiB free**, bounded time/logs/processes. No Docker/DB/cloud/native work or owner `.env`. Preserve existing evidence, Node/pnpm/TS pins and exact strict/script-denied policies.
2. Two separate external graph inputs: repository-equivalent root/API and the reviewed combined root/API candidate. Resolve only with the exact proposed selectors, review every importer/package/snapshot/peer/integrity delta and new helper before installation. Require exactly the reviewed helper 1.0.3 or stop. Static 201/345 expectations are not permission for unrelated changes.
3. Fresh all-version security/deprecation/engine/peer/license/archive review on the **actual resolved graphs**; no findings waived. Frozen/script-denied full installs and repeats; review the combined clean production selection without assuming the old count. No automatic hooks, generated client or database.
4. Bounded **fixed-version-only** CJS/ESM/API/type/semantic and resource-limit cases. Preserve small expected-result corpora for braces/extglobs, dots/negation, empty segments, multiple globstars/partial paths, slash/case/drive/UNC/Unicode behavior. No unbounded vulnerable-baseline exploit or vendor-guard mutation.
5. Unchanged root lint configuration/effective rules, known included/ignored files and intentional discovery/diagnostic controls; verify relevant files were not silently omitted. Exercise type-aware parser/project boundaries, strict compile, all existing 176 entries and full root check under the patched external graph. No rule/assertion/timeout relaxation to obtain green.
6. Repeat positive checks; assertion-specific owned negative controls for wrong/missing selectors/integrity/discovery, with original failures retained. Confirm safe matched exports, actual graph absence of vulnerable minimatch, exact installed archive bytes and fresh advisories. Close owned processes/listeners and document shipping/upstream-support/rollback/removal limits.

Stop on unexpected graph/security/integrity/peer/engine/export/semantics/notice/resource failures. A future E1 pass would support a **separate application/override-adoption decision**, not alter this repository or automatically resume I1-B2–B6. Prefer removing any later owned override when a reviewed upstream parent supports a nonaffected dependency and regression checks pass; never downgrade to the affected version. Existing policy/release gates and **2026-11-23 UTC** latest review date are unchanged.

## 7. Review evidence, checks and remaining status

Evidence: `C:/Users/HP/AppData/Local/Temp/your-own-minimatch-review-x084t3yd/` — hash baseline, official metadata/advisories, four SRI-verified tar archives, inert artifact/file maps, gitHead changelogs, source/caller hashes, static findings and hypothetical-list responses. Four release-API lookups failed with HTTPError; no release text is claimed from them. Artifact changelog/license filename guesses and an old ESLint path guess failed during inspection; actual published names/current caller paths and revision-specific source were used instead. These are retained inspection limits, not executed package/test failures.

No changed graph, install, candidate JS/hook/native execution, engine/generation/DB/HTTP fixture, R2/mail/cloud/browser/Flutter/hosted or global-tool action occurs. Existing unaffected checks pass **176 entries** (21 tooling +14 design/artwork +99 boundaries +42 API), build/types, token/assets/artwork and **41-source /137-directive** scanning, all via direct Node commands without loading minimatch. The API suite uses its correct `apps/api` working directory and passes on that first invocation. These remain distinct from the held full `pnpm check`/ESLint lane. Archive/static-source review is not a passing E1 experiment. Documentation passes **126 Markdown /1,980 local links /four JSON examples /34 whitespace checks**. Preservation/redaction covers exactly ten documentation paths and unrelated tracked/private bytes. The captured C:-only regular-file review footprint is **1,465,491 bytes**, with C: **31,759,056,896 bytes free**; archive payload totals above are distinct from this retained footprint. No Docker/location/host-setting change is needed or performed for the review.

Application/S0/composition/configuration/dependencies/locks/policies/pins, ignored private configuration, old fixtures/failures and **13 immutable snapshots** remain unchanged. Preserve **67 requirements /224 tasks /20 plans /seven checked tasks**, full M02 Planned. Five integration tasks remain uncompleted. **Next owner choice: authorize E1 only under these limits, or keep the gate blocked while waiting for maintained compatible parents.**
