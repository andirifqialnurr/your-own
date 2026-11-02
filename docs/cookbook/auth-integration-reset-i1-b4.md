# I1-B4 — Maintained reset transactions and live credential cutoff

- **Recorded:** 2026-11-02 UTC after `85534ba`
- **Authority:** [Decision0035](decisions/0035-external-i1-batch-resumption.md), external synthetic scope
- **Result:** Selected reset checkpoint verified; **3/5**; no application/production adoption
- **Tasks:** Preparatory M00-T04/T06/T07; seven checked tasks/full M02 Planned

## Public services, explicit background ownership

Use the same exact patched345/full and119-production dependency graph, strict policies/pins and20-file generated schema/client as [B2](auth-integration-cookie-i1-b2.md)/[B3](auth-integration-verification-i1-b3.md). No new identity, private import/vendor patch, global-write fallback, old key/client/dispatcher or candidate substitution. Original Store/Context, AtomicStore, S0 and35-case contract stay byte-identical; **35 cases pass twice** before HTTP.

The maintained **PasswordResetService.request/reset**, registered public **PasswordResetHandler**, default **PasswordHasher**, SessionService/TokenService revocation and actual registered **JwtBearerProvider/AuthenticationGuard** now participate. New ephemeral test signing keys are generated per owned DB lifecycle. Trusted key/HS256/type/issuer/audience and server-allowlisted grant/generation/realm claims remain test-only. No custom password/reset/token cryptography or second credential authority.

A reset request responds uniformly before account work: after HTTP response finish, a bounded owned coordinator calls the maintained request API inside a typed active unit of work. Its public handler completion or public no-account requested event provides an explicit observable latch. The frame remains active until that work finishes; private `jobs`/mail drains observe completion **without shutdown**. Maximum four jobs, five-second completion bound and32-entry synthetic memory mail sink are experiment bounds, not production rate/capacity/timeout policy. Malformed-input/technical failure, lost callbacks, job-crash/uncertain-COMMIT and real mail operations remain broader gates; no private inFlight/issue method or shutdown-as-request API.

The public handler conditionally looks up/rereads the **current verified Active address**, takes the account lock and binds the frame before writes. The library computes/stores token hashes and password fingerprints. Completion starts with the maintained hashed-token lookup, then locks/rereads its account before consuming. Default new-password hashing, conditional current hash/version update, generation increment, live grant cutoff, library session/refresh revocations, callback verification, token consumption and minimized audit/outbox share one transaction. No automatic sign-in/cookie is requested: HTTP success is emitted only after COMMIT. Reset endpoints return no raw token/hash/row, and ordinary logs omit credentials. The separately tested maintained `/tokens` login returns credentials only on its own committed success.

## Executed proof

**13 reset HTTP cases pass in full, clean-production and restored production workers**, plus **18 cookie and12 verification production regressions**. Worker-only typed lint and strict compile pass. Normal fixture login actually issues access/refresh credentials with maintained TokenService; the provider reads current durable account/grant/family/verified-email facts into unchanged S0 policies.

- Real request completion/normalized current-address mail is observable before shutdown; a valid unknown address receives the same response and no link. Unverified/suspended address fixtures do not become recovery authority.
- Actual reset changes the default-cost hash and generation; old password refuses and new password works. Existing cookies and otherwise-signed access deny across processes **after COMMIT**. A separate public **JwtVerifier still verifies the old signature/claims**: live owned cutoff, not a changed bare JWT/revocation claim, causes denial.
- Single-use/sibling-link invalidation, owner isolation, changed address/password fingerprint, invalid password/forbidden automatic sign-in, unknown/malformed/exact expiry and parallel one-winner completion pass. Client automatic-sign-in fields cannot consume a valid link.
- Real **23503 deferred COMMIT** on request issuance publishes no synthetic mail/token. Completion COMMIT failure restores prior hash/version/session/family/grant/token/audit/outbox state, returns safe503/no cookie/success capability and retains old live authorization until a successful retry.
- Actual callback-side **42501** rolls back token consumption and partial cutoff; no signature-only success or alternate-provider fallback is created.
- An observed SQL account-row wait followed by committed address change forces refusal before authority acquisition. A replacement process rejects old credentials and new login uses the maintained new hash.

Two targeted **expected-red controls** remove owned live JWT cutoff or publish reset mail before COMMIT. Each fails the intended assertion, not setup/import/startup; no secret is printed by the deliberate mail-leak control. Full production reset positives and both earlier HTTP suites restore afterward. No vendor rule/contract/hash/default-cost/assertion/time limit is waived.

## Failures, resources and preservation

Preserve the initial worker lint prefer-const error/correction without a rule waiver. First actual reset run passes12/13; its extra bare-signature proof reads `.sub` from the public verifier's **Promise** without await. The corrected helper awaits the documented API and keeps the same assertion; original test/source/logs remain under `attempt-b4-1-verifier-await/`. That failed29.671-second DB lifecycle is removed, not relabeled passing.

The final lifecycle takes **84.612 seconds**, PGDATA **42,816 KiB**, with owned container/volume/port removed and unrelated services retained. Keep the exact reviewed image/engine,2CPU/1GiB/non-root/read-only/cap-drop/no-new-privileges/bounded WAL/log/tmpfs/connections/separate roles. New data stays C:-only under <3GiB additional/≥20GiB free; no host/global-cache/config upgrade or prune.

Evidence: **`C:/Users/HP/AppData/Local/Temp/your-own-i1-resume-7ofj4g7c/b4-final/`**, owned current worker/reset test, contract/full/production/restored/control/cookie/verification regression/SQL/resource/teardown logs and final advisory/inventory/root/documentation/preservation/publication records. Earlier B2/B3 and2466 prior evidence files remain immutable; no owner .env is loaded or disclosed.

No repository app/S0/composition/config/dependency/policy/pin/private/mobile/schema/claims adoption, full M02, real mail/cloud/R2/browser/BFF/native/Flutter/hosted/physical restore/uncertain-COMMIT/lost-response or production key/hash/clock/recovery/rate/retention/capacity/timeout acceptance. **2026-11-23 UTC latest review deadline remains.** Next: **I1-B5 actual fresh staff TOTP/current exact capabilities**; B6 durable denial-effects/regressions remains open.
