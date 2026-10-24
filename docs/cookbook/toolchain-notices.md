# Dependency Notices and Adoption Readiness — M00-T04

- **Version:** 0.3
- **Observed:** 2026-10-24 UTC; static review on Windows, no new package installation or candidate execution
- **Status:** 16 notice dispositions recorded; production selection and M00-T04 completion remain unapproved
- **Related:** [Candidate versions](toolchain-review.md), [tool/JS/mobile results](toolchain-probe.md), [exception-based lint results](toolchain-lint-probe.md), [Decision 0007](decisions/0007-isolated-lint-probe.md)

## 1. Outcome and scope

The instruction to **continue** addressed by this static notice pass was scoped to notices and approval-readiness research. It did **not** approve production peer exceptions, final pins, another install/build experiment, supplier contact or scaffolding. The later, separate combined-attempt authorization and its security stop are distinguished in section 5.

The lint inventory's **15 roots without a separate top-level notice file** were reviewed individually. Comparing the earlier JS inventory found one additional root, `@tokenizer/token 0.3.0`. Across these **16 cases**, **14 have identified embedded, upstream, linked or declaration-plus-terms mappings**; **two retain incomplete attribution/notice mappings: `client-only` and `stable-hash`**. A missing `LICENSE` filename is not the same as an unlicensed package. Conversely, an SPDX label or a related project's license is not a complete notice bundle.

This is a technical evidence/disposition register, **not legal clearance**. Mapping a root notice does not establish rights for every embedded component, native artifact, export or redistribution form. No dependency was removed, substituted, patched or relicensed to make the register appear complete.

## 2. Notice dispositions

All versions below are existing experimental inputs, not new production pins. Sources and exact hashes are retained in the [evidence snapshot](evidence/m00-t04-notice-review.json), including original attribution text rather than synthesized copyright lines.

| Package / version | Located evidence | Disposition |
|---|---|---|
| `@humanfs/types 0.15.0` | Package and exact-commit repository READMEs explicitly say Apache 2.0 and name Nicholas C. Zakas; published types source matches metadata commit `85069f193cbacc371c3beb649ce746f8c5a493be`. Apache terms are present in the same commit's `packages/core/LICENSE` | **Declaration and terms mapped.** Preserve the types README/source attribution and terms. Do not claim there is a separate types LICENSE or invent its copyright line |
| `@next/env 16.4.2` | Version-tagged Next root MIT notice, Vercel 2025 | Root mapping only; embedded dependencies remain separate |
| `@next/eslint-plugin-next 16.4.2` | Same version-tagged Next notice | Root mapping; keep third-party dependency notices separately |
| `@next/swc-win32-x64-msvc 16.4.2` | Same version-tagged Next notice | Root mapping, **not** a license inventory for every linked Rust crate |
| `eslint-config-next 16.4.2` | Same version-tagged Next notice | Root mapping; no new peer-policy approval |
| `@types/json5 0.0.29` | Exact source, including BOM, matches DefinitelyTyped commit `337587de8c13868283993bfacdcdd1a0f3291e7f`. That commit's MIT notice assigns copyrights to contributors named in each definition file | Retain **Jason Swearingen** attribution plus the historical MIT text; do not substitute current unrelated typings/credits |
| `@unrs/resolver-binding-win32-x64-msvc 1.12.2` | Previously fetched MIT notice at metadata commit `ccb26d205e2938b16069c64a28996b48ee97ff94`: UnRS 2025–present, VoidZero 2024, Boshen 2023 | Root mapping only; embedded-crate review remains separate |
| `unrs-resolver 1.12.2` | Same exact-commit UnRS notice | Preserve all three attribution lines, not just the current package author |
| `client-only 0.0.1` | MIT declaration; manifest, empty `index.js` and `error.js` byte-match Next's vendored copy | **Partial.** Neither copy supplies a complete original copyright/notice. React homepage/issue links and Vercel's vendoring are not sufficient to assign a fabricated Meta/React/Vercel copyright |
| `esrecurse 4.3.0` | Complete BSD-2-Clause text in `esrecurse.js` header, Yusuke Suzuki 2014 | Embedded notice located. Preserve the actual disclaimer, including its upstream placeholder, rather than silently editing it |
| `imurmurhash 0.1.4` | Complete MIT text in README, Gary Court and Jens Taylor 2013 | Embedded notice located; retain both authors |
| `language-subtag-registry 0.3.23` | README expressly dedicates the JSON database under CC0 1.0; linked legal text retained | Declaration and terms mapped; no inference about product language/region support or trademark/patent rights |
| `language-tags 1.0.9` | README credits Matthew Caruana Galizia 2013 and links complete MIT terms | Linked mapping. The live page currently renders **2026**; retain original **2013** attribution as well, and do not call the live page version-pinned |
| `natural-compare 1.4.0` | README credits Lauri Rooden 2012–2015 and links complete MIT text on the author's site; source header names version 1.4.0 | Linked mapping; preserve original years and fetched terms. Exact-commit root tree has no standalone license file |
| `stable-hash 0.0.5` | README byte-matches metadata commit `1b314f2cc3e9449bc8d49e417670175cf9afd42a`: “Created by Shu Ding. Released under the MIT License.” | **Partial.** Retain this declaration; no full notice was found in the inspected package/root tree. Do not invent a year or silently borrow SWR's license |
| `@tokenizer/token 0.3.0` | Complete MIT notice in README, Borewit 2020; present in the initial JS probe, not the lint graph | Embedded notice located; no new installation needed |

The [Next v16.4.2 tag](https://github.com/vercel/next.js/tree/v16.4.2) resolves to commit **`2864b1772c37242a9b40ab4d366eb7d368c2a070`**. Its pinned [MIT notice](https://github.com/vercel/next.js/blob/2864b1772c37242a9b40ab4d366eb7d368c2a070/license.md) was fetched and read; this provides an immutable source location for the root mappings, not attestation that every published binary was built from that commit.

No supplier message, issue, purchase or disclosure was sent. The [subsequent public-source trace](toolchain-notice-trace.md#2-stop-repeating-the-two-unresolved-root-searches) located existing upstream requests for both partial cases, but no applicable complete notice. Their attribution entries stay partial; retain the bounded evidence and seek qualified review or separately authorized clarification rather than repeat blind filename searches. An owner decision cannot itself grant missing upstream rights. Do not delete these transitives or change resolver/framework versions without a separately reviewed compatibility decision.

## 3. Graph and embedded-artifact boundaries

| Inventory | Actual finding | What it does not establish |
|---|---|---|
| Two JS experiments | Initial graph **239** identities; lint graph **331**; **61** exact package/version pairs overlap; union **509** | Not a combined resolution, a production lockfile, 509 distinct package names or a shippable SBOM. Do not merge lock documents mechanically |
| Mobile retry | **95 actual hosted packages** retain matching hashes for all **95** recorded root notices; five SDK packages and the synthetic app are separate | No renewed availability/advisory check, embedded/native review, encryption approval or complete Flutter/engine notice bundle |
| Next compiled children | **147 `package.json` paths** under `dist/compiled`; only **10** carry versions; **130** distinct sibling notice files; **17** paths lack a same-directory notice | Paths include scope markers, not just independent packages. A missing sibling file may be covered by a parent/header notice; a sibling notice may still be incomplete |
| Next WASM | Four files: source-map mappings, `@vercel/og` resvg/yoga and interceptors' llhttp | File/hash inventory only; not proof these are shipped, executed, excluded or fully licensed in a future release |
| Hermes parser | README confirms a WASM-compiled parser; `dist/HermesParserWASM.js` embeds the payload | Native content is not limited to `.node`/`.dll`/`.wasm` filenames. A CommonJS cache listing is not complete execution tracing |
| UnRS source lock | **183** entries, **181** registry-sourced, at the declared commit | Includes development/optional/platform-specific inputs; not the exact linked Windows crate set |
| Next source lock | **1,032** entries, **959** registry-sourced, at the resolved tag commit | Not a native license audit, an exact binary SBOM or proof all those crates are distributed |

The 17 Next paths without sibling notices are retained individually in `inventory-results.json`. Examples include a Babel ESM scope marker, `@edge-runtime/*`, `client-only`/`server-only`, browser shims and `string-hash`. They must not all be labelled “unlicensed,” nor assumed cleared by Next's root MIT notice. The [17-path follow-up](toolchain-notice-trace.md#3-embedded-next-notice-triage) distinguishes parent/source/header/LEGAL-file coverage from unresolved marker attribution, aggregate/embedded notices, Unistore's redirected license link and font assets. It does not rewrite this pass's original filename-scan counts or certify a release bundle.

The Next/UnRS source locks and package manifests provide bounded inputs for native-notice review. Build features, target triples, upstream build evidence and actual release artifacts still determine the relevant linked set. No Rust compiler, new package archive or native binary was downloaded or executed here.

Existing sharp Windows Apache-2.0/LGPL-3.0-or-later, axe-core MPL-2.0, caniuse-lite CC-BY-4.0, minimatch BlueOak-1.0.0 and other obligations remain as recorded. The reviewed SQLite host DLL is plaintext compatibility evidence, not the final encrypted mobile driver. Hugeicons remains **Free Stroke Rounded only**; standalone poster/export notice handling and the full implicit-glyph catalog remain open. ApexCharts stays excluded.

## 4. Support and bootstrap recommendation

Public policy pages were reread; this pass did **not** rerun a security audit, refresh every candidate version or execute a production bootstrap.

- [Node's schedule](https://github.com/nodejs/Release/blob/main/schedule.json) puts Node **24** in Maintenance LTS from **2026-10-20**, ending **2028-04-30**. Node 26 LTS starts **2026-10-28**, after this observation. Keep the tested Node 24.22.1 candidate under review; do not automatically jump lines or promise that one patch stays secure until the line's end date.
- [Next's policy](https://nextjs.org/support-policy) still lists **16.x as Active LTS**. This is line-level policy, not permanent support for patch 16.4.2 or a fresh advisory clearance.
- [ESLint's policy](https://eslint.org/version-support/) still lists **10 as Current** and **9 as EOL since 2026-08-06**. The bounded ESLint 10 result is preferable evidence to silently restoring ESLint 9. The three incompatible peer declarations and the experiment-only scope remain unchanged.
- [pnpm's installation guide](https://pnpm.io/installation) describes native pnpm 12 and Node **≥22.13** for its npm-based installer. The earlier experiment verified the explicit Windows native executable; it did **not** test Corepack or a clean production bootstrap.

**Recommendation for a future authorized bootstrap:** retain an explicit, versioned, integrity-checked tool location and launcher rather than depending on the ordinary global Corepack shim. Record Node and package-manager identities separately, isolate configuration/store paths, check the actual executable version, preserve both pnpm lock documents and fail on mismatches. The verified Windows approach is a candidate—not proof for Linux/macOS, CI images, offline recovery or future releases.

Do **not** copy the guide's moving `npx`/self-update or pipe-to-shell instructions into production automation without review. No global PATH/shim replacement, antivirus exclusion, machine-wide package-manager setting, extra version manager, lifecycle-script blanket approval or new remote installer execution is authorized. Previously rejected pnpm 12 settings remain rejected; do not restore them as purported pin enforcement.

## 5. Finite remaining approval queue

This pass narrows the open work; it does not create another accepted decision.

| Gate | Next concrete action | Current authority |
|---|---|---|
| Notice completion | Resolve the two root-package attribution questions using the located upstream requests/review path; address the follow-up's embedded gaps and [artifact delivery map](toolchain-notice-trace.md#4-distribution-mapping-still-required), including posters | Public static research permitted; supplier contact/disclosure and legal/risk acceptance need their own scope. No blanket clearance |
| Reproducible whole stack | The separately authorized [combined attempt](toolchain-combined-probe.md) resolved but stopped on a high Multer advisory before installation/build/lint; choose upstream-fixed candidate review or the explicitly scoped retry proposal | Decision 0008 authorized only the unchanged bounded graph. No dependency override/version-change retry or production adoption is approved |
| Production lint policy | Present Next's original-rule path with **exactly the three disclosed exceptions** as a candidate, including maintenance/removal criteria and retained diagnostics | Decision 0007 approves only the completed experiment. A separate explicit production-policy decision is required; no wildcard or additional exception |
| Final version selection | Consolidate the candidate matrix with actual compatibility, notice, support and target evidence; distinguish provisional platform constraints from tested results | No exact production pins approved here. OS/browser, provider, persistence and contract tasks keep their own gates |
| ApexCharts | Keep integration held until an applicable entitlement determination or explicit direction amendment | No install, replacement engine, supplier contact, business disclosure or spend authorized |
| Scaffold | Finish applicable M00 decisions/spikes and obtain M00-T14 go/no-go | No advance to M00-T05/M01 or repository applications inferred from this report |

The next bounded work remains **M00-T04**, not another broad dependency upgrade or application build. When an approval question is ready, state the exact change and limits; a generic research “continue” must not be relabelled acceptance of production exceptions or all pins.

## 6. Evidence and verification

External research root: `C:/Users/HP/AppData/Local/Temp/your-own-notices-8_f_7qfr/`. The checkout began clean at **`b9cb618ff5d5c324f9c8d78813f59f417ce5d0b5`**. All five earlier snapshots and the earlier temporary samples were preserved.

The separate [notice-review snapshot](evidence/m00-t04-notice-review.json) captures **90 files / 996,552 bytes**, SHA-256 `1e7081755c3d75ead6bc0ec4d633a1295b876ac10cd8b6fd2f3d97c2dce4ab34`. It retains public text/source responses, failed lookups, local notice locations, exact hashes, six successful source-byte comparisons, graph/embedded inventories, the 16-row register and standard-library review/validation scripts. It contains no executable binaries or adopted application implementation. Original bytes/hashes and normalized temporary paths are distinguished.

Recorded lookup failures: guessed HumanFS/stable-hash root LICENSE paths and a React `client-only` package path returned 404; the obsolete DefinitelyTyped `types-2.0` branch query returned 422. Exact trees/readmes/history were then inspected. These failures are not proof that licensing does not exist.

An initial own helper labelled all **101 package-config roots** as hosted dependencies. The initial output is retained and explicitly corrected: **95 hosted + five SDK + one synthetic app**. The final register verifies the 95 hosted notice hashes, not the incorrect initial label. No candidate runtime failed or prior evidence changed.

Validation checks all 16 dispositions, six byte comparisons, fetched/local hashes, the 509-identity set union, Next embedded manifests/notices, the two source-lock counts, 95 mobile notice hashes, all five unchanged earlier snapshots and absence of repository app/config scaffolding. These are static inventory/documentation checks, not new runtime, browser, native-device, security or legal certification. The later [trace report and separate snapshot](toolchain-notice-trace.md#6-evidence-and-checks) preserve this 90-file snapshot unchanged and record the additional findings and historical next-experiment proposal. [Decision 0008](decisions/0008-isolated-combined-js-probe.md) later authorized that attempt; its [security stop](toolchain-combined-probe.md) is separate from this static notice review and leaves the notice gaps intact.
