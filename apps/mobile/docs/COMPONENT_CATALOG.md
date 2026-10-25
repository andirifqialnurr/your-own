# Mobile component catalog index

[README](../README.md) · [Features](FEATURE_INDEX.md) · [Routes](ROUTE_MAP.md) · [Traceability](TRACEABILITY.md)

The executable catalog is **You → UI development catalog** in debug builds: [CatalogScreen](../lib/app/catalog/catalog_screen.dart). It uses only synthetic/in-memory examples. The root [design system](../../../docs/cookbook/design-system.md) owns requirements; this index lists the first implemented subset, not every future product control.

| Component / owner | Actual contract | Fixtures / tests |
|---|---|---|
| [AppButton, AppIconButton](../lib/shared_ui/controls/app_button.dart) | Primary/secondary/ghost, selected secondary state, controlled busy/disabled, optional semantic icon; caller owns submission guard, result and idempotency | Catalog Actions; [shared UI tests](../test/shared_ui_test.dart) |
| [AppTextField](../lib/shared_ui/controls/app_text_field.dart) | Caller-owned controller/focus, label/helper/error, enabled/read-only; owned Cut/Copy/Paste/Select all toolbar. No numeric/currency/password policy | Catalog Fields; shared UI tests (validation, clipboard, pending/error draft preservation) |
| [AppCard](../lib/shared_ui/surfaces/app_card.dart) | Static themed surface, not an implicit interactive button | Catalog cards; shared UI and [golden tests](../test/catalog_golden_test.dart) |
| [AppStatusPanel, AppStatusKind](../lib/shared_ui/feedback/app_status_panel.dart) | Labeled loading/empty/error/unavailable states; optional injected action. No inferred network or persistence outcome | Catalog Feedback; shared UI/golden tests |
| [AppDialog, showAppConfirmation](../lib/shared_ui/overlays/app_dialog.dart) | Compact/short full-window or bounded dialog, stable child state, scrolling, wrapping actions. Confirmation returns intent only; Cancel initially focused, closed-loop focus and trigger restoration | Catalog Actions; modal/keyboard/reflow tests and dialog goldens |
| [AppIcon, AppSymbol](../lib/shared_ui/icons/app_icon.dart) | 28 closed Hugeicons Free Stroke Rounded aliases, decorative semantics and directional RTL mirroring. Adjacent control owns accessible name; no arbitrary SVG input | Catalog Icons; [adapter test](../test/app_icon_test.dart), shared UI tests, contact-sheet goldens |
| [AppFocusOutline](../lib/shared_ui/theme/app_focus_outline.dart) | Stable visible focus ring using semantic tokens | Navigation, appearance and shared UI keyboard tests |
| [LayoutPolicy, LayoutScope](../lib/shared_ui/layout/layout_policy.dart), [BoundedPage](../lib/shared_ui/layout/bounded_page.dart) | Four usable-width classes, short-height/label-fit fallback, bounded scrollable content | [Policy tests](../test/layout_policy_test.dart), [adaptive tests](../test/adaptive_shell_test.dart) |
| [AppTheme](../lib/shared_ui/theme/app_theme.dart), [generated tokens](../lib/shared_ui/theme/app_tokens.g.dart) | Explicit zinc palettes and DM Sans; source is [tokens.json](../../../design/tokens.json), regenerate via root `pnpm tokens:generate` | [Theme tests](../test/theme_test.dart), [generator tests](../../../scripts/design/design.test.mjs) |
| [FontLicenseDialog](../lib/shared_ui/theme/font_license_dialog.dart) | Bundled OFL loading/error/content, scrollable text and Close; no remote fallback | [Appearance widget tests](../test/appearance_widget_test.dart) |

[Golden instructions and notices](../test/goldens/README.md) cover ten Light/Dark Windows-host images. Tests await bundled font/SVG loading; review images when intentionally updating, then repeat comparisons without update mode. [Artwork guard](../../../scripts/check-mobile-ui.mjs) plus [negative fixtures](../../../scripts/design/ui.test.mjs) complement, not replace, rendered/semantic review.

## Remaining inventory and gates

Native screen-reader/IME/rendering, complete product pickers/menus/tables, charts, encrypted drafts and final packaging/notices remain unverified or planned. No chart engine, domain form, upload/share service or arbitrary asset loader is supplied by these primitives. A demo confirmation never authorizes a domain mutation. Host goldens and synthetic timers do not prove native durability, accessibility compliance or real-data privacy.
