# Windows and Android Emulator — Validation Plan

- **Version:** 0.3
- **Prepared:** 2026-10-24 UTC
- **Task:** [M00-T05](../milestones/00-decisions-and-validation.md#m00-t05--supported-environment-review), **Blocked / unchecked for completion**
- **Status:** **P0 inventory completed; P1 statically reviewed — HOLD setup. P2–P4 and all eight synthetic cases remain Not run**
- **Authority:** [Decision 0011](decisions/0011-supported-environment-review-order.md) for review; the later explicit question/reply in section 7 authorizes only one non-admin P0 host inventory, not SDK/emulator execution
- **Sources:** [Environment review and availability](supported-environments-review.md), [mobile native boundaries](../MOBILE_TECH_SPEC.md#3-platform-support-and-native-boundaries), [testing strategy](testing.md)

> Later owner direction: [Decision 0012](decisions/0012-local-development-bootstrap.md) permits local repository setup now, without another WHPX/GPU inventory. The emulator-specific P2–P4/WIN cases below remain Not run and are not the new API/Flutter host tests.

## 1. Purpose and present limits

Make the next Windows assessment finite and useful without buying equipment or pretending an emulator is a physical phone. The owner reported **“belum ada.”** for test-device/Mac access. The Windows checkout exists. The initial plan had no host inventory; the subsequently authorized P0 now records OS/build, CPU/RAM, reported virtualization flags, graphics metadata and point-in-time free space in section 7. **Emulator compatibility, acceleration and an approved resource budget remain unverified.**

The initial planning pass performed no host inventory. The later P0 performed only the scoped built-in Windows reads; neither pass made new network requests, SDK/browser/package downloads, license acceptance, installation, emulator/ADB launches, candidate-tool execution or native tests. Prior Windows Flutter host tests are not Android execution, and the existing plaintext SQLite host DLL is not an approved encrypted Android driver. ENV-A–D remain recommendations; this plan does not adopt Android API 31, any system image or a browser baseline.

Two later execution paths must stay distinct:

- A **separately authorized external synthetic probe** can supply bounded M00 investigation evidence before scaffolding. Its exact tools, libraries, fixture, network/resource limits and permitted native hooks need review and authorization first.
- **Repository application tests** originally awaited the full scaffold gate. Decision 0012 now separately authorizes the bounded local bootstrap and its host checks, while full M00/native/release evidence remains open. A disposable probe still does not implement M01 or the M03 water slice.

## 2. Proposed sequence and stop points

These are planning phases, not extra roadmap tasks. The bounded P0 inventory and subsequent P1 public-document review have been performed; neither grants permission to execute later setup/test phases.

| Phase | Proposed work | Exit evidence / stop condition | Current state |
|---|---|---|---|
| P0 — Host inventory | Read only the allowlisted host facts in section 3 | Sanitized facts or explicit Unknown/Access denied; no configuration changes | Completed: eight observed groups; section 7; not an emulator-readiness pass |
| P1 — Feasibility review | Compare facts with current official Windows/emulator requirements and the exact proposed SDK/JDK/Gradle/native dependencies | Compatible host/tool/image proposal and storage/memory budget, or a specific blocker; no install inferred from a feasible result | Reviewed — HOLD; [source comparison and unaccepted budget](windows-emulator-feasibility.md); acceleration/GPU/tool compatibility unresolved |
| P2 — Isolated setup | Only after separate approval: verified downloads, scoped SDK/AVD/cache directories and an approved hypervisor arrangement | Actual tool/image identities, reviewed licenses/hooks, resource checks and scoped launch/teardown evidence | Not authorized / not run |
| P3 — Synthetic probe | Only after separate approval: one owned emulator at a time, fresh synthetic fixtures and the applicable cases below | Raw pass/failure evidence tied to the exact image/ABI/build; no product release claim | Not authorized / not run |
| P4 — Remaining target proof | Physical Android phone/tablet, macOS/Xcode/iPhone/iPad and actual Safari evidence at their applicable gates | Real platform results and approved target/access/test ownership; emulator results cannot substitute | Blocked on access; not run |

P0/P1 cannot close M00-T05 by themselves. M00-T04's dependency/notice/final-pin blockers and M00-T08/T09/T10/T11 evidence requirements remain. No automatic progression to T06, M01 or deployment follows any phase.

## 3. P0 scope — narrow read-only Windows inventory

The owner authorized one **local, non-administrator inventory only**, with no network request or SDK/native-tool invocation; see the exact question and reply in section 7. Use built-in Windows facilities with explicit field selection, not a complete machine/support dump.

| Allowed facts | Purpose | Exclusions / interpretation |
|---|---|---|
| Windows edition, version/build and host architecture | Check current OS/tool support, including whether the host is x64 or ARM64 | No machine name, username, domain, product key or activation details; installed does not mean security-maintained |
| CPU model, core/logical-processor counts, reported virtualization/SLAT capabilities and hypervisor-present flag | Identify likely acceleration constraints | No processor/BIOS serials or hardware UUIDs; a missing/hidden capability is Unknown, not proof it is disabled or unsupported |
| Installed and currently available RAM | Estimate headroom for IDE/build/emulator workloads | A point-in-time reading is not guaranteed future headroom or a physical-phone performance profile |
| Capacity/free space on the checkout and temporary-data volumes | Identify separate volume constraints before budgeting downloads/extraction/caches | Record volume role and space only; no recursive home-directory scan, network-drive enumeration or file contents |
| Display-adapter model and driver version, if readable without elevation | Flag a later emulator-rendering compatibility review | No display identifiers or full device inventory; successful metadata reads do not test a GPU/backend |

Return only selected fields and per-field errors. Do not request elevation if a field is inaccessible; record it as unknown and stop before any dependent action. The inventory must not enumerate attached phones, browser profiles, personal files, credentials or environment-variable contents.

**Explicitly excluded from P0:** `flutter doctor`, SDK-manager commands, license acceptance, ADB/device discovery, emulator launch, IDE launch, Java/Gradle/browser execution, feature/driver installation, BIOS changes, reboot, registry writes, firewall changes or disabling VBS/Memory Integrity/antivirus. Even a seemingly informational SDK command may start services or populate caches. This inventory authorization is not an execution authorization for such tools.

## 4. Feasibility and setup criteria for later approval

Before proposing P2, resolve all of these without installing to discover the answer:

- **Tool compatibility:** exact Flutter/Dart, JDK, Android build tools, Gradle/AGP and native-plugin requirements. A template constant is not an installed tool or a complete compatible stack. Reverify any executable/archive before reuse; do not inherit a reference app's SDK/lock settings.
- **Virtualization:** check current official emulator support against the actual Windows/CPU/hypervisor state. No acceleration backend is selected here. If enabling a Windows feature, installing a driver or rebooting is necessary, stop and request that specific change; do not disable security controls to make a test run.
- **Image and ABI:** name exact API level, revision, ABI and image flavor. Keep proposed deployment minimum, compile/target SDK and emulator OS separate. An x86_64 emulator cannot establish ARM64 library compatibility. AOSP/Google APIs/Play images have different capabilities and obligations; no Google login, Play services or push proof is implied.
- **Disk budget:** account for download archives, expanded SDK/JDK/tools, package/Gradle caches, AVD system/userdata images, optional snapshots, build output and retained logs. Budget each affected volume, including temporary extraction. Re-measure before/during long work and define approved stop thresholds before launch. The earlier JS retry's **3 GiB / 20 GiB** thresholds are not an emulator allocation or automatically sufficient capacity. Never delete old evidence to make room.
- **Memory budget:** assess concurrent host/build/emulator demand; propose serial phone/tablet sessions first. An AVD configured with 4 GiB is not proof of performance on a 4 GiB physical phone. If the host is insufficient, report the constraint rather than silently switching to a paid cloud runner.
- **Isolation and licenses:** use new explicit external SDK/AVD/cache/temp locations; do not change global PATH or reuse personal AVD/browser profiles. Review applicable licenses before acceptance, artifacts before execution and every needed native hook. No moving installer, blanket script approval or security exclusion. Directory/environment isolation is not an OS sandbox.
- **Network and accounts:** synthetic data only, no real Google/provider login, signing identity or cloud service. Review image/tool background traffic and enforce the approved network boundary. For a local API fixture, verify the emulator's route to the loopback listener; do not expose it on all host interfaces as a shortcut. Stop if required isolation cannot be demonstrated.
- **Teardown:** track owned process IDs, ports and directories. Stop only the owned emulator/fixture/process tree; do not kill a shared ADB service or unrelated developer process. Preserve logs, failures and the before/after inventory. Cleanup requires its own bounded scope; no global cache/AVD deletion.

## 5. Finite planned cases and evidence boundaries

Case IDs below identify planned checks, not completed tests or new requirement IDs. Run only the cases whose fixture/dependency/contract prerequisites have been separately approved; otherwise record **Blocked**, not Pass or a mock substitute.

| Case | Requirement / future owner task | Expected observation in an authorized synthetic probe | Not established by emulator evidence |
|---|---|---|---|
| WIN-01 — Exact build/install/boot | T04 compatibility; T08 native integration | Exact SDK/image/ABI/APK identities; declared native libraries load on that ABI; cold boot distinguished from snapshot restore | ARM64 physical linkage, encrypted storage or any other OS/image |
| WIN-02 — Adaptive state | NFR-07/NFR-08; T09 | Small through Largest usable widths, 599/600, 839/840, 1199/1200 boundaries; portrait/landscape/resize and 479/480 short height preserve selected record/draft and do not duplicate timer/write | iPad multitasking or equivalent OEM window behavior |
| WIN-03 — Appearance/input | NFR-01/NFR-09; T09 | System/Light/Dark, 200% text, keyboard/IME and focus reachability; semantic labels and 48-unit targets; rounded-icon ownership | Full WCAG conformance, real TalkBack/device usability or Safari/browser behavior |
| WIN-04 — Local durability | NFR-02/NFR-03; T08/T11 | With the selected persistence fixture, a confirmed saved synthetic record survives process termination/restart; approved pending-operation identity is preserved | Encryption/key/backup security merely from a row surviving; real OEM process management |
| WIN-05 — Timer interruption | FOC-02/FOC-03; T08 | Distinguish activity recreation, ordinary backgrounding, process death and user force-stop; restore approved timing state without double-counting pauses/breaks or claiming attention | Indefinite background execution or guaranteed alarms after force-stop; emulator sleep is not physical battery management |
| WIN-06 — Permissions/platform actions | INT-03 and native sharing/links; T08 | Explicit permission-denied/cancelled/unavailable states; synthetic sharing/link intent handling on the selected image | FCM/APNs delivery, store-verified links, real share targets or iPad popovers; do not add providers to manufacture coverage |
| WIN-07 — Synthetic network recovery | NFR-02/NFR-03; T10/T11 | Only with an approved contract/fixture: controlled offline/lost-response/retry, same operation ID, truthful pending status, no duplicated accepted effect | Real provider behavior or complete synchronization correctness from a stub API |
| WIN-08 — Failure and teardown | NFR-05; test workflow | No synthetic private canaries in ordinary logs/screens outside allowed fixture evidence; bounded timeout, owned-process teardown and preserved failed outputs | Exhaustive security certification or isolation of all host/emulator traffic |

Use the [canonical viewport matrix](design-system.md#43-mobile-tablet-and-desktop-verification-matrix); logical pixels are not raw AVD display pixels. Do not label a resized Android window an iPad test. Do not use screenshot/golden equality as accessibility or privacy proof.

No case currently produces a performance pass. Emulator timings can diagnose regressions, but the proposed quick-log p95 200 ms and refresh-rate budgets require the agreed physical device, selected encrypted store and controlled workload. Public browser CWV and manual NVDA/VoiceOver/Safari checks remain separate lanes.

## 6. Evidence record and handoff

For each later phase/case record: authorization reference; operator/date; exact host/tool/image/ABI/build identities; fixture and source hashes; viewport/density/text/theme; network/cache/boot state; command, timeout and exit status; expected/observed result; raw redacted logs; resource samples; teardown; and the exact claim/remaining gap. Status is one of **Not run, Blocked, Pass or Fail**—an available command or planned assertion is not a result.

Preserve all earlier evidence unchanged, including failed attempts. The initial plan created no execution snapshot; the later [P0 inventory snapshot](evidence/m00-t05-windows-inventory.json) separately captures the authorized metadata reads, not application tests. The [M00 task log](../milestones/00-decisions-and-validation.md#task-log) distinguishes both passes.

**Next eligible work:** request the [P1 report's narrow WHPX/GPU-memory inventory scope](windows-emulator-feasibility.md#5-disposition-and-next-bounded-choice), separately from owner acceptance of any storage proposal. No SDK/emulator or optional-feature query is authorized by the completed P0 or P1; the prospective read requires explicit permission. Public documentation review remains within Decision 0011. P0 made no network request; P1 made only the eight recorded official text requests. Do not ask again for nonexistent phones/Mac access or infer approval of ENV-A–D. M00-T05 remains blocked for completion and M00-T04 remains open; actual access and native evidence are still required at their original gates.

## 7. Authorized P0 inventory — observed facts and limits

On **2026-10-24 UTC**, the owner was asked:

> Boleh lanjut memeriksa spesifikasi Windows secara read-only—OS, CPU/virtualisasi, RAM, ruang disk, GPU/driver—tanpa admin, jaringan, perubahan setelan, atau menjalankan SDK/emulator?

The owner replied:

> continue

This answers the specific P0 inventory question, unlike the earlier “continue” to planning only. It authorizes local allowlisted metadata collection, not a target baseline, installation or native/browser test. The record lives here and in the task log; no new numbered architecture decision is needed.

### Observed metadata

Collected **2026-10-24 16:19:37–16:19:38 UTC**, using one explicit built-in Windows PowerShell process with `-NoProfile -NonInteractive -Command`, seven local CIM queries and two read-only OS-release registry values. The token's administrator flag was **false**; the helper would stop before host queries if elevated. Eight groups returned selected non-null fields; exit **0**, no timeout, empty stderr, owned PowerShell process exited. There was no permission failure or retry.

| Item | Observed value | Interpretation |
|---|---|---|
| OS | **Microsoft Windows 11 Pro**, 64-bit; local `DisplayVersion=26H2`; version `10.0.26300`, build **26300.9711** | Local OS/registry claims only; release channel, vendor maintenance and patch currency were not independently checked |
| CPU | **11th Gen Intel Core i7-1185G7 @ 3.00 GHz**, **4 cores / 8 logical processors**; architecture code **9 (x64)** | Host metadata, not a build or emulator benchmark |
| Installed RAM | Module capacities total **34,359,738,368 bytes = 32 GiB** | System/OS-visible physical memory is separately **34,024,419,328 bytes ≈31.69 GiB**; do not conflate installed and usable RAM |
| Available RAM | **18,183,958,528 bytes ≈16.94 GiB** | One instant, not a reserved allocation or guarantee under build/emulator load |
| Temporary-data volume | Capacity **497,279,823,872 bytes ≈463.13 GiB**; free **29,459,939,328 bytes ≈27.44 GiB** | Local volume backing the existing external temporary roots; no allocation or cleanup performed |
| Checkout volume | Capacity **526,804,578,304 bytes ≈490.62 GiB**; free **29,120,733,184 bytes ≈27.12 GiB** | Separate logical-volume observation; do not sum both readings into one install budget or infer separate physical disks |
| Graphics | **Intel Iris Xe Graphics**, driver **32.0.101.7088** | No GPU API/driver support check, rendering test or update recommendation |
| Hypervisor | **`HypervisorPresent=true`** | Does not identify the hypervisor, establish Windows Hypervisor Platform availability or prove emulator acceleration |
| CPU virtualization flags | **`VirtualizationFirmwareEnabled=false`**, **`SecondLevelAddressTranslationExtensions=false`**, **`VMMonitorModeExtensions=false`** | Preserve all three values alongside the hypervisor-present result; do not equate them with a verified BIOS-disabled state or an incapable CPU |

All GiB figures use **1,073,741,824 bytes**, rounded to two decimals where needed. No computer/account/domain names, product keys, serial numbers, device UUIDs, network adapters, attached phones or personal files were collected. Registry access was read-only and limited to `DisplayVersion` and `UBR`; it did not inspect activation or identity values.

### Bounded assessment and next step

- **Do not declare the host ready or unusable from P0.** x64 CPU/RAM observations support further feasibility review, not a supported emulator/tool combination. Windows release/build support and GPU/backend compatibility still need official-source comparison.
- **Virtualization remains unresolved.** CPU flags under an already-present hypervisor can be inconclusive about underlying capabilities. No optional-feature state, hypervisor backend, BIOS setting or emulator acceleration check was inspected. Do not enable firmware options, install drivers, disable Hyper-V/VBS/Memory Integrity or reboot on the strength of these flags.
- **Budget before downloading.** Approximately 27 GiB free on each volume is a capacity constraint to evaluate, not proof of sufficient or insufficient space for an unselected setup. Include archives, extraction, SDK/images, caches, AVD growth and preserved evidence. Do not transfer the old JS retry quota, delete evidence, move installations or promise more RAM/free space.
- **Historical P0 handoff:** P1 was next and unperformed at the inventory checkpoint. The later [P1 static review](windows-emulator-feasibility.md) records official comparisons and an unaccepted budget, with setup held. P2/P3, all WIN-01–WIN-08 cases, product targets, physical Android/iOS/iPad/Safari evidence and M00-T14 remain gated. No purchase is required by this inventory.

### Evidence preservation

External root: `C:/Users/HP/AppData/Local/Temp/your-own-windows-inventory-e9srajim/`. The [separate snapshot](evidence/m00-t05-windows-inventory.json) contains **nine files / 37,227 bytes**, SHA-256 **`48c3a6a81c56640601fbafd230b84f7d31ffa295ad27087dc2da9246274ec3b2`**: baseline/authorization, exact query and runner source, command identity, stdout, empty stderr, exit record, parsed observations and capture helper. The executable hash records the built-in file used, not an independent publisher/security attestation.

All **eleven prior snapshots** and pre-inventory repository file hashes were checked unchanged before capture. No earlier source evidence was rewritten to insert these later facts. Only owned evidence/helper files and documentation were written; no system configuration was changed. The helper makes no network requests; this is not a host-wide traffic audit or an OS sandbox. The P0 snapshot proves bounded metadata collection and provenance, not application behavior or support/security certification.

## 8. P1 static review — setup held

The [separate P1 report](windows-emulator-feasibility.md) compares eight official text sources with the unchanged P0 facts. The reported Windows tuple matches Microsoft's published servicing table; CPU-generation/RAM comparisons are bounded positives, not emulator readiness. WHPX availability, the published 4 GB VRAM condition and full native-tool compatibility remain unverified. Software GPU rendering is not a CPU-acceleration or physical-device waiver.

The illustrative budget proposes 32 GiB additional checkout-volume footprint plus a newly proposed 20 GiB free reserve: **52 GiB required versus 27.12 GiB observed at P0**. This is an unaccepted planning envelope, not a vendor minimum or a purchase/cleanup instruction. Exact package sizes and a workable accepted allocation are still needed. P2 remains held, not automatically scheduled. The new [static snapshot](evidence/m00-t05-emulator-feasibility.json) preserves all twelve earlier snapshots. No further host query or SDK/emulator execution ran.
