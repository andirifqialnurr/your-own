# Health module

[Module index](../../docs/MODULE_INDEX.md) · [Actual endpoints](../../docs/ENDPOINT_MAP.md)

[HealthModule](health.module.ts) is the public composition entry imported by [AppModule](../app.module.ts). [HealthController](health.controller.ts) is internal transport, returning only constant liveness and deliberately unavailable readiness statuses. No table, repository, worker, queue or domain service is owned here.

[Loopback tests](../../test/health.test.mjs) cover responses, headers and absent product routes. Configuration/startup tests belong to [the application](../../test/environment.test.mjs). A future dependency-readiness implementation needs its own approved service integration and failure evidence; do not return ready merely because HTTP is listening.
