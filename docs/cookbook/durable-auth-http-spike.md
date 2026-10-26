# M00-T07 — Isolated durable authentication HTTP composition

- **Executed:** 2026-10-26 UTC after `b2ca449`
- **Status:** External composition passed within scope; full T06/T07/M01 and app adoption remain open
- **Authority:** [Decision 0020](decisions/0020-durable-auth-http-spike.md), owner's “continue” to the proposed external HTTP phase
- **Preceding evidence:** [Real memory/module phase](local-nest-authentication-spike.md), [real PostgreSQL store contracts](prisma-auth-store-spike.md)

## 1. What actually ran

Two synthetic Nest module contexts on random **127.0.0.1** HTTP ports share the same test identity state and real PostgreSQL store. They represent user/admin realm checks, not two production domain authorities or implemented Next.js BFFs. The module executes real authentication 0.1.1, default-cost scrypt, encrypted TOTP/recovery, sessions, tokens and verification/reset services against the previously tested generated Prisma store. All four selected store contracts are registered explicitly; no memory session/token/MFA/email-token source replaces PostgreSQL. User/password/lifecycle/grant records and the mail sink **remain in memory**, intentionally. Reset's hash update is real hashing into that synthetic repository, **not a durable account transaction**.

Reuse the two separately frozen reviewed graphs: Nest **12.2.0** / auth **0.1.1** and Prisma/client/adapter **7.10.1** / pg **8.23.1**, on Node **24.18.0**, pnpm **12.8.1**, TypeScript **6.0.3**. Both install with `--frozen-lockfile --ignore-scripts --offline`; seven manifest/lock/workspace files remain byte-identical to the preceding fixture. All **215** candidate files match the reviewed artifact; exact schema-engine binary SHA-256 is rechecked. Generate and strict builds (`skipLibCheck:false`) pass; the owned DB compiler additionally emits declarations for the separate HTTP graph's type checking. Generated upstream `@ts-nocheck` is not a new caller suppression. Repeated generation still yields **15 identical source files**. This is explicit interoperation between two installed graphs, not resolution/adoption of a combined product graph, a new advisory audit or shipping/notice clearance.

No application source/dependency/schema/config, R2, real sender/mail, browser, Flutter/native, hosted CI or deployment changed. No owner `.env` was copied/loaded; its ignored bytes are preserved. No public/admin signup, real account/staff provisioning or real private records exist in this experiment.

## 2. Results and assurance boundaries

**30 Node entries passed twice**: 29 owned HTTP subtests plus one parent, zero failures/skips, **25.536 s / 25.374 s**. These are separate from previous published-store contracts and the repository's root tests.

| Area | Observed subset |
|---|---|
| HTTP/password | Correct password issues an opaque Secure/HttpOnly/host-only cookie; only its hash is stored. Invalid credentials/extra metadata, malformed JSON and >8 KiB JSON are rejected without echo. No-store/nosniff also cover parser errors; powered-by is absent. Cookie flags are inspected as strings, not browser enforcement. |
| Verification | Unverified bootstrap denied; real verification link captured in memory, consumed once over HTTP, then bootstrap allowed. Mail links are not ordinary response data; no SMTP/delivery/provider proof. |
| Staff MFA | Ordinary/unenrolled users denied admin sign-in; enrolled staff first receive a pending, non-operational session. Real TOTP completion rotates cookies and records **server-observed** `verifiedMethod`/`verifiedAt` in PostgreSQL. Incorrect and already-used TOTP codes fail; client method/time injection fails. Enrollment is seeded through real services, not an HTTP staff-provisioning/enrollment acceptance flow. |
| Step-up | Generic recovery MFA allows the fixture's signed-in `/me`, **not TOTP-only operations**. Expired freshness denies operations; a new real TOTP step-up rotates/restores fresh context. Current grant removal denies an already verified session. Fixture 5-second freshness and other TTLs are test values, not accepted product policy. |
| Realms | Distinct cookie names plus server-stored realm prevent even a renamed user-realm, fresh-TOTP staff cookie from entering admin. The precheck returns no match without deleting the valid other-realm session. Frontend `x-admin`/`x-mfa` and user bearer tokens cannot mint admin authority. Both fixtures use loopback: ports are **not** browser cookie isolation; separate deployed BFF origins/secrets remain untested. |
| CSRF/Origin | Real Nest trusted-Origin protection denies hostile public writes; owned mutations require the current session-bound CSRF value and expected Origin. Real browser SameSite/HTTPS/CORS, BFF forwarding and cross-site request behavior remain untested. |
| Lifecycle | Current synthetic Suspended/Deleting/Deleted state prevents cookie bootstrap without recreating accounts. These are memory-repository checks, not durable multi-process lifecycle transactions. |
| Backend failure | Revoke scratch runtime SELECT on the real sessions table; a runtime query must show PostgreSQL **42501**, and HTTP returns sanitized unavailable **503**, not private/cached data. Restore the grant; the same live cookie works. This is an actual permission/read failure, **not** a network outage, pool-disconnect/reconnect or every touch/write-failure policy. |
| Logout ordering | After committed logout, later cookie reads fail. A completion request held **before the library consumes/rotates its pending session** cannot issue a session after pending logout commits. Not proof that every response already authorized/rotated before logout is canceled, or of arbitrary cross-process logout races. |
| Refresh/JWT | Real HTTP refresh rotates; replay revokes the durable family and successor refresh fails. Issued access JWT remains usable after family revoke until fixture expiry. This known limitation is asserted, not called immediate revocation. |
| HTTP reopen | Close user Nest app/client pool, create a fresh module/client pool and use the existing PostgreSQL cookie, then revoke it. The same process retains synthetic users and ephemeral keys; this is **not** durable user/key custody or full process/browser/native restart proof. |
| Reset | Consume real reset link once, change fixture password hash, reject the old password and allow the replacement. Durable sessions and refresh tokens are revoked. **An already-issued access JWT still works after reset**; full credential/access-revocation coordination is unresolved. No atomic user/password/session/email transaction is claimed. |

The staff method/time claim is stronger than the previous prepopulated-metadata fixture: only a successful real TOTP path stamps TOTP assurance, while real recovery gets a different method. The owned guards remain mandatory; library generic MFA/enrollment/token `iat` alone is not fresh staff TOTP. The wrapper performs an additional realm/session lookup; this is not a production performance or authorization-linearization certification. Previously observed best-effort touch behavior remains a separate limit.

## 3. Independent negative controls

Six child runs each disable one **owned** boundary: realm precheck, actual-TOTP method requirement, freshness age, current grant, session-bound CSRF, or public-write Origin protection. Each fails **only its intended subtest plus the parent** (28 passing / two failing entries), with no skip or unexpected failing case. The published package, generated client, normal positive tests and database adapter remain unpatched. These expected-red runs are not production settings or six additional positive tests.

Each final child run opens/closes three HTTP listener lifecycles, including user-app reopen: two positive runs plus six controls = **24 verified closed listener lifecycles**. A preliminary positive checkpoint likewise closed 24; no listener opened in the first two startup failures. Clients, pools and server instances are closed through test/factory teardown; real connection attempts verify closed HTTP ports.

## 4. Resources, failures and cleanup

D: stayed below the experiment's 20 GiB reserve and received **no experimental allocation**. All new fixture/cache/DB files used C:. Existing default C: Docker VHDX was present/in use (read-only exclusive-open probe reports Windows sharing violation 32); no disk override/settings change. Both pnpm metadata records route cache/virtual stores to C:. Retain at least **20 GiB free** and a **3 GiB additional allocation** envelope; final free space is about **26.37 GB decimal**. Observed task-wide free-space delta is about **0.13 GB**, including unrelated activity, not exact per-process attribution; logical external fixture files measured about **363.2 MB** before final publication logs. No unrelated cleanup/global prune or reserve reduction.

Reuse the exact approved official PostgreSQL **18.6-bookworm/linux-amd64** digest from [Decision 0019](decisions/0019-local-prisma-auth-store.md); final launcher explicitly uses `--pull never`. One labeled task container/volume at a time, non-root 999:999, read-only root, dropped capabilities/no-new-privileges, **2 CPUs / 1 GiB**, one random loopback DB port, 40 connections and bounded WAL/tmpfs/temp files/logs. No host/application/socket mount. Separate initialization/migrator/runtime credentials remain ephemeral/redacted. Real Migrate deploy/repeat/status passes in each lifecycle; schema/store/migration source is unchanged, not an app migration adoption.

Retained sequence:

1. Initial strict HTTP compile rejected widened duration strings and a nullable/string listen address. Add the real options type and explicit address narrowing; no type suppression.
2. First DB lifecycle migrated, but emitted HTTP code resolved its relative store import one directory too deep. No HTTP case/listener ran. Emit the owned HTTP JS alongside its TS so runtime/type import paths agree. Container/volume removed.
3. Second lifecycle migrated, but real registry rejected duplicate provider order 0. Set explicit cookie order 0 / bearer order 1; no vendor change. No HTTP listener opened; container/volume removed.
4. Preliminary full run: **28 entries twice**, six controls, teardown in **220.528 s**; archived separately. Hardening adds wrong/replayed TOTP, parser-error headers, explicit 42501 and old-password/JWT-after-reset assertions without weakening existing assertions. Final full run: **30 twice**, six controls, teardown in **217.076 s**, below the ten-minute run bound. PGDATA **42,784 KiB**.

A preparation quoting SyntaxError and a support-check helper's YAML-line assumption for pnpm's JSON-shaped `.modules.yaml` are retained as helper failures/corrections. The latter check's next shell command still ran; the corrected structured metadata check confirms C: cache routes and reserves. It was not a test pass or permission to ignore storage blockers. No reserve/location violation was found.

All **four** sequential task-owned containers/volumes were ownership/name/label/image checked and removed, their assigned DB ports checked closed. Final 24 HTTP lifecycles are closed; two pre-existing Redis/object-storage containers remain running and unchanged. Docker Desktop and reviewed caches remain. Removal is not secure-erasure, backup/restore or deployment evidence.

## 5. Evidence and commands

External root: `C:/Users/HP/AppData/Local/Temp/your-own-auth-http-is3ewhu3/`.

- `auth/apps/api/http-app.ts`, emitted JS, `http.test.mjs`, strict compiler config; `db/store.ts`, generated client/declarations, unchanged schema/migration and exact frozen manifests/locks.
- `baseline.json`, `graph-preservation.json`, `generation-repeat.json`, `storage-preflight.json`, `source-hashes.json`, install/build/migration logs.
- `http-first.log`, `http-repeat.log`, six `control-*.log`, `controls.json`, resource JSONL / `resource-verification.json`, `isolation.json`, `teardown.json`, sanitized PostgreSQL log.
- `attempt-1/`, `attempt-2/`, `attempt-3-positive/`, original compile/helper corrections and per-attempt teardown. Older store/memory/R2 reports and 13 immutable snapshots are untouched.

Commands: each external graph `pnpm install --frozen-lockfile --ignore-scripts --offline`; exact binary-configured `node node_modules/prisma/build/index.js generate` / `migrate deploy` / repeated deploy / `migrate status`; pinned `node node_modules/typescript/bin/tsc -p ...`; fixture `node --test --test-concurrency=1 http.test.mjs`. `run_http.py` owns bounded DB/migration/test/control/cleanup orchestration; no root/product package runner installs or starts this fixture.

## 6. Remaining decisions

No exact app package/protocol/schema/hosting/expiry/hash/key/recovery policy is adopted; early auth 0.1.1 maturity and existing native/bundled/notice/advisory obligations remain. Next bounded preparation should address **durable user/password/lifecycle transaction coordination and current-session/access-JWT invalidation**, then an explicit app-adoption decision/graph, rather than treating this prototype as M02. Real email, browser/BFF, Flutter OS-secure persistence/callbacks/account switching, rate/capacity/maintenance, grants/audit/recovery operations and native/CI/release gates remain open. Seven tasks remain checked; working R2/browser evidence, markers and historical script 403 are unchanged.

## 7. Repository verification

Initial `pnpm check` reached the existing API child-start **10-second timeout** (`null !== 1` in `environment.test.mjs`); `root-first.log` retains the failure. An unchanged separate repeat passes **142 root tests** (21 tooling + 14 design/artwork + 88 boundaries + 19 API), lint/types/API build and **37-source / 131-directive** import scan. No timeout/assertion/skip was relaxed. Documentation passes **103 Markdown / 1,681 local links / four JSON examples** and 29 owned JS/TS/JSON whitespace checks.

Precommit preservation/redaction verification passes for exactly **eleven documentation paths**: root app/config/locks/policies/assets/fonts/goldens/native bytes and 13 snapshots unchanged; **67 requirement IDs / 224 tasks / 20 plans / seven checked tasks** retained. No original config/credential or raw JWT appears in saved logs or the patch. The 30 external entries and expected-red controls are separate from 142 root tests; no Flutter/native/browser check or product-auth test ran.
