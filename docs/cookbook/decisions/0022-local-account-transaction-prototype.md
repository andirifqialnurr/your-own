# Decision 0022 — Isolated account-transaction and live-grant prototype

- **Status:** Owner-authorized external evaluation passed within recorded subset; not product adoption
- **Authorized by:** Project owner, 2026-10-26 UTC
- **Recorded by:** Coding agent
- **Sources:** [Design review](../authentication-transaction-review.md), [Decision 0021](0021-auth-transaction-design-review.md)

## Explicit continuation

After `2e0da4d`, the assistant asked: **“May I test it next in an isolated PostgreSQL prototype, without app integration?”** The owner replied **“continue”**. Authorize evaluation of the review's R1–R3 account-generation/live-grant/shared-transaction model with synthetic data only. This is not adoption of that model, the candidate library, a product schema/wire contract or M02.

## Bounded execution

- External C:-only fixture, original repository/app/locks/policies/assets/config and prior evidence untouched. Recheck current free space and Docker's actual storage placement; keep at least 20 GiB free and under 3 GiB additional allocation. D: now has more free space than in the previous task, but receives no experimental files; do not assume it remains below reserve or infer unrelated cleanup.
- Reuse the two separately frozen reviewed graphs and installed pins: auth 0.1.1/Nest 12.2.0, Prisma/client/adapter 7.10.1/pg 8.23.1, Node 24.18.0/pnpm 12.8.1/TypeScript 6.0.3. Frozen, offline, scripts denied, strict peers/engines and fail-closed dependency policy; no combined product resolution, new identity, vendor patch, weaker hashing or checksum/TLS bypass.
- Reuse the exact official PostgreSQL 18.6-bookworm/linux-amd64 manifest `sha256:6b38fe68f2c02cafffbbce7496f76d110d8a947c039bd22c067e9a43c2250240` with `--pull never` and the previously verified native engine, rehashed before use. One task-owned labeled container/volume at a time, non-root/read-only root, dropped capabilities/no-new-privileges, 2 CPUs/1 GiB, random 127.0.0.1 DB port, bounded logs/WAL/tmpfs/temp files/connections and ten-minute run bound. No host/app/socket mounts or settings changes. Preserve unrelated services; ownership-check teardown and closed ports/processes.
- Synthetic durable account/credential/grant/binding/audit/outbox tables and an explicitly transaction-aware owned adapter may be created only in the scratch database. Use the unmodified real library's hashing/reset/token/MFA services; typed transaction clients, conditional account rechecks and real SQL failures/barriers. No custom reset/password crypto or private vendor imports. A compatible SHA-256 token lookup may route the account lock only; the real service remains the redemption/fingerprint authority.
- Independent Node/Nest service processes with separate clients may communicate through private test IPC rather than new HTTP routes. Distinguish process/service evidence from previous HTTP, actual browser/BFF and native proof. Test rollback/commit failure, late password verification/refresh/MFA vs revocation, live JWT/account/grant checks, intended-denial commit semantics, safe post-commit response buffering and default-cost transaction bounds. Record only the subset actually proved; restore/key custody, production capacity and every design-matrix row are not implied.
- Synthetic mail sink only; ephemeral in-memory keys/passwords/tokens and redacted logs. No original `.env` loading/copying, real accounts/staff provisioning, SMTP/notifications, R2/cloud, browser/native, worker/deployment or release. No tokens/cookies mailed/published before a successful commit; library diagnostics are not durable audit/outbox. Independent expected-red owned controls are allowed, not vendor modifications.

## Recorded result

The [prototype report](../account-transaction-prototype.md) records 30 entries passing twice, six expected-red owned controls, real deferred COMMIT/rollback and DB lock-wait observations, and 24 final cleanly exited service-process lifecycles. Synthetic account/grant state is durable; added owned live checks invalidate access while the bare JWT signature remains valid. All three task container/volume lifecycles are removed, including the preserved initial reenrollment-fixture failure and preliminary positive checkpoint. This is service/process/SQL evidence, not complete HTTP/BFF/browser/native/restore/key-custody or production adoption.

## Completion gate

Preserve failures, exact source/graph hashes and resource evidence; report results/limits, run existing repository/documentation/preservation/redaction checks, then separately commit/push. Stop on real storage/permission/setup blockers rather than changing host policy. No full T06/T07/M01/M02 acceptance, product integration or production token/hash/expiry/key/recovery/hosting/retention policy follows.
