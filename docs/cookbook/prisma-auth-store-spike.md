# M00-T07 — Isolated Prisma authentication-store verification

- **Executed:** 2026-10-26 UTC after `f002158`
- **Status:** External real PostgreSQL/store phase passed; no application adoption or full T06/T07 acceptance
- **Authority:** [Decision 0019](decisions/0019-local-prisma-auth-store.md), owner's explicit continuation to the isolated PostgreSQL/Prisma question
- **Preceding evidence:** [Real Nest memory/HTTP phase](local-nest-authentication-spike.md), [exact Prisma engine/image review](prisma-engine-follow-up.md)

## 1. Allocation, graph and permission boundary

D: was below the earlier 20 GiB experiment reserve (~18.26 GB decimal free). Do not allocate test data there or clean unrelated files. All new experimental workspace/cache/DB allocations used C:, which had more than 20 GiB free throughout. Docker's existing default C: data VHDX was present/in use and no disk-location override was found. Existing D: probe files were read/rehashed only; repository documentation changes are not a relocated DB workspace. No reserve was lowered or host setting changed.

Reused **two separately frozen reviewed graphs**, not a new combined application resolution:

- Nest 12.2.0 / authentication 0.1.1 / TypeScript 6.0.3 graph from the first phase.
- Prisma/client/adapter 7.10.1, pg 8.23.1 and existing explicitly reviewed tooling peers from the earlier DB probe. Its lock SHA-256 remains `1b3ab2922e11746cec7e068c675e1490857db7caa6d3696de1f79f160caf4bec`.

No identity/version/policy/lock change. Auth installs offline and DB's frozen offline repeat later succeeds. All 215 installed auth files match the reviewed artifact; repeated Prisma generation produces **15 identical files**. The initial DB offline install stopped at a missing cached **d3-interpolate 3.0.1** tarball; retain that failure, then fetch only the exact frozen graph with scripts denied. This is cache population, not a version change. Original graphs, reviewed auth artifact hashes and checksum-verified Windows schema engine were rechecked. Additional engine downloads remained denied via the closed-loopback mirror; no checksum/TLS/vendor bypass. Existing `@prisma/dev`/`remeda`, native/image/security/distribution acceptance gaps remain open; historical advisory results were not relabeled as a new full-graph audit.

The owned TypeScript store implements the actual **SessionStore, RefreshTokenStore, MfaStore and EmailTokenStore** interfaces. Its type-only alias points to the installed auth declarations; emitted store code runs against the separate generated-client graph. This is an explicit external fixture boundary, **not** proof of a frozen combined product graph. Strict NodeNext/ES2024 build with `skipLibCheck:false` passed; generated Prisma sources retain upstream `@ts-nocheck`, not an added caller suppression.

One digest-pinned official PostgreSQL 18.6-bookworm/linux-amd64 container at a time, non-root 999:999, read-only root, dropped capabilities/no-new-privileges, **2 CPUs / 1 GiB**, random **127.0.0.1** host port, bounded logs/tmpfs/WAL/temp files and 40 connections. A uniquely labeled task-owned volume held only synthetic PGDATA for DB restart, then was removed. No host/application/socket mount, personal DB, original `.env`, R2, cloud, SMTP, browser/native or Docker settings change. Two pre-existing unrelated service containers were not stopped or altered.

Separate initialization, migrator and runtime credentials stayed in child/helper memory. Real Prisma Migrate **deploy / repeat deploy / status** succeeded on the scratch schema; runtime has only schema usage, intended table DML and sequence usage, not migration metadata or DDL/role authority. The hardened check verifies that migration metadata exists with the actual migration-file checksum, seven auth tables exist in `auth_probe` and no user tables exist in `public`; denials must carry PostgreSQL **42501**, not merely fail because an object is missing or SQL is malformed. Seven auth tables plus migration metadata live in `auth_probe`; this scratch design is not an accepted app schema or migration tree.

## 2. Published contracts and actual SQL behavior

The successful run passed **29 tests twice**, zero failures/skips, in **13.592 s / 19.714 s**: **24 unmodified published contract cases** with `concurrent:true` and `maxPending:3`, plus five owned checks. Sessions, refresh families, TOTP/recovery/failure counts and purpose-bound email tokens use real generated Prisma clients and a PostgreSQL connection pool; these are not renamed memory tests.

| Area | Verified subset |
|---|---|
| Sessions | Optional/JSON/date round-trip, owner-scoped list/delete, forward-only conditional touch, no resurrection after deletion, expiry pruning, concurrent delete/rotation/sign-out behavior |
| Refresh | Optional claims/date round-trip, conditional one-time spend, durable family tombstone covering later successors, per-user family revocation, real TokenService concurrent-refresh reuse behavior |
| MFA | Monotonic TOTP upsert using reviewed `GREATEST`, conditional step claims, transactional recovery-batch replacement, per-user one-time recovery consumption, record-then-count attempt visibility, concurrent lockout through real MfaService |
| Email | Purpose-bound atomic `DELETE ... RETURNING`, one-time concurrent consumes, expiry pruning and capped pending entries; concurrent reset/verification service behavior through a memory user/mail fixture |
| Runtime permissions | Role flags are not superuser/CREATEDB/CREATEROLE/BYPASSRLS. Migration-metadata read, table/schema creation and SET ROLE escalation are denied |
| Real rollback | Duplicate replacement recovery hashes cause failure; a fresh client confirms the previous batch survived the transaction rollback |

The published email-service contract deliberately uses its own **synthetic `PasswordHasher({logN:10})`** and memory user/mail callbacks. It is unchanged upstream test code, not a production hash-policy change or proof that user-password writes and session/email changes form one durable transaction. The preceding real-package phase separately tested library-default scrypt. Do not combine those claims.

## 3. Explicit database barriers and negative controls

Three additional tests hold the target row under an independent coordinator `FOR UPDATE`, launch competing runtime operations, and query PostgreSQL activity until **at least two distinct runtime backends are lock-waiting**, before releasing the barrier:

| Contended operation | Runtime operations | Observed blocked backends, first / repeat | Result |
|---|---|---|---|
| TOTP step claim | 8 | 8 / 8 | Exactly one winner |
| Refresh-token spend | 8 | 8 / 8 | Exactly one winner |
| Email-token consume | 6 | 6 / 5 | Exactly one winner |

These are observed database waits, not just concurrently scheduled JavaScript promises. The other published concurrency cases remain correctly described as pooled real-DB contract cases, not all as explicit lock-barrier tests.

Four independent expected-red child runs removed one **owned adapter** condition: monotonic touch, unused-refresh guard, increasing-TOTP-step guard, or consuming email DELETE. Each failed its intended published assertion. Candidate package/generated/vendor files were not patched, and positive assertions were not weakened. The negative runs are not passing tests or production configuration.

## 4. Restart, original failures and teardown

A separate generated-client process seeded synthetic session/revocation/replay/recovery/email state, another process read it, then the **same task-owned database container was restarted on its retained task volume** and a fresh process read/checked it again. Revocation/spent-token/TOTP-step state survived; no rows were reseeded after restart. This proves recorded row/state persistence, not native secure-store durability or a complete HTTP login after restart. The restart seed's TOTP value is an explicitly non-real sealed placeholder; it is not an encryption/key-rotation demonstration.

Retained attempts:

1. Migrations passed, but the test file could not load a generated `.ts` import from emitted `.js`; no contract case ran. Correct the owned TypeScript `rewriteRelativeImportExtensions` setting, not vendor output or checksum policy. Container/volume removed and initial port closed.
2. All 29 cases passed twice and fresh-process state checks passed, but restart verification used the old host port. Docker had reassigned its random port. Retain the P1001/connection failure and teardown; that attempt's port check described its initial binding, not every post-restart binding.
3. Rediscover and validate the loopback binding after restart, update only synthetic child connection URLs, and verify **both assigned ports** after teardown. The corrected full run passed, including four negative controls, in **62.201 seconds**, retained as `attempt-3-positive/`. A final hardening run additionally checks real catalog/migration checksum and **42501** permission failures, not arbitrary errors; the same 29 cases pass twice, all controls pass as expected-red and restart/teardown pass in **135.796 seconds**. No token/schema/version/assertion was changed to conceal a failure.

Before DB execution, the first type-only alias pointed to a package directory that NodeNext could not resolve (`TS2307`); point it to the exact reviewed declarations. Strict build then passed. The offline cache miss and compiler/loader/restart failures remain external evidence.

Each of the four task containers and volumes was ownership/name/label/image checked before stop/removal. None remains; corrected run confirms two assigned ports closed and both original unrelated services still running. Clients/pools close in `finally`/test teardown. Last PGDATA size was **64,680 KiB**. C: free-space delta from first DB start to final teardown was about **612 MB**, and the broader observed delta since this task's initial baseline was about **1.05 GB**, both including unrelated activity; final free space was about **26.52 GB decimal**, above 20 GiB. External logical task files were about **362.5 MB** before final report/check logs, below the 3 GiB envelope; shared caches/volume deltas are not exact per-process attribution. Named-volume removal is not a secure-erasure/backup-restore claim. Reviewed caches remain; no global prune or unrelated cleanup.

## 5. Limits and next action

This validates the four required external store contracts and selected service/concurrency/persistence behavior. It does not adopt auth 0.1.1 or Prisma pins/schema in the app, resolve early API stability, choose hosting/regions/expiry/key/recovery policies, prove immediate access-JWT revocation, complete staff TOTP method/time issuance, transactional account/password/lifecycle coordination, production capacity/rate limits, real email, full browser/BFF cookie/CSRF, Flutter secure persistence/callbacks or release readiness. Unselected magic-link/OIDC/API-key store contracts were deliberately not enabled.

A sensible next bounded phase is a real auth-module + durable-store **external HTTP composition**, before any product integration: normal and staff sign-in/step-up with trusted method/time, lifecycle/outage/revocation ordering, client reconnect and redaction. No such new phase or M02 is automatically authorized by this completed DB/store test. Full T06/T07/M01 and real-data/release gates stay open; seven tasks remain checked. Owner-reported R2 browser success, two zero-byte markers and prior script 403 evidence remain untouched.

## 6. Evidence

`C:/Users/HP/AppData/Local/Temp/your-own-auth-store-2kf358hl/` contains two frozen tool graphs, owned schema/store/migration and generated source, exact engine path/hash verification, install/build/migrate logs, unmodified-contract runner, barrier JSONL, four expected-red control logs/results, fresh-process/restart logs and `attempt-1/` / `attempt-2/` failures with teardown plus `attempt-3-positive/` before permission/catalog hardening. Passwords/connection URLs were redacted before logs were saved; no original credential or owner data was loaded. Fixture code is not copied into the product. Original D: DB probe and C: memory-phase graphs/evidence remain intact.

## 7. Repository verification

The first `pnpm check` hit the existing API child-start **10-second timeout** in `environment.test.mjs`; retain `root-first.log` / `root-final.log`. A separate unchanged repeat passed **142 existing root tests** (21 tooling + 14 design/artwork + 88 boundaries + 19 API), lint/types/API build and the **37-source / 131-directive** scan. No assertion, startup timeout or test was relaxed/skipped. Documentation checks passed **101 Markdown / 1,660 local links / four JSON examples**, plus 29 owned JS/TS/JSON whitespace checks. Diff/preservation/redaction checks retain ten documentation paths only, original ignored config/app/locks/policies/fonts/goldens/native bytes, 13 snapshots and **67 requirement IDs / 224 tasks / 20 plans / seven checked tasks**. The 29 real-DB tests and four expected-red controls are separate from the 142 root tests; no Flutter/native/browser or app-auth test ran.
