# I1-B1 — Partial durable bearer/guarded-HTTP checkpoint

- **Date:** 2026-10-29 UTC, after `bed0b89`
- **Authority:** [Decision 0029](decisions/0029-local-auth-integration-i1.md); owner's “continue” to the stated I1-B next step
- **Status:** Selected bearer subset verified; **full I1-B remains open**
- **Tasks:** Preparatory M00-T04/T06/T07; seven tasks checked, full M02 Planned

## 1. Scope and evidence boundary

This advances actual durable registered-provider/AuthenticationGuard HTTP, rather than adding older memory-user HTTP and durable IPC results together. It is deliberately a partial checkpoint of the [I1 matrix](auth-integration-readiness.md#4-required-i1-acceptance-matrixall-not-run), not a complete identity implementation, production-policy acceptance or application adoption. Application code/composition/dependencies/configuration and S0 remain unchanged.

The external worker registers a real `JwtBearerProvider` and a null-only observation provider with `AuthenticationRegistry`, imports the maintained `AuthenticationModule`, and reaches protected routes through its actual global `AuthenticationGuard`. No provider synthesizes a fallback user. Fixed trusted key/HS256/type/issuer/audience rules are configured; login accepts only allowlisted credential fields. Maintained default `PasswordHasher` and `TokenService.issue()` handle synthetic password verification and token issuance. No private vendor import, vendor patch, custom password/token cryptography or global logger suppression.

A typed account-locked unit of work reads current account, credential generation, grant/family, realm, expiry and verified-email facts before projecting a minimal internal actor into byte-unchanged S0 own-data policies. Actors/SQL rows/hashes/credentials are not returned by protected routes. Transport `native` maps explicitly to internal `personal`; transport realms are not S0 scope literals. Server-owned grant relationships, not arbitrary client claims or headers, establish current authority. Invalid identity is terminal; technical DB failure remains unavailable rather than signature-only or alternate-provider permission.

**Operator issuance is refused.** Assurance remains primary; no false fresh-TOTP producer is added. A new scratch exact-capability relation/model is prepared but does not establish positive operator/capability acceptance. Actual staff TOTP, staff revisions/step-up and the complete operator policy matrix remain later I1-B work.

## 2. Fresh graph, adapter and execution

- Same reviewed two-importer lock SHA-256 `adfc7066becca85096b249cafd3c60dd5d7bdb24e83bd5a6a5c65c398077d53f`, exact pins/policy B, strict peers/engines, automatic peers off, scripts denied and `verifyDepsBeforeRun:error`; no application graph change.
- Fresh npm/OSV queries for 344 exact versions reported no findings at capture; all 344 reviewed archives were rehashed against saved integrity metadata before candidate execution. These are dated checks, not a comprehensive audit or renewed production acceptance.
- Official pinned engine binary/license rechecked; explicit Generate/repeat produces **20 identical files**, including one new experiment-only capability model. No old generated client or private keys/control dispatcher is copied. Strict compile retains all application compiler flags.
- **The I1-A Store, transaction facade and contract file remain byte-identical.** All **35 cases pass twice** before this HTTP subset: 24 unchanged published cases and 11 owned cases, with concurrency and four SQL barriers per run retained.
- Fresh full **344-package** and clean production **119-package** installs match all reviewed file sets/hashes: **17,123 / 333,609,508 payload bytes** and **4,652 / 88,011,496** respectively. Both contain 215 pristine auth files. Production excludes CLI/Studio/React/DOM/TypeScript/engines.
- In the second positive HTTP run, independent workers load **newly emitted code from the clean production tree**, verified by their private startup module URLs. Parent test tooling does not provide their runtime dependencies or historical absolute imports. Separate production generated-client DB probes also pass twice.

## 3. Actual HTTP subset

**31 cases pass in full and again with production workers**, no skipped/cancelled cases. Two service processes are live together; one is replaced to check current durable state without a stale-positive process cache.

| Area | Actual selected proof |
|---|---|
| Provider/guard | Credential sign-in and protected own-data success in both processes; missing/malformed credentials; wrong issuer/audience/type/algorithm/key; terminal refusal versus null-only fallback |
| Trusted current projection | Exact owner/personal scope; client actor/verified-email/MFA/admin fields cannot elevate; current verified-email and suspended/deleting/deleted state read from SQL |
| Revocation | Post-COMMIT revoked/inactive/expired grant, generation cutoff, family tombstone with a later persisted successor, realm mismatch and unknown-grant signed access refuse |
| Isolation | 24 concurrent requests for two users across two processes, plus cross-owner denials; no shared mutable request actor |
| Unavailability | Actual runtime SELECT privilege revocation produces SQLSTATE **42501**, safe HTTP 503 and no provider fallback; privilege restored in `finally` |
| SQL coordination | Two distinct service backends observed lock-waiting on the account row; committed revocation then makes both guarded requests refuse |
| Logout/mutation | Logout commits before old access fails in another process; audit/outbox mutation succeeds atomically; fresh current grant/family checks after a guard snapshot deny logout and family-revocation gaps |
| COMMIT failure | Real deferred audit-FK **23503** yields safe mutation 503, no success/cookie/token response and unchanged fresh-client audit/outbox counts |
| Surface/cleanup | No public seed/sign/fault/clock/actor control routes; no private credentials in worker logs; process replacement and loopback closure checked |

Three **expected-red single-case controls** remove owned live-state checking, verified-email projection or mutation rechecking. Each fails its intended assertion in production workers, not installation/module startup. The final positive/control lifecycle closes **12 worker/listener lifecycles**. Across failed, diagnostic, preliminary and final runs, all **31** observed worker/listener lifecycles close.

Limits matter: the email-state transition here is **private fixture SQL, not the maintained verification callback**. The deferred fault targets a mutation, not token-minting/reset responses; a complete credential-issuance COMMIT/denial-effects guarantee is still unverified. No cookie/Origin/CSRF/idle-touch/sliding-session work, refresh/reset coordinator, real staff TOTP, mail delivery/drain, physical restore, uncertain COMMIT, browser/BFF/native or production key custody is established.

## 4. Preserved failures and corrections

- Initial strict compile rejected widened actor literals, an attempted private `JwtBearerProvider.reject()` call, and an application typed without Express parser methods. Preserve `build-first.log` / `attempt-type-worker.ts`. Corrections use an explicitly typed actor, the public `AuthenticationError` export and `NestExpressApplication`; no private member, compiler waiver or vendor patch executes.
- First HTTP attempt: **4/30 passed, 26 failed** because login tried S0 `personal` as a DB realm. The unchanged scratch migration permits `native`/`admin`; diagnostic execution identifies actual **23514**. Preserve `attempt-1-http/` and `attempt-2-diagnostic/`. The fix maps realm to scope explicitly; no SQL CHECK is weakened.
- Corrected realm attempt: **28/30 passed**, but wrong-issuer/audience fixtures still contained original valid `iss`/`aud`, which the public signer merges after its configured defaults. Preserve `attempt-3-token-fixture/`. Remove those inherited fixture claims to construct genuinely invalid tokens; server issuance continues to allowlist claims. No verifier assertion is weakened.
- A 30-case full/production positive/control checkpoint is retained in `preliminary-30-pass/`. A family-revocation mutation-gap check then expands the final suite to 31 and the complete positive/control subset is rerun.
- Root `pnpm check` hits the existing **10-second child-start `null !== 1`** once. The unchanged retry passes **176 entries** (21 tooling, 14 design/artwork, 99 boundaries, 42 API), lint/types/build and **41 sources /137 directives**. Neither timeout nor assertions change. A Windows stdout-encoding inspection error is separate from the test results.

## 5. Resource, preservation and evidence

Evidence: `C:/Users/HP/AppData/Local/Temp/your-own-auth-i1b-_dlynitg/` — hash-only baseline; prepare/install/generation/build records; `full/apps/api/src/http-worker.ts`, unchanged store/facade/S0 copies, `http-b1.test.mjs`; source and installed inventories; raw dated advisories; failed/preliminary logs; `b1-http-{full,production}.log`, `b1-controls.json`, `b1-{resources,barriers}.jsonl`; per-attempt isolation/teardown; root first/retry logs.

Fresh baseline: **C: 25,251,188,736 / D: 220,950,958,080 bytes free**. Docker was unavailable and the existing Desktop installation started normally. New experimental data stays C:-only; the existing Docker VHDX location is under C:. D: has ample space, not its historical low-space state. Monitored commands retain **≥20 GiB free / <3 GiB additional envelope**. Captured scratch regular-file footprint is **318,762,062 bytes** using fresh stat/hardlink deduplication, including reused package bytes, excluding the existing Docker VHDX/prior evidence; whole-host free-space changes are not that footprint. A later inventory observed C: **23,464,296,448 bytes free** while root checks ran.

Five sequential owned PostgreSQL/volume lifecycles: failed **70.746 s**, diagnostic **29.066 s**, fixture-correction **38.397 s**, preliminary **76.338 s**, final **88.818 s**. All containers/volumes/DB ports are removed; unrelated Redis/object-storage services remain. Exact reviewed PostgreSQL 18.6/linux-amd64 platform digest is reused with `--pull never`; each owned container has **2 CPUs /1 GiB**, user 999, read-only root, cap-drop/no-new-privileges, bounded WAL/log/temp/connections, random 127.0.0.1 port and no host/app/socket mounts. Final PGDATA **42,872 KiB**. Disposable keys/DB secrets exist only as private fixture inputs, never ordinary logs or owner configuration.

Documentation checks pass **123 Markdown /1,952 local links /four JSON examples /34 whitespace checks**. Preservation/redaction validates exactly **ten documentation paths**, all unrelated tracked bytes, private-config hashes and the retained I1-A inputs. These checks do not rerun Flutter/browser/native suites.

Repository changes are documentation only. App/S0/composition/configuration/dependencies/policies/tool pins, ignored/untracked owner `.env` files, mobile/assets/native, prior fixture sources and **13 immutable snapshots** remain unchanged. Preserve **67 requirements /224 tasks /20 plans /seven checked tasks**; full M02 remains Planned. Existing notice/native/embedded/portable-delivery/early-library ownership gates and Decision 0010's latest **2026-11-23 UTC** review date are not renewed or waived.

## 6. Next bounded work

Continue the **remaining I1-B matrix** under Decision 0029, with fresh resource/prerequisite checks: cookie write ownership/idle/absolute expiry and realm noninterference; maintained verification/reset callbacks and current-address transitions; actual fresh staff TOTP/current exact capabilities; refresh-reuse/MFA denial effects, token/reset COMMIT responses and bounded observable side effects/reopen/operational cases. Keep the same adapter and rerun all unchanged contracts after any change. Neither this checkpoint nor a later complete I1 authorizes application adoption, production policy, a new M02 ordering exception or real data.
