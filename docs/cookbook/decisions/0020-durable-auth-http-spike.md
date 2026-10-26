# Decision 0020 — Isolated durable authentication HTTP composition

- **Status:** Owner-authorized external composition phase passed within scope; not app adoption/full T07 acceptance
- **Approved by:** Project owner, 2026-10-26 UTC
- **Recorded by:** Coding agent
- **Sources:** [Real store report](../prisma-auth-store-spike.md), [Decision 0019](0019-local-prisma-auth-store.md)

## Owner continuation

After `b2ca449`, the next proposed scope was external HTTP composition of the real auth module and durable store. The owner replied **“continue”**. This authorizes that bounded synthetic external composition only, not product auth/schema/dependency adoption or M02. The agent's opening response explicitly kept application code, R2 and owner config untouched.

## Execution boundary

- Reuse the two separately frozen reviewed graphs, installed tools, exact auth 0.1.1 / Nest 12.2.0 / Prisma 7.10.1 / pg 8.23.1 and the prior digest-pinned official PostgreSQL 18.6-bookworm/linux-amd64 image. No new identity, lock/policy change, lifecycle/peer bypass, global upgrade, vendor patch or unverified engine download. This is not a combined product dependency resolution.
- C:-only workspace/cache/DB allocations under 3 GiB with at least 20 GiB free on C:. D: remains below the experiment reserve and receives no test data. Existing Docker storage/location must remain valid. One task-owned labeled container/volume at a time, random loopback port, non-root/read-only root, dropped capabilities/no-new-privileges, 2 CPUs / 1 GiB, bounded logs/WAL/tmpfs/connections; ten-minute run target. Preserve unrelated services and remove only verified owned resources.
- Compose the real auth module with the already tested Prisma store for its selected contracts. Synthetic in-memory user/lifecycle/grant and mail fixtures are permitted and must remain labeled; do not imply a transactional durable account/password repository merely because sessions/tokens/MFA/email state is in PostgreSQL.
- Loopback HTTP fixtures may exercise password sign-in, real verification/reset callbacks to a memory sink, real TOTP/recovery completion, server-recorded assurance method/time, user/admin cookie/realm boundaries, session-bound CSRF, logout/revocation, refresh reuse, controlled lifecycle/read-failure ordering, client/server reopen and safe errors. Independent owned negative controls are permitted. No browser/native/BFF or production timeout/key/hash policy is adopted; inspect cookies as strings, not browser enforcement.
- Use ephemeral keys and library-default hashing/encrypted TOTP, serial hashing. Never return private keys, passwords, TOTP seeds or mail links in ordinary HTTP responses/logs. Synthetic credentials/tokens needed by the test remain in memory; log booleans/statuses/hashes only. No original `.env` load, personal data, real sender/SMTP, R2/cloud/bucket changes, staff provisioning or social methods.
- Close clients/listeners in `finally` and check their ports; verify container/volume ownership before teardown. Retain all failures and old evidence. Do not patch library behavior or claim refresh-family revocation immediately kills issued access JWTs. Any staff context/freshness assertion must distinguish actual server-observed successful TOTP from enrollment flags, recovery codes or client metadata.

## Recorded result

The [composition report](../durable-auth-http-spike.md) records 30 Node entries passing twice, six independent expected-red owned controls and 24 final HTTP listener lifecycles closed. Real TOTP completes/steps up over HTTP and supplies server-recorded method/time in durable session metadata; user/lifecycle/grant/mail remain synthetic memory fixtures. Four sequential task container/volume lifecycles, including two initial fixture failures and a preliminary positive run, were removed. Current-session/user-password transactions, access-JWT immediate revocation, browser/native/BFF, operational policies and production adoption remain open.

## Acceptance boundary

Record actual successes, failures, negative controls and limitations, then separately commit/push the report. No product route/store/schema/SDK installation, paid/hosted resource, deployment, release, complete staff/BFF/browser/native/private-data acceptance or M02 follows. Further product adoption or broader phases require explicit scope; working R2/browser evidence and its separate script 403 remain untouched.
