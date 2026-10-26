# M00-T07 — Isolated real Nest authentication candidate test

- **Executed:** 2026-10-26 UTC after `f2f1ad7`
- **Status:** First real-package/memory/loopback phase passed; no application adoption, full T06/T07 unchecked
- **Authority:** [Decision 0018](decisions/0018-local-nest-authentication-spike.md), owner's “continue” after the [candidate review](framework-auth-review.md)
- **Later phase:** [Decision 0019](decisions/0019-local-prisma-auth-store.md) subsequently authorizes a [passed real Prisma/PostgreSQL store test](prisma-auth-store-spike.md). This document retains the original memory-only results and its then-unapproved next-phase proposal.
- **Candidate:** `@nestjs/authentication` **0.1.1**, installed only in an external disposable workspace with the existing Nest 12.2.0 / Node 24.18.0 / pnpm 12.8.1 / TypeScript 6.0.3 graph

## 1. Graph, install and execution boundary

The interrupted review push had already updated GitHub to `f2f1ad7`; remote HEAD was compared and a normal fetch refreshed local tracking. No force push/history rewrite was needed.

Copied only public manifests, workspace policy and lock into the external workspace; added the exact auth candidate there, never in the app. Lock-only strict/script-denied resolution added **one package identity/snapshot**: **200 → 201** application packages. Every prior package/snapshot version/integrity, manager lock document, override, importer dependency and policy stayed unchanged except the intended external API auth dependency. Candidate integrity matches the reviewed official npm SHA-512. All **215 installed candidate files** matched the reviewed artifact hashes; no vendor patch or lifecycle script ran.

Frozen install succeeded with **133 reused / 68 downloaded** packages: downloaded cache entries were not 68 new versions. Frozen **offline** repeat and graph equality passed. No peer/engine/checksum/TLS bypass or tool upgrade occurred. The direct candidate advisory result from the preceding same-day review is not a fresh full-graph audit or release clearance.

Only the candidate's real services and a strictly compiled synthetic Nest HTTP fixture ran. No original `.env` load, real account/password/mail, database/Prisma/Docker, R2/cloud, browser/native or app auth/upload route. Ephemeral keys, synthetic `.invalid` email/link values and memory stores/mail sink stayed in the probe. There was no hosted mail delivery or callback fetch. Library-default scrypt was used, serially, including its real default-cost hash/verify/reset paths; no cheaper hashing or encryption-off override was used.

## 2. Actual results

The final combined Node suites passed **55 tests twice**, zero failures/skips, in **8.627 s / 7.321 s**. Node's count comprises **36 service tests + 18 HTTP subtests + one HTTP parent**; do not count that parent as another independent scenario. These counts are separate from the root repository suite.

| Area | Evidence exercised | Limits |
|---|---|---|
| Real password service | Default scrypt round-trip; wrong/unknown password, malformed/empty/over-limit input, dummy verification and stored-hash configuration | No production password policy, latency/DoS capacity or native client acceptance |
| Real sessions | Hashed opaque identifier, cookie attributes, invalid/unknown token, idle/absolute expiry, owner-only revoke, fixation replacement, concurrent memory rotation | Cookie strings inspected, not browser enforcement; memory concurrency is not SQL concurrency |
| Real session outage/race behavior | Explicit delayed-touch versus revoke ordering; no memory resurrection; read outage refuses authenticated result | A failed touch still permits the previously read live session by library design; no automatic fail-closed domain transaction guarantee |
| Real tokens/verifier | Issue/rotate, spent-token reuse, concurrent refresh, lost-response/retry revokes family, signature/issuer/audience/time denial; reserved MFA claims cannot be self-asserted | Revoking refresh families does not immediately invalidate issued access JWTs; tested as a limitation, not a missing assertion hidden as a pass |
| Real TOTP/MFA | Encrypted seed, unconfirmed enrollment, one-time confirmation/step replay and concurrent claim, required second factor for enrolled token client, pending session, wrong decryption key, failed-attempt lockout, single-use recovery | Recovery can yield generic MFA as TOTP does; not proof of fresh staff TOTP method/time or full credential-rotation operations |
| Real verification/reset services | In-memory handler/mail sink; hashed purpose-bound tokens, single use, changed-address/expiry denial, wrong-purpose reset leaves verification usable; unknown reset emits no mail; reset changes hash and revokes sessions/refresh | No live email, durable user repository, DB transaction/restart or reset-failure atomicity proof; existing access JWT remains valid until expiry |
| Real module/HTTP integration | Nest global auth guard/provider, public health, unavailable unknown route, password sign-in/Set-Cookie, pending MFA not signed in, verified-email guard, bounded/malformed JSON handling, safe errors/no-store/no-powered-by and logout | Owned synthetic route composition, not published API endpoints; global Origin protection is real Nest behavior but no real browser was run |
| Owned lifecycle/staff/CSRF adapters around real module | Suspended-user denial, current staff grant, separate synthetic admin realm, stale/future/recovery context denial, header spoof denial, session-bound CSRF | Staff context was placed into trusted memory sessions by the fixture, **not** issued by a complete production staff-login/step-up protocol. No signing/key/store/freshness policy is adopted |
| Storage guard | Production-mode storage refuses a missing persistent session store; malformed/late store registration rejected | This tests the package's storage read guard, not full app production deployment/bootstrap or a real persistence adapter |

The strict TypeScript caller/HTTP composition build passed with the actual package and existing Nest peers. Original application source, health behavior and dependency graph were not modified.

## 3. Independent expected-red controls and teardown

Five independent child runs disabled exactly one **owned fixture** control or its library decorator/middleware use: **lifecycle**, **verified email**, **admin realm**, **session-bound CSRF** and **global Origin protection**. Each failed its intended boolean assertion; each closed its listener. No vendor code, assertion expectation or production policy was weakened. They demonstrate the corresponding test sensitivity, not the security of a deployed auth system. Failed subtests also make their HTTP parent fail; those are expected-red runs, not passing suites.

Across the first HTTP run, two final combined runs and five controls, all **eight loopback listener lifecycles** logged closed/non-listening and verified a refused connection to their owned port after teardown. Random 127.0.0.1 ports, request timeouts, bounded responses and no retained client agents were used. No task process/listener/container or worker remains. Sensitive responses/passwords/tokens/cookies/TOTP secrets/links were not printed; assertions compare booleans so failures do not dump credentials.

## 4. Retained failures and corrections

- The first lock checker inspected pnpm 12's manager lock document instead of its second application document and reported an empty added set. Preserve `graph-check-first.log`; correct the helper to compare **both** documents explicitly. No package ran before the corrected graph check passed.
- Initial services: **25/32 passed, seven failed**. One test incorrectly assumed hex SHA-256 rather than the published base64url encoding; assert the exact `node:crypto` base64url digest instead. Six mail tests constructed a registry without its feature options; provide those options to the real registry. No vendor behavior was changed. Corrected 32-test service run passed; four further hardening tests and stronger captured email-token hash checks were included in both final 55-test runs.
- Network install emitted low-throughput warnings while fetching existing-version cache entries. No timeout/registry/security setting or version changed to suppress them.
- The prior interrupted push is a local tracking/command interruption, not a failed remote publication relabeled as a new push. Remote acceptance was independently checked.

## 5. Remaining gates and next bounded proposal

This is stronger than the older hand-built JWT/session doubles: real candidate crypto, services, registry and Nest HTTP guard actually ran. It still does **not** select the package for product use, approve JWT stale-access semantics or a mobile/session protocol, establish staff TOTP freshness, prove durable storage/SQL races, browser cookie/CSRF, Flutter secure storage/callbacks, cross-process restart, production rate limiting, email delivery, key/recovery custody, operating policies or final security/legal acceptance.

**Next proposal, not authorized/executed here:** implement only an external Prisma authentication-store fixture for the already identified required contracts, reuse the reviewed PostgreSQL direction and run the package's contract suite against a real pooled temporary PostgreSQL with explicit race barriers/restart/teardown. Review exact graph, SQL/migrations, permission roles and resource envelope before any DB start. Decision 0014's older DB test does not itself authorize auth database work; request that next scoped phase separately. Do not automatically copy a store into `apps/api/prisma/`, add a product auth endpoint, configure mail or start M02.

R2 settings, credentials, owner-reported browser download and two zero-byte organization markers were not accessed or changed; the old script 403 remains separate evidence. Full T06/T07/M01/native/CI and real-data/release gates remain open, with seven tasks checked.

## 6. Evidence

External workspace/evidence: `C:/Users/HP/AppData/Local/Temp/your-own-nest-auth-ynv2a_sv/` — authorization baseline, reviewed candidate metadata/integrity, lock/install/graph logs, `workspace/apps/api/{services.test.mjs,probe-app.ts,http.test.mjs}`, strict build output, original failed/corrected service logs, final/repeat logs, five expected-red control logs/results and listener JSONL. The synthetic fixture is disposable, not app implementation. Installed cache/modules remain for review; no global cleanup was performed. Original private config and all app/manifests/locks/policies/assets/native wrappers and historical snapshots remain unchanged. Observed external task files total approximately **53.4 MB logical bytes**; this is not a separately attributed measurement of shared pnpm-cache writes or a fresh machine/free-space inventory.

## 7. Repository verification

`pnpm check` passed **142 existing root tests** (21 tooling + 14 design/artwork + 88 boundaries + 19 API), lint/types/API build and the **37-source / 131-directive** import scan. Documentation checks passed **99 Markdown / 1,641 local links / four JSON examples**, plus 29 owned JS/TS/JSON whitespace checks. Diff/preservation/redaction checks retained original ignored config, app/lock/policy/asset/native bytes, all 13 historical snapshots and **67 requirement IDs / 224 tasks / 20 plans / seven checked tasks**. Only ten documentation paths changed. No root application auth, Flutter/native/browser or real DB/store contract suite was run; the 55 external test entries and five expected-red controls are separate evidence from the 142 root tests.
