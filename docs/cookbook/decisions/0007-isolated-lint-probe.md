# Decision 0007 — Isolated Lint Probe with Exact Peer Exceptions

- **Status:** Authorized experiment with bounded results recorded; no production policy or final pins approved
- **Task:** [M00-T04](../../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), In progress / unchecked
- **Approved by:** Project owner (user in this conversation)
- **Approval recorded:** 2026-10-24 UTC
- **Recorded by:** Coding agent, not the approver
- **Scope source:** [Lint rule disposition and experiment B](../toolchain-lint-review.md#8-completed-static-disposition-and-owner-choice)
- **Refines:** [Decision 0005](0005-isolated-compatibility-probe.md)'s no-peer-exception boundary **for this new temporary lint experiment only**; other limits and earlier evidence remain intact

## Approval evidence

After the complete static React-rule disposition, the owner was told:

> Next documents ESLint 10 support, but three plugin peer declarations conflict. I recommend testing its unchanged configuration with **three exact, temporary peer exceptions**, preserving the rules. This requires changing our earlier no-exceptions boundary.
>
> **Authorize that isolated test?** No global changes or app scaffolding; ApexCharts stays held.

The owner replied:

> continue

This directly answers the explicit authorization question. It authorizes the bounded test and its disclosed exceptions, unlike the preceding instructions to continue read-only research. It does not select a production lint stack or authorize a general compatibility bypass.

## Authorized scope

- Use a new external temporary root, **`C:/Users/HP/AppData/Local/Temp/ylp-6fg7obur/`**, with isolated caches/config/home and synthetic data. Initial free space was approximately **27.77 GiB**. Preserve all earlier probes, snapshots, reference apps and existing repository edits. Repository HEAD at start: `aa76d1a4b8a3d7d5e5b7bd915b69b83bef752f15`; the working tree already contained the documented research/probe changes.
- Reuse and recheck the previously verified portable **Node 24.22.1** and **pnpm 12.15.0** through explicit paths. Do not use or update global Node/Corepack/SDKs or shared package stores.
- Resolve/install the exact candidates from experiment B: ESLint **10.13.0**, eslint-config-next / @next/eslint-plugin-next / Next **16.4.2**, @eslint/js **10.0.1**, typescript-eslint **8.72.0**, TypeScript **6.0.3**, React/DOM **19.3.1**, @types/node **24.19.2**, @types/react / @types/react-dom **19.3.0**, and original React/import/JSX accessibility/Hooks plugins **7.37.5 / 2.32.0 / 6.10.2 / 7.1.1**. These are experimental inputs, not approved production pins.
- Keep strict peers enabled, automatic peers disabled, lifecycle scripts disabled and integrity checks on. The only authorized `peerDependencyRules.allowedVersions` entries are:

```yaml
"eslint-plugin-react@7.37.5>eslint": "10.13.0"
"eslint-plugin-import@2.32.0>eslint": "10.13.0"
"eslint-plugin-jsx-a11y@6.10.2>eslint": "10.13.0"
```

- Prove the intended selector scope with synthetic negative controls and record the exceptions prominently. This is **not an unqualified strict-peer pass**. No wildcard peer allowance, `ignoreMissing`, `allowAny`, `--force`, blanket strict-peer disabling, vendor patch or dependency override.
- Inspect actual resolution, package identities/deprecation, scripts, notices, dated advisories and any native resolver binaries before candidate-code execution. Verify required native artifact bytes and review executable requirements. No blanket lifecycle approval. Stop on unexpected constraints, identities, integrity discrepancies or unreviewed requirements rather than silently substituting versions or expanding exceptions.
- Test Next's own configurations and unchanged rule implementations in separate synthetic web/admin compositions. Preserve the 17 React entries, 22 Next rules/Core Web Vitals upgrades, complete official Hooks recommended set, import checks and 31 enabled accessibility preset rules/options with Next's Image mapping. Review additional control-label/hidden-focus checks and explicit component mappings; do not count Next's six accessibility rules alone as complete coverage.
- Capture effective configs, run the 34 seed specimens plus deprecation/alias/edge cases and positive controls, inspect intended diagnostic IDs and fatal/ignored-file conditions, and separately lint/type-check clean samples. Preserve failures; do not suppress rules or replace them with a different engine to manufacture success. Keep actual manifests/lockfiles, frozen-install evidence, commands, notices, results and limitations.

## Excluded and stop conditions

No repository application scaffolding, final-pin adoption, global tools/PATH/config changes, reference edits, real user data, secrets, server/browser/device tests, cloud resources, providers, notifications, spend, supplier outreach, chart engines or deployment. ApexCharts remains held. No alternative React/plugin/linter stack is selected. No app implementation or milestone completion is implied.

If pnpm cannot enforce these exact exception boundaries, or resolution requires additional exceptions/changed candidates, stop that lane and report the blocker. Candidate lint crashes or coverage gaps remain failures, not permission to patch dependencies or weaken rules. Any retry beyond this scope requires its own reviewed authorization.

The owner authorizes the experiment, not its success. Results remain evidence for a separate final-pin/policy decision, and M00-T04 stays unchecked while required compatibility, notices/entitlements and other gates remain open.

## Recorded outcome

The [separate execution report](../toolchain-lint-probe.md) records the exact exception-based install, four rejecting peer controls, eight effective configurations, 668 focused diagnostic executions and both synthetic apps' clean lint/strict type checks. It retains own-helper/fixture corrections, native/notice review, frozen-lock evidence and limitations. The original rule implementations were preserved. Passing these bounded checks does not approve production peer exceptions, final pins, chart integration or repository scaffolding.
