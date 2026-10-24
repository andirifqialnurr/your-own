# Local Development Bootstrap

- **Date:** 2026-10-24 UTC
- **Authorization:** [Decision 0012](decisions/0012-local-development-bootstrap.md), owner's explicit instruction to start setup using the existing laptop
- **Tasks:** M01-T01/T02 locally verified; M01-T03 shell implemented, native verification pending
- **Result:** Runnable local NestJS health API and tested Flutter setup shell. No product functionality, Docker service or deployment.

## What exists

| Path | Implemented scope |
|---|---|
| Root manifests/tool pins/ignore rules | Lean pnpm workspace, strict peers, disabled lifecycle scripts, separate Flutter lockfile |
| [API](../../apps/api/README.md) | Validated development/test environment, loopback binding, health endpoints, no workers/providers/domain writes |
| [Mobile](../../apps/mobile/README.md) | English ARB strings, system light/dark setup screen, explicit environment entry points, generated Android/iOS wrappers |
| API and mobile tests | Synthetic configuration/HTTP/dependency/widget checks; no private data or external provider |

Installed Node **24.18.0**, pnpm **12.8.1**, Flutter **3.38.9 / Dart 3.10.8** were used without a global upgrade. This is a local-development baseline, not the earlier experimental Node/Flutter cohort or a release-support/security certification. Native SDK/JDK/emulator setup was not attempted. Docker was authorized if needed, but there is no database service to run yet.

## Checks actually run

| Check | Result |
|---|---|
| `pnpm install --lockfile-only --ignore-scripts`, then initial frozen install | Passed with strict peers; no peer allowances applied |
| `pnpm install --offline --frozen-lockfile --ignore-scripts` | Passed; generated lock unchanged |
| `pnpm audit --json`, before installation and after final dependency change | Zero known advisories at this checkpoint; not exhaustive security certification |
| `pnpm check` | Typed ESLint, strict TypeScript, build and **19 passing tests** |
| Actual compiled `dist/main.js`, explicit local environment | Loopback live HTTP 200; owned child stopped and port closed afterward |
| API readiness/configuration | Readiness 503 by design; deployment settings/invalid ports/non-loopback host rejected; error input not disclosed |
| `flutter pub get --offline`, then `--offline --enforce-lockfile` | Passed using cached packages; generated application lock retained |
| `flutter gen-l10n` | Generated from owned English ARB; repeated successfully |
| `flutter analyze --no-pub` | No issues |
| `flutter test --no-pub` | **12 passed**: two environment tests and ten size/theme cases at 200% text |
| `dart format --output=none --set-exit-if-changed` on owned source/tests | Nine files, zero changes on final check |
| Ignore rules | `.env`, API build, Dart tool state and Android local paths ignored |

Final documentation checks passed: 65 Markdown files, 1,063 local links/anchors, four JSON examples, 67 preserved requirement IDs and 224 tasks across 20 plans. Only M00-T01/T02/T03 and M01-T01/T02 are checked. `git -c core.safecrlf=false diff --check` passed; unrelated pre-existing files and all thirteen snapshots remain byte-identical to the pre-bootstrap baseline. The new saved-file-only `validate.py` is scoped to this checkpoint; historical no-scaffold validators were not rewritten or claimed as current passes.

The five widget sizes are 320×568, 568×320, 768×1024, 1024×768 and 1366×1024, in both system themes. They are host layout smoke tests, not complete adaptive navigation/accessibility/native evidence. API tests include real ephemeral loopback HTTP and ten separately isolated Multer maintenance regressions; no real upload feature is enabled.

### Corrections retained

The first lint run exposed missing explicit Node types under TypeScript 6. After adding `types: ["node"]`, strict compilation exposed the initial CommonJS/Node16 configuration against Nest 12's ESM declarations and missing Express declarations. The API now uses ESM/NodeNext with explicit `.js` local imports and exact `@types/express` 5.0.6. Checks were rerun; no rule suppression, `skipLibCheck`, vendor patch or peer bypass was used. An initial external baseline-helper quoting error occurred before any writes; the corrected hash baseline was saved before scaffolding.

## Dependency and lock ownership

- Root `pnpm-lock.yaml` was generated anew, not copied from an experiment. It contains **two YAML documents**: 15 package-manager identities and 200 application identities. Both belong in the one lockfile.
- The first 191 application integrity records matched previously reviewed retry records. Nine additional Express declaration packages were introduced for strict typing. Their installed LICENSE texts are byte-identical to the reviewed MIT/Microsoft Corporation notice; they are not omitted merely because they are development dependencies.
- **215 exact registry identities** were checked for availability/deprecation/integrity; 144 declared Node engine ranges accept installed Node 24.18.0. The application graph declares no install lifecycle hooks. Project dependency scripts remain disabled; no global tool update was run.
- Only Decision 0010 **policy B** is applied: `@nestjs/platform-express@12.2.0>multer: 2.5.0`. The current adapter still declares affected 2.4.0; no upstream-fixed adapter was available at this review. All 12 unique installed Multer files matched the reviewed patched bytes, and all ten synthetic regressions plus actual API integration/build checks passed again.
- Policy A is **not configured**: there are no React/Next/import/a11y plugin peer exceptions in this workspace. Later web/admin setup needs its own applicable review.
- `apps/mobile/pubspec.lock` owns **24 hosted + four SDK packages**. Public metadata confirmed no retractions and matching archive hashes. There are no database/native-plugin/chart dependencies. SDK template defaults do not define approved product OS floors.
- Owner accountability, safe removal and **2026-11-23 UTC** latest policy review remain unchanged. This technical revalidation is not automatic policy renewal, release adoption or exhaustive legal clearance. All historical notice/shipping obligations remain attached to any affected future artifact.

Final lock SHA-256 values:

```text
pnpm-lock.yaml
  e18f7fd47d9de95a96c9776cd15b5205935608b1eac82924975ee77b1b22cb4c
apps/mobile/pubspec.lock
  4590baa2ae160cd2bee66f87dd06b90999fde27d06e7ed5fbf3dfe9279b58f10
```

Local review artifacts are retained at `C:/Users/HP/AppData/Local/Temp/your-own-bootstrap-2naxg6i4/`; this report and repository tests are the durable navigation points, not a new emulator-evidence snapshot. The previous **13 snapshots remain unchanged**.

## Not done and next work

- No Android APK, iOS build, emulator/device/browser run, native readiness or production performance result. Native wrappers use temporary `com.example` identifiers, no release signing and no approved launcher artwork.
- No finished theme/token/icon system, adaptive navigation, authentication, encrypted store, sync, tracking, charts, Next.js apps, migrations or CI.
- M00-T04/T05 and full T14 acceptance remain open; this shell does not accept the P1 emulator budget or waive platform/privacy/release work.
- Continue the small foundation slices after reviewing this setup. Resolve native prerequisites when needed for native execution, rather than restarting exhaustive host research before ordinary local coding. The M01 fresh-checkout and full exit review remain outstanding.
