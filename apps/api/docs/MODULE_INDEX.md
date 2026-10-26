# API module index

[API README](../README.md) · [Endpoints](ENDPOINT_MAP.md) · [Jobs](JOB_MAP.md) · [Traceability](TRACEABILITY.md)

Current local foundation, not the [proposed backend module inventory](../../../docs/BACKEND_TECH_SPEC.md#6-nestjs-module-ownership). Paths below exist; there is no domain database or authenticated service.

| Owner | Entry / implementation | Public contract and dependencies | Checks |
|---|---|---|---|
| HTTP composition | [main.ts](../src/main.ts), [app.ts](../src/app.ts), [AppModule](../src/app.module.ts) | `createApplication()` returns an unbound Nest application; main validates config then binds loopback. Imports HealthModule, not a worker. | [environment](../test/environment.test.mjs), [HTTP](../test/health.test.mjs) |
| Configuration | [environment.ts](../src/config/environment.ts) | Pure `readEnvironment`, `AppConfig`, `ConfigurationError`; development/test only, explicit loopback and bounded port. | [environment](../test/environment.test.mjs) |
| Health | [module README](../src/health/README.md), [HealthModule](../src/health/health.module.ts) | Public HTTP-composition entry; controller remains internal. No domain service, DB table or queue ownership. | [HTTP](../test/health.test.mjs) |
| Identity S0 (uncomposed) | [README](../src/modules/identity/README.md), [pure public entry](../src/modules/identity/index.ts) | [Actor facts](../src/modules/identity/contracts/actor-context.ts), [authority/outcomes](../src/modules/identity/contracts/identity-authority.ts), [pure policy](../src/modules/identity/domain/identity-access.ts). No credential authority implementation, Nest module, DI, store or route. | [Synthetic policy/type tests](../test/identity-context.test.mjs), [scope/evidence](../../../docs/cookbook/identity-contract-s0.md) |
| Dependency regression fixture | [runner](../test/multer.test.mjs), [cases](../test/multer-regressions.cjs) | Test-only multipart handling under the exact parent-scoped Multer override; not an exposed upload feature. | Ten isolated child-process cases |

[Import policy and fixtures](../../../docs/cookbook/import-boundaries.md) enforce initial boundaries; the compiler and behavior tests remain necessary. TypeScript source imports use `.js` specifiers for the emitted ESM build.

## Planned, not implemented

Runtime identity/provider integration, users, authorization services, staff access, all trackers, sync, cards/media, social, messaging, jobs/audit/moderation and lifecycle belong to later approved slices. The S0 contract-only identity files above exist, but do not implement those services. See the root [module/path map](../../../docs/cookbook/architecture.md#52-feature-to-application-path-map), [schema ownership](../../../docs/cookbook/schema.md) and [roadmap](../../../docs/milestones/README.md). Only S0's deliberate pure public entry exists; no provider/migration implementation, empty domain scaffolding or worker root has been created.

The owner subsequently authorized S0/order exception in [Decision 0024](../../../docs/cookbook/decisions/0024-local-identity-contract-s0.md). Its [local contract/policy scope](../../../docs/cookbook/identity-contract-s0.md) is implemented without dependencies, provider/store, AppModule wiring or routes. Full M02 remains Planned; the [adoption packet](../../../docs/cookbook/authentication-app-adoption.md) retains all later integration gates. No prototype is ported.

Update this index, endpoints/jobs and traceability together when adding or moving a real module. Root specifications and shared [decisions](../../../docs/cookbook/decisions/0012-local-development-bootstrap.md) remain authoritative; this index does not approve a provider or change a contract.
