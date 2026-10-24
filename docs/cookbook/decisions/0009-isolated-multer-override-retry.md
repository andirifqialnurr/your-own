# Decision 0009 — Isolated Multer Override Retry

- **Status:** Authorized bounded retry completed with passing scoped checks; no production override, final pins or scaffolding approved
- **Task:** [M00-T04](../../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), In progress / unchecked
- **Approved by:** Project owner (user in this conversation)
- **Approval recorded:** 2026-10-24 UTC
- **Recorded by:** Coding agent, not the approver
- **Scope source:** [Stopped combined attempt and remediation proposal](../toolchain-combined-probe.md#4-static-remediation-review--no-retry-authorized)
- **Refines:** [Decision 0008](0008-isolated-combined-js-probe.md)'s no-dependency-override boundary for this separate temporary retry only
- **Later policy decision:** [Decision 0010](0010-conditional-dependency-exceptions.md) separately accepts conditional eligibility of exact A/B exceptions and maintenance controls; it does not retroactively adopt this experiment or approve a baseline, pins or new execution

## Approval evidence

After the advisory and static remediation review, the owner was asked:

> **Authorize a separate temporary retry overriding only `@nestjs/platform-express@12.2.0>multer` to `2.5.0`, with regression checks?** This changes the no-overrides boundary. Existing peer exceptions and storage limits stay unchanged; no production adoption or scaffolding.

The owner replied:

> continue

This directly authorizes the proposed retry. It is distinct from the earlier generic continuation after the audit, which authorized only static blocker research. It neither suppresses the advisory nor approves a production override.

## Exact scope

Use a separate external root **`C:/Users/HP/AppData/Local/Temp/ycr-b8f4n7ys/`**, preserving the stopped combined root/lock, all earlier probes and **eight snapshots**. Initial free space was approximately **28.97 GiB**. Repository HEAD was `fbf4711a7f3cc123c43d2f232aded0da0982c140`, with a clean working tree. No agent commit is implied.

Keep the same 31 exact direct candidates, tools and four-importer synthetic composition from Decision 0008. The only authorized dependency override is:

```yaml
overrides:
  "@nestjs/platform-express@12.2.0>multer": "2.5.0"
```

Retain only the three existing peer allowances:

```yaml
peerDependencyRules:
  allowedVersions:
    "eslint-plugin-react@7.37.5>eslint": "10.13.0"
    "eslint-plugin-import@2.32.0>eslint": "10.13.0"
    "eslint-plugin-jsx-a11y@6.10.2>eslint": "10.13.0"
```

The Multer override is a parent-scoped **dependency override**, not a fourth peer allowance, a vendor patch or upstream Nest support. No bare/global selector, additional override, new direct tool/test framework, broader peer exception or silent candidate substitution is authorized.

## Required gates and checks

1. Reverify existing isolated Node 24.22.1 / pnpm 12.15.0 bytes before reuse. Keep configuration/home/store/state/cache/temp isolated, strict peers enabled, automatic peers and lifecycle scripts disabled. No global changes or fresh SDK/tool installation.
2. Resolve a fresh lock, review actual deltas and current metadata/advisories, and prove the selector affects only the exact intended parent. Verify that no unintended affected Multer instance remains. Review and verify the fixed package archive, installed bytes and notices before execution; retain all existing native/WASM/notice limitations and inspect any new requirement before proceeding.
3. Run newly authored synthetic regressions for late asynchronous-filter teardown, normal upload, exact/over-limit field sizes and failed-storage cleanup. Use process isolation for potentially fatal regressions and loopback-only HTTP where needed. Do not catch/suppress process-level errors to manufacture a pass. No copied reference-app implementation or new test framework.
4. Once those gates pass, resume the original bounded combined checks: four peer negative controls, original effective lint configurations and all 668 diagnostic expectations, clean full-config lint/strict types, API build/OpenAPI/exact-string response, separate Next builds/HTTP checks, frozen repeat and teardown. Preserve failures and distinguish focused-negative fixtures from clean application checks.
5. Keep the **3 GiB additional temporary-footprint / 20 GiB remaining free-space** stop thresholds and monitor during long commands. Conservatively reserve the stopped attempt's approximately 0.31 GiB against the footprint budget. This is monitoring, not a hard quota; do not delete prior roots to make room.
6. Stop for another material advisory, unexpected resolution change, integrity/provenance/rights concern, unreviewed native/hook requirement, needed broader exception or resource threshold. No automatic audit fix, blanket lifecycle approval, alternate framework/chart engine or dependency patch.

## Continuing exclusions

No repository application scaffolding/production locks, global tooling changes, real data/secrets, reference edits, browser/device tests, provider calls, cloud resources, supplier outreach, purchase, deployment or license workaround. Existing attribution/distribution gaps remain open; this local experiment is not release/legal/security certification. ApexCharts remains held. Production override/peer policy, final versions and M00-T14 scaffold go/no-go require separate decisions; M00-T04 remains unchecked.

## Recorded outcome

The [retry report and immutable evidence](../toolchain-multer-retry.md) record the only dependency delta, verified fixed-package bytes, 603 exact metadata records, 508 installed identities and zero-known-advisory audit results. Ten Multer regressions, four peer controls, 668 focused lint expectations, 16 clean files, combined API/Next builds/types/HTTP and frozen lock equality passed. Initial transport/install/helper failures remain documented. A separately copied, content-address-verified prior package cache supported the bounded frozen resume; no old workspace, lock or successful result was inherited. All eight earlier snapshots and the stopped lock remained unchanged; no production approval follows.
