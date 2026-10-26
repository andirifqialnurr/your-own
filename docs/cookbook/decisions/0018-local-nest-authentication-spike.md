# Decision 0018 — Local Nest authentication candidate spike

- **Status:** Authorized local real-package phase passed; not application adoption/full T07 acceptance
- **Approved by:** Project owner, 2026-10-26 UTC
- **Recorded by:** Coding agent
- **Sources:** [Framework-auth review](../framework-auth-review.md), [Decision 0016](0016-framework-auth-and-r2-storage.md)

## Owner continuation and scope

After the review recommended testing the first-party Nest candidate next, with no auth dependency installed or application route enabled, the owner replied **“continue”**. Interpret this as continuation to the review's **isolated local candidate test only**, not adoption of a production auth package/protocol or M02. The prior push was interrupted locally after the remote accepted the review commit; compare remote HEAD and refresh tracking rather than force-pushing or rewriting history.

## Authorized phase

- Disposable workspace outside the repo, installed Node 24.18.0 / pnpm 12.8.1 / TypeScript 6.0.3 and existing Nest 12.2.0 graph, plus exactly **`@nestjs/authentication` 0.1.1**. Recheck its reviewed official tarball integrity/notice and the resolved graph before execution. Strict peers, exact pins, script denial and dependency verification remain; no peer/engine/lifecycle bypass, global upgrade, prerelease substitution or vendor patch.
- Frozen isolated install may fetch the reviewed candidate from the registry. Existing graph versions/integrities must remain unchanged. No source/lock/dependency/config adoption in the application; no owner `.env` load or credentials. A published service may run only after this graph check, not merely because its source was downloaded.
- Real package services and a minimal synthetic Nest/loopback HTTP composition, as available within this bounded slice. Synthetic in-memory users/stores and mail sink only; ephemeral keys and injected clocks. Never connect SMTP, live identity, PostgreSQL/Docker, R2/cloud, browser/native or real personal records. Memory state cannot prove durability or SQL races.
- Exercise library password/token/session/MFA/email behavior, fail-closed owned lifecycle/staff boundaries, concurrency/replay/outage limits and independent guard-removal controls where applicable. Preserve failures and describe real-module results separately from app-owned doubles or unrun matrix rows. No fake immediate access-JWT revocation or generic-MFA-as-fresh-TOTP claim.
- Keep hashing serial at library defaults for at least one real hash round-trip; use bounded synthetic-only overrides only if explicitly labeled. Target five minutes per test run and at most 1 GiB added local task footprint. Do not change host security/global thread-pool settings. Loopback listeners use random 127.0.0.1 ports and close in `finally`; verify owned ports/listeners, preserve sanitized logs without token/password/cookie/TOTP/key/mail-link contents.
- Keep test fixtures external and disposable, never promote prototype auth into product. No new production algorithms, timeouts, store/region/operator/key/recovery policy, endpoint contract, social methods, staff provisioning, email sender, spending/deployment or real-data approval.

## Exit and later work

Record exactly what ran, original failures, graph/build/test/negative-control/teardown results and remaining limits, then separately commit/push the decision/report under existing owner authorization. Real Prisma-store/PostgreSQL concurrency/restart, BFF/browser cookie/CSRF, native Flutter secure persistence/callbacks, complete staff grants/TOTP freshness, full T06/T07/M01 and M02 remain separately gated. R2 settings, working owner-reported browser download, two zero-byte asset markers and historical script 403 evidence stay untouched.

## Execution checkpoint

The [local report](../local-nest-authentication-spike.md) records strict/frozen graph review and install with only auth 0.1.1 added (200 → 201 packages), all 215 installed candidate hashes matching the reviewed artifact, strict caller/HTTP build, and **55 Node test entries passing twice** (36 service + 18 HTTP subtests + one parent). Five independent owned guard-removal controls fail their intended assertions; eight owned loopback listener lifecycles close and their ports refuse connections. Default scrypt/encrypted TOTP were used, with memory stores and mail sink only. The first graph-helper failure and seven initial service-fixture failures are retained/corrected, not vendor patches or relaxed expectations. Real Prisma/DB, full staff freshness and native/browser acceptance remain unrun; no app graph/source/config or R2 change occurred. Next real PostgreSQL/store phase needs separate scope approval.
