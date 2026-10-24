# Toolchain Adoption — Conditional Policies and Remaining Gates

- **Version:** 0.3
- **Reviewed:** 2026-10-24 UTC
- **Task:** [M00-T04](../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), **Blocked/open / unchecked**, paused for Decision 0011's bounded T05 review
- **Status:** Policies A/B and shared controls accepted in [Decision 0010](decisions/0010-conditional-dependency-exceptions.md); **no baseline, final pins or new execution approved**
- **Evidence:** [Combined retry](toolchain-multer-retry.md), [notice register](toolchain-notices.md), [attribution trace](toolchain-notice-trace.md), [static derivation](evidence/m00-t04-adoption-review.json)

## 1. Decision requested, not inferred

The earlier **“continue”** after the retry results authorized only this bounded static review. After the resulting explicit A/B approval question, the owner replied **“lanjut”**. [Decision 0010](decisions/0010-conditional-dependency-exceptions.md) records the separate **2026-10-24 UTC** acceptance of both policies and all shared controls; the original review/evidence remains historical.

**Accepted conditionally:** the exact exceptions below are eligible for a later separately approved baseline. This does **not approve that baseline, a production lockfile, new execution, installation, distribution, deployment or scaffolding**. Each entry remains temporary and independently removable; no exception has been applied to a production baseline.

| Choice | Accepted conditional policy | Rationale / cost |
|---|---|---|
| **A — Lint peer allowances** | Permit only the three exact plugin-to-ESLint allowances below in a future explicitly approved JS baseline | Keeps Next's original React/Next/Hooks/import/accessibility implementations. Separate and combined checks passed. Published plugin peers still reject ESLint 10, so this transfers compatibility-maintenance responsibility to the project; it is not upstream support |
| **B — Multer dependency override** | Permit only the exact Nest-parent override below as a temporary remediation in a future explicitly approved API baseline; prefer a reviewed upstream-fixed adapter if available at selection time | Avoids the known affected 2.4.0 dependency. Archive/source/installed-byte checks and ten regressions passed, but the adapter itself still declares the old exact dependency in the inspected metadata. This is runtime dependency substitution, **not** another lint allowance or an advisory waiver |

**A — exact three allowances:**

```yaml
peerDependencyRules:
  allowedVersions:
    "eslint-plugin-react@7.37.5>eslint": "10.13.0"
    "eslint-plugin-import@2.32.0>eslint": "10.13.0"
    "eslint-plugin-jsx-a11y@6.10.2>eslint": "10.13.0"
```

**B — exact single override:**

```yaml
overrides:
  "@nestjs/platform-express@12.2.0>multer": "2.5.0"
```

These snippets are decision/evidence text, not repository configuration. Approval applies only to these literal selectors/values, with the tested Node 24.22.1 / pnpm 12.15.0 / TypeScript 6.0.3 / Next 16.4.2 / React 19.3.1 cohort as supporting evidence—not permission to silently carry exceptions into a changed graph. The [31-direct-input roster](evidence/m00-t04-adoption-review.json) is an observed experimental roster, **not a manifest to copy into M01**. M01 initially targets API/mobile; web/admin scaffolding retains its separate roadmap prerequisites.

**Historical alternative offered:** decline either policy and wait for reviewed upstream declarations/dependencies. Both were subsequently accepted conditionally; future changes still require review and approval. Do not fall back to EOL ESLint 9, remove rules, switch chart/framework/adapter, or use affected Multer 2.4.0 merely to avoid an exception. Such alternatives would require their own review and approval.

## 2. What the evidence now supports

| Area | Bounded evidence | Still not established |
|---|---|---|
| JS composition | 31 exact direct inputs; two lock documents; 588 application snapshot entries; 508 installed identities; only Multer changed from the stopped graph | Complete product dependencies, final pins, all target platforms or a release SBOM |
| Lint | Four peer rejection controls; eight effective configs; 668 focused expectations; 248 accessibility-option assertions; 16 clean files; strict types | All rule behavior, browser accessibility or unrestricted compatibility with later versions |
| API remediation | Actual adapter resolves only Multer 2.5.0; ten synthetic regressions; Nest build/OpenAPI/exact-string HTTP | Real upload endpoints, production limits/storage, full `FileInterceptor` integration or incident readiness |
| Security | Two zero-known-advisory audit responses in the dated retry, after the real 2.4.0 audit stop | A fresh audit in this review, absence of unknown vulnerabilities or security clearance through an LTS end date |
| Mobile | Flutter 3.47.7 / Dart 3.13.5 and build_runner 2.16.2 host probe, generation and six tests | Encrypted driver/keys, native targets, actual migrations/device lifecycle or final mobile pins |
| Bootstrap | Verified explicit local Windows tool paths and integrity checks; frozen offline repeat | Clean-host/offline bootstrap, Linux/macOS/CI or reproducible target release artifacts |

The original static review read saved evidence only; recording the later policy approval did not refresh technical evidence. No registry tag, support schedule, issue or advisory was refreshed; no package or candidate tool was executed. In particular, it does not claim that an upstream-fixed adapter is still unavailable now. Fresh exact metadata and advisories are a prerequisite to later selection/use. Existing [support/bootstrap findings](toolchain-notices.md#4-support-and-bootstrap-recommendation) remain dated observations.

## 3. Shared maintenance controls — accepted conditionally

[Decision 0010](decisions/0010-conditional-dependency-exceptions.md) accepts all eight conditions for **both A and B**:

1. **Accountability:** the **project owner** is the accountable maintainer/approver unless they explicitly name a delegate. Agents may gather evidence and propose changes; they cannot approve renewal, new selectors, risk acceptance or release on the owner's behalf. No monitoring service or notification automation is currently running.
2. **Time limit:** review at least every **30 calendar days**, before first baseline adoption, before each affected dependency/configuration change and before release promotion—whichever comes first. Approval/initial policy review is **2026-10-24 UTC**; next review is due **2026-11-23 UTC at the latest**, or an earlier adoption/change/release trigger. Record subsequent review/next-due dates explicitly, not retroactively from an experiment. This policy review does not refresh advisories or authorize use before technical revalidation. Without a current review, pause new baseline adoption/promotion and seek renewal. Do not automatically alter running deployments or revert to a known affected version.
3. **Fail closed on scope:** keep strict peers enabled, automatic peer installation disabled and lifecycle scripts denied by default. No wildcard, `allowAny`, ignored missing peer, `--force`, extra override, audit suppression, vendor patch or rule waiver. A necessary native hook needs its own reviewed scope; this policy does not authorize one. Broader selectors or changed selector versions require a new explicit decision.
4. **Revalidation:** record exact tools, direct manifests, both lock documents, transitive delta, availability/retraction/deprecation, engines/peers, notices/native/script changes and current advisories. Related Node, TypeScript, Next, React, plugin, resolver, adapter or Multer changes invalidate the old compatibility evidence until reviewed/retested. Unrelated dependency changes still need graph/security/notice review. No material finding or unverifiable integrity can be waived by a green build or a past audit.
5. **A's regression floor:** preserve the original effective rule implementations/options and the 668 focused expectations, four applicable negative peer controls, actual clean app files and strict compilation. Recheck React detection, aliases, app/client boundaries and relevant native resolver identity. Add product/browser tests where needed; the fixture count is not exhaustive coverage. A future upstream rule change requires an explicit coverage disposition, not mechanical deletion of failing assertions.
6. **B's regression floor:** prove the exact parent edge and absence of unintended affected Multer instances in the new graph; verify patched archive/installed bytes and notices; rerun teardown, normal upload, exact/over-limit field and failed-storage cleanup cases plus actual API integration/build checks. Before a real upload feature ships, test its real Nest interceptor/filter/storage/error handling and endpoint limits with synthetic fixtures. No process-level error swallowing or custom vendor fix.
7. **Safe removal:** remove an A allowance only when the selected upstream plugin accepts the selected ESLint version and resolution/configuration/behavior pass without it. Remove B only after a separately reviewed, approved adapter update resolves a nonaffected Multer version without the override and relevant checks pass. Do not simply delete B and restore the affected 2.4.0 edge. Track and review remaining exceptions independently; no automatic upgrade or expiry-driven downgrade.
8. **Promotion evidence:** attach changes, exact hashes, raw pass/failure outputs, notice disposition, review owner/date and removal/review trigger to the future dependency decision/update. Keep build/lint tests separate; frozen installs are not security/legal review. Final pin approval, applicable M00 prerequisites, M00-T14 and environment-specific release authorization remain mandatory.

Both policies and the schedule above are accepted, with the project owner accountable and **no delegate named**. Actual baseline adoption remains unapproved. Neither policy grants upstream rights or waives the notice/entitlement gates; no background monitoring or automatic renewal is configured.

## 4. Notice work is now scoped by saved dependency paths

The static derivation follows **1,229 dependency/optional edges** across the captured **588 application snapshots**, including resolved peers and non-host platform entries. It finds seven nonempty importer dependency groups. These are **lock reachability**, not runtime loading, installed-platform counts, browser bundles or deployment pruning; group closures overlap and must not be added as a package total.

Among the same **16 installed roots lacking a standalone notice**, the paths partition as follows:

| Captured importer reachability | Cases | Next review responsibility |
|---|---|---|
| Root `devDependencies` only | **12:** `@humanfs/types`, `@next/eslint-plugin-next`, `@types/json5`, UnRS resolver/binding, `eslint-config-next`, `esrecurse`, `imurmurhash`, `language-subtag-registry`, `language-tags`, `natural-compare`, `stable-hash` | Tooling/CI/cache distribution review. Development classification is **not** an exemption or proof these files are excluded from delivered artifacts |
| Web and admin `dependencies` | **3:** `@next/env`, Windows SWC binding, `client-only` | Next runtime/build/browser-output mapping as applicable; an optional Windows binary path does not establish its presence in a Linux deployment |
| API `dependencies` | **1:** `@tokenizer/token` | Preserve the already located README notice along the `@nestjs/common → file-type → strtok3` path; inspect actual API delivery |

In particular:

- `stable-hash 0.0.5` is reached through root tooling: `eslint-config-next 16.4.2 → eslint-import-resolver-typescript 3.10.1 → stable-hash`. Its original notice remains partial; do not substitute another resolver/version or invent attribution.
- `client-only 0.0.1` is transitively reachable through `next 16.4.2 → styled-jsx 5.1.6 → client-only 0.0.1` in **both** app dependency groups. Its original-attribution gap is not merely a lint concern. This corrects the earlier prose's “directly” wording; the immutable witness paths already include `styled-jsx` and are unchanged.
- Embedded `server-only`, Edge/aggregate code, fonts and WASM are not fully described by external-package edges. Lack of a separate lock node does not establish absence from Next's files/output.

The [16-root dispositions](toolchain-notices.md#2-notice-dispositions) remain **14 scoped mappings / two partial**, not 14 complete package clearances. Existing upstream requests for `client-only` and `stable-hash` remain the identified clarification path; do not repeat blind filename searches or post duplicates. Qualified review or narrowly authorized clarification may be needed; owner approval alone cannot grant missing rights.

## 5. Finite remaining gates and handoff

| Gate | Next concrete evidence / decision | Boundary |
|---|---|---|
| **Policy A/B** | Accepted conditionally in [Decision 0010](decisions/0010-conditional-dependency-exceptions.md); owner review due no later than 2026-11-23 UTC, or before adoption/change/release if earlier | No baseline adoption, final pins, new execution or scaffolding approved; fresh technical checks still required |
| **Notice/rights readiness** | Resolve root/embedded marker attribution, Unistore's broken linked terms, aggregate/native/WASM/font coverage, Hugeicons export notices; retain original terms/attribution and assess actual delivery obligations | No supplier message, spend, fabricated notice, broad risk waiver or package removal authorized |
| **Target-dependent pins/bootstrap** | Use approved OS/browser/native/deployment targets to confirm SDK/runtime/library compatibility and tool acquisition; retain exact hashes and clean-checkout evidence | M00-T05/T06 supply target/provider decisions. This review does not select them or authorize another bootstrap |
| **Incomplete application library selection** | Review actual needs for API validation, test/component runners, generated clients, accessible primitives, session/provider adapters and encrypted/native mobile integrations | The probe omits these concerns; Jest/Vitest/Playwright, Prisma, providers and native drivers are not selected by passing Node assertions |
| **Icons and charts** | Finish semantic/implicit-icon and asset/notice review; establish applicable ApexCharts entitlement before permitted client-only/native/design proof | Hugeicons Free Stroke Rounded remains selected; ApexCharts stays held. No replacement, outreach, disclosure, purchase or install |
| **Artifacts and release evidence** | When authorized artifacts exist, use the [delivery map](toolchain-notice-trace.md#4-distribution-mapping-still-required) for separate browser, runtime, tooling, mobile and poster inventories and notice delivery | Do not invent an SBOM now or demand unavailable release outputs as proof already obtained; unresolved rights are not silently deferred |
| **Task order and scaffold** | [Decision 0011](decisions/0011-supported-environment-review-order.md) now permits early M00-T05 [target review](supported-environments-review.md); T04 remains open/unchecked and paused with blockers retained | Review only, not target acceptance or execution. Do not mark T04 verified or weaken M00-T14. M01 still awaits applicable M00 decisions and scaffold go/no-go |

The existing combined experiment is sufficient for the **bounded compatibility question it tested**; repeating it unchanged is not the next task. Maintain the accepted policies and complete the missing evidence instead. Any approved deferral/order adjustment must identify affected tasks and retain blocking gates, not erase requirements.

## 6. Evidence and verification

The [static review evidence](evidence/m00-t04-adoption-review.json) contains **seven files / 36,531 bytes**, SHA-256 **`4c6070b6fe27d108c53baf242ebe9cbd83cddd1f0dec0966f09b727a84090919`**. It retains source-snapshot identities, original/normalized source hashes, the 31-version roster, all 16 witnessed paths, derivation/validator code and the nine earlier snapshot hashes. Its paths/counters are recomputed from saved JSON, not from a new resolution or package execution. Previously modified/untracked documentation and the completed retry snapshot were preserved.

Historical checks for the original pre-approval static pass:

```text
python C:/Users/HP/AppData/Local/Temp/your-own-adoption-review-5qmw8kxn/validate.py
python C:/Users/HP/AppData/Local/Temp/your-own-toolchain-review-so4nyten/validate_review.py
git -c core.safecrlf=false diff --check
```

The static validator and documentation checks passed: **56 Markdown files / 892 local links and anchors / four JSON examples**, tables/fences/whitespace, 67 preserved requirement IDs and all 224 tasks/prerequisites. Only M00-T01/T02/T03 remain checked; `git -c core.safecrlf=false diff --check` passed. Ordinary Node's version and Git state reads confirmed Node 24.18.0, clean Flutter 3.38.9 and unchanged reference HEAD/status counts.

No network research, candidate runtime, install, global change, reference edit, supplier contact, approval, milestone completion or scaffold was performed **in that original static pass**. The last executable results remain those in the separately authorized retry, with their original dates and limitations.

The later approval is recorded only in Decision 0010 and current documentation; the seven-file snapshot and nine preceding snapshots are unchanged. Its captured validator asserts that Decision 0010 does not exist, so that pre-approval checkpoint is no longer a current-state validator. Do not modify the historical helper/snapshot to remove the assertion. The [M00 task log](../milestones/00-decisions-and-validation.md#task-log) records separate current policy/documentation and ten-snapshot preservation checks; no new candidate execution or advisory refresh accompanies acceptance.
