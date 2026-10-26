# API endpoint map

[README](../README.md) · [Modules](MODULE_INDEX.md) · [Traceability](TRACEABILITY.md)

Only the following routes are currently registered. They are unauthenticated **local development/test** health checks, not public production endpoints. [HTTP composition](../src/app.ts) adds `/v1`, `Cache-Control: no-store` and `X-Content-Type-Options: nosniff`; [main](../src/main.ts) binds loopback after configuration validation.

| Method / path | Module → handler | Actual response | Evidence |
|---|---|---|---|
| `GET /v1/health/live` | [HealthModule](../src/health/health.module.ts) → [HealthController.live](../src/health/health.controller.ts) | 200, constant `{"status":"ok"}`; no dependency or personal information | [Loopback HTTP test](../test/health.test.mjs) |
| `GET /v1/health/ready` | HealthModule → [HealthController.ready](../src/health/health.controller.ts) | 503, constant `{"status":"not_ready"}`; listening is not readiness for personal records | [Loopback HTTP test](../test/health.test.mjs) |

There is no OpenAPI artifact or operation-ID assignment yet. The tests also assert 404 for synthetic identity/login/refresh/reset and upload/sync/operator/Money requests. S0's [identity contracts/pure policy](../src/modules/identity/README.md) are uncomposed; there is no auth endpoint or provider/guard integration. That absence is **not** proof of authorization for future endpoints.

## Planned contracts

All domain URLs in the [root endpoint-to-file map](../../../docs/BACKEND_TECH_SPEC.md#74-endpoint-to-file-map) remain proposed/unimplemented, including **`POST /v1/sync/commands`**. No alternate sync path is introduced here. Future endpoints must map to an owning module, approved request/response contract, authorization and actual integration evidence; do not expose this development health shell as a deployment.
