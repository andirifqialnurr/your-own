# Combined JS Probe — Stopped at Security Gate

- **Version:** 0.2
- **Observed:** 2026-10-24 UTC, Windows
- **Task:** [M00-T04](../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), In progress / unchecked
- **Authority:** [Decision 0008](decisions/0008-isolated-combined-js-probe.md)
- **Outcome:** Tool/launcher checks and fresh combined resolution succeeded; the audit reported a high-severity advisory. **No application installation, build, lint or server execution followed**
- **Related:** [Original JS/mobile probe](toolchain-probe.md), [separate lint probe](toolchain-lint-probe.md), [notice trace and experiment plan](toolchain-notice-trace.md)
- **Later outcome:** [Decision 0009](decisions/0009-isolated-multer-override-retry.md) separately authorized the exact-parent Multer 2.5.0 [retry](toolchain-multer-retry.md), which passed bounded combined checks in a new root. This stopped root/lock and snapshot remain unchanged

## 1. Authorization and actual execution

The owner answered **“continue”** directly to the explicit combined install/build/lint experiment question. Decision 0008 permits that bounded attempt with the same three temporary ESLint peer allowances and storage/free-space stop thresholds—not new versions, a dependency override or production adoption.

A new root, **`C:/Users/HP/AppData/Local/Temp/ycp-1in0web7/`**, preserves all previous roots and **seven snapshots**. HEAD was `b9cb618ff5d5c324f9c8d78813f59f417ce5d0b5`; the earlier notice/trace documentation and evidence were already modified/untracked. Initial free space was approximately **29.29 GiB**. The runner isolates configuration/home/cache/store/state/temp and telemetry settings, verifies executable identity before launch, monitors storage during commands and supports owned process-tree timeout teardown. This is not an OS sandbox or filesystem quota.

| Check | Actual outcome |
|---|---|
| Existing tools | Rehashed the earlier Node ZIP and pnpm archive, checked pnpm's recorded SHA-512 and compared both installed executable bytes to archive members before execution; no fresh SDK/tool download |
| Explicit launcher | Node **24.22.1**, pnpm **12.15.0** version checks passed. A deliberately wrong Node executable hash was rejected before a subprocess launch. No fresh-host/cross-platform/bootstrap certification |
| Input reconciliation | **31 distinct exact direct package/version candidates** from the two executed probes; shared versions agree. Four importers: root, API, web and admin. No new direct dependency or candidate version |
| Availability | Fresh exact registry metadata matched all 31 names/versions, without deprecation flags. This is not full transitive/security clearance |
| Resolution | `install --lockfile-only --ignore-scripts` passed with strict peers enabled, automatic peers disabled and exactly the three approved allowances. Only manifests/lock/config were created; no application source or `node_modules` |
| Lock parsing | Used the previously executed js-yaml 5.5.0 utility from the original external probe, not a new parser installation. Both YAML documents were inspected |
| Audit | `pnpm audit --json` returned **exit 1**, **one high** finding for Multer. The agreed security stop condition was applied before application installation/execution |
| Subsequent “continue” | Continued static advisory/source/fix research only. It was not an answer to an override authorization question and did not waive the stop condition |

The three selectors remain precisely React 7.37.5, import 2.32.0 and JSX-a11y 6.10.2 accepting ESLint 10.13.0 for this experiment. No `overrides`, force flag, audit exception, lifecycle approval, vendor patch or weakened rule was applied. Scarf and UnRS postinstall remain disabled.

## 2. Combined lock evidence, not combined runtime success

| Inventory | Finding |
|---|---|
| Manager lock document | **15** package/snapshot entries, one importer |
| Application lock document | **588** package/snapshot entries, four importers |
| Prior application-lock union | **589** exact keys across the earlier 293-entry and 390-entry locks, including optional/platform entries |
| Delta | **Zero new package/version keys**; only `baseline-browser-mapping@2.11.30` absent from the combined graph |
| Integrity comparison | All **588** application package integrity strings match an earlier lock entry for that exact identity |
| Installed union from earlier report | **509**, a different inventory: the union of two previous actual installations, not a count of this uninstalled graph |
| Audit service counts | 167 dependencies, 385 devDependencies, 102 optionalDependencies, **603 totalDependencies**; categories/counts are the service's metadata, not a new installation inventory |

Identities/integrities being previously observed does not establish that new peer contexts or combined application behavior work. A lock-only resolution is not a frozen install or a complete compatibility pass. The fresh peer negative controls, full resolved metadata/native/notice review, frozen install, API/Next builds and HTTP checks, 668 diagnostic expectations, clean lint/type checks and repeat-install equality were **not run** in this graph. Earlier successes remain historical evidence, not replacement results for these missing checks.

## 3. Confirmed security blocker

[GHSA-q7qp-rjg7-q26m / CVE-2026-113872](https://github.com/advisories/GHSA-q7qp-rjg7-q26m) is a reviewed, non-withdrawn **high** advisory, CVSS 3.1 **7.5**. It affects Multer **≥2.0.0 and <2.5.0**; the first patched version is **2.5.0**.

The advisory describes a pending **asynchronous `fileFilter` callback after request teardown** allowing a late parsing-stream error to become unhandled and terminate the Node process. It expressly distinguishes synchronous filters. This is a dependency finding and conditional upstream impact statement—not proof of an exploitable product endpoint, and no exploit or upload server was run here. The repository still has no application implementation.

The actual constraint/path is:

```text
synthetic API
  -> @nestjs/platform-express 12.2.0
     -> multer 2.4.0 (exact dependency, not a range admitting 2.5.0)
```

The audit also reports routes through Nest core and Swagger to that adapter. Multer 2.4.0 and its integrity were already in the original JS graph; combining lint did not introduce a new Multer version.

The fresh [adapter metadata](https://registry.npmjs.org/@nestjs%2Fplatform-express/12.2.0) pins 2.4.0. The observed `latest` endpoint still returns adapter 12.2.0; a targeted 12.2.1 lookup returned **404**. That establishes only those observations, not an exhaustive claim about every release/channel or future upstream publication.

The Multer 2.5.0 release was published **2026-10-22T11:57:23Z**; the advisory reports NVD publication **2026-10-22T15:17:05Z** and GitHub reviewed publication **2026-10-23T22:08:22Z**. Do not portray the fix as newly released during this experiment. Earlier zero-known-advisory reports were bounded dated service results, not exhaustive certification; this current finding supersedes any current-security inference from them. Historical reports/snapshots are not rewritten to conceal that distinction.

Do not “fix” this by adding a root Multer dependency while leaving the adapter's 2.4.0 installed, running an automatic audit fix, hiding the advisory, disabling upload behavior to claim the graph is clean, or silently switching HTTP adapters/framework versions.

## 4. Static remediation review — no retry authorized

**Historical proposal:** this heading preserves its link target and original approval boundary. The later Decision 0009 and separate retry report above supersede the pending-authorization status, not this stopped attempt's evidence.

Multer **2.5.0** is an available stable/nondeprecated candidate. Registry metadata shows unchanged runtime dependencies (`append-field`, `busboy`, `type-is`), Node engine and MIT declaration, with no install/prepare hooks. At the two declared source commits:

- The complete MIT notice is byte-identical and credits **Hage Yaapa, 2014**; preserve its actual text.
- `index.js` is byte-identical.
- The [pinned source comparison](https://github.com/expressjs/multer/compare/35979e5afbb814bdb4b750ce028b125eb84c53af...2c380d06cdaacc68bbef8b36244493a3d33d6b88) contains **eight commits / nine changed files**. It includes the late-error listener fix, **two additional runtime behavior changes** and upstream tests: accepting a field value exactly at `fieldSize` (including the default), and avoiding cleanup of a path-less failed storage result after a file-size abort.

These are static observations, not proof of compatibility with Nest. No Multer 2.5.0 archive was downloaded, installed or executed; its registry integrity/attestation fields were observed, not independently verified as published bytes or provenance. Upstream tests were read, not run. A minor release is not automatically a safe substitution for the adapter's exact pin.

### Bounded options

1. **Keep the experiment paused** until an appropriate upstream Nest adapter release naturally depends on a patched Multer. Recheck exact candidates and request any needed version-change scope; do not auto-follow `latest`.
2. **Request a separately authorized temporary retry** using only the parent-scoped dependency override below, while retaining the same three ESLint peer allowances. This changes Decision 0008's no-override boundary and was **not authorized at this static-review stage**:

```yaml
overrides:
  "@nestjs/platform-express@12.2.0>multer": "2.5.0"
```

[Official pnpm documentation](https://pnpm.io/settings/dependency-resolution#overrides) describes this root-only parent/dependency selector. It is a **dependency override**, not a fourth peer exception, a vendor patch, or a supported upstream Nest pin. No bare/global Multer override, wildcard parent or other edge is proposed.

A retry, if explicitly authorized, must preserve this stopped root/lock, verify the fixed package archive/installed bytes/notices before execution, review the actual new resolution delta and rerun the audit. It must prove the selector applies only to the intended exact parent and that no unintended affected Multer instance remains. Use newly authored bounded regression checks for late asynchronous-filter teardown, a normal upload, exact/over-limit field sizes and failed-storage cleanup; use synthetic data, process isolation where a regression could terminate Node, and loopback only where HTTP is needed. Do not swallow process-level errors in the test harness to manufacture a pass. Node built-ins suffice; no new test framework is selected.

Only after these gates should the original combined checks resume, including the four peer negative controls, all 668 focused lint expectations and separate full-config clean checks/builds. Keep the **3 GiB temporary-footprint / 20 GiB remaining-space thresholds**, script policy, native review gates and teardown requirements. Any additional delta/exception/native requirement or remaining material finding stops the retry. No production override/pin, full security certification, rights clearance or scaffold approval would follow automatically.

## 5. Evidence and verification

The [combined-attempt snapshot](evidence/m00-t04-combined-probe.json) preserves **89 files / 1,105,854 bytes**, SHA-256 `05bb16e1e8fc7db77031c9904943dcc526b25fea2b333abe7984f2c5fefc26f4`: input manifests, lock/config, command logs, tool identities, wrong-hash control, 31 direct metadata records, graph/integrity delta, failing audit, public advisory/release/source evidence and static findings. Registry caches and binary tool artifacts stay external; no application binaries or implementation are adopted.

The validators check the recorded pass/failure distinction, exact peer selectors and absence of overrides, the 588/589 lock relationship/integrity matches, current affected path, advisory and source identities, no installation/scaffold, resource thresholds and all seven preserved earlier snapshots. Global/reference state is rechecked. `python .../ycp-1in0web7/validate.py` and the existing `validate_review.py` passed, as did `git -c core.safecrlf=false diff --check`. Documentation checks covered **53 Markdown files / 838 local links and anchors / four JSON examples**, 67 preserved requirement IDs and all 224 tasks/prerequisites; only M00-T01/T02/T03 remain checked. Global Node stayed 24.18.0, global Flutter stayed clean at 3.38.9 and reference HEAD/status counts matched the baseline. No matching owned Node/pnpm process was observed and no server was started. Final measured temporary file footprint was approximately **0.31 GiB**, below the 3 GiB stop threshold, with more than 20 GiB free. The stopped lock SHA-256 is `79f611945c38c631fe30e21cd781da71cd1791bf4cf1662273010159b88c6493`. Documentation validation does not turn the failed security gate or unrun application checks into passes.

**M00-T04 remains active and unchecked.** At this historical stop, the next execution choice was an upstream-fixed adapter review or an explicit bounded override-retry decision—not automatic continuation. The later Decision 0009 authorized only the separate retry, not production policy. Notice attribution/delivery, production lint policy, final pins, native/browser proof and ApexCharts entitlement remain separate gates. No outreach, replacement chart engine, spend, deployment or M01 scaffold is authorized.
