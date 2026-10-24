# Decision 0006 — Mobile Probe Generator Retry

- **Status:** Authorized experiment revision; results and final pins not approved
- **Task:** [M00-T04](../../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), In progress / unchecked
- **Approved by:** Project owner (user in this conversation)
- **Approval recorded:** 2026-10-23 UTC
- **Recorded by:** Coding agent, not the approver
- **Refines:** [Decision 0005](0005-isolated-compatibility-probe.md) for the stopped mobile experiment only

## Approval evidence

The owner was asked:

> Authorize retrying the mobile probe with reviewed `build_runner 2.16.2`, under the same isolation limits?

The owner then asked whether actual app development had begun. The assistant clarified that these are disposable toolchain tests, not production app development; M01 still requires the remaining foundation gates and scaffold approval. The owner replied:

> okay continue

This authorizes the proposed mobile retry, not a change to that clarified implementation boundary.

## Bounded revision

Replace the retracted **build_runner 2.17.0** with **2.16.2** in a new temporary mobile sample under `C:/Users/HP/AppData/Local/Temp/yop-f3trxjn8/workspace/mobile-retry-2162/`. Preserve the failed sample and earlier evidence. Reuse the already verified isolated Flutter 3.47.7 / bundled Dart 3.13.5 and isolated caches; no global upgrade or repeat SDK download is needed.

Recheck availability/retractions and declared constraints, resolve the unchanged reviewed supporting-package candidates, inspect actual notices/native hooks, and attempt the previously proposed synthetic serialization/Drift-generation and host widget checks. No overrides, suppressed solver checks, encrypted-driver selection or unreviewed native download. Stop and record unexpected constraints or execution requirements rather than silently replacing other candidates.

All Decision 0005 exclusions remain: no repository app scaffolding, reference-app edits, private data, providers, chart engines, global tool changes, native-device claims, supplier contact, spending or deployment. ApexCharts stays held. Successful experiments do not approve final project pins or complete M00-T04/M00-T14.

The [probe report](../toolchain-probe.md#7-authorized-mobile-retry--build_runner-2162) and [milestone log](../../milestones/00-decisions-and-validation.md) record outcomes separately from this authorization: resolution, generation, analysis and six synthetic host tests passed after documented fixture/environment fixes. Device, encryption, full security/legal and final-pin gates remain open.
