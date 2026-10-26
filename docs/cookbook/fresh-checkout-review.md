# M01-T10 — Fresh-checkout foundation review

- **Checkpoint:** 2026-10-25 UTC, existing Windows tools: Node 24.18.0, pnpm 12.8.1, Flutter 3.38.9 / Dart 3.10.8.
- **Status:** Local reproduction reviewed and bootstrap defect corrected; **T10 remains unchecked / full foundation exit blocked** by outstanding native/CI prerequisites. M02 is not started.
- **Authority:** [Owner continuation](decisions/0012-local-development-bootstrap.md#fresh-checkout-continuation), [M01 acceptance](../milestones/01-foundations.md), [local lane](local-verification.md).

## Checkout and reproduction

The reviewed published base is **`28c5e2f6ddfdbbed85ed218e0ab73f9f5ff20a67`** (T09). Two independent local clones were created with `git clone --no-local --single-branch --branch main`, under a new task-owned directory on D:, with spaces in each checkout path. No `.git` alternates or original working-tree artifacts were copied. Push URLs in both review clones were disabled; publication occurs only from the original repository.

Before execution, each clone had no `node_modules`, API `dist`/`.env`, Flutter `.dart_tool`/`build`, Android `local.properties` or iOS generated machine configuration. The first clone stayed source-clean. The corrected retry contains only the reviewed three-file code/policy patch listed below. This is a **fresh checkout with warm existing package/SDK caches**, not a new machine, remote-clone authentication check or cold-cache proof.

| Attempt | Actual result |
|---|---|
| Published base: `pnpm check:local --offline` | 320 tests, API build, Flutter analyzer, 44-file format check and ten goldens passed; no tracked diff. **Bootstrap ordering was wrong:** pnpm installed 200 packages before the script's tool validation. Reported reuse 200/download 0 does not prove the pre-script install honored the helper's offline/frozen contract. |
| Corrected, still-uninstalled retry: `pnpm check:local --offline` | Expected exit 1, `ERR_PNPM_VERIFY_DEPS_BEFORE_RUN`; no dependency tree created. This alias now requires prior installation rather than silently repairing it. |
| Corrected bootstrap: `node scripts/check-local.mjs --offline` | Tool pins were verified **before** the explicit frozen/offline install. Reused 200 JS packages, downloaded 0. The first corrected run stopped on a newly added test-fixture isolation error; that result is retained. |
| Corrected repeat after fixture fix | **321 tests passed: 21 tooling + 14 design/artwork + 88 boundaries + 19 API + 179 Flutter.** Analyzer passed, 44 Dart files unchanged, ten existing golden comparisons passed. Both lockfiles/generated contents unchanged; boundary scan remains 37 files / 131 directives. |

No app source, dependency version/archive hash, golden baseline, SDK pin or native wrapper changed. The retry applied the T10 patch to the published base; it is not misreported as an untouched published commit. The final original-tree check uses the same corrected code and updated documentation.

## Concrete correction and regression

pnpm 12 defaults [`verifyDepsBeforeRun`](https://pnpm.io/settings/build#verifydepsbeforerun) to `install`: `run`/`exec` can install before a package script starts. This was invisible on T09's already-installed tree. [Workspace policy](../../pnpm-workspace.yaml) now uses **`verifyDepsBeforeRun: error`**, not `false`. Dependency verification stays enabled; strict peers, disabled automatic peers/lifecycle scripts, engine pins and the exact Multer override are unchanged.

Use the dependency-free `node scripts/check-local.mjs [--offline]` on a fresh checkout. After setup, `pnpm check:local` remains an alias. Do not bypass the error with force, weakened policy or an unreviewed SDK upgrade. The [argument help](../../scripts/tooling/local-checks.mjs) and root/app READMEs now explain this. The root README also moves the guarded example-config copy **before** `pnpm dev:api`.

The new [real-pnpm regression](../../scripts/tooling/local-checks.test.mjs) copies only public manifests/lock into an isolated temp fixture, requests offline behavior, and verifies that a missing dependency tree fails without running the fixture script, creating dependency trees or changing the lock. Initial fixtures inherited pnpm's `pnpm_config_verify_deps_before_run=false` marker for nested scripts and wrongly bypassed the intended independent-launch check. The test now removes **only that inherited bypass in its child environment**, retains the workspace error policy and all failure assertions, and passes. No global environment/config was changed. Earlier failed fixture runs and the interrupted corrected lane remain saved, not reclassified as passes.

## Actual API startup and artifact review

In the corrected checkout, the compiled CLI behind the documented start command was exercised directly as `node --env-file-if-exists=.env dist/main.js`:

- Missing configuration, `APP_ENV=production`, and non-loopback `API_HOST` each exited 1 with the expected sanitized configuration message.
- The documented Bash guarded copy ran twice and created only the checked-in development `.env.example` contents. It is ignored by Git; the original checkout's `.env` was never read or copied.
- With only `API_PORT` overridden to a temporary loopback port, the example launched successfully. Real HTTP returned live 200/`ok`, ready 503/`not_ready`, and sync-command POST 404, with no-store/nosniff headers and no powered-by header. No personal endpoint was enabled.
- The single owned Node process was stopped in `finally`; process exit and port closure were checked. This is process teardown, not a native lifecycle/durable-storage test. Existing API test assertions and timeouts were not changed.

The first clone remained clean; the retry had only `pnpm-workspace.yaml`, `scripts/tooling/local-checks.mjs` and its test changed, with no unignored generated/config files. Tracked-path checks found no private environment file, signing key/certificate or application database; 58 application/tooling text files had no private-key header. This narrow check plus reviewed synthetic configuration is **not an exhaustive secret/history or security audit**. Font/OFL and ten golden PNG bytes match the original repository; generated/lock content is unchanged. No application credentials or personal records were introduced.

## Evidence and remaining gates

External evidence is retained at `C:/Users/HP/AppData/Local/Temp/your-own-fresh-h2pyep_7/`: original baseline, clone logs/path records, `check-local-first.log`, `cold-pnpm-guard.log`, failed/corrected tooling logs, `check-local-corrected.log`, `check-local-corrected-final.log`, CLI failure/smoke logs/results and `checkout-audit.json`. Review checkouts remain under `D:/my_project/mini-projects/.your-own-checkout-3aqw_1gq/`; no broad cleanup or unrelated process termination was performed. Logs contain synthetic/local data only.

| Gate | Disposition before M02 |
|---|---|
| Host reproducibility | Passed within the stated base/patch, Windows and warm-cache scope; no cold-cache/other-host certification |
| T03 Android/iOS prerequisites | Still open: compatible JDK/SDK/target and actual Gradle/plugin resolution; macOS/Xcode/operator/device access unavailable |
| T05/T06/T07 native behavior | Still open: restart/resume preference durability, launch/system bars, real resize/rotation/IME/Back, TalkBack/VoiceOver and physical phone/tablet/iPad checks |
| T09 hosted CI/macOS | Still blocked: no approved workflow/provider/runner, permissions/artifact retention, Mac path or signing ownership; no hosted/native job ran |
| M00 and real-data gates | Production pins/rights, provider/database/ORM/session baseline, encrypted persistence/key handling, exact-value/sync contracts and full T14 acceptance remain unresolved |
| M01 exit / M02 | **Not accepted/open.** This local review cannot waive the preceding tasks or authorize schema, identity/provider integration or personal data. No Docker, native setup, cloud provisioning or deployment occurred. |

The next bounded proposal is an **M00-T06 infrastructure/provider decision review**, starting with database/ORM and identity choices needed by M02, without provisioning or claiming owner approval. Native/CI acceptance remains separate; do not restart exhaustive hardware inventory as a prerequisite to that discussion. The subsequent [T06 review](provider-baseline-review.md) is now prepared and awaits owner choices; this does not alter T10's blocked foundation exit.
