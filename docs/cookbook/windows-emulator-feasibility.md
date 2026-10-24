# Windows Emulator Feasibility — P1 Static Review

- **Version:** 0.1
- **Reviewed:** 2026-10-24 UTC
- **Task:** [M00-T05](../milestones/00-decisions-and-validation.md#m00-t05--supported-environment-review), **Blocked / unchecked**
- **Result:** **P1 reviewed — HOLD setup.** Hardware/acceleration evidence, exact native-tool compatibility and an accepted resource allocation remain incomplete.
- **Authority:** [Decision 0011](decisions/0011-supported-environment-review-order.md); the owner's latest “continue” follows the offer of official-requirements/resource review, not installation or further machine inspection.
- **Inputs:** [Saved P0 facts](windows-emulator-validation-plan.md#7-authorized-p0-inventory--observed-facts-and-limits), eight public official text sources, previously saved pinned Flutter source.
- **Evidence:** [Separate static snapshot](evidence/m00-t05-emulator-feasibility.json)

> Later owner direction: [Decision 0012](decisions/0012-local-development-bootstrap.md) starts local API/mobile coding using installed tools rather than continuing this inventory. This report's setup hold applies to the proposed emulator environment, not ordinary repository scaffolding. No emulator readiness or resource-budget acceptance is inferred.

## 1. Boundary and outcome

This pass made **eight public text requests**, all successful. It did **not** repeat P0, inspect Windows features/GPU memory, download SDK/package binaries, accept licenses, execute a browser/SDK/emulator, change settings or allocate a test environment. No host metadata or project files were sent to the sources. The earlier non-admin P0 permission is not a reusable permission for more machine queries.

The host is **not shown to be unusable**, but there is insufficient evidence to approve setup. The saved Windows build matches Microsoft's published release table; installed RAM meets the published capacity tier and the CPU generation is above the stated floor. **WHPX availability, the GPU requirement and workload storage remain open.** Do not infer that new equipment is necessary, disable protections, or install first to discover the answer.

P2/P3, all eight WIN cases, physical Android/iOS/iPad/Safari proof and M00-T14 remain gated. Android-first does not remove any platform. M00-T04 remains paused/open; this review feeds constraints back to it, not final pins or a renewed Decision 0010 technical/policy review.

## 2. Official requirements versus saved host facts

The [Android Studio installation page](https://developer.android.com/studio/install) distinguishes **Studio alone**, **Studio & Emulator minimum**, and **recommended** requirements. Its minimum describes small projects and a single AVD, not the full Your Own workload. Preserve its **GB** units; our byte arithmetic below uses **GiB**.

| Area | Published observation | Comparison / disposition |
|---|---|---|
| Host OS | Studio minimum: 64-bit Windows 10; recommended: latest 64-bit Windows. Windows ARM CPUs are not currently supported by that page | P0 reports Windows 11 Pro/x64; this is above the broad minimum. An old technical minimum is not permission to use an unmaintained OS |
| Windows servicing | [Microsoft's table](https://learn.microsoft.com/en-us/windows/release-health/windows11-release-information) lists **26H2**, General Availability Channel, **26300.9711**, revision **2026-10-13**, Home/Pro end of updates **2028-10-10** | Exact version/build matches the saved P0 tuple. This closes the public-table comparison, not live installed-update verification, channel attestation or complete security clearance; no OS change proposed |
| CPU | Studio: post-2017 microarchitecture, Intel 8th-gen Core i5 / AMD Zen Ryzen examples, virtualization required. Recommended laptop suffixes include H/HK/HX; N/U series are not recommended | Reported 11th-gen i7-1185G7 is above the generation example, but not evidence of recommended performance. No benchmark, thermal or power assessment; virtualization remains unresolved |
| RAM | Studio **8 GB**; Studio & Emulator **16 GB**; recommended **32 GB** | P0 reports **32 GiB installed**, about **31.69 GiB OS-visible / 16.94 GiB available** at that moment. Capacity meets the quoted tier, not a guarantee under concurrent build/emulator workloads |
| Disk | Studio **8 GB free**; Studio & Emulator **16 GB free**; recommended SSD with **32 GB or more**. Additional AVDs may need up to **6 GB** each | Saved temp/checkout free space is **27.44 / 27.12 GiB**, respectively. Both exceed 16 GB but are below 32 GB even if GB is decimal. SSD/media type was not inspected. Neither minimum nor recommendation includes a proven project-specific peak budget |
| GPU | Studio alone: none; Studio & Emulator: **4 GB VRAM** with example Nvidia/AMD generations and current drivers; recommended **8 GB VRAM** | P0 only reports **Intel Iris Xe** and driver **32.0.101.7088**. VRAM/API/backend suitability is **unverified**; do not treat 32 GiB system RAM or a GPU name as proof of this requirement. This is not proof the emulator cannot run |
| Display | Minimum **1280×800**, recommended **1920×1080** | Not collected in P0. App logical-window coverage is separate from host panel resolution; neither is inferred from the other |

These are requirements for the published Studio/emulator workflow. A smaller command-line-only probe would need its own exact component/host review; skipping Studio is **not** an automatic GPU/support exception or an approved workaround.

### CPU virtualization and graphics are different gates

The [emulator acceleration guide](https://developer.android.com/studio/run/emulator-acceleration) recommends **Microsoft Windows Hypervisor Platform (WHPX)** on Windows. It requires the appropriate CPU virtualization features and an enabled platform; enabling it may require a reboot. The guide states **AEHD sunsets on 2026-12-31**. Prefer reviewing WHPX, not starting a legacy AEHD/HAXM path or disabling Hyper-V/VBS/Memory Integrity to accommodate another driver. No backend has been selected or enabled.

P0's **`HypervisorPresent=true`** does not prove the `HypervisorPlatform` optional feature or emulator acceleration is usable. Preserve the three CPU flags reported as false. Microsoft's [Hyper-V requirements page](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/host-hardware-requirements) notes that `systeminfo` can omit capability details when a hypervisor is already detected. That is a caution about interpretation, **not proof of why this machine's CIM flags are false**. We did not run `systeminfo` or `emulator -accel-check`.

The acceleration guide separately documents GPU `auto`, `host` and software modes. Software graphics may be useful for a separately reviewed diagnostic probe, but it does not establish CPU VM acceleration, waive the published GPU requirement or produce representative physical-phone performance evidence. No renderer mode is adopted. x86_64 image acceleration on this host is not ARM64 linkage proof, and nested-VM support must not be assumed.

## 3. Native build constraints — not selected pins

The saved Flutter **3.47.7** [pinned Android source](https://github.com/flutter/flutter/blob/abaf9c523780a608bd46686fd5e53740a07077f8/packages/flutter_tools/lib/src/android/gradle_utils.dart) supplies template defaults, not a verified installed Android stack:

| Input | Observed constraint | Remaining boundary |
|---|---|---|
| Flutter template | Gradle **9.3.1**, AGP **9.1.0**, Kotlin Gradle plugin **2.4.0**; compile/target **36**, minimum **24**; NDK **28.2.13676358**, Java minimum **17** | Template/source declarations only. ENV-A's proposed API 31 floor remains unapproved; no native package/driver compatibility follows |
| [Gradle 9.3.1 matrix](https://docs.gradle.org/9.3.1/userguide/compatibility.html) | JVM **17–25** to run Gradle; JVM 26 unsupported; Windows 11 AMD64 listed | No JDK vendor/patch chosen. Wrapper/toolchain/test JVM compatibility is not the same as Gradle runtime compatibility |
| [AGP 9.1 release page](https://developer.android.com/build/releases/agp-9-1-0-release-notes) | Current page heading/compatibility text describes **9.1.1**, despite the 9.1.0 URL; Gradle minimum/default **9.3.1**, Build Tools **36.0.0**, JDK **17**, NDK default **28.2.13676358**, KGP **2.2.10** | A live minor-release page is not an immutable 9.1.0 manifest or authorization to substitute 9.1.1. Several broad constraints align, but full exact compatibility is not established |
| Gradle published test coverage | Kotlin **2.0.0–2.3.0-RC** and AGP **8.13–9.0.0-beta02** are listed as tested | Does not cover every Flutter-template version above. This is a documented coverage gap, **not a demonstrated incompatibility**; retain it for T04/native validation, without silently changing versions |

No exact JDK distribution/patch, command-line tools, emulator build, system-image revision/flavor, native driver or plugin set is selected. Their availability, hashes, licensing, hooks, support and dependency compatibility still need review before any executable setup proposal. No old SDK minimum is recommended as a maintained candidate.

## 4. Per-volume budget proposal — not accepted or measured

**This is an agent-proposed planning envelope, not a vendor minimum, measured package footprint, fixed project requirement or approved quota.** Exact package/archive/extraction sizes must replace these allowances before acquisition. If the reviewed roster exceeds them, stop and propose a revision; do not delete evidence or lower a reserve silently.

Illustrative scope: one external synthetic workspace, one AVD, serial build/run, no new Android Studio installation and no duplicate Flutter SDK extraction. Reuse of existing isolated Flutter tools would require separate approval and fresh identity checks; it is not granted here. Additional IDE/SDK copies, AVDs or unreviewed native inputs require a revised envelope.

### Proposed additional footprint on the checkout volume

A future external root on that volume—not inside this repository—could hold the following. **No such directory or SDK/AVD configuration was created.**

| Component allowance | Proposed GiB | Includes / limitation |
|---|---:|---|
| Retained compressed inputs | 5 | Reviewed downloads retained alongside installed files; not a measured archive total |
| Expanded JDK/SDK/build tools/NDK/emulator | 10 | Counts simultaneous expanded tools; exact roster still unresolved |
| One expanded system image | 4 | Image flavor/API/revision unselected; stop if actual size exceeds allowance |
| One AVD userdata/cache/snapshot allowance | 6 | Explicit allowance, not Google's per-AVD estimate converted into a guarantee; cold/quick boot need separate evidence |
| Gradle/Pub caches and build output | 6 | Dependencies, transforms and output; no reuse of personal/global caches implied |
| Logs and contingency | 1 | Retain failures and synthetic artifacts; not unlimited growth |
| **Total additional footprint** | **32** | Proposed cap, not proof the eventual stack fits |

Separately propose **2 GiB additional temporary-volume footprint** for bounded helper/transient overhead, with large downloads/extraction explicitly kept in the future external working root. Undirected installer/cache writes on the temporary volume would invalidate this assumption.

For discussion, propose a **20 GiB free-space reserve on each affected volume**. This is a **new, unaccepted proposal**, not inherited permission from the old JS retry's 3 GiB/20 GiB controls. Capacity is not pooled across logical volumes.

| Volume role | Saved P0 free space | Proposed growth + free reserve | Required free before starting | Margin against proposal |
|---|---:|---:|---:|---:|
| Temporary data | **27.44 GiB** | 2 + 20 GiB | **22 GiB** | **+5.44 GiB**, point-in-time arithmetic only |
| Checkout-volume external workspace | **27.12 GiB** | 32 + 20 GiB | **52 GiB** | **−24.88 GiB**; this illustrative envelope does not fit |

Formula: **required starting free bytes = (additional peak footprint + proposed reserve) × 1,073,741,824**. Calculations use the exact saved P0 byte counts, not rounded table values. No new free-space measurement was made. The deficit is **to this proposal**, not a statement that every emulator installation needs 52 GiB. Do not interpret it as a purchase, cleanup, partition resize, file move or storage-provider request. A smaller reviewed scope/budget can be proposed for owner acceptance; it cannot waive native/security evidence.

The [SDK environment reference](https://developer.android.com/tools/variables) documents `ANDROID_HOME`, `ANDROID_USER_HOME`, `ANDROID_EMULATOR_HOME` and `ANDROID_AVD_HOME`; it marks `ANDROID_SDK_ROOT` deprecated. Future isolation must also account for JDK/Gradle/Pub/temp paths and any IDE settings. None is set here. The [AVD guide](https://developer.android.com/studio/run/managing-avds) distinguishes system image, user storage and cold/quick-boot state; configure and budget all of them explicitly rather than relying on default home-directory paths.

RAM is another independent constraint: use one AVD at a time in a future proposal, account for build and renderer overhead, and recheck available memory under separately approved execution. The documented approximately 4 GB per concurrently running AVD is not a host-wide peak bound. No emulator timing may satisfy the physical-reference-phone performance budgets.

## 5. Disposition and next bounded choice

**HOLD P2 setup.** This static pass supplied source comparisons and a budget proposal, not clearance or a mandatory hardware upgrade. Remaining questions are finite:

1. Confirm Windows Hypervisor Platform feature state and graphics memory/capability evidence through a **separately authorized narrow local read**, or retain Unknown. Neither a broad diagnostic dump nor an SDK acceleration check is authorized by this review.
2. Resolve the exact native tool/image/library compatibility and license/hook roster with T04's retained gates; do not treat the overlapping Java/Gradle declarations as full proof.
3. Obtain an accepted per-volume peak/reserve plan that fits fresh facts before execution. No cleanup, relocation, purchases or reserve reduction is inferred.
4. Retain actual phone/tablet/Mac access, target/budget/test-operator decisions and required native/browser proof before the applicable M00/scaffold/release gates.

**Next proposed inventory scope, not yet authorized:** one non-admin, no-network read of the **`HypervisorPlatform` optional-feature state** and **GPU dedicated/shared memory sizes**, only if available through reviewed built-in Windows facilities. Record unknown/ambiguous values without elevation or an alternate broad dump; do not equate a truncated legacy `AdapterRAM` field or shared system RAM with dedicated VRAM. No unrelated feature/device inventory, identifiers, settings changes, reboot, driver update, SDK/emulator/browser launch or rendering test. This prospective read is separate from accepting the storage proposal.

## 6. Evidence and validation limits

Research root: `C:/Users/HP/AppData/Local/Temp/your-own-emulator-feasibility-21ix80ko/`. Eight official URLs returned HTTP 200; responses were limited to **4,000,000 bytes**, with a **30-second network I/O timeout**, three workers and allowlisted HTTPS redirects. Only public HTML/text was read, without account login, supplier contact or owner/business-data disclosure. Reading download/license-page text does not accept its terms or download its linked executable.

The [snapshot](evidence/m00-t05-emulator-feasibility.json) contains **six files / 59,408 bytes**, SHA-256 **`1e7b7360fecf7d44f840276bfc5f9b60ba7fbe0bad6e7999e134238990beb792`**. It retains source identities/excerpts, saved P0/template inputs, explicit uncertainties, budget assumptions/arithmetic and capture helpers. Full responses/extracted text remain external with hashes. All **twelve previous snapshots** and pre-review repository file hashes were verified unchanged before capture.

The old P0 validator asserts twelve snapshots and P1 Not run; it is now a historical checkpoint, not a current status validator. Preserve it and earlier helpers unchanged. Current documentation/source/arithmetic/preservation checks belong in the [M00 task log](../milestones/00-decisions-and-validation.md#task-log). These are not fresh package-advisory checks, hardware tests, entitlement clearance or a renewal of Decision 0010's **2026-11-23 UTC** latest review deadline.
