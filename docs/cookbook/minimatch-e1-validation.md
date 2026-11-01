# Isolated minimatch E1 validation

- **Recorded:** 2026-11-01 UTC, after `6851ef4`
- **Authorization:** [Decision 0031](decisions/0031-local-minimatch-e1.md), E1 only
- **Result:** Bounded external technical matrix passes after retained launcher/fixture corrections; **no application or override-policy adoption**
- **Tasks:** Preparatory M00-T04/T06/T07 only; seven tasks checked, full M02 Planned; I1-B2–B6 still **0/5**

**Subsequent tooling-only authorization:** The owner's next “continue” is [Decision 0032](decisions/0032-minimatch-tooling-adoption.md). The [actual repository implementation](minimatch-tooling-adoption.md) now has the exact three overrides/generated lock and passing normal CLI checks, but a new supplemental ESLint/TypeScript API crash leaves verification blocked. This supersedes this document's adoption-unapproved/unpatched checkpoint prospectively only; E1 remains historical external evidence, not clearance of the later failure or resumed auth integration.

## 1. Scope and actual graphs

The owner's “continue” answers the explicit **E1-only/no-application-changes** question, not a request to install into the application or resume the [five integration tasks](auth-integration-batch-security-stop.md). New repository-equivalent and combined root/API workspaces start from `6851ef4`; only the combined workspace additionally takes the previously reviewed external auth/Prisma manifests/lock. All new experimental allocations are on C:. Three clones have push disabled. No owner .env is copied or used.

Retain policy B and add only these **experimental**, exact parent overrides:

```yaml
overrides:
  '@nestjs/platform-express@12.2.0>multer': 2.5.0
  'eslint@10.13.0>minimatch': 11.0.3
  '@eslint/config-array@0.23.5>minimatch': 11.0.3
  '@typescript-eslint/typescript-estree@8.72.0>minimatch': 11.0.3
```

Actual resolution/review precedes installation:

| Graph | Identities/snapshots | Lock SHA-256 |
|---|---:|---|
| Repository-equivalent | 201 /201 | `d8c89796f325d709013d84793445739f5743655dbbd8be7ae542de92901ceb23` |
| Combined external | 345 /345 | `6db54e5a6235a489dbf98db5c5b22d6e2ef050741a35fd7811e1ed73fbb949f0` |

Each removes **only minimatch 10.2.6**, adds **only minimatch 11.0.3 and @isaacs/nonrecursive-glob-match 1.0.3**, and changes only the three selected parent dependency values. Manager document, importer values, settings, existing package metadata/integrities and other snapshots remain byte-equivalent under the strict parser. The combined eslint snapshot retains its already-reviewed optional jiti context; it is not another new delta. Root/API manifests retain their respective input bytes. Repository identities are an exact metadata subset of the combined graph. Helper resolution is genuinely **1.0.3**, not an assumed range result.

Parent declarations still exclude 11.x; this experiment does **not** establish upstream-supported compatibility or accept an enduring major override.

## 2. Security, artifacts, installs and notices

Before installation, fresh official npm metadata for all **345 actual identities** matches lock integrity, has no deprecations and retains existing engine/license/script metadata. npm bulk and OSV batch responses are empty at capture. All **345 SHA-512-matched official archives** are parsed as inert data before imports: **93,496,710 compressed bytes /333,882,302 payload bytes /17,134 files**. Existing archives are rehashed against prior review; the two new ones are independently fetched. Unsafe paths, links, duplicate entries and excess sizes are rejected.

Minimatch/helper have no new peer/native payload. Both retain their actual **BlueOak-1.0.0 LICENSE.md** files, whose SHA-256 values match [the static review](minimatch-remediation-review.md). The helper's `prepare: tshy && bash scripts/build.sh`, Prisma hooks and all other lifecycle hooks remain denied. No hooks, Prisma CLI/engine/generation or WASM payload are run. Fresh Node-engine checks satisfy all **191 declared Node ranges** on **24.18.0**. Strict pnpm installs pass, but Studio's existing `pnpm: 8` declaration remains an explicit upstream-support gate; successful installation does not resolve it.

Explicit private store/state directories, official registry and empty auth files are used with strict peers/engines, automatic peers off, scripts denied, `verifyDepsBeforeRun:error` and exact Node/pnpm/TypeScript pins. Frozen installs and offline frozen repeats leave both locks unchanged. These are actual installed inventories, not static reachability predictions:

| Installed selection | Packages | Exact payload files | Payload bytes |
|---|---:|---:|---:|
| Repository-equivalent full | 201 | 6,747 | 52,561,322 |
| Combined full | 345 | 17,134 | 333,882,302 |
| Combined clean production | 119 | 4,652 | 88,011,496 |

Every installed archive file/hash and exact file set is checked **before candidate imports and again after execution**. Production selects precisely the prior reviewed 119 identities, excluding minimatch/helper, Prisma CLI/engines/Studio, React/DOM and TypeScript. Do not infer production safety merely from tooling exclusion. New notices are verified; existing missing/embedded/native/WASM/image notice and delivery-bundle obligations, including `@prisma/dev` /`remeda` attribution gaps, remain shipping gates.

At **2026-11-01T12:52 UTC**, fresh queries over the actual patched 345-version union again return empty npm/OSV responses. A simultaneous query of the **unchanged repository's 200 identities still reports the minimatch advisory**. These are dated responses, not security certification, a vulnerable-baseline exploit, application exploitability proof or clearance of the actual application graph.

## 3. Runtime and compatibility matrix

Only fixed 11.0.3 code is executed. Owned probe-only module junctions point inside the reviewed C: installations and use public CJS/ESM/type exports; no application dependency is added or vendor source/guard patched.

- **173 explicit expected matching tuples** exercise CJS and ESM in both full graphs, twice: **1,384 constructor/match tuple executions**, plus named matcher, filter, match-list, brace, defaults, escape and API-shape checks. Actual consumers resolve the same fixed identity. Coverage includes optimization levels 0/1/2, actual ignore patterns, dot/negation/comments, braces/extglobs, partial prefixes and completed globstars, empty/trailing/repeated segments, ASCII case, Unicode normalization, Windows separators/drives/UNC/long roots and above-root denial/retention. Removed AST/RegExp APIs are absent, not emulated. Synthetic UNC strings perform no network-share access.
- Strict public **.mts and .cts** type fixtures compile repeatedly with exact optional properties, unchecked-index checks and library checking; each graph's deliberate invalid option fails specifically with **TS2322**, not missing-module/any typing.
- **Four fixed-version resource cases ×two graphs ×two repeats =16 closed child processes**, each with a **3-second process timeout**, `--max-old-space-size=128` and unchanged **1,500-ms compute assertion**. The cap-reaching 244-character pattern retains **128 rows**; the separate large-row case retains **1,100 rows**. Node/V8 block coverage confirms the first-phase cap branch is taken and the >1,000-row pairwise pass skipped, without modifying vendor guards. Many-globstar partial matching and bounded numeric expansion also pass. Maximum captured compute time: **24.9263 ms**. These are small deterministic safety checks, not capacity/timeout policy or universal complexity proof.
- Actual `ESLint.lintFiles(['.'])` discovers exactly **31 tracked applicable files +seven intentional diagnostic canaries =38**, in each graph twice. Nested, hidden and space/Unicode paths and a globstar CLI-style walk are included. **Six ignored/unconfigured canaries** stay excluded: `.local`, mobile, nested dist/node_modules and out-of-project TypeScript. Unmatched searches error. Public ConfigArray tests retain ordered overrides, per-config/global ignores, negated re-inclusion, AND matching and caching.
- The unchanged authored presets produce identical complete effective rule sets/options in both graphs: **64 JS rules /118 API TS rules**. Reference configs apply those public presets to exact filenames, independently of app glob selectors; explicit severity/rule sets, parser, project root and JS globals are asserted. Deliberate `no-undef` and **type-aware no-unsafe-assignment** diagnostics are observed; no rule is disabled to obtain a pass.
- The third parent caller is exercised through real parser **projectService.allowDefaultProject** matching: normal and hidden shallow files get type-aware diagnostics; a nested file outside that allowlist gets the expected project-service boundary error. This is additional external test configuration, not an application parser-policy change.
- Five owned runtime/lint controls fail at their specific assertions: dot handling, partial flag, Windows root, included-file discovery and type-aware diagnostic loss. Together with the two TS2322 controls there are **seven expected-red controls**. None patches vendor code or disables application rules. Restored positives pass.

**Unchanged full `pnpm check` passes twice in each patched external graph**, including all **176 existing entries per run** (21 tooling +14 design/artwork +99 boundaries +42 API), lint/types and 41-source /137-directive scanning. Full builds also pass twice in each graph. Existing API health HTTP/listener tests run; no new auth/DB HTTP composition is exercised. No existing child-start timeout/assertion is changed, and no known API timeout failure occurs in these four runs. These results do not authorize running the actual repository's still-vulnerable lint graph.

## 4. Retained failures and corrections

Original inputs/logs remain external; these are not erased or counted as passing attempts:

1. The preparation helper supplied unsupported pnpm **`--cache-dir`**. Config exited 2 before resolution; the documented private store/state flags replace it. A later strict textual override comparison rejected pnpm's harmless quote/blank-line serialization. Exact selector/value comparison corrects that parser expectation; graph assertions stay strict.
2. Isolating user configuration while leaving Corepack project selection disabled lost its existing default pin. The first root-check launcher **unexpectedly downloaded/executed pnpm 12.16.1 into this experiment's C: cache**. The project's exact **12.8.1** guard refused it **before the check ran**. This is a launcher failure and unintended isolated tool fetch, not a passing check, a global upgrade or an authorized new tool pin. Its cache/log remains inert. Subsequent invocations and nested scripts use an owned shim to the **already-installed 12.8.1 native binary**, hash-recorded unchanged; Corepack network is disabled. No pin/version/engine guard is relaxed or installed globally.
3. An initial positive Windows fixture wrongly equated preserving a drive root with OS-style clamping of above-root `..`. Published 11.0.3 source retains the above-root component. The ordinary parent-cancellation input is corrected; untouched rootless-denial assertions are supplemented by explicit retained-`..` and rootless-absolute-denial cases. The original `WINDOWS_ROOT_CLAMP` assertion failure remains.
4. An initial resource fixture wrongly required a brace-limit exception. Published brace-expansion bounds by **truncating**, not throwing. Final checks assert exactly 100 results, both endpoints, a valid match at 100 and denial at 101. A preliminary no-ordinary-segment pattern did not reach the intended splitting branch; it is not cap evidence. The final two-ordinary-segment pattern and unmodified V8 coverage actually reach the cap. Original inputs/failure/preliminary output remain.
5. An initial raw-preset/effective-rule comparison omitted ESLint's inserted default options and failed. Independent public-API normalization of exact-file preset references corrects the expected representation while preserving complete-rule/option equality and authored severity assertions. No private builtin-rule import or rule/assertion waiver is used.

These new fixture/launcher corrections do not change project source, existing tests, public package contracts or resource limits. They are not an upstream bug claim. No passing result is inferred for the failed original fixtures.

## 5. Evidence, preservation and disposition

Evidence root: **`C:/Users/HP/AppData/Local/Temp/your-own-minimatch-e1-e9hzo52i/`**, baseline **2026-11-01T12:00:56.195735+00:00**.

- `baseline.json`, `resolve.py`, `lockutil.py`, `inputs/`, `{repository,combined}-graph.json`, exact policies/config and resolved locks.
- `prereview.py`, official metadata/index, archive reviews/file maps, two new archives/notices, request hashes and pre/post npm/OSV responses.
- `install.py`, frozen install/repeat logs, `inventory.py`, first/final exact installed inventories.
- `match-probe.mjs`, `resource-probe.mjs`, `probes.py`, strict type fixtures, matching/resource/control logs, `v8/`, `resource-coverage-review.json`.
- `lint-probe.mjs`, effective-config/discovery/project-service reports, controls/restored logs, `final-checks.py`, full check/build logs, `engines.mjs`, final security review.
- `attempt-*`, original Corepack refusal/cache, `installed-pnpm.json`, owned pinned shim, bounded command/process logs, preservation/cleanup/documentation validation.

At the post-execution inventory, fresh-stat deduplicated regular files occupy **525,235,369 bytes**, C: has **30,538,428,416 bytes free**, below the **3-GiB additional /≥20-GiB free** envelope. This includes the unintended isolated Corepack cache. Initial C:/D: free captures are about 31.8/222.5 GB; no historical low-D: claim is repeated. Long paths are handled explicitly, junctions excluded from traversal and real stat identities used; no inode-zero estimate. Owned child processes finish; new canaries are removed. No Docker/DB/R2/mail/cloud/native/browser/Flutter/hosted, host-setting or global-tool change occurs. Prior fixtures/failures and 13 repository snapshots remain unchanged; ignored private files remain untracked and byte-preserved.

Documentation validation passes **128 Markdown /2,002 local links /four JSON examples /34 owned JS/TS/JSON whitespace checks**. Independent preservation/redaction validation covers exactly eleven documentation paths, unchanged application/private bytes, prior fixture inputs, all 13 snapshots and 67 requirements /224 unique tasks /20 plans /seven checked tasks. Only credential hashes and generic redaction checks are used; owner credentials are not loaded into probes.

Application manifests/locks/policies/configuration/source/S0 are unchanged: AppModule still imports HealthModule only, live 200/readiness 503, no auth/product routes. Full M02 and all existing privacy/native/CI/operational/notice/release gates remain. This is one bounded E1 evidence commit, **not five integration completions**.

**Recommendation:** seek a separate owner decision for adopting **only these three exact repository tooling overrides**, fresh frozen installation and unchanged repository checks. Do not add auth/Prisma dependencies, promote scratch protocols or resume I1 in that adoption task. Any later application/patched-external-graph integration continuation needs separate scope and fresh prerequisites. Decision 0010's existing policies and **2026-11-23 UTC latest review deadline** are not broadened or renewed by E1.
