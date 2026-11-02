# Decision 0032 — Exact minimatch tooling override adoption

- **Status:** Exact conditional local tooling adoption now verified by [Decision 0034](0034-tooling-harness-revalidation.md); original blocked checkpoint/failures retained below
- **Owner / accountable maintainer:** Project owner; no delegate named
- **Authorization / review:** 2026-11-01 UTC, after `d705516`
- **Next review due:** **2026-11-23 UTC at the latest**, or earlier affected change/adoption/release trigger; no automatic renewal
- **Tasks:** Preparatory M00-T04; full task unchecked; seven tasks checked, full M02 Planned
- **Evidence prerequisite:** [Decision 0031 / E1](0031-local-minimatch-e1.md), [external validation and retained failures](../minimatch-e1-validation.md)
- **Result / blocker:** [Actual repository tooling adoption](../minimatch-tooling-adoption.md)

## Explicit owner answer

The assistant asked **“May I adopt only the three exact tooling overrides and rerun repository checks, keeping auth integration paused?”** The owner replied **“continue”**. This authorizes this tooling-only adoption and necessary strict/script-denied resolution/install/repository validation, plus one ordinary scoped commit/push. It does not authorize auth/Prisma dependencies, application source/configuration changes, resumed I1-B2–B6, DB/engine/generation/cloud/native/Flutter execution or a release baseline. Five integration tasks stay 0/5.

## C — Three exact parent-scoped dependency overrides

Preserve Decision 0010 policy B unchanged. Add only:

```yaml
overrides:
  'eslint@10.13.0>minimatch': 11.0.3
  '@eslint/config-array@0.23.5>minimatch': 11.0.3
  '@typescript-eslint/typescript-estree@8.72.0>minimatch': 11.0.3
```

C is three dependency overrides, **not peer allowances**, a blanket minimatch override or acceptance of all 11.x combinations. Require helper **@isaacs/nonrecursive-glob-match 1.0.3** and the E1 repository-equivalent 201-identity graph; investigate/stop on unrelated deltas or a different helper rather than silently widening scope. Parent declarations still exclude 11.x; the owner accepts maintenance of the bounded tested combination for current local tooling, not an upstream support promise. Policy A remains absent without Next.

## Maintenance and validation controls

- Owner accountability; record review date/evidence/disposition before every affected dependency/parser/lint/ignore/configuration change and before release, at most 30 days apart. Use the earlier **2026-11-23 UTC** deadline here; this does **not** renew or broaden Decision 0010 A/B.
- Strict peers/engines, automatic peers off, lifecycle scripts denied, `verifyDepsBeforeRun:error`, exact existing Node/pnpm/TypeScript/parent pins. No engine/peer/advisory/checksum/TLS/rule/assertion/timeout waiver, vendor patch/private import, new selector or automatic parent update.
- Fresh actual graph/advisory/deprecation/engine/peer/archive/integrity/notice review before execution; frozen installs/repeats and actual installed-byte checks. Preserve E1's major-API/behavior limitations and initial failures. Check current effective rule options, actual included/ignored-file discovery and type-aware diagnostics, matching and relevant unchanged unit/build/API checks; retain assertion-specific negative controls. Failed runs stay failures.
- Safe removal is independent per selector: separately review/approve an upstream parent change that resolves a nonaffected supported minimatch **without that selector**, then pass graph/security/notice/discovery/lint/regression checks without it. Do not simply delete an override to restore 10.2.6. Stop new affected use/promotion on an overdue review or fresh blocker; never auto-downgrade or suppress findings.
- Preserve historical reports/13 snapshots, private .env bytes/untracked status, unrelated services/caches and application/S0 source. Only `pnpm-workspace.yaml`, the pnpm-generated lock and affected documentation are intended tracked changes. Root/API manifests and ESLint/parser/source remain unchanged.
- New evidence/supplementary probes use C: with **<3 GiB additional /≥20 GiB free**; the explicitly authorized actual repository install/build necessarily uses its existing D: node_modules/dist and existing D: store, with ample space and no prune of unrelated caches. No owner .env is loaded into probes. Use the already installed pinned 12.8.1 binary and disable Corepack network to avoid repeating E1's unintended launcher fetch.

## Recorded outcome — original incomplete checkpoint

The generated actual 201-identity lock exactly matches E1. Fresh actual-graph metadata/advisory/archive/notice review, frozen/script-denied install/repeat and exact installed-byte inventories pass. Actual unchanged pnpm check/build pass twice (176 existing entries per check). However, the supplemental public ESLint API probe crashes inside TypeScript 6.0.3 under no-misused-promises/no-unsafe-assignment. A diagnostic trace and reordered probe do not resolve it; root cause is not established and the new expected-red/repeated final API stages are not reached. Preserve these as failed attempts, not passes. No rule, pin, assertion, timeout or vendor change is used to hide the error.

Stop further affected adoption/promotion and auth execution; retain the exact installed implementation rather than automatically restoring vulnerable 10.2.6. This is not an unqualified adoption/verification pass or a new risk waiver. Next needs bounded API-crash diagnosis, with no further dependency/policy/application changes unless separately approved.

## Subsequent completion of local tooling validation

After the separately authorized diagnosis, the owner's next continuation is [Decision 0034](0034-tooling-harness-revalidation.md). Its [corrected external-worker revalidation](../tooling-harness-revalidation.md) completes repeated positive/full-project/expected-red/restored checks, fresh actual-graph security/integrity/notices and unchanged normal repository CLI/frozen verification. The worker mode changes only in new external child processes, not the repository parser/rules/environment. The specific local tooling validation stop closes; cold-cache and known API child-start failures remain, including the unchanged successful retry. This is not a compiler-wide fix, production/support/legal waiver, new override acceptance/renewal, full M00/M01/M02 closure or permission to resume auth. Exact scope/owner controls/November 23 latest deadline remain.

## Completion boundary

A passing actual-repository result removes this specific repository tooling blocker only. It does not patch preserved external integration fixtures, resume the five auth tasks, adopt the combined graph or establish production/native/CI/privacy/operational/notice acceptance. Full M00-T04 and full M02 remain unchecked/Planned respectively. Any external integration continuation needs separately scoped authorization and fresh prerequisites.
