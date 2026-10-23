# Decision 0002 — Rounded Icons and Chart Rendering

- **Status:** Accepted direction; icon family subsequently selected and ApexCharts hold confirmed in [Decision 0004](0004-toolchain-directions-and-icon-family.md); exact pins and integration evidence pending
- **Approved by:** Project owner (direct instruction in this conversation)
- **Recorded:** 2026-10-23 UTC
- **Recorded by:** Coding agent
- **Related tasks:** M00-T04 dependency selection, M00-T09 design validation; later UI foundations and feature verification
- **Supersedes:** The generic user-web chart-library recommendation and mobile `fl_chart`-first evaluation wording, not Decision 0001 or the remaining product defaults

## Owner instruction

> ohh hold on. for icon make sure use a complete icon banks and do not use from material design or default from flutter and next js. i want the whole icon look rounded.
>
> for chart, i want you to use apex for website. for mobile, make it custom if needed

“Apex” is recorded as **ApexCharts**, the website chart library. This instruction adds visual/tooling constraints; it does not approve M00-T02 recommendations P01–P11 or authorize installations/scaffolding.

## Accepted direction

### One complete rounded icon family

Use one comprehensive, deliberately selected icon bank with a consistent rounded style across Flutter, user web, admin and icon-bearing poster templates. Complete means coverage of the actual navigation/actions, all four modes, social/messaging, privacy, status, accessibility and staff workflows—not downloading every available asset.

Do not use Material Icons/Material Symbols, including their rounded variants, or Flutter's built-in Material/Cupertino icon sets for app-owned iconography. Next.js has no built-in icon family; do not adopt starter/shadcn/component-library icons merely because they are supplied by default. Replace implicit widget/component icons as well as explicitly imported glyphs with the chosen family.

Rounded contours, stroke caps/joins, visual weight and optical sizing must form one consistent system; placing a sharp glyph inside a rounded box is not sufficient. Use semantic icon aliases behind a shared contract with Flutter/React adapters, local approved assets, accessible names and the existing touch-target rules. Missing coverage must be resolved before adoption, not patched with another family or emoji.

This restriction is about icon artwork, not a ban on accessible Material widget primitives, Flutter's `Icon` rendering widget or native OS-owned share sheets/keyboards. Native system UI and legitimate provider brand marks retain their platform/brand requirements; they are not fallback libraries for app navigation.

At the time of this instruction, the icon vendor/family was **not selected**. Decision 0004 subsequently selected **Hugeicons Free Stroke Rounded** as the family. M00-T04 still requires the exact pins, coverage, matching Flutter/React assets, licensing/distribution notices (including poster output) and integration evidence. M00-T09 validates a representative icon catalog on both themes and target sizes. No paid tier or license purchase is authorized.

### ApexCharts for user-web charts

ApexCharts is selected for user-website data-series charts. Exact core/React-wrapper versions, Next.js compatibility, applicable license/entitlements and bundle/runtime behavior remain validation gates. Do not assume it is free for every intended deployment or substitute Recharts/Chart.js because a UI template supplies them. Decision 0004 confirms an installation/integration hold pending licensing clarification; it does not authorize supplier contact or a purchase.

Use a browser-only chart adapter with safe loading boundaries, authorized/minimized data, explicit theme tokens, rounded appropriate marks, readable labels and accessible numeric/table alternatives. Library toolbar icons must be replaced with the selected icon family or unused controls disabled. Built-in download/export is not automatically an approved product capability.

Calendar navigation, contribution cells and simple semantic progress indicators may remain purpose-built accessible components; they are not a reason to introduce a second data-chart library. ApexCharts is not selected as the canonical poster renderer or a mobile WebView dependency.

Admin uses the same rounded icon system. If operational charts are introduced, reusing the ApexCharts adapter is a recommendation for consistency, not a new admin-chart feature or a separately approved admin integration; confirm its scope/license during dependency review.

### Flutter charts may be custom where needed

Use native Flutter widgets and custom rendering such as `CustomPainter` where required to achieve the design. Custom charts must provide semantics, data summaries, selection/hit testing where interactive, reduced motion, bounded performance and correct resize/theme behavior. Do not assume that drawing pixels supplies accessibility.

No Flutter chart package is selected by this decision. Evaluate a library only if justified and separately approved; do not automatically install `fl_chart`, force an ApexCharts WebView, or build an unnecessary general-purpose chart engine.

## Invariants and follow-up

- Keep neutral chart styling, labeled patterns/series, both themes and all four adaptive classes; no default rainbow palette.
- Exact Money values/calculations remain authoritative; chart coordinates may be bounded approximations, but labels/tooltips/tables use exact canonical values. Hidden values cannot leak through chart data, labels, accessible text or exports.
- Review actual licenses and versions before implementation; record blockers rather than silently substituting libraries.
- Add icon provenance/coverage, browser loading/privacy and Flutter custom-chart semantics/performance checks to the affected tasks. All implementation checks remain unverified.
- At the time of this decision, M00-T02 P01–P11 still awaited their own owner response. They were subsequently accepted separately in [Decision 0003](0003-product-defaults.md). This icon/chart instruction itself did not start the reference audit, approve the full toolchain or pass M00's scaffold gate.

Implementation authority: [Design system](../design-system.md), [Mobile](../../MOBILE_TECH_SPEC.md), [Website](../../WEB_PRD.md), [Admin](../../ADMIN_CMS_PRD.md), [Testing](../testing.md), and [M00 tracking](../../milestones/00-decisions-and-validation.md).
