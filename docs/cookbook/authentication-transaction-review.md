# M00-T07 — Durable account transactions and access invalidation

- **Reviewed:** 2026-10-26 UTC after `24a97a8`
- **Status:** Recommendation prepared; not implemented, owner-adopted or runtime verified
- **Scope:** [Decision 0021](decisions/0021-auth-transaction-design-review.md)
- **Authority:** [Backend identity contract](../BACKEND_TECH_SPEC.md#9-authentication-and-account-lifecycle), [security](security.md#3-identity-and-lifecycle), [logical schema](schema.md#3-identity-preferences-and-staff)
- **Observed baseline:** [Decision 0020 HTTP evidence](durable-auth-http-spike.md); no earlier pass is relabeled

## 1. Problem and recommendation

The external composition proved actual TOTP/HTTP/SQL integration but still used memory users/passwords/lifecycle/grants. Password reset revoked durable sessions/refresh families, yet an issued access JWT remained usable. **Moving users into PostgreSQL alone fixes neither cross-store atomicity nor already-issued access authorization.**

Recommended next evaluation, **not accepted production policy**:

- **R1 — Durable authority:** one Nest-owned account/credential authority with a monotonically increasing credential generation, plus revocable logical sign-in grants. Never independent Flutter/web/admin password repositories.
- **R2 — Live access:** if retaining native JWTs, verify cryptography then consult current account + grant state on every protected authorization. Browser BFFs retain separate opaque sessions. No stale positive cache/read replica on a path promising post-commit revocation. Opaque native access is a valid alternative to evaluate, not silently substituted now.
- **R3 — Shared commit:** account/password, credential generation, grant/session/refresh invalidation, reset consumption and required safe audit/outbox records share one explicit database unit of work. Reuse maintained crypto/services; prove composition rather than copying their algorithms.

| Access approach | Revocation property and cost | Disposition |
|---|---|---|
| Stateless JWT until expiry | No current per-device/account cutoff; short TTL only limits exposure | Cannot support a claim of immediate revocation |
| JWT bound to live account/grant | Existing candidate token API can carry owned claims; requires authoritative read and transaction/issuance coordination | Recommend evaluating first, not adopted |
| Opaque access for all clients | Lookup-based revocation, no claim-only authorization; native header/provider/rotation integration still untested | Alternative if JWT complexity is not justified |

The proposed live check intentionally trades stateless availability for current authorization: authority read failure denies protected access with a safe unavailable response, not cached permission. A maintenance touch failure is distinct from failure to read authoritative eligibility. Database capacity, timeouts and this availability tradeoff need explicit acceptance; offline local drafts are not permission for the server to accept stale credentials.

## 2. Actual source constraints

Static inspection of the previously integrity-reviewed **auth 0.1.1** files and owned store, without executing them in this task:

| Source / operation | Finding and consequence |
|---|---|
| `account/password-reset.service.js`, `reset()` | Consume token → check current account/email/password fingerprint → hash → revoke sign-ins → update password → delete other reset links → revoke again → mark email verified → emit event → optional sign-in. Sequential awaits, not a database transaction. Revoking twice is defensive, not a proof that a late password verification cannot issue credentials. |
| Same file, `request()` | Work is deferred with `setImmediate`, tracked in-process, then token save/event/send. Immediate generic response does **not** mean durable mail scheduling; process exit can lose work. |
| `jwt/token.service.js`, `pair()` / `refresh()` | Access JWT signs stored family claims plus subject, not an automatic durable family/session reference. Refresh creates its successor **before** conditional predecessor spend; reuse revokes the family and throws. An outer transaction must not roll that revocation back merely because it returns 401. |
| Same file, `revokeAll()` | Explicitly leaves issued access tokens alive until expiry. Refresh disabled/no signer can make revoke-all a no-op. All issuing/verifying contexts must use consistent selected features. |
| `jwt/jwt-bearer.provider.js` | Cryptographic verification precedes overridable `validate(claims)`: a possible live-state seam, not an existing grant check. Generic MFA is inferred from `amr`, not fresh TOTP method/time. |
| `jwt/jwt-signer.service.js` | Custom claims are spread after configured issuer/audience and generated `jti`, before fixed issuance/expiry times. Never forward a request's claims object: use an exact server-owned allowlist; prevent issuer/audience/subject/key/realm overrides. |
| `session/session.service.js` | Rotation creates a successor then conditionally deletes the old session; failed touch can return the previously read live session. A stable logical grant is distinct from rotating cookie/session digests. |
| `events/authentication-events.service.js` | Diagnostics channels and RxJS notifications occur in process, before any proposed enclosing DB commit. Not a transactional audit/outbox or rollback-safe external notification. |
| Owned `db/store.ts` | Methods use a root Prisma client; recovery replacement/email save start their own `$transaction`, while other steps are separate statements. Passing a transaction client via a type cast or merely wrapping the route does not enlist all calls. |

These are package/adapter observations, not a finding that production account code exists. Candidate early-version maturity, artifact/notice and prior advisory limits remain. No new registry/advisory request or package version selection occurred. A guessed `providers/jwt-bearer.provider.js` path was absent; the actual `jwt/` file was located and checked instead.

## 3. Proposed logical records and trusted context

Names below are review vocabulary, **not** a physical Prisma schema, JWT wire contract or migration:

| Concept | Minimum responsibility |
|---|---|
| Account auth state | Stable internal user FK, lifecycle eligibility, credential generation, credential/hash reference and change revision. Separate from public profile data and publication epoch. |
| Local credential | Library-generated versioned password hash and approved normalized lookup identity, uniqueness/account binding; never raw password. Password reset may change only the verified token's account. |
| Logical auth grant | Unpredictable grant ID, owner, server-selected realm/client kind, credential generation at sign-in, creation/expiry, revocation, trusted assurance and staff-grant revision where applicable. It survives credential rotation as a reference, not as permanent authorization. |
| Session/family binding | Every opaque credential and refresh family maps immutably to its grant/owner/realm. A library session digest, refresh digest, family ID and logical grant ID are different identities. Never repurpose a rotating digest as stable grant authority. |
| Durable security work | Minimal audit plus outbox/job reference written with the change; no passwords, raw reset/refresh tokens, TOTP seeds or full user records in audit/general event payloads. Mail secret storage, retention and encryption need separate policy. |

For candidate JWT issuance, only server code may assign owned grant/generation claims through supported `IssueTokensOptions.claims`; the package carries these into refresh successors. Exact claim names remain pending. Require canonical types and owner/realm consistency; missing/malformed bindings fail closed. Serialize a BIGINT generation without unsafe JSON-number coercion. Never add the current generation to an old token while validating it or refreshing an old family: that would upgrade a revoked credential. General profile/theme changes do not automatically change credential generation. Never reuse user/grant IDs or reset a generation after deletion/restore.

Proposed verifier order: fixed issuer/audience/algorithm/key/temporal validation → strictly parse owned binding claims → one coherent primary-authority read of account, grant and required family state → compare subject/realm/generation, lifecycle, expiry/revocation → build a minimal trusted context → enforce owner/policy. For cookie access, resolve digest → bound grant with equivalent checks; no JWT downgrade/fallback around missing state. JWT claims, frontend flags and generic `amr` are not current staff grants or fresh TOTP. Staff grant removal/regrant must not revive old assurance: bind its revision or invalidate the affected admin grants and require reauthentication.

## 4. Transaction and ordering contract to prove

Use an explicit opaque unit-of-work port shared by credential repository, all selected auth-store methods, verification/reset handlers, grant binding and safe audit/outbox writes. A transaction-aware adapter must accept a correctly typed transaction client; transaction ownership sits at the coordinator. Nested helpers reuse that context without opening an unrelated transaction. Missing/mismatched context fails closed on coordinated paths; no fallback to a global client. Async-local propagation alone is not a transaction proof.

Proposed consistent lock order: account auth-state row first → affected logical grants in stable ID order → associated session/family/email/MFA rows under a reviewed per-operation order. All writers, including login, MFA completion, refresh, reset, logout, staff changes and deletion, must obey it. Account bootstrap/creation needs a separate uniqueness/coordination path when no row exists; old credentials must never create a missing authority row. Do not claim one lock order covers unrelated pair/conversation/publication workflows without reviewing those crossings.

| Flow | Required coordination |
|---|---|
| Password sign-in | Expensive verification can occur outside a transaction, but creation locks/re-reads current account eligibility and the same hash/generation that was verified before creating a grant. A reset committed during hashing makes that result stale; do not stamp a newer generation onto it. Issue no usable response credential until commit. |
| Refresh | Lock/recheck account and grant/family binding before rotation; preserve the original generation. Revoked/reused/expired families cannot mint usable successors. A known reuse outcome must **commit** its revocation before returning invalid-token, not throw out of a generic rollback wrapper. |
| Reset | Resolve the existing token's account for lock routing without treating lookup as authentication; under the account lock let the real library re-consume/check purpose, expiry, email, subject and password fingerprint. A mismatch between routing and consumed account aborts. Update hash, increment generation, invalidate all existing grants/session/family credentials across realms, invalidate reset siblings and write required audit/outbox atomically. No automatic sign-in in the proposed first prototype. |
| Device logout | Revoke the stable grant plus its session/family credentials, not just the currently presented digest. A concurrent completion/rotation cannot revive that grant. Unrelated devices stay eligible unless an all-device action is requested. |
| Global logout/reset/lifecycle deny | Advance account security generation or equivalent durable cutoff and revoke appropriate grants within the coordinated commit. Reactivation must not restore old credentials. Exact suspension/recovery policy remains to approve. |
| MFA/step-up | Only actual server-observed TOTP success upgrades assurance under a still-eligible account/grant/revision. Failure/lockout counters need a committed failure outcome; blanket rollback on bad code must not erase attempt accounting. Recovery is not TOTP step-up. |

**Reset composition blocker:** the current service hashes after token consumption, so wrapping it unchanged keeps that expensive work inside the enclosing transaction. A preparatory lookup may route locks only; it must not invent reset redemption/fingerprint crypto or authorize a user. Supported lookup/digest compatibility, lock ordering, default-cost hashing under bounded transaction time, handler conditional-write failures and every participating store must be proved. `updatePassword` must throw on failed conditional mutation rather than silently reporting success; an invariant failure in email verification cannot be hidden by an ignored false result. If the supported seams cannot satisfy bounds, seek a maintained upstream transaction/prepare-commit seam or review another integration. Do not vendor-patch, weaken hashing or declare the existing service automatically atomic.

**Side-effect blocker:** use reset without auto-sign-in while evaluating atomicity; buffer response tokens/cookies until commit, and never mail/push/publish or acknowledge success inside an open DB transaction. Library events may occur even if an outer commit later fails: keep them diagnostic/minimized, not the source of durable audit, mail or privileged effects. The proposed coordinator writes authoritative safe audit/outbox rows; actual durable mail request/dispatch, protected secret references and duplicate-delivery handling need their own design/test. No SMTP/worker is enabled here.

Known authentication denials versus technical failure need typed outcomes: an intended reuse denial must preserve family revocation, a wrong-factor denial must preserve required attempt counts, and library invalid/stale reset-token consumption semantics must be explicit. Unexpected DB/write/audit/commit failure must roll back coordinated changes and return no usable credential. Do not catch every exception and commit partial reset state. Retrying serialization/deadlock failures cannot silently repeat nontransactional effects or MFA verification; define retry scope after testing. A lost response after committed reset does not justify saving replayable plaintext token pairs: the client may need to sign in with the replacement password or request recovery again.

## 5. Meaning of revocation and failure

The proposed guarantee is **post-commit authorization**, not recall of delivered bytes: an authorization read that begins after revocation commits must reject affected credentials even when their signature/expiry remains valid. Use a current primary READ COMMITTED authorization snapshot, not a stale replica, earlier repeatable-read snapshot or positive cached eligibility. Reads already authorized may finish; sensitive writes must recheck under the account/grant coordination and hold it through domain commit. Define each operation's authorization point and lock interaction; a route guard alone is insufficient.

Invalid/revoked bindings yield the selected invalid-session response; authority read/commit failure yields safe unavailable, not an anonymous bootstrap or a signature-only fallback. On uncertain commit, do not emit new credentials or assume rollback: later attempts re-read durable state. Socket permissions need reauthorization at protected sends/operations, not only handshake; logout also clears the correct client scope. Existing signed media URLs, earlier responses and external caches have separate revocation limits. This review does not solve them by changing auth generation.

## 6. Required evidence before adoption

All rows below are **Not run for this proposed account/grant design**. Prior store barriers and HTTP tests remain scoped evidence, not substitutes.

| Future case | Required observation |
|---|---|
| Reset rollback at each write/commit boundary | Fresh clients see either old coherent state or the full new state; no mixed password/generation/grants/token/audit state, no usable response credential on failure. |
| Login verification held across reset | Two independent API processes/clients; old verified hash cannot create a current grant after reset commits. |
| Refresh/MFA held across device/global logout | Stable grant stays revoked across rotations, successors and retry; other devices survive device-only logout. |
| Same-second resets/global logout | Generation comparison rejects old JWTs without relying on coarse `iat`; no generation wrap/reuse or upgrade from current-state lookup. |
| Two reset attempts / reuse denial | Observed real DB contention, single accepted transition, explicit consume/rollback behavior; refresh reuse still commits family revocation. |
| Wrong-factor transaction outcome | Real failure/lockout counts persist; no capability issued and no attempt-budget reset through rollback. |
| Lifecycle / staff remove-then-regrant | No deleted-account rebootstrap or old admin assurance revival; current scopes and actual TOTP method/time still enforced. |
| Malformed/signed wrong bindings | Missing/forged/cross-owner/realm/generation claims and unsafe numeric coercions denied; frontend claims never influence signing configuration. |
| Authority outage / restart / restore | No cached-positive fallback; fresh processes with approved persistent keys/user state enforce existing cutoffs; restore procedure cannot reactivate revocations. |
| Side effects / lost response / default-cost bounds | Audit/outbox commits exactly with intended state; diagnostics are not authoritative, no mail/cookie before commit, retries are explicit; bounded transaction/lock duration measured with default hashing. |

An eventual external prototype should reuse the exact reviewed graphs without a merged product resolution, synthetic durable accounts, real PostgreSQL migrations/roles, independent instances/barriers, injected write/commit failures and guard-removal controls, with the existing C:-only resource envelope **freshly preflighted**. This paragraph is a proposed test boundary, not execution approval, new numerical production policy or a fixture implementation.

## 7. Decision and verification record

Recommend R1–R3 for the next **isolated evaluation**, retaining opaque access as an alternative. Owner acceptance/prototype authorization, production library/protocol/schema/keys/recovery/retention/hosting choices, combined product graph and complete T06/T07/M01/M02 acceptance remain open. No password/reset primitive or app auth endpoint was added.

Evidence directory: `C:/Users/HP/AppData/Local/Temp/your-own-auth-transactions-oh9qilfu/`. It retains baseline/config hashes (no values), `source-review.json` and preservation/check logs. All **215 published/installed candidate files** still match the original artifact; eight selected candidate sources and two owned sources are hash-recorded. Source-order assertions are static checks, not execution of the proposed model. Earlier external fixture source hashes remain unchanged.

`pnpm check` passes on its first run: **142 existing root tests** (21 tooling + 14 design/artwork + 88 boundaries + 19 API), lint/types/build, **37 source files / 131 dependency directives**. Documentation passes **105 Markdown / 1,706 local links / four JSON examples**, plus 29 owned JS/TS/JSON whitespace checks. Preservation/redaction checks retain exactly eleven documentation paths, original ignored config/app/locks/policies/assets/native bytes, **13 snapshots / 67 requirement IDs / 224 tasks / 20 plans / seven checked tasks**. Previous task failures are untouched, not new passes.

No candidate execution/install/download, DB/auth-fixture listener/container, R2/mail/cloud, browser/native or global-tool change occurred. Existing repository API health-test listeners run/close as part of the root suite; no product-auth test or new account/grant implementation ran. Review artifacts are C:-only and below 10 MiB. Documentation/source validation is not runtime proof of this design.
