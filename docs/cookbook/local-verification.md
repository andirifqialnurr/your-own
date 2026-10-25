# M01-T09 — Reproducible local verification lane

- **Checkpoint:** 2026-10-25 UTC; Windows host, Node 24.18.0 / pnpm 12.8.1 / Flutter 3.38.9 / Dart 3.10.8.
- **Status:** Local subset implemented and tested. **T09 stays unchecked**: hosted CI, actual native builds and an approved macOS path remain unavailable/unverified.
- **Authority:** [Owner continuation](decisions/0012-local-development-bootstrap.md#indexes-and-local-check-automation-continuation), [M01 task](../milestones/01-foundations.md), [testing strategy](testing.md).

## Run and scope

From the repository root with the already-installed pinned tools:

```bash
node scripts/check-local.mjs
# When all locked packages are already cached:
node scripts/check-local.mjs --offline
```

**Fresh-checkout correction (T10):** use the dependency-free Node entry above on an uninstalled checkout. `pnpm check:local` remains an alias after setup. [T10's review](fresh-checkout-review.md) found pnpm 12's default pre-script install ran before the helper; the workspace now sets `verifyDepsBeforeRun: error`, retaining (not disabling) dependency checks. Explicit frozen install inside the helper still runs after tool validation. A raw pnpm script on missing/outdated dependencies fails rather than silently repairing them.

The [entry point](../../scripts/check-local.mjs) verifies Node, pnpm, Flutter and both Flutter's bundled Dart and the PATH Dart launcher before dependency installation. It checks manifest/runtime-pin agreement and **never upgrades an SDK**. Offline mode adds offline flags to both managers; a missing cache is a failure, not permission to fall back online. The complete lane currently requires Windows because its golden images were reviewed there; other hosts need a reviewed lane/baselines. This is not a Windows product-support commitment.

The [serial plan](../../scripts/tooling/local-checks.mjs) executes:

1. `pnpm install --frozen-lockfile --ignore-scripts` (plus optional `--offline`). Existing strict-peer/disabled-auto-peer policies and the exact Multer override remain unchanged.
2. `pnpm check`: documentation/source-whitespace and tooling tests, token/asset/artwork checks, design/boundary tests, real import scan, ESLint, strict TypeScript and API tests. The API test command builds with `tsc` before executing its tests.
3. In `apps/mobile`: `flutter pub get --enforce-lockfile` (plus optional `--offline`), `flutter gen-l10n`, `flutter analyze --no-pub`.
4. The documented non-writing Dart format check over owned source/tests, followed by `flutter test --no-pub --reporter expanded`. Generated localization stays generator-owned; generated theme tokens retain their generator/format checks.

Both lockfiles, generated localization directory (including additions/removals) and generated tokens are compared before/after each step, including failed commands. CRLF/LF conversion alone is ignored. Any content drift fails with paths; **no reset, restore, cleanup or automatic retry** occurs. Review changed files and intentionally regenerate/review before repeating. This compares the current working tree, so legitimate unrelated edits need not be discarded. It is not a sandbox or a generic checker for future generators.

No native build, Docker service, network application endpoint, deployment, signing, cloud runner or background task is started. Frozen installation may access package registries unless offline mode is selected. API tests use temporary loopback listeners; the application is not left running.

## Documentation, formatting and fixture isolation

- `pnpm check:docs` uses [the repository checker](../../scripts/check-docs.mjs) and [parser](../../scripts/tooling/documentation.mjs): tracked plus unignored Markdown, local inline links/ATX headings, duplicate anchors, fenced JSON examples and table/fence/whitespace consistency. External links are not fetched; this is not a full Markdown parser or a semantic proof of requirement coverage.
- The same command checks spaces/tabs/trailing whitespace/final newlines in owned JS/TS/JSON source/manifests. It is whitespace hygiene, **not a new JS pretty-printer**. Dart uses its actual formatter; JS/TS retain ESLint and strict compiler checks.
- [Documentation fixtures](../../scripts/tooling/documentation.test.mjs) reject absent paths/anchors, repository escapes, malformed links/JSON/tables and whitespace failures. [Runner fixtures](../../scripts/tooling/local-checks.test.mjs) cover pins, unsafe flags, frozen/offline ordering, stop-on-failure, generated/lock drift, additions/removals and platform launch arguments.
- Tooling tests create unique synthetic OS-temp directories and remove only their own directories. Existing API tests retain ephemeral loopback ports, explicit teardown and process-isolated multipart cases. Flutter tests retain synthetic stores/clock/state and real bundled font/SVG loading; no private data or actual preference storage is used.
- API test files now run with `--test-concurrency=1`, without changing any assertion or the existing 10-second failed-start timeout. T07/T08 recorded intermittent child-start timeouts; serialization avoids overlapping configuration/HTTP/multipart suites and keeps the local lane within one app's checks at a time. It does not certify performance or guarantee an overloaded host cannot time out.

## Executed evidence and limits

`pnpm check:local --offline` passed all steps on the installed Windows tools: **320 tests = 20 tooling + 14 design/artwork + 88 boundaries + 19 API + 179 Flutter**, including ten existing golden comparisons. The boundary scan remains **37 source files / 131 directives**. Flutter analysis passed; Dart formatting checked **44 files, zero changes**. Both frozen/offline installs succeeded and lock/generated content stayed unchanged; no dependency version, archive hash, policy exception or golden baseline was changed. Root `pnpm check` remains independently usable and does **not** run Flutter.

External execution/preservation evidence: `C:/Users/HP/AppData/Local/Temp/your-own-checks-9fhjosfw/`. Earlier T08 timeout/repeat evidence remains in `your-own-indexes-7ec3ganw`; no failed result was overwritten or reclassified as a pass. The new helpers' negative fixtures fail deliberately inside passing tests; they are not failed application checks.

## CI and native disposition

| Lane | Current evidence / next action |
|---|---|
| Windows local host | Executed as above; reusable automation, not a hosted workflow result |
| Hosted CI | **Not configured/run.** No `.github/workflows` file, runner, credential, artifact upload or paid service was introduced. Owner must approve provider, execution permissions, artifact retention/access and resource policy before promotion. |
| Android native | **Not run.** Compatible JDK/SDK/target and actual Gradle/plugin resolution remain unverified; preserve [native prerequisites](../../apps/mobile/README.md#native-run-when-an-android-target-is-available). |
| macOS / iPhone / iPad | **Blocked, no approved path/operator.** The owner reported no Mac/device access. Before execution, record authorized access/operator, accepted macOS/Xcode/SDK tuple, synthetic build/device scope, resource/signing ownership and evidence handling in the [environment review](supported-environments-review.md). No provider or target is selected here. |
| Release / security / fresh checkout | Not proven by this lane. Native accessibility/IME/lifecycle/durability, shipping notices, policy reviews and M01-T10's fresh-checkout review remain separate. |

A future approved macOS lane must actually build the configured development shell and exercise applicable iPhone/iPad/native behavior; an unsigned compile is neither signing/store acceptance nor a substitute for those tests. Do not run the root specification's illustrative production commands against the fail-closed current entry points. No false iOS pass or `continue-on-error` native waiver is supplied.

The original next proposal was M01-T10; its [subsequent fresh-checkout review](fresh-checkout-review.md) now records reproduction, the bootstrap correction and 321 tests including one additional real-pnpm regression. The 320-test paragraph above remains the historical T09 checkpoint. Native/environment limitations remain retained. M02 and release gates are not opened by these two task commits.
