# Mobile Shared UI — M01-T07

- **Checkpoint:** 2026-10-25 UTC; coding agent implementation/review, not release acceptance.
- **Status:** Implemented; host widget/semantic/visual checks pass. Native accessibility/IME/rendering verification remains pending; T07 stays unchecked.
- **Authorization:** [Decision 0012 continuation](decisions/0012-local-development-bootstrap.md#shared-ui-continuation), following T06's separate `df3a85c` commit/push. The owner's per-task publication instruction remains in force.
- **Contracts:** [Design components](design-system.md#51-universal-component-contract), [mobile UI](../MOBILE_TECH_SPEC.md#9-design-system-and-accessibility), [testing](testing.md#8-adaptive-ui-and-accessibility), [M01](../milestones/01-foundations.md).

## Scope and use

In a debug development build, open **You → UI development catalog** (`/dev/catalog`). Both the entry and route are guarded by `kDebugMode`; profile/release artifact exclusion still needs actual build evidence. Existing staging/production entry points remain fail-closed. The catalog uses synthetic, in-memory examples only: no service, request, personal-record write or appearance-store access. Leaving the route disposes its input controllers; this is not durable draft storage.

| Existing path under `apps/mobile/lib/` | Contract |
|---|---|
| `shared_ui/controls/app_button.dart` | Primary/secondary/ghost, selected single-choice, disabled/pending; labeled icon-only control. 48-unit targets, wrapping text, semantic states and visible focus. Busy labels are explicit; static hourglass does not invent progress. |
| `shared_ui/controls/app_text_field.dart` | Plain-text controller/focus injection, wrapping persistent accessible label, helper/error, read-only/disabled states and 16-unit input typography. Caller owns validation and input lifetime. Not an amount/password parser. |
| `shared_ui/surfaces/app_card.dart` | Static bordered, shadow-free compact/standard surfaces; no false tap/hover behavior. |
| `shared_ui/feedback/app_status_panel.dart` | Labeled loading/empty/error/unavailable states, decorative glyphs, live feedback where applicable and explicit optional Retry. No fabricated zero or permission inference. |
| `shared_ui/overlays/app_dialog.dart` | Stable scrollable dialog tree, bounded on wide windows and full available space on compact/short windows. Confirmation defaults focus to Cancel, traps traversal, supports Escape/Back and restores the actual trigger focus. Returns intent, never performs a mutation. |
| `shared_ui/icons/app_icon.dart` | 28 closed semantic aliases using existing Free Stroke Rounded constants; 24-unit artwork, coherent stroke, decorative semantics, logical Back/Next mirroring only. No vendor names in callers, raw SVG input, Pro style or fallback. |
| `app/catalog/catalog_screen.dart` | Localized Actions / Fields / Feedback / Icons fixtures, state previews, simulated failure/retry and confirmation. Technical icon alias names remain developer identifiers. |

The plain-text toolbar uses localized SDK clipboard/selection actions with owned text buttons, instead of the SDK toolbar's implicit overflow/back glyphs. Only Cut/Copy/Paste/Select all are allowed; it does not introduce search/share actions. Clipboard operations require deliberate action; tests use a synthetic channel double. Native selection, IME, autofill and clipboard behavior remain unverified.

`AppButton.busy` is **controlled UI, not an async lock or request idempotency**. Callers must synchronously guard submissions, handle outcomes and preserve operation IDs where applicable. The catalog demonstrates same-frame guards for simulated submission and dialog opening; retains input on failure/retry/section changes; and ignores a delayed completion after disposal. None of this implements domain transactions or authorization.

Focus-ring gaps now inherit the actual parent surface rather than painting canvas-colored patches inside cards. Disabled fields use semantic disabled colors. The first icon sheet exposed awkward alias wrapping and an unsuitable Intake illustration; shorter technical labels and the existing rounded Droplet glyph corrected them. No new visual family or token palette was introduced.

## Dependencies, artwork and checks

Installed tools remain Flutter 3.38.9 / Dart 3.10.8, Node 24.18.0 / pnpm 12.8.1. **No package identity/version/archive hash was added or changed.** The already-reviewed `flutter_svg 2.3.0` is now an exact direct **dev** dependency so visual tests can await its public loader futures. The only Flutter lock change is `transitive` → `direct dev` for that package. It still exists at runtime through Hugeicons; a dev declaration does not exclude it from shipped artifacts. [T06's dependency/license review](mobile-adaptive-shell.md#dependency-and-notice-review) remains the applicable exact-version evidence; no fresh advisory audit is claimed here.

Ten [PNG baselines](../../apps/mobile/test/goldens/README.md) cover four catalog sections plus confirmation in both themes, using actual bundled fonts and rendered SVGs. All were inspected by the coding agent and normal comparison tests subsequently passed. The complete Hugeicons MIT notice accompanies the fixtures; DM Sans/OFL assets are unchanged. These are owned synthetic fixtures, not native screenshots or owner visual acceptance.

`pnpm check:ui` adds a conservative source guard for built-in icon family references, four stock navigation-glyph widgets, non-rounded/out-of-adapter vendor symbols and the Material font flag. Eleven new positive/negative tests exercise it. It also rejects forbidden text inside comments/strings; this deliberate limitation is documented in the source. It is **not a Dart parser or exhaustive proof against implicit SDK glyphs**. Runtime widget checks exercise the actual controls, dialog, text toolbar and catalog; future pickers/menus need their own audit.

## Verification and traceability

**300 tests pass:** 179 Flutter (including 20 new behavior/layout cases and ten goldens), 88 boundary, 19 API and 14 design-script tests. Root `pnpm check` passes strict lint/types/API build, token/font checks, artwork guard (**31 Dart files**) and import scan (**37 source files / 131 directives**). Flutter localization generation, analyzer, formatting and offline/enforced-lockfile repeat also pass.

| Contract | Evidence |
|---|---|
| NFR-01 / NFR-09, semantic component states | `test/shared_ui_test.dart`: names, roles, selected/disabled/pending state, actual field label, readonly/disabled configuration, explicit Copy/Paste and no built-in glyph widgets; existing theme contrast tests retained |
| NFR-07 / NFR-08, usable controls and reflow | All catalog sections at five phone/short/tablet/large windows × both themes at 200%; all action targets at least 48; dialog draft/selection/focus/element retained across resize and keyboard insets |
| NFR-01 / NFR-08, modal safety | Cancel initial focus, traversal containment, Escape and platform Back, no double modal, confirmation result and keyboard trigger-focus restoration |
| NFR-02 / NFR-08, bounded synthetic state | Same-frame simulation guard, attempt count, retained draft after failure/retry/section changes, delayed completion after dispose; no real-data/integrity claim |
| NFR-09 / icon contract | `test/catalog_golden_test.dart`: ten exact host comparisons; all 28 aliases rendered in both themes, RTL navigation mirroring, no Pro/built-in fallback; `scripts/design/ui.test.mjs` source/font regressions |
| Regression/ownership | Existing appearance/adaptive/API tests pass; import policy unchanged; `shared_ui` remains independent of app/features/persistence |

Initial failures were corrected, not suppressed: child-argument ordering, an incorrect test getter/unused imports/braces; the icon-button test now inspects the actionable button node instead of an empty outer tooltip node; the paste test explicitly selects its replacement range after Android-style Copy collapses selection. An initial **concurrent** root run hit the unchanged API entry test's 10-second child timeout (`null !== 1`); a serial repeat passed unchanged. No timeout increase, API edit, peer waiver or test exclusion was used.

External checkpoint: `C:/Users/HP/AppData/Local/Temp/your-own-ui-kyff5f9b/` holds the pre-task baseline and initial/final logs. The source, tests, notice, images and this report are the durable repository artifacts. All 13 historical evidence snapshots, root lock/policies, native wrappers, font bytes and unrelated existing files are preserved.

## Remaining gates

T03/T05/T06 and T07's applicable native checks remain open: Android/iOS/iPad rendering, real screen readers/keyboard/IME/selection, native lifecycle and release packaging/notices. Host goldens are not WCAG, privacy or native certification. No emulator, hardware inventory, Docker, deployment or real tracker/auth/social service was enabled.

This is the **first shared catalog**, not every component in the design inventory: pickers, sheets, tables, charts, feature-specific forms, full staff/web/poster icon coverage and real domain workflows remain later work. Next proposed bounded task: **M01-T08 — app-local navigation and requirement-to-test indexes**, not started.
