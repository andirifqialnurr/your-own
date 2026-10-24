# Decision 0011 — Bring Forward Supported-Environment Review

- **Status:** Accepted task-order adjustment for bounded review only; target choices remain unapproved
- **Tasks:** [M00-T05](../../milestones/00-decisions-and-validation.md#m00-t05--supported-environment-review) opened for review, now Blocked / unchecked after the availability update; [M00-T04](../../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review) remains open/unchecked, paused with blockers retained
- **Approved by:** Project owner (user in this conversation)
- **Approval recorded:** 2026-10-24 UTC
- **Recorded by:** Coding agent, not the approver
- **Refines:** The default preceding-task prerequisite in the [task workflow](../../milestones/README.md#task-workflow-and-evidence), only to review M00-T05 before M00-T04 is complete

## Approval evidence

After recording Decision 0010, the owner was asked:

> Boleh mendahulukan review **M00-T05—target OS/browser dan kebutuhan macOS**, sambil mempertahankan blocker M00-T04?

This asks to bring forward the OS/browser/macOS review while preserving M00-T04 blockers. The preceding response explicitly excluded final versions, installation and scaffolding. The owner replied:

> continue

This authorizes the proposed **review/order adjustment**, not acceptance of target versions, device access, a test service or a final baseline.

## Scope and rationale

M00-T04's final compatibility/pin review needs supported platform targets. Requiring it to close before even reviewing M00-T05 would hide that dependency. Bring forward only M00-T05's read-only assessment and owner decision preparation:

- Review product/platform requirements and public platform/framework documentation; compare saved source/metadata where useful.
- Propose OS/browser coverage, representative Android phone/tablet and iPhone/iPad test lanes, macOS/Xcode access requirements, accessibility checks, performance measurement budgets and accountable test ownership.
- Ask for the owner's actual available devices/macOS path without credentials, serial numbers or personal data. Do not infer access from the current Windows checkout.
- Distinguish dependency minima, proposed product support, maintained/security-eligible environments, build SDK/target settings and store-submission rules. Published requirements are not native/browser verification.
- Preserve all earlier experiment roots, failures, locks, snapshots and existing working-tree changes. Any static research/helper files stay in a new external temporary root; no application configuration is created.

## Task disposition and continuing gates

**M00-T05 is the sole active task.** M00-T04 stays open/unchecked and paused with target-dependent compatibility, missing library choices, rights/notices, ApexCharts entitlement and final-pin/baseline gates retained. Its conditional exception policies and review deadline in [Decision 0010](0010-conditional-dependency-exceptions.md) are unchanged; this review does not renew them.

M00-T05 remains unchecked until its targets, coverage, macOS path, accessibility/performance requirements and test ownership have explicit approved answers. Permission to investigate is not acceptance of the resulting recommendations. A proposed environment without confirmed access is not a verified test environment.

No M00-T06 or M01 work, M00-T14 go/no-go, target/provider selection, package/SDK/browser/emulator installation, candidate-tool execution, native/browser/device tests, connected-device inspection, signing, certificates, supplier contact, purchases, cloud/CI provisioning, release or repository scaffolding is authorized. Existing iOS/iPad native and four-window-class requirements remain mandatory; Android-first changes release order, not required coverage.

## Follow-up

The [supported-environment review](../supported-environments-review.md) was prepared. The owner's later **“belum ada.”** reply on 2026-10-24 UTC reports no test devices or Mac access yet; the [availability record](../supported-environments-review.md#7-owner-availability-and-next-steps) blocks completion, not device-independent static planning. This fact does not amend the authorization or approve target choices, purchases, installations or a native-validation waiver. Feed approved target constraints back into M00-T04 for dependency validation; any incompatibility needs an explicit resolution rather than a silent minimum-version increase. Keep all later safety and release gates intact.

A subsequent explicit question separately requested the plan's narrow non-admin, no-network Windows host inventory; the owner replied **“continue”**. The [P0 authorization and result](../windows-emulator-validation-plan.md#7-authorized-p0-inventory--observed-facts-and-limits) record only that completed local metadata read. This is not SDK/emulator/browser execution, setup, connected-device inspection, target acceptance, a new task-order change or a renewal of Decision 0010. T05 remains Blocked / unchecked; its native access and evidence gates are unchanged.
