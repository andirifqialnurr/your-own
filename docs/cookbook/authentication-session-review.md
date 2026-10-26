# M00-T06/T07 — Authentication method and session review

- **Checkpoint:** 2026-10-26 UTC; repository base `18c2b6dd5b446a2750e455c31eb06c6b1f7fb3f3`.
- **Status:** Historical proposal retained; the owner's subsequent “lanjut saja” in [Decision 0015](decisions/0015-auth-methods-and-local-protocol-spike.md) accepts A1/A2 directions and authorizes the local synthetic phase. [Results](authentication-session-spike.md) now supply that portion only; timeout/store/protocol/SDK and full T06/T07 acceptance remain open/unchecked.
- **Authority:** [Decision 0013 review continuation](decisions/0013-provider-and-session-directions.md#authenticationsession-review-continuation), [ACC-01](../PRD.md#acc-01--account-lifecycle), [backend identity](../BACKEND_TECH_SPEC.md#9-authentication-and-account-lifecycle), [mobile isolation](../MOBILE_TECH_SPEC.md#12-authentication-and-account-isolation), [browser sessions](../WEB_PRD.md#8-authentication-and-browser-sessions), [staff assurance](../ADMIN_CMS_PRD.md#6-staff-authentication-and-sessions), [security](security.md).

[Decision 0013](decisions/0013-provider-and-session-directions.md) already accepts Supabase Auth and separate server-side web/admin sessions as directions, **not** their methods/protocol/physical store. The completed [local DB/ORM probe](prisma-engine-follow-up.md) proves no identity, JWT revocation, browser security or native credential-storage behavior.

## 1. Two scoped owner choices

These were the proposal labels presented to the owner, not new product requirement IDs. Decision 0015 records their subsequent scoped acceptance; the original recommendation/rationale below is retained.

| Choice | Recommendation | Why / not selected |
|---|---|---|
| **A1 — First user login method** | **Email + password, verified email before personal bootstrap, provider-managed reset/recovery** | One initial method across mobile and later web; no second Nest password/hash database. Supports password managers and avoids requiring email delivery on every returning login. Still depends on real delivery for verification/recovery and tested provider password/abuse policy. Magic link/email OTP, Google/Apple, passkeys and phone/SMS remain alternatives/later choices, **not enabled or promised**. No guest/anonymous account. |
| **A2 — Staff second factor** | **TOTP required before staff access**, with current grants and fresh step-up for high-impact actions | Fits the required MFA boundary without selecting SMS billing. Enrolled factor alone is insufficient: verify a challenge, trust server-verified assurance and still check current application grants. Staff provisioning/recovery is restricted and audited, not public signup or an emergency bypass. Normal-user optional MFA is a separate choice, not a pilot requirement inferred here. |

**Historical suggested owner response (answered “lanjut saja”, Decision 0015):** accept/adjust A1/A2 as directions and authorize the bounded **local synthetic** protocol spike in section 5. That would not approve a Supabase project, email sender/service, password/timeout numbers, physical session store/keys, real staff provisioning, spending or M02. Those retain explicit gates.

Password minimum/maximum, breach checks, rate limits/CAPTCHA, reset/verification expiry and support recovery rules remain to be reviewed against the chosen provider/project. Do not silently adopt a provider minimum, truncate passwords or invent numbers here. Keep neutral reset/signup responses where account-existence leakage is possible; never log passwords, links or tokens. The existing admin **15-minute idle / 8-hour absolute / 5-minute step-up** values remain **proposed**, not accepted by A1/A2 or this review.

## 2. Official evidence and constraints

Nine new official public documents returned HTTP 200 on 2026-10-26; two same-day session/SMTP source captures were hash-verified and reused without claiming a new request. This is static review only, not provider or SDK execution.

| Official source | Finding / consequence |
|---|---|
| [Password flows](https://supabase.com/docs/guides/auth/passwords) | Signup confirmation, recovery and implicit/PKCE flows are distinct. Reset requests intentionally avoid revealing whether an account exists. Choose/test an allowlisted callback flow, rather than assuming SDK defaults match the server-only BFF. Recovery links authenticate a recovery context; do not give them staff grants/step-up automatically. |
| [Password security](https://supabase.com/docs/guides/auth/password-security) | Provider owns password hashing and configurable strength/breach controls. Naming Supabase does not select the actual project settings or justify storing passwords in Nest/mobile preferences. Plan-dependent controls need an explicit disposition, not a free-tier guarantee. |
| [JWT overview](https://supabase.com/docs/guides/auth/jwts), [claims](https://supabase.com/docs/guides/auth/jwt-fields) | `iss`, `sub`, `aud`, expiry, session identity and anonymous/role distinctions matter. Verified `aal`/optional `amr` describe authentication, not staff capability. Never authorize from an unverified decoded payload or editable user metadata; reject anonymous/public/service-role credentials on ordinary user routes. |
| [Signing keys](https://supabase.com/docs/guides/auth/signing-keys) | Asymmetric keys support JWKS discovery/rotation; edge/SDK caching affects propagation. Prefer an explicitly configured asymmetric signing-key direction for review. Do not trust a request-selected issuer/JWKS URL or treat key rotation as immediate per-session revocation. Exact algorithm allowlist, trusted endpoint and cache/outage bounds remain unapproved. |
| [JavaScript getClaims](https://supabase.com/docs/reference/javascript/auth-getclaims), [getUser](https://supabase.com/docs/reference/javascript/auth-getuser) | `getClaims` verifies tokens using possibly cached keys; `getUser` makes an Auth-server network request. Neither statement alone proves our required **current per-device session revocation** or application lifecycle/grants. Do not substitute a network request or signature pass for a separately specified session-authority check. |
| [MFA overview](https://supabase.com/docs/guides/auth/auth-mfa), [TOTP](https://supabase.com/docs/guides/auth/auth-mfa/totp) | Enrollment, challenge and verification are separate; successful verification upgrades assurance. TOTP QR/secret is credential material, never ordinary screenshots/logs. `aal2` alone establishes neither staff eligibility nor freshness. The claims reference lists optional `amr` method/timestamp: any use for step-up must be signature-verified and demonstrated against actual refresh/recovery/provider behavior. Do not substitute token `iat` for time of authentication. |
| [Session lifecycle](https://supabase.com/docs/guides/auth/sessions) (saved source reused) | JWT signature/expiry, rotating refresh token and current provider session are separate. Logout/session limits have enforcement/cleanup timing; some controls are plan-dependent. Default browser SDK token access is not our accepted server-only opaque-cookie BFF. That integration needs an owned adapter and proof. |
| [SMTP](https://supabase.com/docs/guides/auth/auth-smtp) (saved source reused) | Built-in delivery is restricted/best-effort/non-production. Real verification/recovery needs an approved sender/domain/service, costs and delivery/abuse tests. No email was sent or provider credential/account requested. |

Source response URLs/times, raw hashes and LF-normalized parsed-text hashes are retained at `C:/Users/HP/AppData/Local/Temp/your-own-auth-review-jwthwhkx/`. The two reused captures remain in `your-own-providers-8_va6yfr`. No historical evidence snapshot was rewritten.

## 3. Proposed protocol boundary — not an implementation

### Identity and revocation

- Verify a fixed trusted issuer, explicit audience/algorithm, signature/expiry/time claims and bounded subject/session shapes. Reject `none`, wrong key/algorithm/issuer/audience, malformed/expired/future-invalid values, anonymous/provider service credentials, request-driven key URLs and an untrusted actor override. Map **issuer + subject**, never merge accounts solely by email.
- Resolve current application lifecycle and ownership independently: suspended/deleting/deleted users cannot bootstrap or replay sensitive receipts merely because a JWT is valid. Verified email policy in A1 must use trusted provider evidence, not editable metadata or a frontend boolean.
- Use a proposed application session/revocation authority bound to issuer, subject, provider `session_id` and context. Application-committed logout/revocation should deny subsequent authorized operations after its defined authorization point. It cannot recall in-flight responses or exported data.
- A provider-side logout/reset outside our application is a **different race**. T07 must identify a trustworthy current-session signal (for example a tightly scoped provider session-state adapter) and an approved freshness/outage policy; `getUser` success, offline JWT checks or a webhook-shaped JSON payload are not sufficient proof. Do not grant broad access to provider-owned `auth` tables or promise immediate provider-wide revocation without that evidence. If no safe signal is available, affected online operations remain unavailable until the design is resolved.
- Serialize/coalesce refresh at the session scope, respecting provider rotation/reuse semantics and lost responses. A concurrent old refresh/save must not revive a logged-out session. No disabled reuse detection or silent new-operation ID on unknown mutation outcomes.

### Browser realms and staff assurance

- Existing accepted approach: browsers hold **opaque Secure/HttpOnly/host-only cookies**, not provider tokens. Separate web/admin cookies, secrets, records and credentials. A safe same-origin destination may be retained through login; reject open redirects. Provider tokens stay server-side and BFF forwarding stays allowlisted.
- Proposed backing store is durable PostgreSQL infrastructure storage with separate realm/role access; **physical store/library/schema, encryption/key custody, TTLs and recovery are not approved**. Do not import the domain Prisma client into Next.js, or store plaintext refresh tokens in an audit table/backup without approved protection.
- Bind backend staff context to trusted authenticated issuer/subject/session and the intended admin realm; require current staff eligibility/capabilities, verified MFA and required fresh step-up. Supabase's ordinary `authenticated` audience is **not a web/admin realm separator**. A copied user JWT, user `aal2`, browser `x-admin`/`x-mfa`/realm fields or an admin layout never suffice. Exact backend-verifiable staff-context protocol remains to be proven, not invented headers here.
- Cookie-authenticated mutations, including login/logout and MFA actions, need strict allowlisted Origin handling and a session-bound CSRF strategy. SameSite alone does not protect against hostile sibling subdomains. Callback endpoints have their own verified state/PKCE/nonce/replay rules; do not blanket-exempt them. Rotate session identity after successful login/privilege transitions, prevent fixation, and reject absent/invalid checks.
- Validate signed assurance/method timestamps or an approved backend step-up record; missing/untrustworthy freshness denies sensitive actions. Password recovery, factor removal and staff-grant revocation must invalidate the appropriate staff context. Do not infer fresh login from token refresh or allow recovery to bypass MFA. Staff operator/bootstrap/recovery ownership remains undecided.

### Mobile, callbacks and failure states

- Mobile sends access tokens to Nest, not raw table requests; no service-role credential in the bundle. Review the SDK's actual persistence adapter and OS-backed key store before storing any token. `shared_preferences` remains **appearance only**. Installing secure storage does not automatically change an auth SDK's storage behavior.
- Use an explicitly allowlisted callback/code exchange and one-time correlation. A cold launch, wrong device/initiating context, replay, malformed URL or canceled recovery must fail safely; do not fall back to an insecure implicit-token URL just to make a callback work. Actual Android/iPhone/iPad callbacks/IME/lifecycle remain native tests, not desktop HTTP evidence.
- Logout/account switching stops sync/socket activity, detaches private state and prevents stale writes from the prior scope. Pending offline records require the separately approved retention/resolution policy; auth expiry is not permission to delete them. Offline local signout and pending provider revocation must not be presented as confirmed server-wide logout.
- Identity/JWKS/session/assurance outage must not become permissive login/staff access or a private-screen flash. Return sanitized unavailable/reauthentication states and preserve valid pending input; exact cache/clock/availability bounds still require approval.

## 4. Required evidence matrix for T07

At the review checkpoint all cases below were **Not run**. The subsequent [synthetic report](authentication-session-spike.md) exercises only local crypto/HTTP/session-double invariants; real provider/browser/native/durable-store proof remains missing. Root health tests, decoded sample JWTs and the DB probe do not satisfy those requirements.

| Area | Required positive/negative/race evidence | What a local synthetic test cannot prove |
|---|---|---|
| Token verifier | Signed token accepted only for fixed trusted scope; reject wrong/none algorithm, bad signature/key, malformed claims, wrong issuer/audience, expired/time-invalid and anonymous/service credentials | Actual project key/claims/rotation and SDK configuration |
| JWKS rotation/outage | Known/unknown/revoked key cases, bounded refresh/single-flight under concurrency, no request-driven remote key fetch or fail-open | Hosted edge propagation, clock/cache numerical budgets or provider SLA |
| Lifecycle/session | Issuer+subject isolation, session binding, revoke-before-read/write/replay, delete-before-bootstrap and stale-token denial | Real provider logout/reset/session signal and production retention |
| Refresh/logout | Two refresh attempts, lost response, newer credential save and concurrent logout; old completion cannot resurrect session | Supabase's actual reuse/refresh semantics or native durability |
| Browser realms/CSRF | Web cookie/context cannot become admin; missing/wrong Origin/token, sibling-domain attack, fixation/rotation and unsafe redirect/replayed callback denied | Real browser cookie/CSP/SSR/back-forward behavior, XSS containment |
| Staff assurance | Normal user, no grant, revoked grant, AAL1, stale/missing/mismatched freshness denied; only eligible current verified context accepted | Provider TOTP/AMR/freshness/recovery behavior or actual staff custody |
| Secrets/privacy | Synthetic canary absent from unauthenticated/wrong-realm responses and routine logs; no token/cookie/key leakage | Complete production diagnostics/bundle/storage/native-screen audit |
| Signup/recovery | Neutral responses, confirmation/PKCE/state/redirect validation, recovery cannot grant staff assurance | Real SMTP delivery/rates, real identities, provider abuse and mobile callbacks |

## 5. Proposed bounded local spike and acceptance limits

**Historical plan:** this review did not itself authorize execution. Decision 0015 subsequently authorized the first phase and its [results](authentication-session-spike.md) are now recorded. The original proposed scope was: if the owner accepts A1/A2 and permits the next spike, implement an isolated temp-workspace **Node 24 synthetic** protocol experiment using existing built-in crypto/test/HTTP tools where sufficient. No application auth routes, package installation, Docker/database, Supabase stack/project, browser/device, live email or real credentials are needed for its first phase.

Use ephemeral asymmetric keys and synthetic issuer/subjects/session/realm fixtures, a task-owned loopback JWKS/HTTP server, injected clocks and explicit concurrency barriers. No remote discovery driven by test requests; no log of raw synthetic bearer/cookie/key values. Negative controls and resource teardown are required. Keep fixed test keys/data clearly synthetic; never import the original `.env` or real provider configuration. Stop/report a scope/tool gap rather than add an unreviewed SDK or pretend an in-memory session fixture is durable storage.

Record exact commands/results and limitations, then separately commit/push the bounded experiment report. This first phase can test protocol invariants and fail-closed adapters **only**; it does not select the store, finalize the auth/session API or close full T07. Actual provider/session/MFA/mail and browser/native/storage evidence remain later separately authorized stages. Full T06's hosting/regions/cost/secret/recovery choices, T04/T05/T08/T10–T14 and M01 exit remain open; no M02 or real-data go follows.

## 6. Review verification

`pnpm check` passed **142 existing root tests** (21 tooling + 14 design/artwork + 88 boundary + 19 API), lint/types/API build and the **37-source / 131-directive** scan. Documentation checks passed **90 Markdown / 1,519 local links / four JSON examples**; `git diff --check` passed. Source-response/hash and preservation checks retain 67 requirement IDs, 224 tasks/20 plans/seven checked tasks, the app source/manifests/locks/policies/assets/native wrappers and all 13 historical snapshots. These are review/foundation checks, **not** executed identity/CSRF/MFA/provider tests. No auth/Flutter/native/browser spike, SDK installation, Docker operation or provider/email action occurred in this review.

**Historical owner question (subsequently accepted within Decision 0015's scope):** accept **A1 (email/password + verification/recovery)** and **A2 (required staff TOTP)** as directions, and permit this **local synthetic protocol spike only**, without cloud/email/provider resources or application integration?
