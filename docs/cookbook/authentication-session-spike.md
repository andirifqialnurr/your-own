# M00-T07 — Local synthetic identity/session protocol spike

- **Checkpoint:** 2026-10-26 UTC; repository base `5580b64dde8056fbf6ab3012ae64f868f6c1818a`.
- **Authorization:** Owner **“lanjut saja”** to A1/A2 plus the local synthetic phase, recorded in [Decision 0015](decisions/0015-auth-methods-and-local-protocol-spike.md).
- **Status:** Local protocol experiment passed; **full T06/T07 remain unchecked**. No real login, TOTP verification, SDK/provider integration, durable session store, browser/native or M02 functionality is implemented.

## 1. Scope and reproducibility

Used installed **Node 24.18.0**, built-in `node:crypto`, `node:http`, `node:test`, `node:net` and standard file utilities. **No dependency/image install, Docker operation, external network request, Supabase project, real email or credential, original `.env`, database, app auth endpoint or global setting change.** The accepted email/password + verification/recovery and required staff TOTP are directions, not shipped features or approved production timeout/store/protocol details.

Disposable source/evidence lives only under:

```text
C:/Users/HP/AppData/Local/Temp/your-own-auth-probe-_7o_5dem/
  workspace/protocol.mjs
  workspace/support.mjs
  workspace/protocol.test.mjs
  tests-first.log
  tests-hardening-before.log
  tests-reviewed.log
  tests-repeat.log
  resources-*.jsonl
  negative-controls/
  negative-controls.json
  source-hashes.json
```

The three `.mjs` files are experiment-only, not an application auth library or a package to copy into M02. Commands actually used include `node --check <file>` and, from the external workspace, `node --test --test-concurrency=1 protocol.test.mjs`. The task-owned `run_controls.py` copies the fixtures into isolated negative-control directories and executes filtered child suites, then two full positive runs; it installs nothing.

The harness creates ephemeral **Ed25519** keys, uses Node's actual signing/verification primitives, and serves public JWKS plus a toy boundary over real **127.0.0.1** HTTP on random ports. Trusted issuer is an unresolvable synthetic label, not a remote destination. Keys remain in memory; only public JWKs are served. Private keys, bearer tokens, opaque cookies and CSRF values are not written into evidence logs. Source contains clearly named synthetic canaries, not personal data.

**Fixture-only choices:** EdDSA, accepted claim shapes, strict synthetic return-path list, key TTL/cooldown, staff freshness, cookie lifetime and callback lifetime exercise boundaries; they do not select production algorithms, API/cookie names, callback URLs or policy numbers. The manual JWT envelope/parser is not a reviewed JOSE implementation. Production must use an intentionally reviewed provider-aware verifier/library, not this disposable parser.

## 2. Executed results

The initial suite passed **89 tests**. Three added malformed-input tests exposed real gaps in the prototype; the retained expanded run failed **3 of 92**:

- Non-string callback verifier reached a hashing API instead of a controlled denial.
- Equal character-length but different UTF-8 byte-length nonce reached `timingSafeEqual` with incompatible buffers.
- A malformed/empty refresh response could be reported accepted and overwrite credentials.

The prototype now checks callback input types/bounds, compares buffer **byte** lengths before constant-time comparison, and rejects malformed refresh responses before any credential/version commit. Tests require controlled denials and preserved prior state; no expectation was weakened. This is hardening of a synthetic harness, not a claim that an application vulnerability was fixed.

After correction, **92 tests passed twice, zero failures/skips**. Each full run created and closed **85 fixture pairs / 170 listeners**, sequentially (peak two listeners per fixture), and verified that both ports refused connection after teardown. Both runs completed in seconds, below the five-minute/50-MiB bounds.

| Area | What the local suite actually exercised |
|---|---|
| Signature/claims | Real signed identity and HTTP positive control; bad signature/tampering, wrong/none/confused algorithm, wrong issuer/audience, malformed encodings/lengths/claims, expiry/not-before/issued time, missing identity/session, anonymous/public/service credentials and malformed assurance/method time denials. |
| JWKS | Fixed trusted loopback URL only; single-flight refresh under a real held HTTP response; unknown-key burst refresh limit; new key rotation and old-key removal **after cache expiry**; stale-cache outage refusal; malformed/empty/oversized/duplicate/private-field key sets and redirects rejected. No request-selected key fetch. |
| Lifecycle/session double | Issuer/subject/session tuple isolation; current suspended/deleting/deleted/unverified-email state, revoked or unavailable authority deny a valid signature. HTTP request held during JWKS verification is denied when logout commits before authorization. No application bootstrap or receipt endpoint exists here. |
| Refresh/logout double | Coalesced concurrent refresh, separation between subjects, logout versus late response, newer revision versus stale completion, lost-response uncertainty preserving attempt identity and refusing blind retry, and malformed response leaving prior credentials intact. These model application ordering, not Supabase's actual refresh/reuse protocol. |
| Opaque browser boundary | Browser request sends cookie/CSRF only; toy server retrieves its provider token from server-side memory. Web cookie cannot be renamed/reused as admin; duplicates, expiration, fixation identity/old CSRF after rotation, browser bearer and actor overrides are denied. Cookie attribute **strings** are inspected, not enforced by a real browser/TLS stack. |
| Origin/CSRF | Missing/wrong/null Origin including hostile sibling; missing/wrong/other-session CSRF denied, alongside a working positive mutation fixture. This is manual HTTP-header validation, not browser CSRF/XSS/CSP acceptance. |
| Staff assurance double | Valid synthetic eligible context accepted; ordinary user AAL2, spoofed headers, revoked/revised/missing capability grant, wrong realm/session, AAL1/missing/recovery/mismatched method, stale TOTP time despite refreshed JWT `iat`, and changed session revision denied. No real TOTP challenge, staff provisioning or Supabase AMR semantics were exercised. |
| Callback/recovery model | One-time hashed-verifier/nonce/context/realm/expiry correlation, replay/unsafe return paths and malformed input rejection; recovery never emits staff assurance. This is a correlation model, **not an interoperable OAuth/PKCE exchange or native callback**. The neutral recovery HTTP fixture only returns a generic response and performs no delivery/account lookup. |
| Diagnostics | Rejected response bodies and allowlisted routine audit fields omit synthetic private/provider credential canaries, actual generated bearer/cookie/CSRF values and untrusted URL content; no-store responses retained. Not a whole-product secret/telemetry audit. |

## 3. Independent negative controls

Six isolated copies deliberately removed **one guard each**; the named otherwise-valid negative case had to fail at its intended behavior assertion, not compilation/setup. The unchanged main suite then passed again.

| Removed guard | Test that failed as required |
|---|---|
| Trusted issuer equality | Wrong-issuer signed token rejection |
| Current session revocation | Valid signature after committed logout denial |
| Staff realm | Staff context cannot be used in the web realm |
| Exact Origin | Hostile sibling Origin mutation denial |
| Session CSRF | Wrong-CSRF mutation denial |
| Current staff grant/capability | Revoked staff grant with otherwise valid fresh context denial |

These are **expected-red controls**, not six additional passing auth cases or a relaxed production mode. All control source/logs remain under `negative-controls/`; no mutated guard was applied to the main harness or repository. Filtered suites intentionally select one test each, unlike the full 92-case runs with zero skips.

## 4. What remains unproven / adoption gates

- Session/actor/grant/provider/assurance stores are explicitly **trusted in-memory doubles**. They neither select PostgreSQL session storage nor prove atomic durable grants/revocation across replicas, restart, encryption, key custody or retention.
- No actual email/password validation, password hashing/strength/breach controls, signup verification, SMTP, rate limits/CAPTCHA, TOTP secret/enrollment/challenge/recovery, provider identity linking or account deletion was executed.
- No hosted Supabase issuer/JWKS, edge cache/rotation, `getClaims`/`getUser`, `session_id` authority, provider-side logout/reset or real refresh-token rotation/reuse/lost-response evidence. **Immediate provider-wide revocation is still not established.** Application-double revocation after its authorization point cannot recall in-flight responses or exports.
- No real Next.js BFF/SSR/session-encryption integration, browser cookie/SameSite/CSRF/CSP/back-forward storage isolation, auth callback deep link, Android/iOS/iPad secure persistence, accessibility/lifecycle or native database encryption.
- The accepted staff method remains TOTP, but exact trusted freshness/context transport and operational staff bootstrap/recovery still require approval/provider evidence. **JWT `aal2` is not a staff grant; token refresh `iat` is not a login/TOTP timestamp.**
- Production algorithm/audience/issuer/project/clock/cache bounds, physical session store/library/keys and numerical policies (including proposed 15-minute/8-hour/5-minute staff windows) are not adopted by these fixture constants. No full T06/T07, M01 exit, M02, real-data or release go follows.

## 5. Lifecycle, evidence and next action

Every main/failed/control fixture closes owned servers/connections in teardown and records opened/closed IDs with port-closure checks; no listener or background process is left by the experiment. No unrelated process/resource was touched. Evidence is below the authorized 50-MiB file cap; no cleanup or global package/security setting was changed. All original app source/manifests/locks/policies/fonts/goldens/native wrappers and the 13 historical snapshots remain unchanged.

The original [review](authentication-session-review.md) is retained as a pre-approval/Not-run checkpoint; this report supplies only the local synthetic portion. Preserve failed malformed-input logs and expected-red controls alongside passing repeats. Production auth must not import this prototype.

Repository regression checks: `pnpm check` passed **142 existing root tests** (21 tooling + 14 design/artwork + 88 boundary + 19 API), lint/types/API build and the 37-source/131-directive scan. Documentation checks passed **92 Markdown / 1,550 local links / four JSON examples**; preservation checks retained 67 requirement IDs, 224 tasks/20 plans/seven checked tasks and all unchanged application/asset/policy/snapshot bytes. `git diff --check` passed. The 92 external synthetic cases and six expected-red controls are **not part of** that 142 count, and no Flutter/native/provider test ran.

**Next bounded proposal:** provider-specific session/revocation/assurance adapter review and a separately scoped execution plan for actual provider evidence. No account/resource, SDK install, email, Docker/provider stack, browser/native or application integration is authorized automatically. Remaining hosting/region/budget/secret/recovery choices and native/CI gates remain open; do not restart unrelated hardware inventory or treat synthetic tests as the missing provider proof.
