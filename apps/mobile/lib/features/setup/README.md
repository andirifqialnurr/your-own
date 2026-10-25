# Setup presentation

[Feature index](../../../docs/FEATURE_INDEX.md) · [Routes](../../../docs/ROUTE_MAP.md)

[SetupScreen](presentation/setup_screen.dart) presents appearance settings and the bundled font notice. [FoundationPage](presentation/foundation_page.dart) presents honest setup/unavailable text and injected navigation callbacks. The [app router](../../app/router/app_router.dart) composes these screens.

Inputs are pure appearance values, pending/error state and callbacks. This feature imports no router, concrete preference store or app-owned service. There is no domain/data layer or cross-feature public entry yet; creating empty layers would not add a useful contract.

[App](../../../test/app_test.dart), [appearance](../../../test/appearance_widget_test.dart) and [adaptive](../../../test/adaptive_shell_test.dart) tests cover the current shell. This is not account onboarding, tracker data, social service or native durability evidence. Keep later product settings in their approved owning slice rather than growing this development feature into a miscellaneous service container.
