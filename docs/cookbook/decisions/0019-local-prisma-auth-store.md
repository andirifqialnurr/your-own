# Decision 0019 — Isolated PostgreSQL/Prisma authentication-store test

- **Status:** Authorized external DB/store phase passed; not application adoption/full T07 acceptance
- **Approved by:** Project owner, 2026-10-26 UTC
- **Recorded by:** Coding agent
- **Sources:** [Real Nest candidate phase](../local-nest-authentication-spike.md), [prior exact Prisma/image review](../prisma-engine-follow-up.md)

## Owner authorization

After commit `f002158`, the assistant asked **“Next: test durable authentication storage with isolated PostgreSQL/Prisma. May I proceed?”** The owner replied **“continue”**. Authorize that external synthetic database/store phase only, not product database/schema/auth integration or M02.

## Preflight and scope

D: currently has less than the earlier 20 GiB experimental-allocation reserve. Do not allocate experiment/cache/database files there, clean unrelated files or lower the reserve. Use C: for the external workspace/cache and task-owned Docker storage only: its free space exceeds 20 GiB, Docker Desktop uses its existing default C: data VHDX (present and in use; no disk-location override found), and no image pull is needed. Existing D: probe files may be read/rehashed, never modified. Repository documentation evidence is not experimental DB storage. Stop if the C: reserve cannot be retained or storage placement becomes unresolved.

- Reuse installed Node 24.18.0 / pnpm 12.8.1 / TypeScript 6.0.3, exact Nest authentication 0.1.1, Prisma/client/adapter 7.10.1, pg 8.23.1 and the already reviewed official PostgreSQL 18.6-bookworm linux/amd64 manifest `sha256:6b38fe68f2c02cafffbbce7496f76d110d8a947c039bd22c067e9a43c2250240`. Reverify artifacts/config/RootFS and native engine hash; no version/platform substitution or checksum/TLS bypass.
- Prefer reusing the two separately frozen reviewed tool graphs through a type-only/store-runtime boundary. Do not claim they are a tested combined application graph. If a combined graph/new identity is necessary, review it before installation/execution. Keep strict peers, scripts denied, exact pins and dependency verification. No application/source/lock/config adoption or global changes. Existing Prisma notice/native/distribution gaps remain shipping blockers.
- One uniquely labeled task-owned container at a time, random **127.0.0.1** port, **2 CPUs / 1 GiB**, read-only root, non-root postgres UID 999, dropped capabilities/no-new-privileges, bounded tmpfs/runtime logs/connections/WAL/temp files and small synthetic datasets. One task-owned labeled Docker volume may persist only scratch PGDATA across an explicit DB-container restart, then must be removed after ownership checks. No socket/host/application mounts, personal DB connection, unrelated resource stop/prune or Docker settings change.
- Keep additional task workspace/cache/DB allocations under **3 GiB** and **20 GiB free on C:**; target ten minutes per DB run. Record footprint/placement limitations honestly. Two existing unrelated service containers remain untouched.
- Separate initialization/migration/runtime credentials generated in memory; least-privilege schema/DML runtime, no superuser/CREATEDB/CREATEROLE/BYPASSRLS, no migration-metadata grants. SQL migrations/schema/client generation and CLI operations live outside the app; use only the previously checksum-verified engine and deny additional automatic downloads. No original `.env` load or real credentials.
- Implement required auth contracts only: sessions, refresh tokens/families, TOTP/recovery/attempts and purpose-bound email tokens. Compile against actual package types and run its unmodified contract cases with concurrency enabled on real pooled PostgreSQL. Add explicit lock barriers, failure/rollback checks, denial controls and process/DB restart proof as feasible; distinguish these from scheduler-only races. Do not enable social methods, magic-link/OIDC/API keys or infer production auth policy.
- Synthetic test records and in-memory mail only, no SMTP/cloud/R2/browser/native. Retain original failures and sanitized results, never raw tokens/passwords/cookies/TOTP seeds/connection strings. Close clients, verify owned labels/image/IDs before teardown, remove only the task container/volume and confirm port closure. Preserve reviewed caches and unrelated resources.

## Acceptance boundary

This proves only the recorded external store/protocol cases; it does not accept a production auth package, store schema/key/recovery/expiry/hosting policy, transactional tracker integration, immediate access-JWT revocation, full staff freshness, real email/browser/native durability or app/M02 execution. Record actual outcomes and remaining gates, then commit/push separately under existing owner instruction. Historical 13 snapshots, prior failure evidence, owner browser R2 success and script 403 remain intact.

## Execution checkpoint

The [real-store report](../prisma-auth-store-spike.md) records two unchanged frozen tool graphs, exact auth/engine verification, repeat-identical generation, strict caller build and real Prisma migration/repeat/status. **29 tests pass twice** (24 unmodified published contracts plus five owned checks), with three explicit database barriers, four expected-red adapter controls, rollback/least-privilege denials and fresh-process/database-restart persistence. Initial offline-cache, alias/compiler, generated-import and restart-port fixture failures remain recorded. All four owned containers/volumes were removed; final run verified both assigned ports closed and two unrelated services untouched. Allocations stayed on C: above its 20 GiB reserve; no D: test data, policy waiver, app graph/schema/source/config/R2 or M02 change. Full auth/staff/platform/policy gates remain open.
