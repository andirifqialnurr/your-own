# Toolchain Probe — M00-T04 Execution Evidence

- **Version:** 0.4
- **Observed:** 2026-10-23 UTC, Windows x64 / Git Bash
- **Task:** [M00-T04](../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), In progress / unchecked
- **Authorization:** [Decision 0005](decisions/0005-isolated-compatibility-probe.md) and [Decision 0006](decisions/0006-mobile-probe-generator-retry.md); temporary chart-free experiments only
- **Related:** [Candidate review](toolchain-review.md), [metadata follow-up](toolchain-compatibility.md), [durable evidence snapshot](evidence/m00-t04-probe.json)
- **Later follow-up:** [Decision 0007](decisions/0007-isolated-lint-probe.md) authorized a separate three-exception lint experiment on 2026-10-24 UTC; its [bounded passing results](toolchain-lint-probe.md) do not change this earlier probe or approve production exceptions/pins. The later [Decision 0008 combined attempt](toolchain-combined-probe.md) stopped on a fresh high-severity Multer advisory affecting the existing Nest Express graph. Earlier build/audit observations remain historical, not current security clearance

## 1. Outcome

| Lane | Actual result | Limit |
|---|---|---|
| Portable tooling | Downloaded, checked and executed Node **24.22.1**, pnpm **12.15.0**, Flutter **3.47.7 / Dart 3.13.5** | Isolated experimental versions, not approved project pins or global upgrades |
| JS workspace | Lockfile-only resolution and frozen installation passed with strict peers and lifecycle scripts disabled; **239 installed external package/version identities** | Includes only the synthetic sample; no approved production dependency graph |
| NestJS | Nest CLI build with TypeScript 6.0.3 passed; decorator/OpenAPI and loopback HTTP assertions passed | One explicit DTO/string fixture; not generated-client, auth, concurrency or complete domain-contract proof |
| Next user/admin | Both production builds passed after the configuration/fixture corrections below; separate loopback HTML, CSS/JS and 404 checks passed | No browser engine, hydration, interaction, session isolation, accessibility or performance certification |
| Mobile sample | Initial 2.17.0 attempt failed on retraction; authorized **2.16.2 retry passed resolution, generation, analysis and six host tests** | See section 7; no native-device, persistence/encryption or product-readiness result |
| Frontend lint | **Blocked in this earlier probe**; later evidence is linked above | No EOL ESLint, peer override or skipped lint counted as a pass in this probe |
| ApexCharts | **Held; excluded from installation and execution** | No entitlement determination, supplier outreach, alternate chart engine or purchase |

The repository itself remains documentation-only. All executable probe files, dependencies, SDKs and build outputs are outside it at `C:/Users/HP/AppData/Local/Temp/yop-f3trxjn8/`. The JSON snapshot is **evidence**, not an application scaffold, adopted lockfile or install entry point. No M00 checkbox changed.

## 2. Tool identity and isolation

| Download | Actual byte count | Computed SHA-256 |
|---|---:|---|
| Windows Flutter 3.47.7 ZIP | 1,934,624,561 | `c2c875da25a1a1448d18ee4e8f398b2f6fce888b4775d8f9130538e16d826cb4` |
| Windows Node 24.22.1 ZIP | 37,748,064 | `d2046d28c2c3dcd211ac5145c0bf30e2047ef9dfb306693c8c6e2eccd8b95fa5` |
| `@pnpm/exe.win32-x64` 12.15.0 TGZ | 23,797,937 | `330357f1c8227b90fb016d28713b024318c60ef06ef97aa38e81394823c47556` |

Flutter/Node matched the official published SHA-256 values; pnpm matched registry SHA-512 integrity. Its registry signature also verified against the HTTPS-fetched npm key `SHA256:DhQ8wR5APBvFHLF/+Tc+AYvPOdTpcIDqOhxsBHRwC7U`. This is not independent Node/Flutter publisher-signature or pnpm SLSA attestation verification. Archive paths were checked before extraction.

Flutter's initial download reached the 900-second command limit. A bounded HTTP Range resume continued from byte **911,212,544**, then hashed the complete archive before extraction. No partially downloaded SDK was executed. The extracted SDK's version command confirmed framework `abaf9c523780a608bd46686fd5e53740a07077f8`, engine `deb287481e3ce9468f3434937ced4240a70539ca` and Dart 3.13.5. First invocation built Flutter's tool and resolved its own tool dependencies inside the isolated SDK/Pub cache; that bootstrap is distinct from the failed application resolution.

The runner used explicit executable paths and a restricted child environment with temporary HOME/USERPROFILE/APPDATA/LOCALAPPDATA, npm/Pub/pnpm/Corepack stores, XDG paths, Git configuration and temp directories. Telemetry opt-outs were set. pnpm's config output and install log identify the temporary cache/state/store paths. This is process-level isolation, not an OS security sandbox or comprehensive filesystem/network tracing.

At close, the ordinary Node command still reported **24.18.0**, and the existing global Flutter checkout remained clean at **3.38.9**. Reference HEADs/status counts matched the audit baseline (finance 0, water 0, coffee 37, book 1); no commands wrote to those repositories. Free space was approximately 35.75 GiB initially and 28.31 GiB at the final check; that volume difference is not an exact probe-allocation measurement. Temporary evidence/tools are retained, not automatically deleted.

## 3. JS graph and package-manager findings

Direct sample versions remain those in the candidate review. Additional inspected helpers were `@types/node 24.19.2`, `@types/react 19.3.0`, `@types/react-dom 19.3.0`, `@tailwindcss/postcss 4.3.3`, `reflect-metadata 0.2.2` and `rxjs 7.8.2`. The Express adapter resolved Express **5.3.0**; this does not approve it over other backend adapters. The exact manifests and full sample lockfile text are retained in the evidence snapshot.

Commands used the isolated pnpm binary, explicit `--state-dir <probe>/cache/pnpm/state`, and the temporary workspace:

- `install --lockfile-only --ignore-scripts`: passed after correcting unsupported configuration.
- `install --frozen-lockfile --ignore-scripts`: passed; 239 installed identities.
- `audit --json`: returned **zero known advisories in every severity category** for the submitted graph at that time. The service reported 308 total dependency entries, which is not the installed Windows package count. This is a registry advisory result, not a security guarantee or complete binary audit.

Important pnpm 12 findings:

- `managePackageManagerVersions` and `packageManagerStrictVersion` were rejected as unknown workspace settings; they were removed, not silently ignored.
- `stateDir` is not accepted in `pnpm-workspace.yaml`; the explicit CLI option was accepted and confirmed in config output. No global config command was used.
- The generated `pnpm-lock.yaml` contains **two YAML documents**, including package-manager bootstrap dependencies. A first ad-hoc single-section counter was unsuitable. The subsequent `js-yaml.loadAll` check counted 15 package/snapshot entries in the manager document and 293 in the application document, with four application importers. Snapshot and parse the whole file; do not confuse these entries with the 239 installed Windows identities.
- `strictPeerDependencies: true`, `autoInstallPeers: false`, `ignoreScripts: true` and `verifyStoreIntegrity: true` were confirmed. No overrides or blanket build-script approval were added.
- `@scarf/scarf 1.4.0`, reached through Swagger UI, declares `postinstall: node ./report.js`; it remained disabled. No dependency rebuild or analytics script was run.

Sample lockfile SHA-256: `c92f8b09ced05779d00350a442388564447fb93b7547eb3ee744438a540790a1`. This is **not** the project's production lockfile.

### Notices and native binaries

An exact installed-manifest/root-notice inventory covers 239 external identities, excluding nested subpath manifests. Not every embedded notice was cleared. Besides MIT/ISC/BSD/Apache declarations, the graph includes Lightning CSS **MPL-2.0**, minimatch **BlueOak-1.0.0**, caniuse-lite **CC-BY-4.0** and argparse **PSF-2.0**.

The Windows sharp **0.35.5** binary package declares **Apache-2.0 AND LGPL-3.0-or-later**. Its Apache root LICENSE alone does not cover the bundled DLLs. Its README lists LGPL, MPL, font/patent and other embedded-library notices, including use of LGPLv3 via earlier licenses' “any later version” clause. This was reviewed before the Next builds; LGPL/GPL non-conveyed/unmodified execution permissions and MPL grants support only this local, non-distributed experiment. The [SPDX LGPL text](https://github.com/spdx/license-list-data/blob/main/text/LGPL-3.0-or-later.txt) was read after the GNU site connection failed. **No distribution/source-offer/linking/patent clearance is claimed.** Preserve and complete those obligations before adoption or delivery. No image-optimization or poster-renderer test was performed.

Some packages lack a standalone root notice in the installed artifact, including `@next/env`, `@next/swc-win32-x64-msvc`, `@tokenizer/token` and `client-only`; upstream/bundled notice mapping remains required. Package metadata is not a substitute notice. Existing Hugeicons notices remain in the temporary packages; generated poster/export compliance and complete icon coverage are still unverified.

## 4. Executed application checks and corrections

### NestJS

From `<probe>/workspace/api`, explicit portable Node commands ran:

1. `node node_modules/@nestjs/cli/bin/nest.js build` — exit 0, strict TypeScript, `skipLibCheck: false`, decorator metadata enabled.
2. `node dist/main.js` — exit 0. An explicitly decorated synthetic DTO produced an OpenAPI `string` property; a `GET /probe` bound to `127.0.0.1` returned the exact string `9007199254740993` with HTTP 200. The app closed in `finally`.

This exercises Nest 12.2.0 / Swagger 12.0.3 / CLI 12.0.10 / TS 6.0.3 together. It does not exercise the Swagger compiler plugin, Jest/ts-jest, DTO validation libraries, generated Dart clients or database/storage contracts. Node assertions were used, not a selected production test-runner stack.

### Separate Next compositions

Each application had its own manifest/config/build directory. App Router server composition rendered a client component with scoped QueryClient state, RHF/Zod, Tailwind/PostCSS and a local Hugeicons Home01 SVG. No provider, chart, credentials or remote font/icon service was added.

`node node_modules/next/dist/bin/next build` initially compiled the bundles but failed strict dependency type checking: Next declarations referenced `PromiseWithResolvers`, absent from the probe's ES2023 library list. The temporary configurations were corrected to include **ES2024 type libraries**, keeping strict checks and `skipLibCheck: false`; no compiler version, dependency override or type-check bypass changed. This does not supply a runtime polyfill or approve a browser baseline. Next added incremental checking; its suggested `allowJs` was explicitly set false.

Both production builds then passed. Initial HTTP assertions exposed another fixture issue: RHF's `defaultValues` alone did not place the expected uncontrolled input value in server HTML. Both fixtures now share one defaults object between RHF and the input's explicit `defaultValue`; builds and the original value assertions passed afterward. This is not browser hydration verification. Initial failures are preserved alongside successful results, not overwritten as passes.

Final `next start --hostname 127.0.0.1 --port <temporary-port>` checks passed for both applications:

- HTTP 200 and the correct application marker, without the other application's marker.
- Server-rendered synthetic form/query text and rounded SVG attributes with a decorative semantic wrapper.
- All **eight** referenced CSS/JS assets per response returned 200; generated CSS contained the Tailwind utility under test.
- A missing synthetic route returned 404.

These are **HTTP/markup checks**, not browser execution, pixel parity, complete accessibility or real session isolation. No form submission, hydration, keyboard/touch, resizing, cache privacy, strict-mode cleanup or native chart claim follows. All owned server process trees were terminated afterward and the ports were confirmed closed; Windows forced teardown exit 1 is recorded separately from successful build/test assertions. No probe Node/Dart/Python/pnpm process remained at the final inspection.

## 5. Mobile blocker and correction to earlier research

`flutter pub get` for the exact proposed mobile sample exited 1:

> Because isolated_probe depends on build_runner 2.17.0 which doesn't match any versions, version solving failed.

Fresh [exact metadata](https://pub.dev/api/packages/build_runner/versions/2.17.0) and the package index report **`retracted: true`**. Retrospective inspection found that flag **already present in the earlier saved index**. The metadata-only range checker did not filter retracted versions; its arithmetic checks were not evidence of package availability. **Withdraw build_runner 2.17.0 as a candidate.** Do not describe this as a newly occurring upstream change or bypass the retraction.

No version was changed to make the solver pass. The previously identified build_runner 2.17.1 / Drift generator `build` conflict remains. The resolver suggested **2.16.2**; follow-up metadata inspection, not installation, found:

- Dart `^3.11.0`.
- `build ^4.0.9`.
- `analyzer >=14.3.0 <15.0.0`.
- No retraction flag in the inspected exact record; published 2026-10-07.

Those ranges overlap the previously inspected build 4.1.0 / analyzer 14.3.0 candidates. **At this initial stop, 2.16.2 was only a proposed revised experiment candidate**; Decision 0006 subsequently authorized the retry reported in section 7. Full Pub resolution, helper/native-hook/license review and generated compilation are still necessary. That separate approval did not select final production pins. Do not add `dependency_overrides` or silently select an encrypted SQLite helper.

At the initial stop, the SDK version command passed, but **no mobile application lockfile or generation/widget/native test result existed**. Section 7 records the later host evidence without claiming native-device coverage. No Android SDK, Xcode, emulator, database, encryption driver or key-management solution was installed or selected.

## 6. Evidence and remaining work

The [JSON snapshot](evidence/m00-t04-probe.json) retains exact temporary manifests/configs, authored probe source and runner/check helpers, the full JS lockfile, command records/logs, tool-download/signature records, installed-package notice inventory and selected metadata. Paths are normalized to `$PROBE_ROOT`; per-file hashes identify original bytes before normalization. No credentials, personal data, vendor binaries or reference-app source are included. These are **disposable evidence files**, not production implementation or adopted dependency pins. Original tool/package archives and full notices remain in temporary storage; no standalone package redistribution is made by this snapshot.

The snapshot contains 120 captured files (571,969 bytes), SHA-256 `c3d34b4aaf5a322d272ed5a13a8240b5c26da8738c3c522b93dfdd77159f2c0f`.

Additional preserved identities:

| Artifact | SHA-256 |
|---|---|
| Failed mobile sample manifest | `d439d9fdbd2d8009eba91e54d2927f160b5db9f4bca73ae58b56f6298d742c78` |
| Isolated Flutter tool's bootstrap lockfile | `6a98afb61c0cc72f31631ab444932f072fd275aa04d56cde2bf6831ba02fc8f8` |
| Fresh retracted-version response | `74bb5fca7e763aa1f5eb03e7cd6ff8eee921aeea45fdf27536659ca00ed27824` |
| Proposed build_runner 2.16.2 response | `0acbbffee67bc8bbbb1670bdba2523aca3ca0cec9667b5fd4ef1d13b567468f3` |

Bounded tooling errors were corrected or recorded: the large download timeout/resume; an unacceptable registry content-negotiation header and metadata command timeout; a Windows console encoding error while printing an already-saved pnpm failure log; pnpm 12 settings rejection; initial Next library-type and form-fixture assertions; and the blocked Pub solver. None is hidden by marking M00-T04 Verified.

The initial retry approval request was answered in Decision 0006; its results follow. **Next remains M00-T04:** incorporate the later lint evidence into production-policy and remaining distribution-notice/compatibility review, with ApexCharts entitlement held. Final pins, full native/browser proof, later M00 contracts and M00-T14 scaffold approval remain outstanding. No M00-T05/M01 advancement, deployment, supplier contact or spend occurred.

## 7. Authorized mobile retry — build_runner 2.16.2

The owner replied **"okay continue"** after the explicit retry proposal and clarification that actual app development had not begun. Decision 0006 authorizes only this revised temporary experiment. The original failed manifest, command logs and 120-file evidence snapshot are unchanged.

### Scope and resolved graph

A new sample at `<probe>/workspace/mobile-retry-2162/` changed only the proposed direct generator version to **2.16.2**, reusing the isolated Flutter/Dart SDK and caches. Fresh exact metadata confirmed all nine hosted direct candidates available/not retracted before resolution. `flutter pub get` succeeded with **100 dependencies: 95 hosted and five SDK packages**, excluding the synthetic sample itself. Actual selected generator-chain versions include:

| Package | Resolved version |
|---|---|
| build_runner / build | 2.16.2 / 4.0.11 |
| analyzer / source_gen | 14.6.0 / 4.3.1 |
| drift / drift_dev | 2.35.2 / 2.35.1 |
| json_serializable / json_annotation | 6.15.2 / 4.12.0 |
| sqlite3 / flutter_svg | 3.8.0 / 2.3.0 |

Riverpod 3.4.3, go_router 18.1.1, Dio 5.11.1 and Hugeicons 1.2.0 remained unchanged. Pub selected transitives rather than forcing the earlier static example versions; no dependency override, retracted package exception or encrypted connection helper was used. An inspection of all 95 resolved hosted entries found no retracted versions, and Pub cache archive-hash records matched saved metadata. Those cache records are not an independent re-download or publisher attestation of every package. The application lockfile SHA-256 is `3a0c14b62eda6aa1f6eb7354495661ea4ebef779797b9968f9bc85c6babf8a35`.

### Native hook and notices

Before generation/tests, inspection found one package hook: sqlite3 3.8.0's `hook/build.dart`. The default path selects **plaintext SQLite**, downloads a platform binary from the supplier's tagged GitHub release, and verifies its bundled SHA-256 before reuse. The source-selection/downloader/hash paths, MIT binding notice, SQLite's public-domain statement and GitHub release metadata were reviewed. No SQLCipher/multiple-ciphers/system-library override was selected.

The **1,729,024-byte** `sqlite3.x64.windows.dll` was independently downloaded into temporary storage and matched both the package hash and upstream release digest: `3a29878d0936510af0f563dfc7668c561c92f7ebe1d9fef95975f721dc01b590`. The subsequent hook output and copied test-build DLL matched that digest too. This permits only the reviewed synthetic host experiment; it is not independent build provenance, exhaustive binary/legal/security clearance or selection of the application's persistence driver. Tests did **not** open a database, load real data, or demonstrate SQLite operations/encryption.

Root notices were inventoried for all 95 hosted packages; text markers were 75 BSD, 16 MIT and four Apache. These are an inventory, not complete embedded-notice/legal clearance. SDK packages without individual root notices retain the SDK notice mapping. Selected generator/icon/SQLite/SDK notice text is retained with the retry evidence. Hugeicons imports Flutter primitives, but the test's app-owned artwork uses only the selected Stroke Rounded icon.

### Commands and results

Commands used explicit isolated executables and the restricted environment, not global Flutter/Dart:

| Command / check | Result |
|---|---|
| `flutter --version --machine` | Confirmed 3.47.7 / bundled Dart 3.13.5 again |
| `flutter pub get` | Passed, resolved sample lockfile created |
| `dart run build_runner build` | Passed; serialization and Drift generation completed |
| `flutter analyze --no-pub` | Final run passed, no issues |
| `flutter test --no-pub --reporter expanded` | Final run passed, **six tests** |
| `flutter pub get --offline --enforce-lockfile` | Passed; lockfile bytes unchanged |
| Repeated `dart run build_runner build` | Passed; both generated `.g.dart` files byte-identical |
| `dart format --output=none --set-exit-if-changed lib test` | Passed, zero changes |

Six tests cover: exact synthetic decimal-string/null DTO round-trip; rejecting a number for the checked string field; generated Drift row/insert-companion types without opening a database; Dio interception without sending a network request; independent Riverpod containers; and a host widget journey combining go_router, the selected icon, counter-state retention across widths **390/700/1000/1300**, Light/Dark and **200% text**, followed by route navigation/return. This is not the product's complete adaptive/accessibility or API contract suite, nor an eight-device test matrix.

Two initial failures were retained and corrected rather than hidden:

- The broad Drift test import collided with the matcher named `isNull`; narrowing it to `show Variable` fixed the source error without suppressing analysis.
- Flutter host testing required `%PROGRAMFILES(X86)%`, removed by the original restrictive runner. A retry-specific wrapper passes only standard Windows Program Files discovery paths in addition to the existing allowlist. Home/cache/config isolation remains; no Visual Studio/Android SDK or OS setting was installed/changed.

Flutter also added `build/**` to analysis exclusions during the frozen Pub step; strict casts/inference/raw-types remain enabled and authored/generated source is not excluded. Final analysis and all six tests were rerun after that change. Generated files were produced by the generator, never manually patched. Repeated incremental output equality is not a clean-machine reproducibility guarantee.

### Evidence and remaining gates

[Retry evidence snapshot](evidence/m00-t04-mobile-retry.json): **65 captured files**, 229,093 bytes, SHA-256 `77d18a89cb2f383986900a2a6d439a27b8588a423f6279b79a0d68fbc196f8d8`. It preserves manifests/lockfile, authored/generated source, runners, metadata/notices, failures/successes and final state. File hashes identify original bytes before temporary-root normalization; no executable binary, credentials, personal data or reference-app source is embedded.

Final inspection found no remaining probe processes. Global Node remained 24.18.0; the global Flutter 3.38.9 checkout stayed clean, and reference HEADs/status counts matched the earlier baseline. Temporary-volume free space was approximately 27.48 GiB. No repository app scaffold or global tooling change occurred.

**The mobile compatibility blocker is resolved for this host sample, not for the whole app.** No native Android/iOS/iPad build, persistence/migration/encryption, real HTTP/auth/sync, screen-reader/golden test, full icon catalog, complete license/security audit or release readiness was established. The later lint experiment supplies bounded runtime evidence; production lint policy, ApexCharts rights/integration, remaining notices and final-pin approval still prevent M00-T04 completion.
