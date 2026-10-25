# Mobile route map

[README](../README.md) · [Features](FEATURE_INDEX.md) · [Components](COMPONENT_CATALOG.md) · [Traceability](TRACEABILITY.md)

[createAppRouter](../lib/app/router/app_router.dart) owns the following local routes. [AppDestination](../lib/app/router/app_destination.dart) defines the four branch paths/labels/symbols; [AppShell](../lib/app/shell/app_shell.dart) changes navigation placement without changing their identity.

| Route | Composition / actual screen | Access and navigation | Evidence |
|---|---|---|---|
| `/today` | [FoundationPage](../lib/features/setup/presentation/foundation_page.dart): setup information | Initial branch, not a dashboard; offers appearance link | [Adaptive shell tests](../test/adaptive_shell_test.dart) |
| `/progress` | FoundationPage: unavailable summaries | Retained branch; no tracker data | Adaptive shell tests |
| `/circle` | FoundationPage: unavailable sharing | Retained branch; Messages entry pushes `/messages` | Adaptive shell tests |
| `/you` | [SetupScreen](../lib/features/setup/presentation/setup_screen.dart) | Working appearance choice/retry and DM Sans notice; catalog entry in debug only | [Appearance widgets](../test/appearance_widget_test.dart), [shared UI tests](../test/shared_ui_test.dart) |
| `/messages` | FoundationPage: messaging/unread unavailable | Root route; Back pops when possible, otherwise returns to Circle. No fake unread count | Adaptive shell tests, pushed/direct entry |
| `/unavailable` and unmatched paths | Neutral FoundationPage | No route/error/user input echoed; safe appearance link | Adaptive shell tests, invalid/untrusted-looking paths |
| `/dev/catalog` | [CatalogScreen](../lib/app/catalog/catalog_screen.dart) | `kDebugMode` guards route and entry. Back pops or returns to You on direct entry; synthetic data only | Shared UI tests, [goldens](../test/catalog_golden_test.dart) |

URI schemes, authorities, queries and fragments redirect to the neutral unavailable page. These rules are not an authentication mechanism or approved external deep-link contract. No native link registration, session guard, domain detail/master-detail route or process-death restoration exists.

The app owns one stable router outside theme/layout builders; injected routers remain caller-owned. Inactive branches remain mounted but are offstage, excluded from focus/semantics and widget tickers disabled. This does not stop domain timers automatically. [Synthetic nested detail tests](../test/adaptive_shell_test.dart) preserve draft/selection/focus/scroll/hidden value/timer/write count; their `/today/item/:id` path is **test-only**, not a production route.

## Planned

Auth/onboarding, tracker details/editors, real social/DM navigation and permission-aware deep links follow the [mobile routing contract](../../../docs/MOBILE_TECH_SPEC.md) and [milestone prerequisites](../../../docs/milestones/README.md). Add actual source/test links when implemented; do not turn a proposed URL into a public promise by listing it here.
