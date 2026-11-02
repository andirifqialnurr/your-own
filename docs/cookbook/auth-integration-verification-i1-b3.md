# I1-B3 — Maintained verification callbacks and current-address safety

- **Recorded:** 2026-11-02 UTC after `e48a7b4`
- **Authority:** [Decision0035](decisions/0035-external-i1-batch-resumption.md), external five-checkpoint scope only
- **Result:** Selected verified-email checkpoint verified; **2/5**; full I1/application adoption still open
- **Tasks:** Preparatory M00-T04/T06/T07; seven checked tasks/full M02 Planned

## Composition and transaction ownership

Continue the [B2 patched345/full/119-production graph](auth-integration-cookie-i1-b2.md), strict pins/policies and identical generated schema/client20. No new package/version/peer/engine/security exception or old fixture mutation. The original Store/Context, AtomicStore, S0 and35-case contract remain byte-identical; **35 cases pass twice** again before HTTP. Current worker-only typed lint and strict compilation pass with unchanged rules/flags.

The actual maintained **EmailVerificationService.send/verify** and registered public **EmailVerificationHandler** now drive loopback HTTP completion. This is not B1's private SQL verified-email toggle. A transport store receives the **library-computed token hash**, discovers its owner without consuming, locks/rereads the durable account in an active typed frame, then delegates to the unchanged generic consume. No custom reset/token hash or private vendor helper. Conditional `id + current email + Active` update, minimized audit/outbox and token consumption share that transaction. Generic contracts are not rewritten or replaced by a permissive test adapter.

Issuance accepts the current server-read account/address, never a client user/email override. Handler.send stages a link on that transaction's frame; an explicit **bounded32 synthetic memory sink publishes only after COMMIT**. Normal HTTP exposes no token/email/principal, and an explicit private drain observes completion without shutdown. This is not durable mail delivery: crash between COMMIT and memory publication, lost delivery and production mail/retention/rate policy remain unproved. Minimized durable audit/outbox rows do not themselves deliver a link.

## Executed acceptance

**12 HTTP cases pass in full, clean-production and restored clean-production workers**; the worker's runtime dependency tree is checked at startup. The entire unchanged **18-case B2 cookie suite also passes in production** after the new composition.

- A maintained callback changes a durable unverified account to verified; the existing cookie's actual provider/guard/S0 projection changes403→200 in another process. A fresh replacement process reads the committed result.
- Extra user/email/verified fields are rejected; client headers cannot elevate; callback result returns only `{verified:true}` and no cookie/credentials.
- A link sent to an old address cannot verify a newly changed one. **An observed SQL row wait**, then committed address change before account acquisition, proves the conditional current-address reread rather than a lucky sequential test.
- Malformed/unknown/exactly expired/wrong-purpose tokens refuse. Wrong-purpose verification does not consume a password-reset-purpose row. A used token cannot replay; successful verification removes sibling verification links for that owner, not another user's links.
- Two independent service callbacks for one real token yield exactly one201 and one400, one minimized verified audit and no remaining consumed token.
- Real deferred-FK **23503** during request issuance prevents synthetic mail publication and token persistence. Callback COMMIT failure restores the consumed token, false verification state and prior audit/outbox counts; the same token works after fault restoration. No success/cookie/credential escapes.
- Actual **42501** on callback-side outbox INSERT rolls back verification and token consumption; technical failure is503, not an authenticated or verified capability. Restoring privilege recovers.
- Inactive current accounts and hostile Origin cannot complete verification. These synthetic Origin/session controls do not select final browser/BFF/native protocol.

Three **assertion-specific expected-red controls** remove only owned conditional-address matching, verified-email projection or post-COMMIT mail publication. Each fails its intended assertion, not startup/import/installation; the complete production verification positives and B2 regressions are restored afterward. Vendor code, all35 contract assertions/concurrency, current source rules and existing timeouts remain.

## Evidence, checks and limits

Evidence remains **`C:/Users/HP/AppData/Local/Temp/your-own-i1-resume-7ofj4g7c/`**, immutable **`b3-final/`** checkpoint plus `run_b3.py`, current new worker/test sources, full/production/restored/control/cookie-regression logs, exact inventories/advisories and validation/publication records. No new failed B3 runtime attempt is relabeled; B2's original capped-inventory/unsupported-option/helper/readiness/lint/root-timeout failures stay preserved in their own evidence.

This DB lifecycle takes **94.561 seconds**, PGDATA **42,816 KiB**, with container/volume/port removed and unrelated services preserved. Retain the verified image/engine,2CPU/1GiB/non-root/read-only/cap-drop/no-new-privileges, bounded WAL/log/tmpfs/connections and separate roles. New data remains C:-only under <3GiB additional/≥20GiB free; no host/image/settings/global-cache change. Current exact bytes/security, ordinary root checks and documentation/preservation results are recorded separately in the checkpoint validator.

Application source/S0/composition/configuration/dependencies/policies/pins/private .env/mobile and13 snapshots remain unchanged. No auth library/model/schema/claims adoption, production mail/key/hash/clock/expiry/recovery/availability policy, browser/BFF/native/Flutter/hosted/real-data/physical-restore/uncertain-COMMIT proof or M02 advancement. The **2026-11-23 UTC latest review deadline is not renewed**. Next: **I1-B4 maintained reset transaction/live cutoff**; B5 fresh staff TOTP/exact capability and B6 denial/regression remain unrun.
