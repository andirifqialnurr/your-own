# Proposed local PostgreSQL / Prisma spike

- **Status:** Plan only; execution authorization pending. No package/image pins, helper, database, container or schema has been created.
- **Purpose:** Validate the accepted [Decision 0013](decisions/0013-provider-and-session-directions.md) DB/ORM direction with synthetic local evidence before affected M02 implementation. This does not close M00-T06 or replace M00-T07/T10/T11 and native gates.
- **Existing tools:** Node 24.18.0 / pnpm 12.8.1; Docker may be used under the owner's existing-tool instruction when the bounded spike is separately authorized. Do not install/upgrade global tools or inspect unrelated host/device/account state.

## Proposed scope and preparation

1. Create one task-owned temporary workspace outside the application workspace. Preserve the repository source, manifests/locks, policy exceptions, original `.env`, historical evidence, reference apps and any existing Docker resources. No `apps/api/prisma/` or feature migration is introduced by the probe.
2. Review a small exact graph: Prisma CLI/client, the compatible PostgreSQL driver/adapter if required, and only needed test/compiler tooling. Record availability, Node/TS compatibility, peers/engines, full license notices, advisories, native/download/install hooks and transitive deltas **before installation/execution**. Current pins, strict peers, disabled automatic peers/lifecycle scripts and fail-closed pre-script verification remain. If generation needs an unreviewed hook/download, stop for scoped review instead of enabling scripts globally or adding a bypass.
3. Select a supported exact official PostgreSQL image/tag and immutable digest after checking image/platform/license/security information. Do not use `latest`, assume a cached image or pull the full Supabase stack. A local image's success will not certify the hosted provider's network/pooler configuration.
4. Check only the current free space and owned-resource footprint needed for allocation; set a bounded time/storage/memory/CPU envelope before execution. Do not rerun hardware inventory, change Docker/virtualization/security settings, prune caches or interrupt existing containers. Stop/report if the installed daemon cannot run within that scope.
5. Use one uniquely named/labeled container with an ephemeral test data area and only a randomly assigned **127.0.0.1** host port. No public bind, privileged mode, Docker socket mount or application-directory mount. Generate task-local credentials at execution time; never copy the original `.env`, put credentials in committed fixtures or print connection strings/passwords in logs. The initialization identity is only for provisioning the synthetic roles/database.

These are proposed constraints, not invented installed artifacts or approved resource sizes. Review exact versions/digests and actual resource availability at execution time. No cloud credentials, Supabase project, external email or paid service is needed.

## Required synthetic cases

| Case | Evidence required from a real local PostgreSQL connection |
|---|---|
| Generation/build | Exact reviewed CLI generates from a minimal synthetic schema; generated client compiles/runs with installed Node 24 / strict TS6. Record engine/driver resolution and lifecycle behavior. |
| Reproducible migration | Apply the scratch migration to an empty owned database, then verify an idempotent deployment repeat and a second empty owned database produce equivalent intended structure. No production reset, `db push` shortcut or provider-owned schema changes. |
| Least privilege | Separate migrator and runtime credentials. Runtime can perform intended DML but fails DDL/schema creation and privilege escalation; inspect role flags to prove no superuser/CREATEDB/CREATEROLE/BYPASSRLS grant. Session-store/provider schemas are not needed. |
| Exact values | Persist/reload a synthetic BIGINT above JavaScript's safe integer range (for example decimal string `9007199254740993`) without conversion through `Number`; explicit JSON/DTO encoding remains separate. This is not Money-range/currency approval. |
| Atomic failure | A deliberately failed multi-row transaction leaves none of the intended rows/effects committed. Assert counts/state via a fresh connection, not only caught exceptions. |
| Conflicting attempts | Two real concurrent connections/barriers contend on the same synthetic revision/unique operation key; show the expected accepted/conflict result and no duplicate effect. This is a primitive probe, not full receipt/sync correctness or exactly-once network delivery. |
| Constraints/indexes | Demonstrate a reviewed SQL check/unique or partial index not represented solely by the ORM model; invalid rows fail in PostgreSQL. Do not use SQLite/mocks to claim this. |
| Teardown | Close owned connections, stop/remove only the labeled task-owned container and task-owned test storage after verified identity checks; preserve sanitized logs/locks/notices. Verify the test port/process no longer serves and record any retained downloaded image/cache footprint. Never run global prune or remove unrelated volumes. |

Every failure is retained. Frozen/offline repetition is required where the already-reviewed cache permits it; missing cache or advisory/compatibility failures stop rather than silently change versions, install scripts, drivers or policy. The probe must not expose an API, start a worker, create users or store private data.

## Non-claims and report

Record exact tools, dependency lock/hash/notice review, image digest, migration/schema/role fixtures, commands, positive/negative results and teardown. A partial pass stays partial. In particular this does **not** prove Supabase Auth/Storage/pooling, TLS/hosted networking, browser sessions/CSRF/MFA/revocation, encrypted mobile persistence, complete Money constraints, owner stream ordering, backup/recovery targets or production readiness.

After a separately authorized run, commit/push its reviewed report independently under the owner's per-task instruction; do not copy disposable probe source into the product or open M02 automatically. Resolve remaining provider/hosting/region/budget/auth-method/session-store/secret/recovery decisions explicitly.

**Execution question:** may the agent run this isolated synthetic local PostgreSQL/Prisma probe using the installed tools and Docker if needed, after exact package/image/resource review, with no Supabase/cloud project, paid service, external email or product migration?
