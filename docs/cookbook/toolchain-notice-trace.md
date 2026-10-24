# Attribution Trace and Next Validation Plan — M00-T04

- **Version:** 0.2
- **Observed:** 2026-10-24 UTC; Windows, public text-only research and existing-file inspection
- **Status:** Static research complete; the later combined attempt was separately authorized by Decision 0008 and stopped at its security gate. Attribution/bundle questions and any changed-scope retry remain open
- **Related:** [Notice register](toolchain-notices.md), [candidate review](toolchain-review.md), [completed lint experiment](toolchain-lint-probe.md), [M00-T04](../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review)

## 1. Outcome and authority

The **“continue”** addressed by this historical static pass was scoped to tracing the two remaining root-package attribution questions and examining embedded notices. No installation, candidate execution, expanded peer allowance, supplier contact, production selection or scaffolding occurred in that pass. Its instruction did not authorize the proposed combined check. A later explicit question/answer is now recorded separately in [Decision 0008](decisions/0008-isolated-combined-js-probe.md); the [resulting attempt](toolchain-combined-probe.md) stopped at the security gate before application installation/execution.

The earlier **16-root register remains 14 scoped mappings / two partial cases**. Public history now identifies existing upstream requests for both partial cases; neither supplies the missing original notice. Separately, all **17 Next embedded manifest paths without sibling notices** were triaged. Parent/source notices explain several cases, while marker attribution, merged dependencies, a broken Unistore license link and actual distribution coverage remain explicit. These are not 17 independent unlicensed packages, nor 17 cleared bundles.

## 2. Stop repeating the two unresolved root searches

| Case | Additional public evidence | Disposition / next action |
|---|---|---|
| `client-only 0.0.1` | [React issue 27242](https://github.com/react/react/issues/27242), including all 12 observed comments, asks for the same missing notice. Its closure followed stale/inactivity bot messages; the observed state is closed / not planned. Later comments still request original attribution. Registry metadata identifies the publisher account, but no repository/author copyright notice. React's server-module RFC describes publishing the marker packages; Next's original vendoring commit copies them | **Still partial.** No observed comment supplies an authoritative release-specific notice. Conflicting legal opinions from commenters are not adopted. A publisher account, RFC authorship, React homepage or copying into Next does not determine the original copyright holder. Inactivity closure is not resolution |
| `stable-hash 0.0.5` | [Issue 25](https://github.com/shuding/stable-hash/issues/25), “Please add a LICENSE file,” is open with zero comments. Queries for default-branch history of `LICENSE` and `LICENSE.md` returned empty arrays; the inspected current root tree also lacks a separate notice. Earlier exact-commit README/source evidence remains unchanged | **Still partial.** Retain “Created by Shu Ding. Released under the MIT License.” The two filename histories are bounded negative evidence, not proof of absent licensing everywhere. Do not invent a copyright year or borrow SWR's notice |

The initial issue searches using `repo:facebook/react` returned **422**. A repository lookup resolved the current name to `react/react`; a broader title search located issue 27242, which was then read directly. Failed searches are not negative evidence. No issue, comment, message or business disclosure was submitted.

**Recommended next step:** retain these explicit open entries rather than conduct another blind filename search. The existing requests already ask the relevant questions; do not post duplicates by default. The owner can arrange qualified licensing review of the available declarations/notices or separately authorize narrowly scoped clarification through an approved channel. Neither an owner approval nor a commenter’s opinion creates upstream rights.

If clarification is authorized later, the questions are already bounded:

- **Client-only:** Which authoritative source and copyright/permission notice apply to the exact published `client-only@0.0.1` files? If supplied for a later release, does it also cover 0.0.1?
- **Stable-hash:** Please identify the complete notice applicable to `stable-hash@0.0.5` / metadata commit `1b314f2cc3e9449bc8d49e417670175cf9afd42a`, preserving the release's actual attribution rather than inventing a year.

These are unsent questions, not an outreach plan or permission to use existing GitHub credentials. Product name, private application details, owner identity and business information are unnecessary for those questions.

## 3. Embedded Next notice triage

All paths below are under existing **Next 16.4.2 `dist/compiled/`**. The [pinned Next manifest](https://github.com/vercel/next.js/blob/2864b1772c37242a9b40ab4d366eb7d368c2a070/packages/next/package.json), [vendoring taskfile](https://github.com/vercel/next.js/blob/2864b1772c37242a9b40ab4d366eb7d368c2a070/packages/next/taskfile.js) and source lock provide **declared build-input links**, not reproducible-build attestation. Twelve exact registry integrity strings match their records in that source lock. Its own canaries, overrides and peer settings are **not** adopted into our experiments or production policy.

| Embedded path / declared input | Notice evidence | Remaining boundary |
|---|---|---|
| `@babel/runtime/helpers/esm` / runtime 7.27.0 | The manifest is an ESM scope marker, not a separately named package. Existing parent `@babel/runtime/LICENSE` contains MIT / Sebastian McKenzie and other contributors, 2014–present. The regenerator helper's banner points to its distinct MIT notice; the installed `regenerator-runtime/LICENSE` retains Facebook, 2014–present | Preserve parent and applicable helper notices; do not classify the scope marker as a missing-license package or erase helper attribution |
| `@edge-runtime/cookies` / 6.0.0 | Exact release tag resolves through an annotated tag to commit `440c123a37284d6a852ce453af810ad484ecfc01`; same-commit manifest matches name/version. Root MIT notice credits Vercel 2024 | Root source mapping, not all bundled-input or published-byte provenance |
| `@edge-runtime/ponyfill` / 4.0.0 | Same release commit/root notice, with matching package manifest | Next rewrites its primitives import during vendoring; no unmodified-byte/build claim |
| `@edge-runtime/primitives` / 6.0.0 | Same release commit/root notice. Two nonempty `*.LEGAL.txt` files retain formdata-polyfill / Jimmy Wärting and ws / Einar Otto Stangvik MIT banners; these filenames were outside the earlier sibling-name scan | The banners are not complete terms for every embedded input. Source manifest lists undici 6.21.0, event-target-shim 6.0.2, urlpattern-polyfill 10.0.0 and workspace format input; determine what is actually bundled before calling it complete |
| `@next/font` / 16.4.2 | Pinned `packages/font/package.json` declares MIT, under Next's root notice. Vendoring copies JS/JSON/declaration files rather than all notice filenames | Root family mapping does not cover embedded fontkit 2.0.2/dependencies or license actual fonts. Existing `dist/fontkit/index.js` is inventoried; its merged notice set remains open |
| `babel-packages` | Generated synthetic manifest, not an independently versioned npm identity. Bundled text contains Lodash/Underscore, regenerate and regjsgen notices; nearby `babel/LICENSE` supplies Babel's own MIT text | **Aggregate incomplete.** Neither the nearby Babel notice nor short banners prove complete notices for all merged modules |
| `client-only` / 0.0.1 | Same three bytes/files already compared with the installed root package in the earlier review | **Original attribution remains partial**, as section 2 records |
| `constants-browserify` / 1.0.0 | Complete MIT text in README at metadata commit `e0ee990c75f3a0b3275e6bb2e3ff4d5d169d1b9d`, Julian Gruber 2013 | Source-input mapping; retain the README notice, not a fabricated standalone LICENSE |
| `css.escape` / 1.5.1 | Complete `LICENSE-MIT.txt` at metadata commit `b036d330b93f58b1bc87f1097fdc822da58e090f`, Mathias Bynens | Preserve the original notice, which has no year; do not invent one. Compiled-byte/source relationship is not independently reproduced |
| `data-uri-to-buffer` / 3.0.1 | Complete MIT text in same-commit README, Nathan Rajlich 2014 | Root source notice; merged inputs and actual delivery still need mapping |
| `http-proxy-agent` / 5.0.0 | Complete MIT text in same-commit README, Nathan Rajlich 2013 | Root source notice, not blanket coverage of bundled dependencies |
| `https-proxy-agent` / 5.0.1 | Complete MIT text in same-commit README, Nathan Rajlich 2013 | Same qualification; a similarly named modern package is not substituted |
| `punycode` / 2.1.1 | Complete `LICENSE-MIT.txt` at metadata commit `68df855dc42d1086ada161331b3074468e8d848d`, Mathias Bynens | Retain the notice without inventing a year; source mapping is not a build attestation |
| `server-only` / 0.0.1 | Embedded manifest declares MIT; original Next vendoring history includes this marker too | **Original attribution remains partial.** React/Next family association is insufficient. The client-only issue is evidence for that package, not a maintainer answer for server-only |
| `setimmediate` / 1.0.5 | Complete `LICENSE.txt` at metadata commit `f1ccbfdf09cb93aadf77c4aa749ea554503b9234`, Barnesandnoble.com, llc, Donavon West and Domenic Denicola, 2012 | Preserve all three attributions, not merely manifest author “YuzuJS” |
| `string-hash` / 1.1.3 | README at metadata commit `5bf7547a91372c399f4052cc1094a93f73e10284` expressly dedicates rights under linked CC0, naming The Dark Sky Company, LLC; CC0 terms were retained earlier | Declaration/terms mapping, not MIT. Preserve the actual upstream wording rather than silently correcting it |
| `unistore` / 3.4.1 | Exact-commit README says MIT and explicitly credits © Jason Miller. Its linked `oss.ninja/mit/developit` now redirects to a technology/blog home page, not the requested notice | **Full linked terms not recovered in this pass.** A 200 response is not a successful license retrieval. Retain the attribution/declaration and failed-link evidence; do not use unrelated landing-page text as a license |

All exact metadata commits, source URLs, retrieval hashes, local file hashes and classifications are in the [trace snapshot](evidence/m00-t04-notice-trace.json). The three Edge release tags resolve to the same commit; their [MIT text](https://github.com/vercel/edge-runtime/blob/440c123a37284d6a852ce453af810ad484ecfc01/LICENSE.md) was read completely. Complete MIT texts/README sections for the seven other MIT input names above were read, as were the remaining named notice sources. Source mappings do not assert all minified/merged outputs equal those upstream bytes.

**Font boundary discovered in the existing Next package:** nine font paths, **five distinct SHA-256 byte identities**: four Geist WOFF2 files duplicated under the ordinary/ESM devtools trees, plus `@vercel/og/Geist-Regular.ttf`. Bytes were hashed locally, not downloaded, rendered or adopted. Their applicable font notices and inclusion in future artifacts remain open. Next's root MIT notice or `@vercel/og`'s code notice is not automatically the font license. This does not select Geist over DM Sans, select a poster engine, or approve implicit third-party UI glyphs.

The earlier 130 sibling-notice / 17 missing-sibling counts remain a description of that scanner, not exhaustive license detection. This pass found parent/header/LEGAL-file evidence without rewriting its immutable snapshot. An initial comment-extraction regex also captured a JavaScript regular-expression fragment as if it were a comment; that helper output is retained and superseded by a narrower candidate-comment scan. Neither scan is a JavaScript lexer, and neither is used as proof that all notices were found.

## 4. Distribution mapping still required

There is no production artifact to certify yet. This is the finite mapping required when the approved implementation/build exists; it is not a demand to invent a release SBOM now.

| Distribution form | Evidence and notice-delivery work |
|---|---|
| Browser JS/CSS/assets, separately for web/admin | Hash the actual public output and map merged source, fonts/icons, banners and extracted notices. Test an accessible, durable notice route/file and retention through minification/CDN packaging. A server-only dependency inventory does not describe the browser payload |
| API/Next runtime directory or container | Inventory files actually delivered, including copied packages/native/WASM/font assets and required notices/source obligations. Unused files may still be distributed. If standalone tracing/pruning is selected, verify its real output rather than assuming a `devDependency` or unused feature is absent |
| Build/lint/CI tools | Keep a separate inventory for ESLint/parser/resolver/SDK/compiler and any distributed CI image or cache. A development label does not establish that no one receives a copy. Keep UnRS/Hermes/SWC/Node/pnpm notice scopes separate from application runtime |
| Mobile APK/AAB and later iOS/iPad artifact | Map Flutter framework/engine, Dart, hosted/SDK packages, fonts/icons and the actually selected native libraries; inspect generated notice assets and accessible in-app delivery. The 95 hosted root notices and plaintext Windows test DLL do not cover future target binaries or encrypted-driver selection |
| Private/exported/published posters | Determine rights and notice delivery for actually used icon/font artwork and render inputs, including standalone copies. An About page alone is not assumed sufficient. Rendered output is not automatically a copy of every renderer dependency, either; assess applicable terms and artifact contents rather than imposing invented obligations |

Sharp's native LGPL/Apache obligations, MPL-bearing code, CC-BY data and the prior Rust/WASM inventories remain open where relevant. Rust Cargo lock contents alone do not identify linked features/crates. Neither snapshot inventories nor module-cache observations prove exclusions. Appropriate target/build evidence belongs to the corresponding M00/native/design and release gates; nothing here waives them.

## 5. Proposed combined JS graph and launcher check — not authorized

**Historical proposal:** the heading/plan below retain the original research boundary and link target. Decision 0008 subsequently authorized the unchanged bounded attempt, which stopped on the Multer advisory. Any version/override retry requires its own explicit scope decision; this historical proposal is not permission to bypass that stop.

**Purpose:** establish whether the separately successful Nest/Next and lint samples work in **one fresh JS resolution**, and test an explicit local launcher. A 509-identity set union is not that proof. This would be one bounded experiment, not production adoption or a new application scaffold.

### Exact scope proposed for owner approval

- A **new external temporary root**, preserving all prior roots/snapshots. One root plus three synthetic importers for API, user web and admin; no new shared-package architecture, mobile retry, provider, database, chart or product feature.
- Reuse the existing isolated **Node 24.22.1 / pnpm 12.15.0 Windows** artifacts only after rechecking archive integrity and executable-member bytes. Test explicit paths/version checks and a wrong-hash negative control. No global/Corepack shim, moving installer, fresh SDK/tool download, global PATH change or machine configuration. This is a **local launcher/bootstrap-path check**, not fresh-host, Linux/macOS/CI or offline-bootstrap certification.
- Use the **exact direct versions already executed** in the [original JS probe](toolchain-probe.md) and [lint probe](toolchain-lint-probe.md). Reconcile their manifests explicitly before resolution; no Jest/Vitest/Playwright, alternate lint stack, new direct dependency or silent version substitution. Recheck availability, retraction/deprecation, engines/peers and current advisories before execution; stop on a material new blocker.
- Request **fresh permission to use only these same three experiment-only allowances in the combined root**. Decision 0007's completed experiment does not already authorize this one:

```yaml
peerDependencyRules:
  allowedVersions:
    "eslint-plugin-react@7.37.5>eslint": "10.13.0"
    "eslint-plugin-import@2.32.0>eslint": "10.13.0"
    "eslint-plugin-jsx-a11y@6.10.2>eslint": "10.13.0"
```

- Strict peers remain enabled; automatic peer installation and lifecycle scripts remain disabled. No wildcard bypass, `allowAny`, ignored missing peers, `--force`, dependency override, vendor patch or rule waiver. Scarf and UnRS postinstall stay disabled; do not enable another hook to make a combined install pass.
- Isolate configuration, home/cache/store/state/temp paths and telemetry settings as in the earlier probes; no secrets, inherited alternate native/WASI paths or real data. This remains process-environment isolation, **not an OS sandbox**.
- Proposed stop thresholds: **3 GiB additional temporary footprint** or **20 GiB remaining free space**; start above the free-space threshold. Monitor between phases and during long-running commands, stopping at a threshold rather than silently increasing the budget; this is not a filesystem quota. No cleanup of earlier roots to make space. Commands need timeouts, owned process-tree teardown and loopback-only synthetic servers. No purchase, external application service or deployment.

### Ordered gates and acceptance evidence

| Phase | Proposed work / stop condition |
|---|---|
| 1 — Baseline and launcher | Record HEAD/status, original snapshot/lock hashes, reference/global state and free space. Validate existing Node/pnpm bytes before running them. Reject mismatched launcher identity/version/configuration; do not fetch a replacement tool |
| 2 — One resolution, scripts disabled | Produce a new lock from reconciled exact direct manifests rather than merge old locks. Re-run bounded peer negative controls. Parse both pnpm lock documents; compare package/version identities with both earlier graphs, preserving additions/removals/duplicates and actual importer boundaries |
| 3 — Review before package execution | Review every new resolution identity, notice, script/native/WASM delta and advisory result. Metadata-only changes do not authorize code execution. Stop for new/unreviewed native artifacts or hooks, material provenance/rights concerns, unavailable/retracted inputs, incompatible peers or a needed exception outside the three selectors. Broader changes require another explicit scope decision |
| 4 — Frozen installation and bounded checks | Verify a frozen scripts-disabled install. Run strict API compilation/OpenAPI/exact-string loopback check; each Next app's production build and marker/assets/404 HTTP checks; explicit lint/effective-config/rule checks and strict TypeScript checks in **the same graph**. Retain the 668 focused lint expectations and add full-config clean checks for all authored sample files, adapting sample composition without hiding failing source. Expected-negative fixtures stay distinct from clean application inputs. Next builds do not run lint automatically |
| 5 — Repeat and evidence | Repeat frozen resolution/install without lock changes, recheck applicable artifact/vendor identities, stop all owned servers/processes and confirm ports closed. Record actual results/failures, graph deltas, commands, limits and immutable evidence; never relabel a partial run as success |

No browser/hydration, real sessions, device/encryption, production deployment or complete security/license claim follows. Missing bundle notices remain recorded even if the compatibility experiment passes. No release artifact is approved for distribution by this experiment.

### Separate production decisions after evidence

The original-rule lint path remains a **candidate**, not selected production policy. Any later production exception decision must name exact versions/selectors, retain all effective React/Next/Hooks/accessibility/import checks, assign maintenance ownership and require re-review on every relevant version change or support/security issue. Remove an exception only after an upstream peer declaration accepts the selected version and the effective/behavioral checks pass without it. No automatic carry-forward, broader selector, EOL ESLint 9 fallback or custom replacement-rule suite is approved.

Final pins, notice disposition/delivery, platform-specific verification and ApexCharts rights remain separate decisions. ApexCharts stays held: no install, alternative engine, supplier contact, business disclosure or spend. Applicable M00 work and the **M00-T14 scaffold go/no-go** still precede M01.

## 6. Evidence and checks

External root: `C:/Users/HP/AppData/Local/Temp/your-own-notice-trace-ognynj6x/`. HEAD was `b9cb618ff5d5c324f9c8d78813f59f417ce5d0b5`; the prior notice-review documentation/evidence was already modified/untracked and preserved. The [separate trace snapshot](evidence/m00-t04-notice-trace.json) preserves **95 files / 711,079 bytes**, SHA-256 `b03a66c2bd9f7247c94dffd00e372ebbce3d559749bf520daf0ec3ab4c88d7ba`: selected public responses, failed lookups, source/input links, dispositions, local hashes and helpers. The large Next source lock and unrelated redirected landing-page body remain externally hashed; only their relevant derived records/response identities enter the snapshot. It contains no newly adopted implementation or binaries.

The validator checks fetched/captured byte identities, all 17 dispositions, the twelve registry/source-lock integrity matches, three Edge tag/manifest links, existing issue states/comments, nine font paths/five byte identities, all six unchanged prior snapshots and absence of repository scaffolding. Documentation checks preserve all 224 tasks, 67 requirement IDs and checked state limited to M00-T01/T02/T03. Actual commands passed: `python .../your-own-notice-trace-ognynj6x/validate.py`, the earlier notice `validate.py`, `python .../your-own-toolchain-review-so4nyten/validate_review.py`, and `git -c core.safecrlf=false diff --check`. Documentation validation covered **51 Markdown files / 809 local links and anchors / four JSON examples**, tables/fences/whitespace and milestone prerequisites. Global Node stayed 24.18.0, global Flutter stayed clean at 3.38.9, and reference HEAD/status counts matched the existing baseline. These are static research/documentation checks, not new candidate/runtime tests. **M00-T04 remains In progress and unchecked.**
