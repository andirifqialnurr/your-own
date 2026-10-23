# Reference Apps — Dependency and Provenance Register

- **Version:** 0.1
- **Observed:** 2026-10-23 UTC, Windows/Git Bash
- **Scope:** M00-T03 static inventory; companion to the [reference-app audit](reference-app-audit.md)
- **Disposition:** No reference source, asset, lockfile or dependency tree adopted. This is not a legal clearance, security audit or new-stack selection.

## 1. Evidence and limits

All four `pubspec.lock` files were read. The 22 distinct directly declared hosted package/version pairs were matched to existing directories under `C:/Users/HP/AppData/Local/Pub/Cache/hosted/pub.dev/`, and their complete root `LICENSE` files were read. No package was fetched, installed, upgraded or executed.

For a table entry `name@version`, the evidence path is `<cache>/name-version/LICENSE`. The SHA-256 below identifies the exact local notice bytes reviewed. A cached notice is evidence of the supplied text, **not independent proof of the publisher's provenance or a verification of the entire package archive**. Lockfile archive hashes were not revalidated against downloaded archives; no network licensing lookup was performed. Full nested/native/browser/font obligations must be reviewed for whatever versions are actually selected in M00-T04/M00-T08.

Reference source locations and committed HEADs are in the main audit. Coffee's lockfile has pre-existing uncommitted changes; the byte digests below identify the inspected working copies. These are not Your Own lockfiles or pins.

| Reference | Lockfile SHA-256 | Total entries | Hosted entries | SDK entries |
|---|---|---|---|---|
| Finance | `309e1bb9c9a461c960c598c25630b4d1b34c60cdc4578510e496281d90b24599` | 74 | 71 | 3 |
| Water | `cb46f7e8fde42682b099bdbcc1a0d95ad166801fb363c906fe9ded0f3e30f866` | 98 | 95 | 3 |
| Coffee | `db99c47ad9b70f22b12868027431ec6f97fbbd2c375ba1957134bc874f7cf661` | 115 | 110 | 5 |
| Book | `200ce1e2d49d33b1a6c6ed7ee4f59100096f9bd79fc3849abdd37944ecd3509a` | 86 | 82 | 4 |

The union contains **165 hosted name/version pairs**, including **22 direct pairs** and **143 other pairs**. All 165 corresponding cache directories existed. Root licenses were fully reviewed for the 22 direct pairs, not for every transitive package. The complete transitive inventories remain the identified source lockfiles; none is silently cleared by the direct-package table.

## 2. Direct resolved package notices

F = finance, W = water, C = coffee, B = book; `dev` means a development dependency. MIT/BSD labels describe the inspected notice text, not the legal status of every nested asset. The existing broad manifest constraints are recorded separately in the main audit.

| Resolved package | Reference / role | Observed root notice | LICENSE SHA-256 |
|---|---|---|---|
| `apexcharts_flutter@0.1.2` | F | MIT; additional NOTICE discussed below | `1d3fce93f8234d169992f2b5b1ca7fc5e6ff44a1e037e85aa5d1dddd27601bb8` |
| `build_runner@2.15.0` | W dev | BSD-3-Clause | `a4b5d7d31626e90b77e8696f1c47643aa31f52e17c1907c1ab60b068110e6e10` |
| `cupertino_icons@1.0.9` | F/W/C | MIT | `310d6ab6483280280c9db122bded0a63c09558bc5743720f61dbcbb494db370a` |
| `dio@5.9.2` | W | MIT | `0b4d36faa9f74d67c3b7e082fc860c643b41f5bb14b4d262fe9c3559c88992b7` |
| `drift@2.34.0` | W | MIT | `31f84e4edff98f0238a5bef1c2ce754e401fbab149782f0ff4dc9b68fd086f75` |
| `drift_dev@2.34.0` | W dev | MIT | `31f84e4edff98f0238a5bef1c2ce754e401fbab149782f0ff4dc9b68fd086f75` |
| `drift_flutter@0.3.0` | W | MIT | `7cf86321e740e4ff631ab6d00962c2d65fa85e4163bdd89334f1d22354ab0306` |
| `equatable@2.0.8` | W | MIT | `07720a43bdabe44206067a2bffd1089dcdc4cc5b0b7f8169308c2f8ba6ad0c86` |
| `flutter_bloc@9.1.1` | W | MIT | `7e944ae2d1553a6c1db91ec53a5ed1b0e1b078637748d8b70995a5afc4e37d6e` |
| `flutter_launcher_icons@0.14.4` | F/C/B dev | MIT | `02c454256448927423b4c0e517a083cadf78a8d9467a9d31ad3b4f4ff48ff7ca` |
| `flutter_lints@3.0.2` | B dev | BSD-3-Clause | `89519eca6f7b9529b35bdddd623a58c3af06a88c458dbd6531ddb4675acf75a9` |
| `flutter_lints@6.0.0` | F/W/C dev | BSD-3-Clause | `89519eca6f7b9529b35bdddd623a58c3af06a88c458dbd6531ddb4675acf75a9` |
| `flutter_riverpod@2.6.1` | F/B | MIT | `757d9c09a9a2a701144328c0fd596234ea287ff62952b39cd22f9ad4caed1171` |
| `get@4.7.3` | C | MIT | `ec83934ddf3a59ecd89efa679ee527be1e09ea87d02c8e095430405c1784ff80` |
| `google_fonts@6.3.3` | B | BSD-3-Clause; not a license for all font files | `420f7739f169097f0aad1242045169cd643c8f1d94e62866fad265ae4c369b7d` |
| `google_fonts@8.2.1` | C | BSD-3-Clause; not a license for all font files | `420f7739f169097f0aad1242045169cd643c8f1d94e62866fad265ae4c369b7d` |
| `image_picker@1.2.3` | C/B | BSD-3-Clause plus included Apache-2.0 aFileChooser notice | `8e22fae63e4e8ac897f0cb3018ed94ed730b3e5da5d42c6856a26ba524f0fd88` |
| `path@1.9.1` | C/B | BSD-3-Clause | `3c32b53167c7dae9190c38dab5dd9fe1789c53623ebc7d1babcb29914c5b3f16` |
| `path_provider@2.1.6` | F/W/C/B | BSD-3-Clause | `420f7739f169097f0aad1242045169cd643c8f1d94e62866fad265ae4c369b7d` |
| `shadcn_ui@0.53.6` | C | MIT | `466a3e8cee1b8ecfb44b51340e2fceb218955320955c334ad98a2cd4c40893dd` |
| `sqflite@2.4.2+1` | F/C/B | BSD-2-Clause | `c81f9454cf3107c116bc3c1fd22b7d751523a2b11e17cf90c0db3327d3c9e0da` |
| `sqflite_common_ffi@2.4.0+3` | F/C dev | BSD-2-Clause | `c81f9454cf3107c116bc3c1fd22b7d751523a2b11e17cf90c0db3327d3c9e0da` |

**Disposition for every row:** inventory only, not inherited or installed. Reevaluate any independently selected dependency against the new contracts, supported platforms, resolved graph and actual version. Cupertino/default glyphs and the old theme stacks are not reused under Decision 0002; the MIT label does not override that design requirement.

## 3. Nested and non-package obligations

| Component | Evidence actually inspected | Finding / disposition |
|---|---|---|
| Apex native port | Cached `apexcharts_flutter-0.1.2/{LICENSE,NOTICE,README.md,pubspec.yaml}` | Native Dart/CustomPainter port, **not a WebView wrapper**. Supplier NOTICE claims exclusive derivation from ApexCharts.js v4.7.0 at `1e93a0d47b834111cf616fb6c78a263bbae7c1d8`, under MIT; it says the pristine reference tree is excluded from the published package. This claim was not independently traced to upstream. No port selected for Your Own. |
| User-web ApexCharts | Not present as the selected new web dependency | Do not extrapolate the port's MIT notice to current JS core/React-wrapper versions, commercial entitlements or deployment rights. M00-T04 must separately review official terms and exact versions; no downgrade/workaround or purchase approved here. |
| Image picker native code | Complete `image_picker-1.2.3/LICENSE`, including aFileChooser text | Retain applicable BSD and Apache notices, modification/NOTICE obligations if adopted; do not reduce the bundle to a BSD-only label. Native implementation/dependency closure remains a selection/release review. |
| Darwin SQLite bridge | `sqflite_darwin-2.4.2/darwin/FMDB_LICENSE.txt` | Included FMDB MIT notice observed; a wrapper's BSD notice is not the only relevant notice. No native implementation copied or tested. |
| SQLite bindings/binaries | `sqlite3-3.5.2/LICENSE`; lockfiles also resolve `3.3.3` and `3.5.1` | Read 3.5.2 MIT binding notice only; other binding versions and actual linked SQLite/encryption binaries need their own provenance/notices. No encryption inferred from the package name. |
| Obsolete Flutter SQLite helpers | `sqlcipher_flutter_libs-0.7.0+eol/README.md` and `sqlite3_flutter_libs-0.6.0+eol/README.md`, both in water's lock | Both state these versions no longer do anything and are obsolete with sqlite3 v3. Their presence does **not** establish SQLCipher use or encrypted data. Do not copy the graph as an encryption solution. |
| Transitive icon package | `lucide_icons_flutter-3.1.17/LICENSE`, in coffee's lock | Root MIT notice read; underlying glyph/font provenance and complete cross-client rounded coverage not verified. Its presence through shadcn does not select Lucide or any other icon family. |
| Flutter/Dart SDK and engine | Existing `C:/Users/HP/develop/flutter/LICENSE` | Flutter root BSD-3-Clause text read. SDK/engine bundled third-party licenses and toolchain identity remain separate work. No `flutter --version` or other SDK executable was run; SDK lock entries `0.0.0` are not actual version pins. |
| Remaining hosted transitives | All four identified lockfiles; union count above | Not adopted as a tree. Except for the targeted notices above, individual transitive licenses and shipped native/browser assets are unreviewed. Review the graph of the **new selected stack**, not a presumed clean graph inherited from these references. |

Minimum notice-handling implications if a package is later selected: preserve required MIT copyright/permission text; retain BSD source/binary notices and disclaimers and respect BSD-3 non-endorsement; retain applicable Apache license/attribution/NOTICE and modification notices. These summaries do not replace full terms or establish compliance of a future binary.

## 4. First-party source and asset provenance

| Material | Evidence / uncertainty | Audit disposition |
|---|---|---|
| Four app source trees and test implementations | No project license/ownership grant established by the scoped filename/content scans; local repository location and `publish_to: none` are not permission | Reference-only. No source/test implementation copied; write new domain code and synthetic fixtures from Your Own requirements. Direct copying requires explicit rights/provenance and compatibility review first. |
| Finance Montserrat files | Manifest bundles four font weights; root source notice scan found no license file | Do not copy these bytes. Existing font-name recognition is not provenance. New fonts follow the approved DM Sans/licensed-alternative design gate. |
| Water Plus Jakarta Sans files and images | Manifest declares fonts/images; source names `assets/images/pexels-pixabay-302769.jpg` | Do not copy. A filename suggesting Pexels/Pixabay is not a license, source URL, attribution record or model/property release. No image content or personal data was opened. |
| Coffee Google Fonts usage | `lib/app/shot_theme.dart` calls Montserrat APIs | Package license is not font-specific permission or offline-bundling proof. Do not inherit the font/theme. |
| Book Google Fonts usage | `lib/core/theme/app_text_styles.dart` calls Inter/Merriweather APIs and contains non-fetching fallbacks | Do not inherit the retired typography direction or assume font rights from the package's BSD notice. |
| Launcher/brand art | `money.png`, `coffee-beans.png`, `book-stack.png` and generated native/web variants in manifests/source inventory | Provenance unestablished; exclude originals and derivatives. Existing coffee launcher edits remain untouched. |
| Generated database/native scaffolding and sample assets | Generator ownership, originating templates and nested notices not comprehensively reviewed | Do not transplant. Generate fresh application artifacts only after M00's scaffold gate using approved tooling. |
| User-selected covers/coffee images and local databases | Not opened; paths/storage helpers inspected only | Never fixtures or redistributable assets. Real-data import/access requires separate explicit scope and consent. |

## 5. Closure and next gate

This register completes the **inventory and non-reuse disposition** required by M00-T03; it does not resolve every upstream licensing question by declaring it safe. Unknown source/asset permission remains a hard blocker to copying those materials. Because no such copying or dependency-tree adoption is selected, those unknowns do not prevent completing the read-only audit itself.

M00-T04 must select and verify actual runtime/package versions, one complete rounded icon family and the user-web ApexCharts entitlement/integration. M00-T08 must validate the chosen encrypted native stack. M00-T09 must validate fonts/icons/chart rendering. Any later proposal to reuse reference code/assets must reopen the applicable provenance review before copying. No owner approval, installation, native verification or release clearance is supplied by this register.

**Commands/evidence:** `read` for complete lockfiles/direct LICENSE files and the targeted notices above; `rg`/`find` for filename/content inventories; inline standard-library `python -` for lockfile counts and SHA-256 of lockfiles/notices. A first font search used a nonexistent coffee `lib/theme` path; the corrected search over `lib/` found `lib/app/shot_theme.dart`. Complete command/output is in the agent session. No package manager, migration, application test or network request was run.
