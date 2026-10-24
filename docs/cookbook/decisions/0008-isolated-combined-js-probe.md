# Decision 0008 — Isolated Combined JS and Launcher Probe

- **Status:** Authorized attempt stopped at its security gate; no changed-scope retry approved by this decision. Decision 0009 separately authorizes that retry; production policy/final pins remain unapproved
- **Task:** [M00-T04](../../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), In progress / unchecked
- **Approved by:** Project owner (user in this conversation)
- **Approval recorded:** 2026-10-24 UTC
- **Recorded by:** Coding agent, not the approver
- **Scope:** [Combined graph and launcher plan](../toolchain-notice-trace.md#5-proposed-combined-js-graph-and-launcher-check--not-authorized)

## Approval evidence

After the static notice trace, the owner was asked:

> **Authorize a new isolated combined JS install/build/lint test using the same three exact temporary peer exceptions?** Proposed storage stop threshold: 3 GiB. No global changes, production adoption or repository scaffolding; ApexCharts stays held.

The owner replied:

> continue

This directly answers the new, bounded execution question. It does not retroactively turn the earlier static research into execution permission or extend Decision 0007 automatically. This decision separately permits the same three exceptions in one new combined experiment, not in production.

## Authorized scope and gates

Use **`C:/Users/HP/AppData/Local/Temp/ycp-1in0web7/`**, preserving all earlier roots and seven snapshots. Initial free space: approximately **29.29 GiB**. HEAD: `b9cb618ff5d5c324f9c8d78813f59f417ce5d0b5`; prior documentation/evidence changes were already modified/untracked and must be preserved.

1. Recheck existing Node **24.22.1** and pnpm **12.15.0** archive integrity and executable-member bytes before reuse. Check explicit launcher identities/versions and a wrong-hash negative control. No new SDK/tool download, global/Corepack bootstrap, global PATH/configuration change or shared-store write.
2. Reconcile the **exact direct candidates already executed** in the original JS and lint probes into one fresh external workspace: root plus synthetic API/web/admin importers. Do not mechanically combine their locks. No new direct tool, test framework, provider, database, chart, mobile run or production feature.
3. Keep strict peers enabled, automatic peer installation/lifecycle scripts disabled and integrity checking enabled. Only these allowances are permitted:

```yaml
peerDependencyRules:
  allowedVersions:
    "eslint-plugin-react@7.37.5>eslint": "10.13.0"
    "eslint-plugin-import@2.32.0>eslint": "10.13.0"
    "eslint-plugin-jsx-a11y@6.10.2>eslint": "10.13.0"
```

4. Re-run bounded peer negative controls. Review both lock documents and every resolved identity/delta, scripts, notices, engines/peers and current advisory evidence **before application-package execution**. Scarf/UnRS postinstall stay disabled. Do not use overrides, wildcard exceptions, ignored missing peers, force, vendor patches or dropped rules.
5. Stop for unavailable/retracted inputs, integrity/provenance discrepancies, material new security/rights concerns, incompatible constraints, new/unreviewed native artifacts or hooks, or any need to change candidates/exception selectors. Review/report the blocker rather than silently substituting or expanding scope.
6. Only after those gates, frozen-install and run bounded API strict compilation/OpenAPI/exact-string loopback checks; separate Next builds/HTTP checks; original effective lint configuration, 668 focused diagnostic expectations and full-config clean/strict-type checks in the same graph. Preserve failures; Next builds alone do not prove lint passed.
7. Monitor the new temporary footprint and volume free space between phases and during long commands. Stop at **3 GiB additional footprint** or **20 GiB remaining free space**; these monitored thresholds are not a filesystem quota. Do not delete earlier evidence to make room. Use timeouts and owned process-tree teardown; servers are loopback-only with synthetic data.
8. Repeat frozen checks, verify unchanged locks and prior evidence, stop owned processes/ports and record an immutable outcome. The owner authorizes the attempt, not success.

## Excluded and continuing gates

No repository applications/production locks, global tools/configuration changes, reference edits, secrets/real personal data, cloud provisioning, browser/device execution, provider calls, purchases, outreach, deployment or license workaround. Process-environment isolation is not an OS sandbox. The local launcher check is not fresh-host, macOS/Linux/CI or offline-bootstrap certification.

Existing root/embedded/native/font attribution and notice-delivery gaps remain explicit. Technical experiment authorization is not legal clearance or release-distribution approval. Production exceptions and exact final pins require separate decisions. ApexCharts remains held, with no substitute engine, supplier contact, business disclosure or spend. M00-T04 remains unchecked; applicable M00 work and **M00-T14 scaffold go/no-go** still precede M01.

## Recorded outcome

The [combined report](../toolchain-combined-probe.md) records verified tool reuse/launcher checks and fresh lock-only resolution, followed by audit exit 1 for high-severity GHSA-q7qp-rjg7-q26m in the adapter's exact Multer 2.4.0 dependency. Application installation, builds, lint and servers did not run. The subsequent “continue” led only to static advisory/fix review. At that point Multer 2.5.0 was a reviewed candidate, not an installed or approved override; changing the edge required separate explicit authorization. No unrun test was counted as passed. The owner subsequently answered the explicit override-retry question in [Decision 0009](0009-isolated-multer-override-retry.md). Its [separate passing experiment](../toolchain-multer-retry.md) does not erase this original stop, broaden this decision or approve production adoption.
