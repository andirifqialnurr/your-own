# Decision 0010 — Conditional Dependency Exception Policies

- **Status:** Policies A and B accepted conditionally; **no baseline adoption, final pins or new execution approved**
- **Task:** [M00-T04](../../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), **In progress / unchecked**
- **Approved by / accountable maintainer:** Project owner (user in this conversation); no delegate named
- **Approval / initial policy review:** 2026-10-24 UTC
- **Next policy review due:** **2026-11-23 UTC at the latest**, or an earlier adoption/change/release trigger below
- **Recorded by:** Coding agent, not the approver
- **Proposal:** [Adoption decision packet](../toolchain-adoption-review.md#1-decision-requested-not-inferred), including all eight shared maintenance controls
- **Supporting evidence:** [Lint experiment](../toolchain-lint-probe.md), [stopped combined attempt](../toolchain-combined-probe.md), [separate Multer retry](../toolchain-multer-retry.md), [saved-evidence adoption review](../evidence/m00-t04-adoption-review.json)

## Approval evidence and limits

After the static adoption review, the owner was asked:

> Approve both conditional policies?
> - **A:** The three exact tested ESLint peer allowances.
> - **B:** Only `@nestjs/platform-express@12.2.0>multer → 2.5.0`.
>
> Both require project-owner accountability, review at least every 30 days, revalidation and safe removal criteria. **No final pins, new installs, deployment or scaffolding are approved by this choice.**

The owner replied:

> lanjut

“Lanjut” means “continue.” Here it directly answers the explicit A/B approval question, unlike the earlier continuation after retry results that authorized static review only. **Both policies and their shared controls are accepted**, making only the exact exceptions below eligible for a later, separately approved baseline. This does not adopt that baseline or authorize a production lockfile, installation, candidate execution, distribution, deployment, scaffolding or task-order change.

Decisions [0007](0007-isolated-lint-probe.md), [0008](0008-isolated-combined-js-probe.md) and [0009](0009-isolated-multer-override-retry.md) retain their original experiment-only scope. This is a separate prospective policy decision, not retrospective production approval of any experiment.

## A — Exact lint peer allowances

```yaml
peerDependencyRules:
  allowedVersions:
    "eslint-plugin-react@7.37.5>eslint": "10.13.0"
    "eslint-plugin-import@2.32.0>eslint": "10.13.0"
    "eslint-plugin-jsx-a11y@6.10.2>eslint": "10.13.0"
```

Only these three literal parent/version/peer selections are eligible. The inspected published peer declarations still exclude ESLint 10; passing scoped tests does not create upstream support. The project accepts responsibility for maintaining compatibility evidence while retaining the original Next/React/Hooks/import/accessibility implementations and options. Each allowance is reviewed and removable independently.

## B — Exact parent-scoped Multer override

```yaml
overrides:
  "@nestjs/platform-express@12.2.0>multer": "2.5.0"
```

This is one **dependency override**, not a fourth peer allowance, a bare/global Multer selector, upstream Nest support or a security-advisory waiver. Prefer a separately reviewed upstream-fixed adapter if available at baseline selection. The stopped graph's Multer 2.4.0 finding remains valid; the separate patched experiment does not clean that historical graph.

These snippets are decision text, **not repository configuration**. Node 24.22.1, pnpm 12.15.0, TypeScript 6.0.3, Next 16.4.2 and React 19.3.1 identify the supporting experimental cohort, not approved production pins. The 31-input experimental roster is not a manifest to copy into M01.

## Accepted maintenance controls

The eight controls proposed in the adoption packet apply to **both A and B**:

1. **Accountability:** the project owner maintains and approves each policy unless explicitly delegating. Agents may investigate and record, not approve renewals, selectors, risk acceptance or release. No monitoring service, reminder or automatic renewal has been configured.
2. **Review deadline:** review at least every **30 calendar days**, before first baseline adoption, before any affected dependency/configuration change and before release promotion—whichever comes first. The initial policy review is **2026-10-24 UTC** and the next calendar deadline is **2026-11-23 UTC**. Record subsequent reviewer, date, evidence, disposition and next deadline. Without a current review, pause new adoption/promotion and seek renewal; do not automatically alter deployments or downgrade to an affected version. This initial policy review is **not a fresh technical/advisory check** or clearance to use the exceptions for 30 days without the earlier-trigger checks.
3. **Fail closed on scope:** strict peers stay enabled, automatic peers disabled and lifecycle scripts denied by default. No wildcard, `allowAny`, ignored missing peer, `--force`, extra override, audit suppression, vendor patch or rule waiver. Native hooks require their own reviewed/approved scope. Changed selector versions or broader exceptions require a new explicit decision.
4. **Revalidate before use/change:** record exact tools, direct manifests, both lock documents, transitive delta, availability/retraction/deprecation, engines/peers, notices/native/scripts and current advisories. Related Node/TypeScript/Next/React/plugin/resolver/adapter/Multer changes invalidate old compatibility evidence until reviewed/retested. Unrelated changes still require graph/security/notice review. A green build or historical audit cannot waive a material finding or unverifiable integrity.
5. **A regression floor:** preserve original effective rule implementations/options, all 668 focused expectations, four applicable negative peer controls, actual clean app files and strict compilation. Recheck React discovery, aliases, app/client boundaries and relevant native resolver identity. Add product/browser checks where needed. Upstream rule changes require explicit coverage disposition, not deletion of failing checks; diagnostic counts are not exhaustive product coverage.
6. **B regression floor:** verify the exact parent edge, absence of unintended affected Multer instances, patched archive/installed bytes and notices. Rerun the ten synthetic regression areas, including teardown, normal upload, exact/over-limit fields and failed/successful-storage cleanup controls, plus actual API integration/build checks. A real upload feature additionally needs its actual Nest interceptor/filter/storage/error/endpoint-limit tests. No process-level error swallowing or custom vendor fix.
7. **Safe removal:** remove an A allowance only after the selected upstream plugin accepts the selected ESLint and resolution/configuration/behavior pass without it. Remove B only after a separately reviewed and approved adapter update resolves a nonaffected Multer without the override and relevant checks pass. Never merely delete B to restore 2.4.0. Track remaining exceptions independently; no automatic upgrade or expiry-driven downgrade.
8. **Promotion evidence:** retain exact changes/hashes, raw failures/results, notice disposition, reviewer/date and review/removal triggers with each future dependency decision. Build/lint checks remain separate; frozen installs are not security/legal clearance. Final pins, applicable M00 gates, M00-T14 and environment-specific release authorization remain separate approvals.

## Remaining gates and next action

Both policies are accepted, but **neither is applied to a production baseline**. Complete the [remaining gates](../toolchain-adoption-review.md#5-finite-remaining-gates-and-handoff): original-attribution and embedded/native/WASM/font/actual-delivery obligations; target-dependent compatibility/bootstrap; omitted application-library choices; full icon coverage and ApexCharts entitlement. Owner approval cannot grant third-party rights. No outreach, business disclosure, spending, alternate stack, EOL fallback or rule removal is authorized.

**M00-T04 stays unchecked.** No M00-T05/M01 advance or M00-T14 go/no-go follows. If target decisions must precede final pins, request a separate, bounded M00-T05 review/order adjustment while preserving T04 blockers; do not silently reorder tasks or repeat the successful combined experiment.

## Recording and evidence preservation

This approval-recording pass changes documentation only. It does not refresh metadata/advisories, rerun candidate tools or application tests, install dependencies, contact suppliers or modify reference apps/global tooling. All ten existing evidence snapshots remain historical and immutable; the adoption snapshot correctly still says the policies were proposed at its capture time.

The captured adoption validator contains an assertion that Decision 0010 does not exist. That assertion describes its pre-approval checkpoint, not the current repository. Do not edit the captured helper or evidence to manufacture a current pass. Current documentation, policy-scope/date and snapshot-preservation checks are recorded in the [M00 task log](../../milestones/00-decisions-and-validation.md#task-log); they are not renewed compatibility, security or legal certification.
