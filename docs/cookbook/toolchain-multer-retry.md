# Toolchain — Isolated Multer Override Retry

- **Version:** 0.2
- **Observed:** 2026-10-24 UTC, Windows x64
- **Task:** [M00-T04](../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), **In progress / unchecked**
- **Authority:** [Decision 0009](decisions/0009-isolated-multer-override-retry.md), not a production dependency-policy decision
- **Predecessor:** [Stopped combined attempt](toolchain-combined-probe.md), whose security failure and immutable evidence remain intact

## 1. Outcome and scope

The owner answered **“continue”** to the explicit question authorizing a separate temporary retry with only `@nestjs/platform-express@12.2.0>multer` overridden to **2.5.0**, regression checks, the existing three peer allowances and unchanged storage limits. This new approval is distinct from the earlier post-audit continuation that supported static research only.

The retry passed the bounded combined checks below. **This is an override-based, peer-exception-based local result**, not upstream Nest support, a strict-peer pass without exceptions, exhaustive security/compatibility proof, final pins or permission to scaffold applications.

External root: **`C:/Users/HP/AppData/Local/Temp/ycr-b8f4n7ys/`**. Starting repository HEAD: `fbf4711a7f3cc123c43d2f232aded0da0982c140`, clean working tree; no agent commit. All earlier roots, the stopped lock and eight earlier snapshots were preserved. Ordinary Node **24.18.0**, clean Flutter **3.38.9** and all four reference HEAD/status-entry counts remained unchanged.

Reverified existing Node **24.22.1** / pnpm **12.15.0** archives and executable members; explicit version checks passed and a wrong-hash launcher control rejected before subprocess launch. Configuration/home/cache/state/temp stayed external. Strict peers remained enabled, automatic peers and lifecycle scripts disabled. No global shim, native toolchain, chart package, test framework or vendor patch was introduced.

## 2. Exact graph and security gates

| Check | Observed result |
|---|---|
| Direct inputs | Same **31 distinct exact candidates** and root/API/web/admin composition as the stopped attempt |
| Lock documents | Manager **15** package/snapshot entries; application **588** entries / four importers |
| Delta from stopped application graph | Only **`multer@2.4.0 → multer@2.5.0`**; all other **587 package records**, the manager document and importer definitions unchanged |
| Override scope | Exactly one Multer dependency edge, under the exact Nest Express adapter **12.2.0** parent; no other Multer version in the new lock/installed graph |
| Availability/integrity metadata | **603** exact manager/application registry records; names, versions and lock integrity matched, no deprecation flags |
| Published fixed package | SHA-512 archive verification; **12 files** inventoried and matched to installed bytes; no native file or install/prepare hook |
| Source/notice comparisons | Complete MIT notice, `index.js` and `lib/make-middleware.js` matched the previously inspected declared 2.5.0 source commit byte-for-byte |
| Audit | Both pre-install and final `pnpm audit --json` returned **exit 0 / zero known advisories** in their dated service results |
| Installed application graph | **508 identities**; **372** declared Node-engine ranges matched the executed Node; runtime resolution through the adapter selected Multer **2.5.0** |

The authorized selector remains:

```yaml
overrides:
  "@nestjs/platform-express@12.2.0>multer": "2.5.0"
```

The three exact ESLint allowances are unchanged from [Decision 0008](decisions/0008-isolated-combined-js-probe.md). No global Multer override, extra peer allowance, audit suppression or automatic audit fix was used. The original advisory **GHSA-q7qp-rjg7-q26m / CVE-2026-113872** is not dismissed: the original graph remains affected and stopped. Historical roots/caches intentionally remain preserved; “no affected instance” refers to the new resolved/installed graph, not every historical file on the machine.

The patched archive SHA-256 is recorded in the snapshot's `evidence/multer-archive.json`; its SHA-512 matches the previously researched candidate. Source and integrity comparisons do not independently verify publisher attestations or certify absence of other vulnerabilities. The release contains field-boundary and cleanup changes as well as the security fix.

## 3. Executed regressions and combined checks

| Area | Actual checks / result |
|---|---|
| Multer regressions | **10 separately launched cases passed**: async teardown; normal upload; explicit, default 1 MiB and UTF-8 exact/over field boundaries; failed/path-less storage cleanup and successful-storage cleanup control |
| Async failure path | A genuinely truncated multipart stream resumed after asynchronous filter teardown; the actual parser reported `Unexpected end of form`, closed, and called the middleware completion once with no accepted files. No test-added parser error listener or process-level exception suppression |
| Upload isolation | Synthetic Node-built-in HTTP servers bound only to `127.0.0.1`; built-in stream/storage fixtures wrote no file; timeouts and teardown retained |
| Peer negative controls | All **four** missing/mismatched-allowance variants rejected with `ERR_PNPM_PEER_DEP_ISSUES`, now using all four combined importers |
| Effective lint configuration | **Eight** configs retained 17 React entries, 22 Next rules, 16 recommended Hooks entries and 31 original accessibility entries/options; **248** accessibility option assertions |
| Focused lint behavior | **668 expectations passed:** 316 React + 336 integration/accessibility + 16 plain JS/TS; React **19.3.1** detected through actual fixture files |
| Full-config clean lint | **16 actual files**, eight per app, zero diagnostics/warnings; original build client/form/query/icon samples included, not just separate lint-only pages |
| Nest | CLI/strict TypeScript build; decorator/OpenAPI string schema; loopback GET returned exact string **`9007199254740993`**; application closed |
| Next web/admin | Separate Next **16.4.2 Turbopack** builds and explicit strict typechecks passed; `skipLibCheck: false` retained |
| Next HTTP | Each app returned its own marker/form/query/rounded-SVG markup, **eight CSS/JS assets**, a Tailwind utility and a missing-route **404**; both owned process trees terminated and ports closed |
| Repeat installation | Frozen, scripts-disabled **offline** repeat passed; byte-identical lock verified before/after a final repeat |

Owned synthetic build samples and lint support/config/check files were reused, not reference-app code or old successful results. The strict Next type configuration adds the lint alias and explicitly excludes deliberately invalid `fixtures/` specimens from application compilation. No lint rule was dropped or disabled. A clean-file assertion is separate from negative rule specimens, which may intentionally trigger additional diagnostics. Next builds do not run lint; separate commands did.

These are bounded Windows host results. They do **not** establish browser hydration/accessibility, exhaustive plugin coverage, a Nest `FileInterceptor` endpoint, cross-platform/native builds, encrypted storage, real upload security or release readiness. The Multer regressions resolve the module through the installed adapter but use built-in synthetic stream/HTTP fixtures, not a product endpoint or the affected version as an exploit target.

## 4. Preserved failures and cache resume

- **23 initial metadata requests failed with transport errors.** The initial review/gate failure remains. One bounded repeat of the identical URLs succeeded; no identity, advisory or deprecation concern was waived.
- **Initial frozen installation timed out at 600 seconds** during slow downloads. Its log, partial store and owned process-tree termination record remain. It is not presented as a successful fresh download/bootstrap.
- A separate copy of the original probe's **package cache only** avoided repeating large downloads. Two serial copy helpers timed out at **240 / 600 seconds**; their scripts and partial copy were preserved. A final bounded parallel pass reverified all **46,490 content-addressed files**, including partial copies, and copied the cache index without modifying its source. The copy's entire potential allocation was reserved before work, free space monitored during it and the full root measured afterward. No workspace, links, lock, project-cache state or result was inherited.
- Only temporary **`storeDir`** changed; the earlier configuration remains in evidence. The frozen resume passed: pnpm reported **237 reused / 271 downloaded / 508 installed** and **46,478 file-integrity checks**. These are different measurements from the cache-copy inventory. No hooks were enabled.
- An installed-manifest verifier initially failed with Windows **cp1252 `UnicodeDecodeError`**; explicit UTF-8 fixed the helper. Its initial source remains.
- The first integration-lint command failed **`ENOENT`** because the helper omitted the existing 84-case input file. The input—not old results—was copied byte-for-byte and all **336 executions rerun**. No rule/configuration change manufactured success.

`evidence/corrections-and-limits.txt` and the retained command records distinguish these real failures from expected negative peer exits and deliberate Next server teardown exits. Process-environment isolation is **not an OS sandbox**; storage monitoring is not a quota. No antivirus exclusion or system change was used.

## 5. Notices, native identity and remaining decisions

Compared **507 unchanged installed manifests**, **498 previously recorded root notice hashes**, and **12 standalone binary/WASM files** against prior inspected installations: seven native addon/DLL files and five WASM files. The five SWC/Sharp/UnRS native hashes also link to the earlier integrity-verified archive records. Hermes's embedded-WASM source file matched separately. Scarf and UnRS postinstalls remained disabled. These are bounded file comparisons, not exhaustive native loading, linked-crate provenance or publisher attestation.

The same **16 roots** lacking standalone notices remain subject to the [notice review](toolchain-notices.md) and [public-source trace](toolchain-notice-trace.md). Existing `client-only`/`stable-hash` attribution gaps, embedded marker/merged-code/font/native obligations and artifact-specific notice delivery are **not resolved by this retry**. No font, poster renderer or image-optimization behavior was adopted or tested.

The subsequent [adoption review](toolchain-adoption-review.md) led to [Decision 0010](decisions/0010-conditional-dependency-exceptions.md), separately accepting exact A/B conditional eligibility and owner/30-day review/revalidation/removal controls. This does not adopt the retry graph or approve new execution. Remaining M00-T04 work includes complete notices/support/security/target review, omitted application-library choices and final pins, not an automatic scaffold. A future upstream-fixed adapter should be reviewed rather than assuming the temporary override is permanent. **ApexCharts remains held**; no outreach, disclosure, purchase, replacement engine or integration was authorized. Platform/browser/native validation and the applicable M00 gates, including **M00-T14**, remain separate.

## 6. Durable evidence and verification

[Immutable retry snapshot](evidence/m00-t04-multer-retry.json): **1,520 files / 7,543,653 bytes**, SHA-256 **`75c42fb16584b880a0a1fc34655f33e509ff2ae6982f44f983cf9d92db647207`**. Original lengths/hashes identify original bytes; temporary paths are normalized. Binary archives, dependency caches/trees and build output remain external. The large cache-copy catalog and Multer archive are represented by external-file hashes, not embedded binary/package payloads.

Retry lock SHA-256: **`7a4d4cf92eb8dcbd026c24ee965774f531be98acd042b4cf30a9c220c54c352e`**. Stopped lock remains **`79f611945c38c631fe30e21cd781da71cd1791bf4cf1662273010159b88c6493`**.

Final execution-state measurement: approximately **1.16 GiB** in the new root, **1.47 GiB including the reserved stopped-attempt footprint**, with approximately **27.35 GiB free**. All sampled values stayed below the **3 GiB** additional-footprint threshold and above **20 GiB** free. No matching candidate process remained; all synthetic servers closed. These measurements precede the small final documentation/snapshot writes, not a filesystem quota guarantee.

Recheck without reinstalling or overwriting snapshots:

```text
python C:/Users/HP/AppData/Local/Temp/ycr-b8f4n7ys/validate.py
python C:/Users/HP/AppData/Local/Temp/your-own-toolchain-review-so4nyten/validate_review.py
git -c core.safecrlf=false diff --check
```

The retry validator checks the scoped graph, metadata/archive/native/source evidence, actual test outputs, retained failures, lock equality, resource/global/reference state, all eight prior snapshot hashes and absence of repository scaffolding. It is not a substitute for the unperformed product, legal, browser, native or release checks. **M00-T04 remains open.**
