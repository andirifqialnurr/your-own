# Frontend Lint Review — M00-T04

- **Version:** 0.3
- **Observed:** 2026-10-23 UTC, Windows / Git Bash
- **Status:** Historical read-only investigation; later [authorized lint experiment](toolchain-lint-probe.md) passed bounded checks on 2026-10-24 UTC. M00-T04 remains In progress / unchecked
- **Related:** [Compatibility findings](toolchain-compatibility.md), [candidate review](toolchain-review.md), [prior executable probes](toolchain-probe.md)
- **Authority:** [Decision 0004](decisions/0004-toolchain-directions-and-icon-family.md) accepts supporting directions, not these replacement plugins. Decisions [0005](decisions/0005-isolated-compatibility-probe.md) and [0006](decisions/0006-mobile-probe-generator-retry.md) do not authorize a new lint stack automatically.

## 1. Outcome

**No production lint baseline is selected.** This historical investigation found plausible ESLint 10-compatible import and accessibility replacements, but neither inspected React alternative establishes complete equivalent coverage. The [completed static disposition](#8-completed-static-disposition-and-owner-choice) mapped all 17 baseline entries and proposed testing Next's original configuration instead. The research instruction alone did not authorize that policy change. A subsequent explicit owner answer, recorded in [Decision 0007](decisions/0007-isolated-lint-probe.md), authorized the three-exception experiment; its [separate report](toolchain-lint-probe.md) records 668 focused diagnostic executions and clean lint/type checks for both synthetic apps. Production exceptions, final pins and complete verification remain unapproved.

This pass fetched public metadata/documentation and statically inspected 16 integrity-checked npm archives outside the repository. It did **not** install dependencies, execute downloaded package code, run lint, download native bindings, change global tools, scaffold applications or touch the ApexCharts hold. The owner’s instruction to continue investigation is not recorded as adoption or expanded executable-probe approval.

## 2. Revalidated blocker and important qualification

The [ESLint support page](https://eslint.org/version-support/) still identifies version 10 as Current and version 9 as EOL since **2026-08-06**. Latest inspected stable records remain ESLint **10.13.0**, React plugin **7.37.5**, import plugin **2.32.0** and JSX accessibility plugin **6.10.2**. All three plugins still declare peer ranges excluding ESLint 10. No paid-support exception, peer override or downgrade was adopted in this initial static pass.

**Runtime support and declared peers are different evidence.** Current [Next documentation](https://nextjs.org/docs/app/api-reference/config/eslint), last updated 2026-10-15, explicitly claims ESLint 10 support from eslint-config-next 16.4.0 and also warns that included plugins can fail strict peer installation. The inspected **16.4.2** archive contains `dist/rule-context.js`; its `fixupPluginRules` supplies legacy context APIs to React/import rules. This qualifies the earlier range-only finding: it does not prove the default configuration cannot run. It also does not change the conflicting package declarations or authorize relaxing strict peers. No runtime test of those wrappers was performed.

Next also documents using **`@next/eslint-plugin-next` directly** with an owned flat configuration. That is a legitimate integration path, not permission to omit React, Hooks, imports or accessibility checks. Its exact 16.4.2 archive has **22 recommended rules** and two Core Web Vitals severity upgrades; these must remain accounted for. Package source, rather than the shorter website rule table, supplies that count.

## 3. Candidates, maintenance signals and limits

These are research versions, **not final pins or a tested dependency graph**.

| Area | Inspected candidate | Evidence / remaining issue |
|---|---|---|
| ESLint / JS rules | `eslint 10.13.0`, `@eslint/js 10.0.1` | Current ESLint line; Node 24.22.1 fits both declared engines. No candidate linter executed |
| TypeScript | `typescript-eslint 8.72.0`, existing TS 6.0.3 direction | ESLint peer includes 10; TS range remains `>=4.8.4 <6.1.0`. Typed project/file scoping still needs tests |
| Next | `@next/eslint-plugin-next 16.4.2` directly | First-party rules avoid importing the conflicting aggregate config; no ESLint peer declared is not runtime proof |
| Hooks | `eslint-plugin-react-hooks 7.1.1` | Official plugin peer includes 10. Preserve its complete recommended set, not only two familiar Hooks rules |
| Imports | `eslint-plugin-import-x 4.17.1` | ESLint peer includes 10; includes `no-anonymous-default-export`. Namespace, resolver settings, TypeScript aliases, exports and workspace boundaries need fixtures |
| Import resolver | `eslint-import-resolver-typescript 4.4.5` | Import/import-x peers optional. New `import-x/resolver-next` configuration is documented; Rust-based `unrs-resolver` adds a native provenance/notice gate before execution |
| Accessibility | `eslint-plugin-jsx-a11y-x 0.2.0` | ESLint peer `^9.0.0 \|\| ^10.0.0`; promising static baseline comparison below. A 0.x release is not a prerelease, but its API/maintenance risk still needs review |
| React | `@eslint-react/eslint-plugin 5.28.8` and its seven exact direct sibling/shared packages | README explicitly requires ESLint ≥10, Node ≥20.19 and TS ≥5 despite broad `*` peers. Not a drop-in replacement; coverage gaps below |
| Alternate engine | `oxlint 1.89.0` | Text archive/schema inspected only. Partial React rule-name coverage is not complete equivalence; native Windows binding metadata only, no binding download or execution |
| Other inventory | `@biomejs/biome 2.6.2` | Metadata only; no rule-parity/source assessment. Not selected or recommended merely to bypass peers |

Registry publication dates and repository observations:

- Import-x **4.17.1**, published **2026-06-28**; `un-ts/eslint-plugin-import-x` is not archived/disabled and had a default-branch commit on **2026-10-22**.
- JSX-a11y-x **0.2.0**, published **2026-05-10**. Its registry repository URL under `es-tooling` redirects to **`eslint-community/eslint-plugin-jsx-a11y-x`**. The repository is not archived/disabled; observed default-branch commit **9fffc69e3cfe136c492a68f6e6d292b410793ecf**, dated **2026-10-14**, defines a CI matrix including ESLint 9/10, Node 20/22/24 and Windows/macOS/Linux. Reading that workflow is **not** running it, checking its results or proving that the released archive was built from this newer commit.
- ESLint React **5.28.8**, published **2026-10-23 16:03 UTC**, shortly before this review. `Rel1cx/eslint-react` is not archived/disabled and has same-day activity. Recency and a broad peer range do not establish stability or a support commitment.

These are maintenance signals, not contractual support or supply-chain certification. Revalidate exact artifacts, deprecation status, actual graph and advisories before any authorized execution.

## 4. Accessibility comparison

The original JSX-a11y 6.10.2 exports **39 rules**; JSX-a11y-x 0.2.0 exports **36**. The three missing names are `accessible-emoji`, `label-has-for` and `no-onchange`, each explicitly deprecated in the original source and not enabled by its recommended/strict presets.

A local **text-only** checker compared the published `recommendedRules` and `strictRules` objects after normalizing the namespace, whitespace, comments and trailing commas. Both token sequences match, including rule options. Both presets enable the same **31 error-level rules**. All six accessibility rules explicitly configured by Next 16.4.2 also exist in the fork. This is configuration-text evidence, **not behavior, implementation parity or accessibility certification**.

Important integration requirements:

- The fork reads **`settings['jsx-a11y-x']`**, not `settings['jsx-a11y']`. Blindly copying the old settings would lose custom component/polymorphic mappings.
- Preserve Next’s `Image` alt-text mapping and test owned `Link`, input, button and icon-control wrappers. Labels and actual rendered elements must agree with mappings.
- `control-has-associated-label` is **off even in the strict preset**. `no-aria-hidden-on-focusable` is exported but not enabled by these presets. Do not infer complete control/icon accessibility from the word “strict”; review explicit additions and negative fixtures against [WEB-08](../WEB_PRD.md#25-testing-and-acceptance-criteria) and [ADM-14](../ADMIN_CMS_PRD.md#24-testing-and-acceptance-criteria).
- Preserve keyboard/click, focusability, valid roles/ARIA, meaningful alternatives and label associations. Test positive examples too, avoiding a configuration that “passes” by ignoring JSX or suppressing whole files.
- Static lint cannot verify runtime dialog focus, keyboard journeys, screen readers, contrast, zoom/reflow or DOM semantics. The [testing strategy](testing.md#8-adaptive-ui-and-accessibility) remains mandatory.

## 5. React coverage is still a blocker

The exact React 7.37.5 sources identify **21 recommended rules**. Next 16.4.2 explicitly disables four, leaving **17 active entries**. Two of these are JSX usage bookkeeping rules; equal rule counts alone are not an appropriate equivalence test.

Initial mapping against ESLint React 5.28.8:

| Active Next React baseline | Candidate disposition — unverified |
|---|---|
| `display-name` | Separate component/context display-name rules exist, but are not automatically enabled by the recommended preset; scopes/options need comparison |
| `jsx-key` | `no-missing-key`; fragment/iterator/spread cases still need fixtures |
| `jsx-no-comment-textnodes` | `jsx-no-comment-textnodes`; preserve required severity and cases |
| `jsx-no-duplicate-props`, `jsx-no-undef` | Do not silently substitute TypeScript; establish exact compiler/parser coverage for TSX **and any permitted JSX** before accepting a split check |
| `jsx-uses-react`, `jsx-uses-vars` | Parser/unused-variable integration needs explicit proof with the selected JSX runtime and file types, not blanket unused-variable suppression |
| `no-children-prop`, `no-danger-with-children` | Candidate JSX children and DOM dangerous-HTML rules exist; options/severity and spread cases need fixtures |
| `no-deprecated` | Several individual DOM/lifecycle replacements exist, not a demonstrated complete equivalent of the original aggregate rule |
| `no-direct-mutation-state`, `no-find-dom-node`, `no-render-return-value` | Corresponding candidate rules exist; no behavioral parity demonstrated |
| `no-is-mounted`, `no-string-refs`, `require-render-return` | No direct matching rules in the inspected replacement catalogs. Type errors or bespoke restrictions are hypotheses, not proven replacements |
| `no-unescaped-entities` | No counterpart established in the inspected replacement catalogs; do not quietly drop it or claim ordinary type checking is equivalent |

The four rules Next already disables are `no-unknown-property`, `react-in-jsx-scope`, `prop-types` and `jsx-no-target-blank`. Recording the historical baseline is not a new permission to disable other checks or weaken product security/accessibility requirements.

ESLint React also supplies its own Hooks-related checks. Do not apply its `disable-conflict-eslint-plugin-react-hooks` preset and silently replace the official Hooks/compiler diagnostics. An evaluated configuration must explicitly assign ownership and preserve coverage.

### Why an alternate engine is not an automatic fix

Oxlint **1.89.0**’s versioned configuration schema contains matching names for **14 of the 17** active React entries. It lacks matching entries for `no-deprecated`, `jsx-uses-react` and `jsx-uses-vars`. Built-in scope analysis might replace the bookkeeping rules; it does not by itself establish deprecated-API coverage. Matching names do not prove matching options, semantics or diagnostics. Thus neither an Oxlint-only switch nor an ESLint/Oxlint combination is approved as the solution.

Adding a second engine incurs native-binary review and configuration/test ownership. Biome’s metadata alone supplies no coverage comparison. No alternate engine, custom rule kit, prerelease, patched vendor package or peer exception was adopted.

## 6. Notice and execution boundaries

- Import-x’s MIT notice retains **Ben Mosher (2015)**. The accessibility fork’s MIT notice retains **ES Community Tooling (2024–present)** and **Ethan Cohen (2016–2024)**. Preserve upstream authorship, not only the fork’s package name.
- ESLint React and the seven inspected sibling/shared archives have byte-identical MIT notices, **Rel1cx and Other Contributors (2023)**. This does not clear their uninspected transitive graph.
- The TypeScript import resolver has an **ISC** notice, **Alex Gorbatchev (2021)**. Its resolver’s native dependencies still need separate review.
- The two Next lint archives lack a standalone root notice; the version-tagged Next **16.4.2** repository [MIT license](https://github.com/vercel/next.js/blob/v16.4.2/license.md), **Vercel (2025)**, was fetched/read as upstream mapping. Do not fabricate a notice from a registry label.
- Oxlint’s root MIT notice credits **VoidZero Inc. & Contributors (2024–present)** and **Boshen (2023)**. No native-binding/embedded-license clearance follows from this text archive or its registry metadata.
- The 23 inspected version records were stable and not marked deprecated. None declared a direct preinstall/install/postinstall/prepare hook in those records. That says nothing about all transitives, runtime native loading, publisher signatures or security. No SLSA/signature verification or complete graph audit was performed here.

All 16 static archive bytes matched their registry SHA-512 integrity before text inspection. Registry integrity is not independent publisher attestation, legal clearance or permission to execute an arbitrary graph.

## 7. Evidence and next action

Research root: `C:/Users/HP/AppData/Local/Temp/your-own-lint-review-sm_kl3kn/`. Durable selected metadata, source/notices, helper scripts, static results and source/archive identities are retained in [the evidence snapshot](evidence/m00-t04-lint-review.json). The snapshot captures **106 files**, **1,096,476 bytes**, SHA-256 `e67a47b5ca9a533b949b57faeb8fe759aeceb28328b461c402ff737d32c0bc6f`. Large registry indexes, complete archives, schema and selected website HTML remain external; their source URLs/hashes identify omitted bytes. This is research evidence, not an application manifest/configuration/lockfile.

Checks actually run:

- Public HTTPS GETs; static archive integrity and safe text extraction, without installation or vendor-code execution.
- `node .../check_ranges.cjs` on ordinary installed **Node 24.18.0**, with existing npm **semver 7.8.1**: **49 selected engine/peer assertions — 46 matches / three expected ESLint 10 rejections**, across 23 stable/nondeprecated records. Node 24.22.1 / TS 6.0.3 were candidate **input strings**, not runtimes executed here. This is not full dependency resolution.
- `python .../compare_static.py`: accessibility preset token comparisons, exported-name inventory, React/Next baseline inventory, publication and notice hashes. No JavaScript module was imported/evaluated.
- Versioned Oxlint schema inspection followed its `$ref` to `DummyRuleMap`. An initial inspection helper incorrectly assumed direct `properties`; a subsequent terminal print hit Windows encoding limits. Corrected reference traversal/UTF-8 output produced the retained 14/17 name inventory. Neither failure was a candidate lint run.

**Historical next action after the first pass:** finish the rule-by-rule coverage disposition before proposing an executable experiment. The follow-up below completes that static disposition, not compatibility verification. Any experiment must require the intended rule/compiler diagnostic, not unrelated parse errors, ignored files or zero-file runs; cover both Next apps, JS/config files, TS/TSX, aliases/exports and cross-app restrictions; and run lint separately from type checks/builds.

A passing limited experiment would still not approve production pins or prove browser accessibility/security. Keep M00-T04 unchecked, preserve existing probe evidence, and do not advance to M00-T05/M01, restore ESLint 9, relax peers without a new explicit decision, install chart engines or treat research as an owner decision.

## 8. Completed static disposition and owner choice

### What the deeper source review established

All **17 active React baseline entries** now have a disposition, positive/negative specimen and required edge-case list in [the rule-map evidence](evidence/m00-t04-lint-rule-map.json). Its **34 specimens are unexecuted data**, not passing tests or production code. Rule-isolated positive specimens may intentionally trigger a different rule; a future full-config clean sample must pass every enabled check separately.

Important refinements to the initial mapping:

1. **Display names:** ESLint React 5.28.8's component rule explicitly returns early without `memo`/`forwardRef` and filters to those wrappers. It cannot simply replace the original's broader anonymous-component coverage. Adding context display names does not fill that gap.
2. **Deprecations:** React 7.37.5's source has **31 catalog entries**, including alias duplicates, nested legacy APIs, `this.transferPropsTo`, three lifecycle names, ReactDOM and server-renderer APIs. All version thresholds apply to candidate React 19.3.1. The rule also handles named imports and require/destructuring forms. Three lifecycle rules are not equivalent. [typescript-eslint's `no-deprecated`](https://typescript-eslint.io/rules/no-deprecated/) relies on JSDoc/type information, and TypeScript itself does not error merely because a declaration is marked deprecated. Missing/removed type declarations and deprecation diagnostics are different checks.
3. **JSX references:** [ESLint 10's release notes](https://eslint.org/blog/2026/02/eslint-v10.0.0-released/) document native JSX reference tracking. That supplies a plausible route for undefined/unused-component checks, but is not proof for typescript-eslint's separate scope manager. It also does not reproduce `jsx-uses-react`'s marking of the React pragma/fragment binding. The two bookkeeping rules have no standalone error; their fixtures must inspect the relevant unused-variable rule rather than expect a nonexistent helper diagnostic.
4. **`isMounted`:** the original checks `this.isMounted()` calls with method/property ancestry, not only React component classes. A React-class-only replacement would be narrower.
5. **String refs:** the original disables its `this.refs` prohibition for React **18.3 and newer**, while literal/string-expression `ref` checks remain. `noTemplateLiterals` defaults to false. A blanket `this.refs` ban at React 19 would change behavior rather than preserve it.
6. **Text and returns:** unescaped-entity detection reads source text, so checking decoded JSX values can reject valid entities. Render-return enforcement checks for a syntactic return, excluding nested callbacks; that is not the same as all-path return analysis or type checking. Do not ban class/error-boundary components merely to remove the testing obligation.

The version-tagged [Next 16.4.2 ESLint guide](https://github.com/vercel/next.js/blob/v16.4.2/docs/01-app/03-api-reference/05-config/03-eslint.mdx), not just the moving website, explicitly documents ESLint 10 support **and** the strict-peer conflict. The previously inspected exact package supplies the legacy-context wrapper. Fresh exact registry records for Next config, ESLint and the three plugins retained their prior artifact integrity and peer declarations. These facts justify considering a controlled experiment; they do not prove runtime compatibility.

A small additional registry search did not establish another ready drop-in: `eslint-plugin-react-compat 0.1.7` concerns Inferno/Preact compatibility, not ESLint 10; `@eslint-react/kit 5.28.8` is custom-rule infrastructure, not proof that missing rules are supplied. A guessed community React-package URL and an old Next test-directory URL returned 404; those are recorded lookup failures, not exhaustive absence or failing application tests. No new package archive, native binary or dependency installation was needed for this pass.

### Owner choices — historical proposal

| Option | Consequence | Recommendation |
|---|---|---|
| A — Keep strict declarations with no exceptions | Retain the blocker; wait for compatible declarations or continue evaluating a genuinely complete replacement | Default before Decision 0007; production exceptions remain unapproved |
| B — Authorize a narrowly scoped official-config experiment | Test Next 16.4.2's documented ESLint 10 path with three explicit, exact peer-declaration exceptions; retain original rule implementations | Recommended experiment only; subsequently authorized by Decision 0007 and executed separately, without production adoption |
| C — Commission a replacement/custom-rule stack | Own the missing semantics, tests, notices and ongoing maintenance, potentially with another engine | Not recommended just to avoid this declared-peer mismatch; requires a separate scoped decision |

**B changes a boundary.** Decision 0005 expressly prohibited forcing ESLint peers. The proposal is an explicit amendment **for a new disposable lint experiment only**, not a reinterpretation of past approval. Calling it a “metadata exception” does not make the risk disappear: it overrides a package manager's compatibility safeguard while actual compatibility remains unproven. At proposal time, an explicit owner answer was required and A remained in effect. Decision 0007 subsequently records that answer and its experiment-only amendment; it does not alter production policy.

### Proposed experiment B — subsequently authorized separately

- Reuse verified portable **Node 24.22.1 / pnpm 12.15.0** in a new external temporary workspace with isolated caches/config/home and synthetic fixtures. Preserve all existing samples and evidence. No global manager/SDK changes, repository app scaffolding, servers, browser/native-device tests, chart engines, providers, spend, outreach or deployment.
- Candidate tooling: **ESLint 10.13.0**, **eslint-config-next 16.4.2**, **@eslint/js 10.0.1**, **typescript-eslint 8.72.0**, **TypeScript 6.0.3**; Next **16.4.2**, React/DOM **19.3.1** and the already reviewed type helpers (**@types/node 24.19.2**, **@types/react / @types/react-dom 19.3.0**) for the synthetic apps. Explicitly review/pin the original plugins: **eslint-plugin-react 7.37.5**, **eslint-plugin-import 2.32.0**, **eslint-plugin-jsx-a11y 6.10.2**, **eslint-plugin-react-hooks 7.1.1**, and **@next/eslint-plugin-next 16.4.2**. These are package versions, not selected production pins. Stop if the aggregate config resolves different plugin identities; do not add dependency overrides to force them.
- Keep `strictPeerDependencies: true`, automatic peer installation off, integrity checks on and lifecycle scripts disabled. If authorized, the **only proposed peer exceptions** are the following [pnpm `allowedVersions` parent selectors](https://pnpm.io/settings/peer-dependencies#peerdependencyrulesallowedversions):

```yaml
# Historical proposal; later authorized only for Decision 0007's experiment.
peerDependencyRules:
  allowedVersions:
    "eslint-plugin-react@7.37.5>eslint": "10.13.0"
    "eslint-plugin-import@2.32.0>eslint": "10.13.0"
    "eslint-plugin-jsx-a11y@6.10.2>eslint": "10.13.0"
```

- This is not an unqualified strict-peer pass. Record the three exceptions prominently in resolution/test results. Do not use `allowAny`, `ignoreMissing`, blanket `strictPeerDependencies: false`, `--force`, vendor patches, dependency overrides or changes to other declared peer ranges. Test selector scope with synthetic negative controls/removal of an exception; if pnpm 12 does not enforce the intended narrow scope, stop rather than broaden it.
- Resolve with scripts disabled; inspect the full graph, native resolver artifacts/hooks, actual notices and dated advisories before loading any candidate code. Verify required binary bytes before execution. Unexpected peers, unavailable/deprecated candidates, integrity discrepancies or unreviewed executable requirements stop the relevant lane. Do not silently substitute versions. Preserve the actual lockfile and prove a frozen repeat install.
- Load Next's own Core Web Vitals and TypeScript configurations; keep all **17 original React entries**, the **22 first-party Next rules/two severity upgrades**, complete official Hooks recommended rules and import checks accounted for. Do not apply replacement-React conflict-disable presets or patch Next's wrapper.
- Preserve the **31 enabled JSX accessibility rules/options** from the original recommended/strict comparison, in addition to Next's `Image` mapping. Apply rule overrides through the plugin registered by Next rather than blindly registering a second plugin object. Review explicit control-label and hidden-focus checks, custom component mappings and genuinely decorative icons; merely loading Next's six-rule accessibility subset is not sufficient evidence here.
- Capture effective configurations for both synthetic web/admin apps and representative JS/JSX/TS/TSX files. Run the 34 seed specimens, expand the 31-entry deprecation/alias and documented edge cases, and verify target rule IDs, positive controls, matching file counts and no fatal parser failures. Test actual unused-variable diagnostics for bookkeeping helpers. Negative specimens are expected to fail intentionally; neither an ignored file nor an unrelated error proves detection.
- Separately lint/type-check a clean full-config sample for each app, including supported class/error boundaries, imports/aliases, owned controls and server/client restrictions. No automatic fix or rule-disable change may conceal a failed requirement. Preserve results/failures/commands, native/script review and remaining limits. Success would support a later final-pin decision—not verify M00-T04 or authorize production use of the exceptions.

### Follow-up evidence

External root: `C:/Users/HP/AppData/Local/Temp/your-own-lint-map-28y1e0b6/`. `inventory.py` checked the 31-entry deprecation catalog and five unchanged exact metadata identities; `build_map.py` covered exactly the 17 baseline entries and produced 34 **not-run** specimens. `node .../check_map.cjs`, using installed Node **24.18.0** and existing semver **7.8.1**, passed **35 range assertions: 32 matches / three expected ESLint 10 peer rejections**, plus map/specimen consistency. Candidate versions were input strings, not newly executed runtimes.

The separate [rule-map snapshot](evidence/m00-t04-lint-rule-map.json) captures **27 files / 197,222 bytes**, SHA-256 `baacd50b325aafc4c97a44cd891f96c61d4f73d03e5cbb6394cd1d4c4faa0df7`, preserving these facts, public responses/404s, source identities, helper scripts and the fixture plan. Earlier executable-probe, mobile-retry and first lint snapshots remain unchanged. No lint/compiler specimen, package-manager exception, new dependency graph or application test was executed during this follow-up.

**Historical next action:** obtain the owner's explicit authorization for experiment B. That answer and bounded execution are now recorded in [Decision 0007](decisions/0007-isolated-lint-probe.md) and the [lint probe report](toolchain-lint-probe.md). No replacement stack was selected; production peer policy and final pins remain unapproved. M00-T04 stays In progress / unchecked; ApexCharts and all scaffold gates are unchanged.
