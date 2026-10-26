# Decision 0015 — Auth methods and local synthetic protocol spike

- **Status:** Accepted directions; authorized local synthetic phase executed, not provider integration or full T06/T07 acceptance
- **Approved by:** Project owner, 2026-10-26 UTC
- **Recorded by:** Coding agent
- **Sources:** [Method/session review](../authentication-session-review.md), [accepted provider directions](0013-provider-and-session-directions.md)

## Owner response

After review commit `5580b64`, the assistant asked:

> Usulan:
> - Email/password + verifikasi dan pemulihan email.
> - TOTP wajib untuk staff.
>
> Setuju arah ini dan lanjut uji lokal sintetis, tanpa cloud, email nyata, atau integrasi aplikasi?

The owner replied **“lanjut saja”**. Accept the two methods as directions and execute only the first local synthetic phase described in the review. This is not approval of unmentioned production policy numbers, store/protocol details or a real provider/email/native/browser integration.

## Accepted directions

- **A1:** Initial email/password login, verified email before personal bootstrap, provider-managed verification/reset/recovery. Supabase remains the accepted provider direction; do not create a second application password database. Other login methods/guest mode are not enabled or promised.
- **A2:** Staff must complete TOTP verification before operational access, plus current application grants and required fresh step-up for high-impact actions. Enrollment alone, a normal user JWT or `aal2` does not establish staff permission. No public staff signup or unaudited recovery bypass.
- The server-only opaque-cookie web/admin separation from Decision 0013 remains. Exact JWT algorithms/cache/freshness/expiry numbers, CSRF/staff-context implementation, physical session store, encryption/key custody, provider project/settings, email sender, costs/regions and recovery ownership remain pending. The existing admin 15-minute/8-hour/5-minute values remain proposals, not approved here.

## Authorized local phase

- One disposable workspace outside the repository, using **installed Node 24.18.0 built-in crypto/test/HTTP only**; no package installation, SDK, Docker/database or cloud/provider resource. No application auth route or M02 implementation.
- Ephemeral asymmetric keys, synthetic identities/session/realm/assurance records, injected clocks and explicit barriers. Use only task-owned loopback listeners on random **127.0.0.1** ports; no external key discovery or request-driven outbound URLs. No original `.env`, real credential/account/email or private data.
- Tests may model verifier/JWKS, lifecycle/session revocation, refresh/logout races, web/admin isolation, cookie/Origin/CSRF, staff assurance, safe callbacks and redacted errors. A hand-built JWT/session harness is **disposable experimental code, never a production auth library**. Actual Supabase session/refresh/MFA/mail and browser/native/storage evidence remain missing.
- Numerical fixture settings exist solely to exercise boundaries; they do not approve production timeouts/algorithms. An in-memory session/grant/provider double does not select a store, prove durability or prove provider-side revocation.
- Bound execution to five minutes per run and 50 MiB of new local evidence/fixture files. Close all owned connections/servers and verify their ports close in teardown; preserve failures/sanitized logs, not raw bearer/cookie/key values. No global config/host/security change or unrelated cleanup.
- Separately commit/push the reviewed report and decision under the owner's existing instruction. Preserve application source/locks/policies/assets and all historical snapshots; do not copy prototype auth into product or automatically start M02.

## Execution checkpoint

The [local report](../authentication-session-spike.md) records **92 synthetic cases passing twice** and **six expected-red guard-removal controls**, with all owned loopback listeners/ports closed. Three malformed-input prototype failures were retained and corrected; no expectation was weakened. This is built-in Node crypto/HTTP plus trusted in-memory authorities, not real Supabase/password/TOTP/browser/native/durable-store evidence. No product source/dependency/auth route or provider resource was added.

M00-T06/T07 and M01/native/CI/real-data gates remain open. Decision 0010's owner, exact exceptions and 2026-11-23 UTC latest review date are unchanged.
