# Mobile feature and ownership index

[README](../README.md) · [Routes](ROUTE_MAP.md) · [Components](COMPONENT_CATALOG.md) · [Traceability](TRACEABILITY.md)

One Flutter source tree serves all usable window classes. These are **current files**, distinct from the [proposed feature map](../../../docs/MOBILE_TECH_SPEC.md#5-proposed-project-structure).

| Owner | Entry / implementation | Contract and limits | Tests |
|---|---|---|---|
| Startup/config | [development](../lib/main_development.dart), [staging](../lib/main_staging.dart), [production](../lib/main_production.dart), [default main](../lib/main.dart), [config](../lib/core/config/app_config.dart), [bootstrap](../lib/app/bootstrap.dart) | Only development starts; other environments fail closed before services. No URLs/secrets. | [Config](../test/config_test.dart), [first-frame restore](../test/appearance_widget_test.dart) |
| App composition | [YourOwnApp](../lib/app/app.dart), [router](../lib/app/router/app_router.dart), [destinations](../lib/app/router/app_destination.dart), [shell](../lib/app/shell/app_shell.dart) | Stable router per session; retained branch navigation, layout does not recreate feature state. Router imports only under app. | [Adaptive shell](../test/adaptive_shell_test.dart) |
| Appearance | [controller](../lib/app/appearance/appearance_controller.dart), [pure contract](../lib/core/domain/appearance_preference.dart), [adapter](../lib/core/preferences/shared_preferences_appearance_store.dart) | `AppearancePreferenceStore`; only `your_own.appearance.v1`. Bounded read, immediate session selection, serialized/coalesced saves, visible failures/retry. Not credential or record storage. | [Controller](../test/appearance_controller_test.dart), [store double](../test/appearance_store_test.dart), [widgets](../test/appearance_widget_test.dart) |
| Setup presentation | [feature README](../lib/features/setup/README.md), [settings](../lib/features/setup/presentation/setup_screen.dart), [foundation page](../lib/features/setup/presentation/foundation_page.dart) | Receives pure appearance values/callbacks. No router/vendor/storage imports or cross-feature public contract yet. | [App](../test/app_test.dart), [appearance](../test/appearance_widget_test.dart), [routes](../test/adaptive_shell_test.dart) |
| Development catalog | [CatalogScreen](../lib/app/catalog/catalog_screen.dart) | App composition, not a tracker feature; debug-only synthetic in-memory examples. | [Shared UI](../test/shared_ui_test.dart), [goldens](../test/catalog_golden_test.dart) |
| Localization/assets | [English ARB](../lib/l10n/app_en.arb), [l10n config](../l10n.yaml), [generated output](../lib/l10n/generated/), [font registration](../lib/app/font_licenses.dart), [font provenance/license](../assets/fonts/README.md) | ARB is authoritative; regenerate, do not hand-edit. Bundled DM Sans, no runtime font fetching. English-first, not global locale coverage. | [Theme](../test/theme_test.dart), [asset check](../../../scripts/check-mobile-assets.mjs) |
| Shared presentation | [Component catalog](COMPONENT_CATALOG.md) | No application/feature/service ownership; pure UI contracts and injected callbacks. | [Import policy](../../../docs/cookbook/import-boundaries.md), widget/visual cases |

## Planned, not implemented

Account/session scope, onboarding, Focus, Read, Intake, Money, real Today/Progress, card generation/export, social/profile, messaging, notifications, encrypted storage, sync and network repositories remain future [milestone slices](../../../docs/milestones/README.md#milestone-map). The four visible destinations do not implement those features. Riverpod/Dio/Drift directions are not installed feature architecture.

When a feature becomes real, add its public contract, domain/data/presentation owners and specific tests here. Keep framework dependencies out of domain contracts; no direct presentation-to-persistence access. [Specifications](../../../docs/MOBILE_TECH_SPEC.md) and shared [decisions](../../../docs/cookbook/decisions/0012-local-development-bootstrap.md) outrank this index.
