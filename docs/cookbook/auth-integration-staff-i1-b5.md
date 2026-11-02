# I1-B5 — Actual staff TOTP and current exact capabilities

- **Recorded:** 2026-11-02 UTC after `697955d`
- **Authority:** [Decision0035](decisions/0035-external-i1-batch-resumption.md), external synthetic scope only
- **Result:** Selected staff checkpoint verified; **4/5**; no application/staff-production adoption
- **Tasks:** Preparatory M00-T04/T06/T07; seven checked tasks/full M02 Planned

## Proof source and scoped composition

Continue the same patched345/full/119-production graph, strict pins/policies,20-file generated schema/client and unchanged Store/Context/AtomicStore/S0/35-case contract. **35 cases pass twice** before HTTP; no new dependency identity/peer/engine/security exception or old fixture modification. Ephemeral MFA encryption/signing keys are newly generated per owned DB lifecycle, not copied or persisted as app configuration.

Actual maintained **MfaService.enroll/confirm/TokenService.issue** perform encrypted enrollment, default real TOTP verification/replay protection and recovery-code checks. Enrollment is **private synthetic fixture provisioning only**, not a public staff signup/provisioning/recovery API. A disposable RFC6238 authenticator-input generator uses public Node HMAC and a known public RFC vector solely in the test runner; it never verifies/accepts credentials or becomes an application service. No private vendor import/patch or custom server verifier/hash/encryption.

Staff issuance requires current Active/verified/staff/password/generation state under an account lock, an actual resolved maintained TokenService.issue call with the second factor and its same-call method observation. A private per-call scope correlates the public verified-method diagnostic to that operation; **an event alone, enrollment/confirmation event, supplied AMR/iat/boolean or generic MFA result is not authority**. Only a real TOTP success stamps durable grant method/time and activates it before COMMIT. Recovery or absent/unconfirmed factors never mint active operator credentials. Library events remain diagnostics; minimized audit/outbox effects are separately written transactionally.

The actual registered JwtBearerProvider/AuthenticationGuard reads current grant/account/family, staff revision, exact current capability relation and server-observed method/time into unchanged S0 policy. Test freshness is computed with a5-second bound, rejecting future method time; it is not JWT age or adopted production timing. Admin transport realm maps explicitly to operator scope. Native/personal credentials do not inherit staff capabilities, and operator scope cannot read raw private trackers.

## Executed acceptance

**13 staff HTTP cases pass in full, clean-production and restored workers**, plus **18 cookie/12 verification/13 reset production regressions**. Worker-only typed lint/strict compile pass with no waiver.

- Real TOTP issuance stamps `totp`/server time/admin realm in SQL and authorizes an exact permitted operation across independent processes.
- Enrollment confirmation/staff boolean/extra client method/time/capability fields do not create fresh issuance. Actual stored secret differs from the plaintext authenticator secret; a used time step refuses in another process.
- Exact freshness boundary denies; a new actual TOTP succeeds. Future proof, generic MFA/recovery method labels and client freshness headers cannot become TOTP.
- A real recovery factor is consumed but returns401/no active staff grant/live family/token response, preserving intended denial effects without inventing fresh TOTP.
- Exact capability values do not expand wildcard/roles. Current removal denies without a positive cache. Remove/regrant increments staff revision and cannot revive an old credential; a new TOTP/revision credential succeeds.
- Operator/private-tracker isolation and ordinary-user/client-header denial remain distinct from successful scoped operations.
- Actual deferred **23503** on staff issuance yields safe503/no credentials/cookie, restores the spent TOTP step and leaves no partial grant/family/audit/outbox. The same code works after fault restoration.
- Actual capability SELECT **42501** is503/unavailable, not a default/cached operator permission. Restored privilege recovers. A fresh replacement process rereads current assurance/capability/lifecycle and denies later suspension.

Three **assertion-specific expected-red controls** omit owned freshness, exact-capability projection or staff-revision gating. Each fails the intended assertion, not startup/import. Full production positives and all preceding HTTP regressions restore afterward; no vendor assertion/concurrency/default hashing/time limit is weakened. There is no new failed B5 runtime attempt presented as a pass; older phases' failed/preliminary evidence remains immutable.

## Evidence and remaining boundary

Evidence: **`C:/Users/HP/AppData/Local/Temp/your-own-i1-resume-7ofj4g7c/b5-final/`**, current owned worker/staff authenticator test, full/production/restored/control/regression/SQL/resource/teardown plus final installed-byte/advisory/root/documentation/preservation/publication records. The DB lifecycle takes **127.579 seconds**, PGDATA **43,048 KiB**, and container/volume/port close. Preserve2CPU/1GiB/non-root/read-only/cap-drop/no-new-privileges/bounded WAL/log/tmpfs/connections/separate roles, reviewed image/engine and unrelated services/caches. New experimental data stays C:-only under <3GiB additional/≥20GiB free; ordinary logs contain no raw tokens/TOTP/enrollment/recovery secrets or owner .env.

No application identity producer/route/library/schema/claims/policy, production staff provisioning/recovery/key/hash/freshness/rate/retention/capacity/timeout policy, full M02/notice/native/CI/browser/BFF/Flutter/cloud/real mail/physical restore/uncertain-COMMIT acceptance follows. Normal-user cookie MFA and complete client flows are not certified by this operator-token experiment. Keep **2026-11-23 UTC latest review deadline**. Next and final checkpoint in this batch: **I1-B6 refresh-reuse/MFA denial durability and scoped regression closure**; full I1/operational/adoption gates still remain afterward.
