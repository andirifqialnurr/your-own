# Toolchain Compatibility — M00-T04 Follow-up

- **Version:** 0.6
- **Observed:** 2026-10-23 UTC, Windows / Git Bash
- **Task:** [M00-T04](../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), In progress / unchecked
- **Authority:** [Decision 0004](decisions/0004-toolchain-directions-and-icon-family.md) accepts directions, not exact pins, downloads/installs or executable integration spikes
- **Related:** [Candidate review](toolchain-review.md), [mobile specification](../MOBILE_TECH_SPEC.md), [web specification](../WEB_PRD.md), [backend specification](../BACKEND_TECH_SPEC.md)

> This document preserves the read-only investigation. [Decision 0005](decisions/0005-isolated-compatibility-probe.md) later authorized the [executed probe](toolchain-probe.md): tools/JS checks passed, while mobile resolution rejected retracted build_runner 2.17.0. The retraction was present in the earlier index but missed by the range-only review; its recommendation is withdrawn below. [Decision 0006](decisions/0006-mobile-probe-generator-retry.md) subsequently authorized the successful 2.16.2 host retry. [Decision 0007](decisions/0007-isolated-lint-probe.md) later authorized the [separate lint experiment](toolchain-lint-probe.md), which passed bounded original-rule checks with three exact temporary peer exceptions. No production exception or final pin is approved.

## 1. Findings and limits

1. **Flutter 3.47.7 / Dart 3.13.5 is now established by published release metadata and pinned upstream source.** The earlier 404s used an obsolete archive path. No SDK archive was downloaded, installed or executed during this read-only phase. The later probe verified/executed the Windows SDK; its first application resolution failed, then the authorized 2.16.2 host retry passed. Native-device compatibility remains unverified.
2. **Withdraw ESLint 9.39.4 as the recommended baseline.** The official support page says ESLint 9 reached end-of-life on 2026-08-06. Matching plugin peer ranges is not sufficient justification for selecting an unsupported toolchain.
3. **The default frontend lint graph still conflicts under unmodified peer declarations.** Three inspected plugins exclude ESLint 10. A later experiment passed with three explicitly authorized exceptions; production exceptions, a replacement linter or paid/EOL support have not been selected.
4. Selected Node/TS/framework and Dart generator ranges were mechanically checked. These checks narrow candidates; they are **not a full package-manager resolution, build, test suite, license clearance or security audit**.
5. ApexCharts remains on hold. This follow-up did not contact the supplier, change the chart requirement or establish entitlement.

## 2. Flutter/Dart identity and archive-path correction

The [official archive page](https://docs.flutter.dev/install/archive) loads a deferred client module. Static inspection of [that module](https://docs.flutter.dev/main.client.dart.js_3.part.js) exposed its current release-list URL:

- Current: `https://storage.googleapis.com/flutter_infra_release/releases/releases_<os>.json`
- Previously attempted: `https://storage.googleapis.com/flutter_infra_release/flutter/releases/releases_<os>.json`

Following the page's actual URL, rather than guessing another SDK version, succeeded for [Windows](https://storage.googleapis.com/flutter_infra_release/releases/releases_windows.json), [macOS](https://storage.googleapis.com/flutter_infra_release/releases/releases_macos.json) and [Linux](https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json). Each identifies stable **3.47.7**, bundled Dart **3.13.5**, and framework commit `abaf9c523780a608bd46686fd5e53740a07077f8`.

Independent source cross-check:

1. `git ls-remote https://github.com/flutter/flutter.git refs/heads/stable refs/tags/3.47.7` returned that same framework commit for both refs at inspection time.
2. Its [pinned engine.version](https://github.com/flutter/flutter/blob/abaf9c523780a608bd46686fd5e53740a07077f8/bin/internal/engine.version) identifies engine `deb287481e3ce9468f3434937ced4240a70539ca`.
3. The [engine's root DEPS](https://github.com/flutter/flutter/blob/deb287481e3ce9468f3434937ced4240a70539ca/DEPS) selects Dart revision `04bcd1036cdc799ac6564988f159ee454d42c822`; the framework commit's root DEPS agrees. The earlier nested `engine/src/flutter/DEPS` guess was not the correct source path.
4. Dart's [VERSION at that revision](https://github.com/dart-lang/sdk/blob/04bcd1036cdc799ac6564988f159ee454d42c822/tools/VERSION) specifies stable, major 3, minor 13, patch 5.

### Published artifact identities — not downloaded-byte verification

Paths are relative to `https://storage.googleapis.com/flutter_infra_release/releases/`. These hashes were **read from release metadata**, not computed over installed/downloaded SDK archives. macOS/Linux entries establish published availability, not host/device validation or an approved CI platform.

| Platform / architecture | Published archive path | Published SHA-256 |
|---|---|---|
| Windows x64 | `stable/windows/flutter_windows_3.47.7-stable.zip` | `c2c875da25a1a1448d18ee4e8f398b2f6fce888b4775d8f9130538e16d826cb4` |
| macOS x64 | `stable/macos/flutter_macos_3.47.7-stable.zip` | `17d39b000a5d0681e3f7b61a105a36f6f31dd41ab9073f625fd466f38035f901` |
| macOS arm64 | `stable/macos/flutter_macos_arm64_3.47.7-stable.zip` | `dd9da574c3168460550117eb0e8dd0313ae934fabf64a82a6d557fff5fd1422e` |
| Linux x64 | `stable/linux/flutter_linux_3.47.7-stable.tar.xz` | `af7455f540df951184c7953fbe3cf884766e7541dacf8571f9f582db03dd6230` |

The existing global Flutter checkout remains clean at **3.38.9**, with previously observed cached Dart 3.10.8. No global SDK was upgraded. Before using a new SDK, separately authorize its isolated download, verify actual bytes/provenance, run its version command and test the selected dependency/native paths. Do not independently replace Flutter's bundled Dart with another SDK.

## 3. Declared-range checks, not a resolved graph

A temporary local checker used the already installed Node **24.18.0** and npm's existing **semver 7.8.1** module. It read saved registry/release JSON; it did not install or execute candidate framework/library code. Node **24.22.1** was an input version string, **not the runtime executing the check**.

The sample contained **29 npm package records and 13 pub package records**. Only constraints between included records were checked; absent/transitive dependencies, optional peer combinations, build scripts, SDK-pinned package interactions and platform binaries were not resolved. Stable Dart range strings were compared as supported numeric ranges, not through a substitute implementation of Pub's solver.

| Assertion category | Count | Observed result |
|---|---:|---|
| npm Node engines | 18 | Candidate Node 24.22.1 satisfies the inspected declarations |
| npm selected peer edges | 26 | 23 match; three expected ESLint 10 rejections below |
| npm selected tool dependencies | 2 | Nest CLI's TypeScript range accepts 6.0.3; Next's sharp range accepts 0.35.5 |
| Rejected latest TypeScript | 3 | 7.0.2 falls outside Swagger 12.0.3, typescript-eslint 8.72.0 and ts-jest 29.4.15 declarations |
| Dart SDK ranges | 13 | Candidate Dart 3.13.5 satisfies the inspected declarations |
| Flutter SDK ranges | 4 | Candidate Flutter 3.47.7 satisfies the inspected declarations |
| Selected pub dependency edges | 16 | Inspected candidate versions fit these declarations |
| Rejected installed SDK examples | 2 | Installed Dart 3.10.8 does not satisfy Riverpod 3.4.3; Flutter 3.38.9 does not satisfy go_router 18.1.1 |
| Targeted advisory ranges | 4 | Next 16.4.2 does not match the four affected-version ranges returned by three reviewed advisories |

**Total: 88 assertions — 76 accepted ranges and 12 expected non-matches.** Expected non-matches include known incompatibilities and advisory exclusions; they are not 12 failing application tests. A separate intersection check confirms that build_runner 2.17.1's `build >=5.0.0 <5.1.0` cannot intersect drift_dev 2.35.1's `build >=3.0.0 <5.0.0`.

### Dart generator candidate chain

**Correction: withdraw build_runner 2.17.0.** Its ranges overlap those inspected alongside Drift 2.35.2 / drift_dev 2.35.1 and json_serializable 6.15.2, but the later probe found it retracted. The 88 checks did not filter retractions, despite that flag being present in the saved index. See the [initial failure](toolchain-probe.md#5-mobile-blocker-and-correction-to-earlier-research) and later [authorized 2.16.2 retry](toolchain-probe.md#7-authorized-mobile-retry--build_runner-2162); the latter passed limited host checks without overriding retractions. Additional records inspected during the original range review:

| Package | Version | Relevant declaration |
|---|---|---|
| [build](https://pub.dev/api/packages/build/versions/4.1.0) | 4.1.0 | Dart `^3.11.0`; analyzer `>=13.3.0 <15.0.0` |
| [analyzer](https://pub.dev/api/packages/analyzer/versions/14.3.0) | 14.3.0 | Dart `^3.11.0` |
| [source_gen](https://pub.dev/api/packages/source_gen/versions/4.3.1) | 4.3.1 | Dart `^3.11.0`; analyzer `>=14.0.0 <15.0.0`; build `>=3.0.2 <6.0.0` |
| [json_annotation](https://pub.dev/api/packages/json_annotation/versions/4.12.0) | 4.12.0 | Dart `^3.9.0` |

This shows feasible inspected intersections, not a complete solution. Do not add overrides to force these transitives or treat them as final direct dependencies. The first `pub get` attempt failed on the retraction; the separately approved 2.16.2 retry resolved and generated/compiled the synthetic sample. Migration/persistence tests remain unrun. Encrypted SQLite and its connection helper remain M00-T08 decisions.

## 4. Support and security findings

### Frontend lint baseline remains unresolved

The [official ESLint support policy](https://eslint.org/version-support/) identifies ESLint 9 as EOL from **2026-08-06**, including the previously considered 9.39.4. Withdraw that recommendation; the owner's direction approval did not approve an EOL exception or a paid support contract.

ESLint **10.13.0** is a current-line candidate. However, the inspected dependency chain reached through eslint-config-next **16.4.2** includes:

| Plugin | Inspected version | Declared ESLint support relevant here |
|---|---|---|
| [eslint-plugin-react](https://registry.npmjs.org/eslint-plugin-react/7.37.5) | 7.37.5 | Stops at `^9.7`; excludes 10 |
| [eslint-plugin-import](https://registry.npmjs.org/eslint-plugin-import/2.32.0) | 2.32.0 | Stops at `^9`; excludes 10 |
| [eslint-plugin-jsx-a11y](https://registry.npmjs.org/eslint-plugin-jsx-a11y/6.10.2) | 6.10.2 | Stops at `^9`; excludes 10 |

`eslint-config-next` itself accepting `>=9` does not remove its plugins' narrower ranges. React Hooks 7.1.1 and typescript-eslint 8.72.0 accepting 10 likewise do not certify the whole chain.

The subsequent [static lint review](toolchain-lint-review.md) adds an important qualification: Next now documents ESLint 10 runtime support and the exact 16.4.2 archive wraps legacy React/import rule contexts, while its documentation also acknowledges strict-peer installation failures. The blocker here is the declared graph under the retained strict-peer policy, not a demonstrated runtime crash. Import/accessibility replacements look plausible; React coverage gaps prevent selecting a complete replacement baseline. No candidate lint configuration was installed or executed during that static pass. The later [17-entry rule disposition](toolchain-lint-review.md#8-completed-static-disposition-and-owner-choice) proposed a controlled original-config test. [Decision 0007](decisions/0007-isolated-lint-probe.md) subsequently authorized its three exact temporary peer exceptions. The [execution report](toolchain-lint-probe.md) records 668 focused diagnostic checks and clean lint/type checks for both apps; this is bounded exception-based compatibility evidence, not a production bypass or complete verification.

Next action: finish notice/support/bootstrap review and present explicit final-pin/production peer-policy choices informed by the experiment. Do not silently broaden its exceptions, drop accessibility rules, select a substitute prerelease, replace the linter or accept EOL software to make an install pass. No production frontend lint configuration is approved or implemented yet. Backend and frontend may have separate configurations, but a backend lint pass cannot certify either Next.js app.

### Targeted Next.js checks

The [official support policy](https://nextjs.org/support-policy) lists Next 16 as Active LTS at inspection time. Three critical advisories linked from the project's security page were inspected:

| Advisory | Relevant condition / patched version | Candidate disposition |
|---|---|---|
| [GHSA-2464-fhr4-w9xw](https://github.com/advisories/GHSA-2464-fhr4-w9xw) | Image optimization/upstream native issue; affected Next 16 through 16.4.0, patched 16.4.1; guidance also requires resolved sharp ≥0.35.5 | Next 16.4.2 is outside the returned affected ranges; actual sharp/binary graph still needs inspection |
| [GHSA-673q-mjm6-r5xr](https://github.com/advisories/GHSA-673q-mjm6-r5xr) | App Router Cache Components returning multiple typed arrays; affected Next 16 through 16.4.0, patched 16.4.1 | 16.4.2 outside the returned range; no cache/privacy integration proven |
| [GHSA-vcvr-r3jv-pc5j](https://github.com/advisories/GHSA-vcvr-r3jv-pc5j) | Node `next/og` ImageResponse with attacker-controlled SVG values; affected `>=16.2.0 <16.3.6` | 16.4.2 outside the returned range; poster stack not selected by this check |

This is a **targeted sample**, not an exhaustive vulnerability scan or a safety certification of Next, React, sharp, Satori, pnpm or any transitive binary. Recheck exact resolved graphs and upstream notices before installation/use and releases. No application currently exists here to patch. The proposed Satori/backend poster path must have its own advisory/license review; passing a Next version range does not clear another renderer.

## 5. Bootstrap observations

The following observations precede execution. The [probe report](toolchain-probe.md#2-tool-identity-and-isolation) supersedes their not-downloaded/not-executed status for the isolated Windows tools only; it does not approve production bootstrap or global changes.

- Node 24.22.1 remains the candidate security-patch update, not an installed version. Its [published SHA-256 list](https://nodejs.org/dist/v24.22.1/SHASUMS256.txt) gives `d2046d28c2c3dcd211ac5145c0bf30e2047ef9dfb306693c8c6e2eccd8b95fa5` for `node-v24.22.1-win-x64.zip`. No archive/signature was downloaded or verified.
- pnpm 12.15.0's registry metadata declares preinstall/postinstall scripts and platform-specific native optional dependencies. The [Windows x64 package metadata](https://registry.npmjs.org/@pnpm%2Fexe.win32-x64/12.15.0) identifies a native executable; it was **not downloaded or run**.
- The [version-tagged pnpm install script](https://github.com/pnpm/pnpm/blob/v12.15.0/pnpm/npm/pnpm/install.js) was read only. It replaces launcher files, rewrites package bin mappings and can regenerate npm Windows shims. Do not invoke the existing Corepack/global launcher or run a global installer as an incidental experiment.
- For an authorized Windows probe, prefer isolated verified portable tools invoked through explicit paths, with temporary package stores/config/home locations. Review the native executable's provenance/notices and bootstrap behavior first. This is a proposed probe method, not a selected production/CI bootstrap or authorization to download binaries.

## 6. Chart-free compatibility probe — authorized scope

Further metadata checks cannot prove runtime claims. The **disposable, synthetic, chart-free M00-T04 probe** below was subsequently authorized in Decision 0005, not as M01 scaffolding. [Execution results](toolchain-probe.md) distinguish the passing checks from the mobile blocker and untested scope.

### Scope requested

1. Create an isolated temporary workspace outside this repository and the reference apps. Download/verify Windows Flutter 3.47.7 with bundled Dart 3.13.5, portable Node 24.22.1 and pnpm 12.15.0 from reviewed official distribution sources. Downloads may consume several GB including caches; stop on digest/provenance discrepancies.
2. Use process-local paths and isolated cache/config/home directories; do not alter global PATH, SDKs, Corepack, npm/Pub stores, OS settings or reference repositories. Disable unneeded telemetry in that isolated environment. No Android SDK/Xcode/emulator installation or cloud provisioning.
3. Resolve only the reviewed sample package directions, with lifecycle scripts initially disabled where supported. Record the actual graph, install scripts, notices and targeted advisories; stop for review of unexpected licenses, native downloads, script requirements or incompatible constraints. No bulk script approval or dependency overrides.
4. Create minimal disposable probes: a Flutter host widget/serialization/Drift-generation test with synthetic data; Nest TypeScript/decorator/OpenAPI build/test using a candidate adapter; and a minimal Next production build/local render with the selected React/form/query/icon directions. The Express adapter and test tooling are evaluated candidates, not approved backend selections. Test separate web/admin composition without real sessions or credentials.
5. Bind any test server to loopback only, use synthetic fixtures, stop processes afterward, and record outputs/limitations. No public deployment, service accounts, personal database, user uploads or production-like secret store. No automatic copying of probe source/lockfiles into the application.

**Excluded:** ApexCharts and other chart engines, paid features/accounts, supplier outreach, native-device or encrypted-storage claims, providers/ORM/queues, production migrations, real authentication/CSRF/staff assurance, release certification and changes to the roadmap. The unresolved frontend lint graph must be reported as blocked, not bypassed or counted as a passing foundation gate. An approved probe may test runtime candidates without claiming that missing lint coverage is resolved.

**Exit evidence:** actual tool versions/digests, exact temporary manifests/lockfiles and notices, commands/results for resolution/generation/build/tests, failures and teardown, remaining native/browser/security/licensing gaps, and a recommendation for separately approved final pins. macOS/iOS evidence remains M00-T05/T08/T09 work. M00-T04 stays unchecked while ApexCharts entitlement/integration and other required evidence are missing.

The earlier instruction to continue read-only investigation did not authorize this probe. The later response **"continue"**, directly answering the explicit download/build/test authorization question, did authorize the bounded attempt recorded in Decision 0005. It did not approve production pins, changed candidate versions or M01 scaffolding.

## 7. Evidence and next action

Temporary research: `C:/Users/HP/AppData/Local/Temp/your-own-toolchain-followup-zfc00p6m/`. Public GET requests fetched JSON, documentation and source **text only**. No SDK/package archive or executable binary was downloaded in this follow-up. No project/private data or credentials were uploaded.

Commands actually run include the `git ls-remote` above, Python standard-library fetch/inspection helpers, `node .../check_constraints.cjs`, and read-only Git inspection of the installed Flutter checkout. The checker produced `constraint-results.json`; SHA-256 of the inspected report is `3e2af66d584c26d0050a059723e28d9cd9efee3df67dd4085c658468211789b1`. It records the selected versions, all 88 range outcomes, explicit generator conflict and published artifact identities. Re-running it changes its observation timestamp/report hash, not the intended assertion meanings.

Selected raw-response SHA-256 identities:

| Source | SHA-256 |
|---|---|
| Windows release JSON | `1cee9c197cf13613fedd0d2a6698f080a99e07847819df1fbe5dff05e2a76cf3` |
| macOS release JSON | `be26ba7041e985325ac4dad55f795bbf51fb636da23e1ae41876223ebd51fc84` |
| Linux release JSON | `977fb09b01091b2e10cd8a82c2bc7107740959ee49949a6fd52f7bf4465fac73` |
| Pinned Flutter/engine root DEPS (identical inspected responses) | `3fca94f21ddd9d0293389a5e24acea81c042225b102e315c1926e0524cf9ce0e` |
| Pinned Dart VERSION | `5f3f923f07f287ea465d304cecb19b597e613e46c440cb4443ccc483a03f5175` |
| ESLint support page | `99eb43663ab2dcc368b36f980b73bbee0528c578ddccd43a9a96ff2ba4853450` |

Fetch manifests (`manifest.json`, `followup-manifest.json`, `detail-manifest.json`, `release-manifest.json`) preserve URLs and success/404 outcomes. The earlier candidate research and its five static icon/chart archives remain historical evidence, not new installs. Temporary files are not durable release evidence; retain approved graphs/notices and executed test evidence in the project before adoption.

**Next:** follow the [probe outcome](toolchain-probe.md), including the separately authorized successful mobile retry; incorporate the separately authorized lint results into remaining production-policy/notice/final-pin review and leave ApexCharts held for entitlement or an explicit owner change. No exact-pin approval, milestone completion or scheduling deferral is inferred.
