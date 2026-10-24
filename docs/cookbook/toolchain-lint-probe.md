# Isolated Frontend Lint Probe — M00-T04

- **Version:** 0.1
- **Observed:** 2026-10-24 UTC, Windows x64 / Git Bash
- **Status:** Bounded experiment passed; M00-T04 remains In progress / unchecked
- **Authorization:** [Decision 0007](decisions/0007-isolated-lint-probe.md), following the [static rule disposition](toolchain-lint-review.md#8-completed-static-disposition-and-owner-choice)
- **Related:** [Candidate review](toolchain-review.md), [compatibility findings](toolchain-compatibility.md), [earlier tool/JS/mobile probes](toolchain-probe.md)

## 1. Outcome and boundaries

Next's official **16.4.2** Core Web Vitals and TypeScript configurations ran with **ESLint 10.13.0**, retaining the original React/import/accessibility/Hooks implementations. **668 focused diagnostic executions**, separate clean lint of **seven files per synthetic app**, and both strict TypeScript checks passed. No vendor patch, alternative engine, rule suppression or automatic fix was needed.

**This was an exception-based experiment, not an unqualified strict-peer pass.** The three published plugin declarations still exclude ESLint 10. Decision 0007 authorized exactly these temporary allowances, not production use:

```yaml
peerDependencyRules:
  allowedVersions:
    "eslint-plugin-react@7.37.5>eslint": "10.13.0"
    "eslint-plugin-import@2.32.0>eslint": "10.13.0"
    "eslint-plugin-jsx-a11y@6.10.2>eslint": "10.13.0"
```

Strict peers stayed enabled; automatic peer installation and lifecycle scripts stayed disabled. No `allowAny`, `ignoreMissing`, blanket strict-peer disabling, dependency override or package substitution was used. The result supplies bounded runtime evidence for Next's documented compatibility path; it neither repairs upstream declarations nor proves exhaustive rule semantics, security or accessibility.

The repository remains documentation-only. No production app, final pin, production peer-policy change, global upgrade, chart integration, server/browser/device run, provider, supplier contact, spend or deployment was authorized or performed.

## 2. Tools, graph and execution review

External root: **`C:/Users/HP/AppData/Local/Temp/ylp-6fg7obur/`**. Home, configuration, caches and temporary files were isolated. Explicit portable tool paths reused the earlier probe's **Node 24.22.1 / pnpm 12.15.0**, after archive/executable-byte rechecks and version commands. This is process/environment isolation, not an OS sandbox.

| Area | Actual evidence |
|---|---|
| Direct inputs | The 16 exact candidates listed in Decision 0007; React/DOM 19.3.1, TS 6.0.3, typescript-eslint 8.72.0, @eslint/js 10.0.1 and the original plugins, without changing versions |
| Resolution/install | Scripts-disabled lockfile resolution and frozen install passed with only the three exceptions; repeat frozen install retained the lock digest |
| Negative peer controls | Four separate synthetic graphs failed with `ERR_PNPM_PEER_DEP_ISSUES`: no exceptions, missing React exception, wrong React parent version, wrong allowed ESLint version |
| Lock documents | Manager: 15 package/snapshot entries and one importer; application: 390 entries and three importers. Counts include platform-optional entries, not only installed identities |
| Installed graph | 331 distinct external package/version identities; fresh registry records had no deprecation flags or fetch errors. All 245 declared Node-engine ranges matched executed Node 24.22.1 |
| Resolver | Actual Next graph uses `eslint-import-resolver-typescript 3.10.1` with `unrs-resolver 1.12.2`, not the alternative 4.4.5 resolver researched for import-x |
| Dated advisory check | `pnpm audit --json`: zero known advisories across its service-reported 405 total dependencies. Its category/count semantics differ from the installed inventory; this is not a full security audit |
| Transitive prereleases | `gensync 1.0.0-beta.2` and `resolve 2.0.0-next.7` are upstream dependencies in the resolved stable-package graph, not silently substituted prerelease lint tools. Retained for final support/pin review |

The review inventoried scripts and notices before candidate lint execution. UnRS's `postinstall.js` invokes `napi-postinstall.checkAndPreparePackage`; it remained disabled. Its Windows loader, alternate-path/WASI controls and fallback paths were inspected. The restricted environment did not inherit those override variables; runtime version enforcement was enabled. No rebuild or blanket script approval was needed.

Three registry archives independently matched SHA-512 integrity and their **five native files** matched installed bytes: UnRS's Windows resolver, Next's Windows SWC, and sharp's Windows addon/two DLLs. The **1,886,720-byte** UnRS binding has SHA-256 `19654fe888473d39f326eb79b23fc0c29890a3ba129b01fb68f136e3353b1bc5`. Alias-resolution tests observed that exact installed binding in the CommonJS module cache. This cache observation is not exhaustive native/WASM execution tracing. Archive consistency is not publisher attestation or reproducible-build verification.

Notices retained include permissive licenses plus axe-core's MPL-2.0, language-subtag-registry's CC0-1.0, tslib's 0BSD, caniuse-lite's CC-BY-4.0, minimatch's BlueOak-1.0.0, and sharp Windows' Apache-2.0 AND LGPL-3.0-or-later. The UnRS source/binding map to commit `ccb26d205e2938b16069c64a28996b48ee97ff94` and its actual MIT notice, crediting UnRS, VoidZero and Boshen. A guessed `LICENSE.md` returned 404; the actual `LICENSE` was fetched/read. Next's missing root notices map to the previously reviewed version-tagged Vercel MIT text.

**15 installed roots lack a separate top-level notice.** The inventory preserves that fact. Remaining upstream/nested/embedded notice mapping, source-offer/distribution obligations, signatures, full advisories and support remain final-adoption gates. Registry labels, local non-conveyed execution and retained notices are not legal clearance or permission to distribute a production graph.

## 3. Effective configuration and actual tests

The two app-local configs compose Next's original presets with `@eslint/js` recommended, original JSX-a11y strict rules, explicit Image/owned-control mappings, alias resolution and synthetic import restrictions. No second React/accessibility plugin object is registered to evade Next's wrappers. The additions are owned configuration, not changes to vendor rule implementations.

Eight effective configs cover **web/admin × JS/JSX/TS/TSX**, retaining:

- **17 active React entries**, including both JSX bookkeeping rules.
- **22 Next rules**, including the two Core Web Vitals severity upgrades.
- **All 16 official Hooks recommended entries**, not merely the two familiar Hooks rules.
- **31 error-level accessibility preset rules/options**, plus `control-has-associated-label` and `no-aria-hidden-on-focusable`.
- Next's `Image` alt mapping, owned button/input/link mappings, import checks and the selected unused-variable rule.

**248 accessibility option assertions** checked 31 rules across eight configs. `alt-text` deliberately extends the original defaults with `img: ['Image']` without narrowing default element coverage to images alone. The remaining preset options are retained. Effective parser/settings/rules are captured per file extension; this verifies the composed configuration, not every possible Next parser combination or a type-aware project-service lint suite.

| Check | Executed result | Limits |
|---|---|---|
| React baseline and edges | **79 cases × two extensions × two apps = 316**. Includes all 34 seed specimens, all 31 deprecation catalog entries, import aliases/require destructuring, modern API control, string refs, `this.refs` at React 19, entity/raw-text cases, nested returns and memo display names | Every case requires the intended rule's presence/absence. Bookkeeping checks inspect actual unused-variable diagnostics. Not exhaustive option/spread/type-scope coverage |
| Accessibility and integration | **84 cases × two extensions × two apps = 336**. Positive/negative pairs for every one of the 31 accessibility rules, added control/hidden-focus checks, owned control and Image mappings, Hooks rules/dependencies, selected Next checks, aliases and cross-app/client-import restrictions | All preset entries are retained, but only two Hooks rules and selected Next rules have targeted behavioral specimens. No browser/assistive-technology certification |
| Plain JS/TS | **16 executions** across both apps: used/unused binding and resolved/unresolved alias controls | Distinct from JSX/TSX fixtures and type checking |
| Full-config clean lint | ESLint CLI, `--max-warnings 0`; **seven actual files per app**, zero diagnostics. Includes App Router-shaped compositions, owned controls, a supported class/error boundary, aliases, server stub and JS settings file | Positive rule specimens can violate unrelated rules; only these separate clean samples claim a full-config pass |
| TypeScript | Separate `tsc --project tsconfig.json --noEmit --pretty false` per app: exit 0; strict enabled, `skipLibCheck: false`, ES2024 libraries | No Next build, generated route typing, hydration, runtime sessions or browser behavior exercised |
| Repeat installation | `install --frozen-lockfile --ignore-scripts`: exit 0; lock unchanged | Does not remove the three peer exceptions |

No final specimen passed by being ignored, producing a fatal parser error, matching only an unrelated diagnostic or linting zero files. The **668 total executions** are focused synthetic expectations, not 668 product tests. `.client.*` import-name restrictions are deliberately limited test controls, **not** server-only enforcement, credential isolation or a proof against all relative/alias boundary bypasses.

## 4. Preserved corrections

1. The first config-inspection helper attempted the non-exported `eslint-config-next/package.json` subpath. Its `ERR_PACKAGE_PATH_NOT_EXPORTED` failure is retained. Reading the matching manifest by walking from the public entry point fixed the helper; no vendor export or source was changed.
2. Initial React specimens used nonexistent virtual paths while the process cwd was the workspace root. The original plugin falls back to cwd for version discovery in that case, warned that React was absent and assumed its latest sentinel. That initial 316-case run is retained **but is not the React-19-specific result**. Materializing each fixture inside its owning app before a fresh run removed the warning; all 316 repeated checks passed, and the original utility's cached-version predicate matched **19.3.1**. No version override or rule suppression was used.
3. The clean-check Python helper initially imported a nonexistent `WS` name before invoking a candidate. Its correction used the actual runner path/key interface. A later own-harness output-name collision overwrote the first successful web CLI diagnostics with its command record. That lost report is **not** claimed as retained evidence. Distinct command/output filenames and reruns yielded the retained seven-file reports for both apps. The original command exit/log and the limitation remain recorded.

These were own inspection/fixture/harness corrections, not hidden candidate substitutions. No candidate lint crash or failed final target expectation was worked around by patching dependencies or disabling checks.

## 5. Evidence and remaining decision

[Durable evidence](evidence/m00-t04-lint-probe.json): **1,480 files / 5,421,598 bytes**, SHA-256 `5c4f10270146ff8cd9eb60758961608502e6ae2c158cbccbac6e7b143330eea7`. It retains normalized synthetic source/config/fixtures, manifests/lock, selected public source/notices, registry records, helpers, command records, diagnostics and prior-snapshot identities. Binary packages/caches remain external. Embedded sample configuration is evidence, not a repository application or production lockfile. All four earlier snapshots remain byte-identical.

Reproducible external checks include `check_effective.mjs`, `test_rules.mjs`, `test_coverage.mjs`, `check_final.mjs`, `clean_checks.py` and `validate_probe.py`; actual command arguments/cwds/exit codes are retained. The final validator checks diagnostic counts/targets, effective options, engine ranges, native/notice/metadata hashes, frozen lock, earlier source bytes and absence of repository scaffolding.

Final observations: global Node remains **24.18.0**; global Flutter remains clean **3.38.9**; four reference HEADs/status-entry counts remain unchanged. No matching owned Node/pnpm process remained; no server was started. Free space was approximately **25.83 GiB**, versus 27.77 GiB initially; this is not precise experiment allocation. External artifacts are retained, not silently cleaned up.

**Next remains M00-T04:** finish outstanding graph/embedded-notice/support/bootstrap review and present explicit final-pin and production lint-policy choices. The experiment makes Next's original-rule path a supported candidate for that review; it does not authorize production exceptions automatically. ApexCharts entitlement and integration remain held. No milestone checkbox changes, M00-T05 advance or M01 scaffold permission follow.
