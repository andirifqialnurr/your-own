# API job and event map

[README](../README.md) · [Modules](MODULE_INDEX.md) · [Traceability](TRACEABILITY.md)

**Current inventory: zero jobs, durable events, processors or queue consumers.** [AppModule](../src/app.module.ts) imports only HealthModule. Neither a worker entry point nor a dispatcher, database outbox, queue adapter or scheduler exists. Health requests produce no work. The uncomposed [S0 identity contracts/pure policy](../src/modules/identity/README.md) declare no service implementation, audit/outbox event, sender or job and add no work. [HTTP tests](../test/health.test.mjs) exercise only the local shell.

## Planned, not implemented

The [backend job contract](../../../docs/BACKEND_TECH_SPEC.md) and [architecture](../../../docs/cookbook/architecture.md#6-domain-boundaries) describe future rendering, notifications, export/deletion and outbox processing. Providers and operational gates remain unresolved; no event names or fictional processor paths are assigned here.

When a real slice adds a job, record its owning module, event/job name and version, producer and processor source links, durable transaction boundary, stable idempotency identity, retry eligibility, current-authorization checks and automated/recovery evidence. HTTP and worker composition stay separate. A queue enqueue is not durable domain acceptance, and a successful mock does not verify delivery or restart recovery. Use synthetic identifiers only; never store private payloads or credentials in this map.
