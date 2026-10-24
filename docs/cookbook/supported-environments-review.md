# Supported Environments — M00-T05 Review

- **Version:** 0.5
- **Reviewed:** 2026-10-24 UTC, Windows x64 / static sources, separately authorized P0 inventory and P1 public-document feasibility review
- **Status:** **Blocked / unchecked: owner reports no test devices or Mac access yet; no target baseline selected**
- **Authority:** [Decision 0011](decisions/0011-supported-environment-review-order.md) brings this review forward; M00-T04 remains open/unchecked
- **Requirements:** [Mobile platforms](../MOBILE_TECH_SPEC.md#3-platform-support-and-native-boundaries), [accessibility/performance](../PRD.md#24-accessibility-reliability-and-experience-requirements), [test strategy](testing.md), [design matrix](design-system.md#43-mobile-tablet-and-desktop-verification-matrix)
- **Evidence:** [Initial static source records and excerpts](evidence/m00-t05-environment-review.json) · [Later read-only Windows inventory](evidence/m00-t05-windows-inventory.json) · [P1 static feasibility evidence](evidence/m00-t05-emulator-feasibility.json)

> Later direction: [Decision 0012](decisions/0012-local-development-bootstrap.md) permits local API/mobile scaffolding with installed Node/pnpm/Flutter instead of further host research. T05 and product target acceptance remain open; the experimental framework tuples below are not the new local-development pins.

## 1. Decision boundary

The owner approved reviewing M00-T05 before T04 closes, **not the recommendations below**. Android-first is the accepted limited-pilot release order; Android tablets, iPhone/iPad, four window classes, accessibility and native validation remain required. Flutter desktop/web applications, watches, TV and XR are not added because upstream supports them. User web/admin remain separate Next.js apps.

Five different concepts must stay separate:

1. A framework/plugin's technical minimum, which may rise with the eventual encrypted driver or other native libraries.
2. The product's declared OS/browser support and actual tested device/architecture coverage.
3. Current security maintenance of the exact OS/device/browser. A compatible old OS is not automatically safe for personal data.
4. Build-host/tool/SDK/compile/target versions, which need not equal the oldest deployable OS.
5. Store-submission requirements at the actual submission date, not distribution permission or a complete store-compliance audit.

No mobile test device, macOS host, Android SDK/JDK, browser binary, emulator, signing identity or paid test service was inspected, installed or selected in this review. The later [P0 inventory](windows-emulator-validation-plan.md#7-authorized-p0-inventory--observed-facts-and-limits) reads only approved Windows host metadata. Neither that inventory nor the earlier Windows host probes supplies native Android/iOS or browser proof.

## 2. Published constraints, not product targets

| Source observed on 2026-10-24 | Bounded finding | Consequence / limitation |
|---|---|---|
| [Flutter deployment matrix](https://docs.flutter.dev/reference/supported-platforms), describing 3.47 | Android supported API 24–37, CI-tested 24–36; iOS supported 15–27, CI-tested 18 and 26 | Upstream support and upstream CI coverage differ; neither is Your Own device testing or vendor security support |
| Flutter 3.47.7 [Android source](https://github.com/flutter/flutter/blob/abaf9c523780a608bd46686fd5e53740a07077f8/packages/flutter_tools/lib/src/android/gradle_utils.dart) | Template minimum API **24**, compile/target **36**; native build constants also exist | A template default is not the final manifest, validated native stack or permission to install its toolchain |
| Same commit's [iOS project template](https://github.com/flutter/flutter/blob/abaf9c523780a608bd46686fd5e53740a07077f8/packages/flutter_tools/templates/app/ios.tmpl/Runner.xcodeproj/project.pbxproj.tmpl) | Deployment target **15.0** in three configurations | Does not choose Xcode, establish plugin compatibility or prove iPad behavior |
| Next 16.4.2 [version-pinned installation documentation](https://github.com/vercel/next.js/blob/2864b1772c37242a9b40ab4d366eb7d368c2a070/docs/01-app/01-getting-started/01-installation.mdx) | Chrome/Edge/Firefox **111+**, Safari **16.4+** | Framework minimum only; not the final application's effective browser floor |
| [Tailwind v4 upgrade guide](https://tailwindcss.com/docs/upgrade-guide) | Chrome **111+**, Firefox **128+**, Safari **16.4+**; relies on modern CSS | Combined Next/Tailwind review must not promise Firefox 111. This is family-level documentation, not an executed 4.3.3 browser matrix; actual Edge/CSS behavior also needs testing |
| [Google Play target requirements](https://support.google.com/googleplay/android-developer/answer/11926878?hl=en) | New phone/tablet apps and updates target Android 16 / API **36+** from **2026-08-31** | Target API is not `minSdk`. Do not assume an extension, private-app exemption or permission to submit a pilot |
| [Apple submission requirements](https://developer.apple.com/news/upcoming-requirements/) | Xcode **26+** and iOS/iPadOS **26+ SDK** since **2026-04-28**; separately, deployment target iOS **13+** since **2026-09-09** | Building against SDK 26 does not require all users to run OS 26. Flutter's inspected minimum 15 remains stricter than that store minimum; plugins may raise it |
| [Xcode host/device support table](https://developer.apple.com/support/xcode/) | Initial request and one identical-URL retry both failed with connection resets | **Exact macOS/Xcode/SDK/device/simulator pairing remains unverified.** No guessed host requirement or fallback to an old Xcode |

The two fetched Flutter source files match the existing isolated SDK **after LF normalization only**. Original fetched and local byte hashes differ because of CRLF line endings; both identities and the transform are recorded. This is source-text consistency, not a fresh SDK archive/executable verification or permission to execute it. No package advisory was refreshed; Decision 0010's maintenance review is not renewed here.

## 3. Proposed support policy — not accepted

| ID | Recommendation | Approval/validation still needed |
|---|---|---|
| **ENV-A** | Working native compatibility floors: **Android 12 / API 31**, **iOS/iPadOS 18**, with phone and tablet coverage | Product choices above framework minima, proposed to bound legacy/native testing; not vendor requirements. Confirm device/audience fit, review native-package constraints and approve floor/current-OS coverage before selecting targets; actual native proof remains separately gated. No maximum OS or permanent compatibility promise is inferred |
| **ENV-B** | User web and admin: current and previous stable **Chrome, Edge and Firefox**, plus the current supported **Firefox ESR**; current and previous major **Safari** on vendor-maintained macOS/iOS/iPadOS | Record exact version/build/OS tuples at each release; update the matrix when a channel moves. Old framework minima are not a recommendation to run obsolete browsers. Safari coverage includes real iPhone/iPad, not only a WebKit runner |
| **ENV-C** | Prefer an owner-controlled, supported **Mac** with an explicitly reviewed Xcode/SDK pair; separately arrange physical iPhone/iPad access | Owner must confirm access, host model/OS and responsible tester. A hosted macOS runner is an alternative proposal requiring separate provider/budget/security approval; it cannot replace physical-device tests |
| **ENV-D** | Retain applicable WCAG **2.2 AA**, four adaptive classes, System/Light/Dark and manual assistive-technology checks; use the proposed measurement plan below | Existing requirements are not weakened; exact reference devices, test operators and numerical budgets still need owner acceptance |

ENV-A is a proposed **compatibility floor**, not permission to use an unmaintained device with sensitive data. Check the particular device/vendor's update status and installed patch before real-data use. If an older floor device is no longer security-maintained, it may be considered only for a separately authorized isolated synthetic compatibility test—not production use. Support wording and a workable maintained-device baseline must be resolved before T05 closes; no unsupported-version bypass is approved.

Browser support is a separate contract from native OS support: an older OS running the native app does not imply that its bundled Safari is in ENV-B. Do not silently expand the browser promise to every Android browser, embedded webview or iOS browser brand, or call them tested because an engine is similar. Unsupported-browser handling must be truthful and non-destructive; never bypass authentication or discard drafts. W0/W1/W2/W3 and A0/A1 retain their own feature/release gates.

If a required library conflicts with approved targets, return to the owner with the exact conflict. Do not raise the floor, drop a platform, add a polyfill stack, change the renderer or weaken security automatically.

## 4. Proposed device and browser coverage

All lanes below are **planned, not available/verified test environments**. The owner reports no test devices or Mac access yet (section 7); exact Windows browser/tool readiness remains unreviewed. No ownership or compatibility is inferred. The 4 GiB/60 Hz Android profile is a measurement reference proposal, not a universal RAM requirement or a claim that other hardware works.

| Lane | Reference / use | Required proof when separately authorized |
|---|---|---|
| A1 — Android floor | ARM64 phone, proposed API 31 floor, approximately 4 GiB RAM / 60 Hz; physical device for performance/lifecycle | Durable quick-log acknowledgement, restart/process death, migration with pending writes, secure storage/key behavior, TalkBack, IME, notifications denied and timer recovery |
| A2 — Android current | Maintained physical phone on current stable Android; floor emulator supplements A1, not substitutes for physical proof | Current target-SDK behavior, permissions, back navigation, background restrictions, app links and sharing; record OEM/OS/build separately |
| A3 — Android tablet | Physical tablet with landscape, split-window and external keyboard/pointer where supported | All usable window classes, resizing, focus, drafts and timers preserved; tablet support is not phone screenshots stretched |
| I1 — iPhone | Compact and contemporary viewport profiles; proposed OS 18 floor plus current OS coverage | Native build/installation and real lifecycle/key/permission/link/share/VoiceOver behavior; simulator is supplementary |
| I2 — iPad | Physical large iPad plus narrow supported multitasking windows and keyboard/pointer | Live resize, split view or current OS windowing, rotation, keyboard insets, popover sharing, selected-record/draft preservation and VoiceOver |
| W1 — desktop web/admin | Windows Chrome/Edge/Firefox/ESR, real macOS Safari; agreed exact supported tuples | Production build hydration, sessions/CSRF, logout/back-forward cache privacy, keyboard, NVDA/VoiceOver, high zoom and forced colors where applicable |
| W2 — mobile web/admin | Android Chrome and actual Safari on iPhone/iPad, in supported browser/OS tuples | Touch/keyboard, browser suspension, sharing/app-link fallbacks, viewport/zoom/reflow, safe staff confirmations; admin is not desktop-only |

Before claiming a supported lane, record actual hardware, OS/build, architecture, screen scale/refresh rate, browser or SDK version, test operator, fixture and evidence. Exact device purchase/rental, device counts, test-service enrollment, ABI packaging and CI images remain unselected. If a floor device or Safari version cannot be tested, keep the gap explicit rather than claiming coverage from a newer device. Emulator x64 success is not ARM64/native-driver proof.

Use the existing [viewport matrix](design-system.md#43-mobile-tablet-and-desktop-verification-matrix): 320×568 and 390×844, 568×320 short landscape, 768×1024 tablet, 1024×1366/1366×1024 iPad examples, boundary pairs **599/600, 839/840, 1199/1200**, and **479/480** usable-height transition. Include desktop through 2560×1440 and narrow desktop windows. These are logical/CSS sizes, not required physical panel resolutions. Exercise Light/Dark and System transitions, keyboard-visible states, large content and resizing without duplicate writes/timers.

## 5. Accessibility and performance evidence plan

### Accessibility

Keep the [existing WCAG 2.2 AA target](../PRD.md#nfr-01--accessibility), not a claim of conformance. Test screen-reader order/names/statuses with **TalkBack, VoiceOver and NVDA** on the applicable real environments; keyboard-only completion and no focus hidden by sticky elements/virtual keyboards; 200% text and applicable 400% web zoom/reflow; reduced motion and forced colors. Check accessible authentication and non-drag alternatives, errors/focus restoration, exact-value chart/text alternatives and immutable poster text. Project primary targets remain **48×48 logical/CSS units**, not reduced to WCAG's smaller minimum exceptions. Automated checks/goldens do not replace manual review. Tools/versions and human operators remain to be assigned.

### Proposed budgets and measurement protocol

| Measurement | Proposed budget / method | Limit |
|---|---|---|
| Mobile durable quick-log acknowledgement | Retain **p95 ≤200 ms**, tap to durable local transaction plus visible saved/pending-sync acknowledgement; warm baseline, 20 warmups then at least 100 recorded actions | Use the selected encrypted store and representative physical reference phone; separate server acceptance. A spinner or optimistic state before commit is not a durable-save result |
| Mobile interaction rendering | UI and raster timing considered separately against the actual refresh interval, e.g. **16.7 ms at 60 Hz** / **8.3 ms at 120 Hz**; propose p95 within that interval | Report missed-frame ratio and worst stalls as well; no timer accuracy inferred from frame rate. Profile/release, not debug/emulator benchmarks |
| Public web CWV | Propose **p75 LCP ≤2.5 s, INP ≤200 ms, CLS ≤0.1**, segmented mobile/desktop | These are [published good-experience thresholds](https://web.dev/articles/vitals), not measured results. Pre-release repeatable lab runs are diagnostic proxies, not field-percentile evidence or permission to enable analytics |
| Authenticated web/admin | Measure interaction acknowledgement, loading/commit/error states and layout stability separately from public pages | Server-authorized operations must not appear completed early. Fix exact numerical route/network budgets after reference profiles/provider choices; not approved by the public CWV numbers |
| Large history / rendering | Synthetic empty, ordinary and **10,000-record** aggregate private-history fixture, plus a separate **100,000-record** stress tier; report query/render/sync/memory behavior | Proposed workload sizes, not product caps or generated datasets. Exact distributions, Money-safe values, poster dimensions/peak memory and cold-start budgets remain open |

For repeatability record build mode/commit, exact device/runtime/OS, refresh rate, thermal/power state, fixture/hash and cache state. For future web network profiling, propose a controlled **10 Mbps down / 2 Mbps up / 150 ms RTT** lane and a separate local/non-throttled lane, with actual settings recorded. No arbitrary desktop CPU throttle substitutes for a physical low-end phone. Define percentile calculation, exclude only documented warmups, retain failures/outliers and raw redacted measurements. Server/network/queue/render timings are separate; existing backend p95 read 500 ms/mutation 750 ms proposals are not accepted or validated here.

Numbers above remain proposals. M00-T05 cannot be declared complete while the required budgets/reference profiles remain unresolved. Do not invent startup, memory, battery or poster benchmarks before the renderer/storage/hardware are selected.

## 6. macOS path, owners and gates

**Availability update, 2026-10-24 UTC:** the owner replied **“belum ada.”** (“none yet”) to the test-device and Mac-access questions. Record no currently available test devices or macOS access for this project. This is owner-reported availability, not a machine/device inspection or a claim about everything the owner possesses. The existing Windows checkout remains available; Android SDK/emulator/browser readiness, developer membership and signing capability were not established by this reply.

Preferred sequence once access and scope are approved:

1. Record owner-provided Mac model/chip, macOS version, available storage and Xcode version; recheck Apple's host/SDK/simulator/device table, exact Flutter and native-library requirements. The failed page lookup leaves this step blocked, not waived.
2. Separately authorize isolated tool acquisition/setup if needed. Read-only source review does not authorize Xcode, simulators, CocoaPods, Java, Android SDKs, browser downloads or native hooks.
3. Establish non-signing/simulator compilation and native plugin linkage, then authorized physical-device tests. A successful non-signing build does not prove signing, APNs, keychain persistence, iPad sharing or background behavior.
4. Signing/TestFlight/store distribution, credentials, cloud/CI accounts and any paid Mac/device service require their own owner authorization and secure handling. No Windows-based iOS workaround or service signup is selected.

| Responsibility | Current / proposed owner | Acceptance evidence required |
|---|---|---|
| Target/support and release decisions | Project owner is the approver under existing workflow | Explicit target/coverage/budget acceptance; no agent self-approval |
| Android physical tests/performance | **Unassigned**, owner to name operator/access | Device facts, repeatable fixtures and real results |
| Mac/Xcode and iPhone/iPad tests | **Unassigned**, owner to confirm access/operator | Reviewed host/tool pair and native-device evidence; CI alone insufficient |
| Browser/manual accessibility review | **Unassigned**, owner to name operator; agent may assist within authorized tooling | Supported tuple matrix, keyboard/screen-reader findings and fixes |
| Automated tests/traceability | Agent/contributor may implement later under approved task scope | Selected tools, approved execution environment and reproducible artifacts |

T05 supplies approved target constraints back to T04; T04 still owns final SDK/library/notice/baseline compatibility. T06 owns providers/hosting/cost; T08 owns encryption/native lifecycle; T09 owns visual/icon/chart proof; T10/T11 own contracts/sync. None starts automatically. Applicable iOS/iPad evidence and **M00-T14** remain scaffold gates, even for an Android-first pilot. ApexCharts stays held; this review authorizes no charts, outreach, purchase or replacement.

## 7. Owner availability and next steps

After being asked for available Android/iPhone/iPad models/OS/RAM and Mac/macOS/Xcode access, the owner answered on **2026-10-24 UTC**:

> belum ada.

This reports **none available yet** for the requested project test resources; it is not approval of ENV-A–D, a purchase/rental budget, an emulator installation, a hosted macOS provider or a platform waiver. No new decision record is needed for this inventory fact. Do not repeatedly request model/version details until access changes; accept later clarification if the reply referred to a narrower resource set.

**M00-T05 is Blocked / unchecked for completion.** Actual reference-device/access arrangements, a validated macOS/Xcode path, test operators and target/budget acceptance remain unresolved. M00-T04 remains open/unchecked and paused. Existing requirements do not demand buying equipment immediately, but they still require an approved, workable access plan and later real native evidence at the applicable gates. Borrowed/remote access could be reviewed if offered; none is arranged or authorized here.

Device-independent target/coverage planning may continue within Decision 0011's existing static-review scope. Keep proposed profiles hypothetical. A Windows emulator plan is not an installed emulator or a substitute for physical Android/iOS/iPad evidence; a WebKit runner is not real Safari proof. No installation, spend, native-test waiver, task completion, M00-T06/M01 advance or M00-T14 approval follows.

**Planning continuation, 2026-10-24 UTC (historical checkpoint):** the owner's subsequent **“continue”** follows the offer of Windows/emulator planning without installation. The [Windows/emulator validation plan](windows-emulator-validation-plan.md) now defines a narrow proposed host inventory, compatibility/resource prerequisites, eight future synthetic cases and emulator-versus-physical evidence limits. At that checkpoint all inventory/setup/test steps were Not run; the planning continuation did not infer new execution permission or a Decision 0012.

**Subsequent P0 authorization/result, 2026-10-24 UTC:** the owner answered **“continue”** directly to the narrow read-only Windows-inventory question. The [recorded question and results](windows-emulator-validation-plan.md#7-authorized-p0-inventory--observed-facts-and-limits) establish one non-admin collection, not SDK/emulator execution. Eight metadata groups were observed; Windows/CPU/RAM/graphics and point-in-time space are now recorded. Hypervisor-present and CPU capability flags do not establish acceleration readiness. No network request, system-setting change, install, native/browser test or connected-device discovery occurred. At that checkpoint P0 alone was complete; P1–P4 and all eight synthetic cases were Not run, with T05 still Blocked / unchecked. No new numbered decision or target acceptance follows.

**P1 static review, 2026-10-24 UTC:** the owner's next **“continue”** followed the offer of official-requirements/budget review. The [report](windows-emulator-feasibility.md) records eight successful public text responses, the Windows servicing-table match, unresolved WHPX/GPU/native-tool constraints and an unaccepted per-volume budget. The proposed 52 GiB starting-free envelope for the checkout volume does not fit P0's 27.12 GiB observation; it is not a mandatory vendor minimum or permission to acquire/clear space. **HOLD setup**; P2–P4 and all synthetic cases remain Not run. No host inspection or SDK execution occurred in P1.

**Next eligible work:** request the report's narrow non-admin, no-network WHPX-state/GPU-memory read, without setup, broad diagnostic dumps or changes. This proposed read is not yet authorized; target and storage-budget acceptance remain separate. Revisit phone/tablet/Mac access only when available or a specific alternative is explicitly authorized; request only model/OS/access/operator facts, **no credentials, account access, device identifiers or personal data**.

## 8. Evidence and limitations

The initial static research root is `C:/Users/HP/AppData/Local/Temp/your-own-target-review-9vauky8z/`. Ten unique official URLs were requested, with one bounded identical-URL retry: **nine successful responses and two Xcode connection-reset failures**. Requests were unauthenticated public text reads, ≤4,000,000 bytes each; no project files or owner business details were uploaded. Initial searches/read attempts for the missing Xcode text produced file-not-found errors, retained as research-helper failures—not application failures or evidence of missing platform support. No further retry or substitute compatibility claim was made.

The separate evidence record contains **seven files / 41,672 bytes**, SHA-256 **`4b31046a6d39a609d8f6d0dbaf6da9c6e77944301bcb9d11a3c9ba8c8988837f`**. It retains request URLs/times/status/hashes, selected excerpts, source/local line-ending comparisons, the initial failures and ten earlier snapshot identities. Live documentation remains dated; source-hash equality and parsed declarations are not publisher attestation, complete package compatibility, current security clearance, store acceptance, WCAG conformance or native/browser test results. All prior snapshots stay unchanged. The availability reply was recorded after this frozen initial review, not inserted into its historical evidence. Its original validator assumes T05 is In progress and is not a current status check after the Blocked transition; preserve that helper rather than rewriting historical assertions. Current documentation/preservation checks and commands/results are recorded in the [M00 task log](../milestones/00-decisions-and-validation.md#task-log).

The later P0 has its own [nine-file inventory snapshot](evidence/m00-t05-windows-inventory.json), preserving all eleven earlier snapshots. Its authorization, source/command/output identities, raw capability flags and limits are documented in the Windows plan; it is not a replacement for the original static-source record or a fresh compatibility/security/policy review.

P1 has a further [six-file static snapshot](evidence/m00-t05-emulator-feasibility.json), preserving all twelve earlier snapshots and the P0 observations without another query. Its source/template comparisons and budget arithmetic are documentary evidence only. The P0 validator's twelve-snapshot/P1-Not-run assertions are now historical too; preserve rather than rewrite or rerun them as current checks.
