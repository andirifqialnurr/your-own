# Identity — S0 contracts and pure policies

[API module index](../../../docs/MODULE_INDEX.md) · [S0 scope](../../../../../docs/cookbook/decisions/0024-local-identity-contract-s0.md) · [Evidence](../../../../../docs/cookbook/identity-contract-s0.md)

This is an **uncomposed, dependency-free** preparatory boundary. It is not a Nest module, credential verifier, user/password/session store, JWT parser, auth route or working identity service. [AppModule](../../app.module.ts) still imports HealthModule only. Do not import the external experiment's worker, seed/signing/fault/clock controls or publish a development login bypass.

| File | Owns |
|---|---|
| [actor-context.ts](contracts/actor-context.ts) | Internal authority-owned user/context references, application scope, lifecycle/authentication/email eligibility and assurance/staff-grant facts. No credential, hash, profile or wire/storage format. |
| [identity-authority.ts](contracts/identity-authority.ts) | Request-bound authority **interface only**, plus distinct authenticated/denied/unavailable outcomes. A future adapter must verify its server-held request and current authority state; none exists here. |
| [identity-access.ts](domain/identity-access.ts) | Conservative pure verdict for a server-owned own-data or operator requirement using an already trusted snapshot. No I/O, cryptography, clock lookup, capability expansion or identity minting. |
| [index.ts](index.ts) | Only public types and `evaluateIdentityAccess`; no provider/infrastructure constructor. |
| [identity-context.test.mjs](../../../test/identity-context.test.mjs) | Synthetic pretrusted fixtures, denial/eligibility/assurance/immutability cases and real compiler positive/negative callers. Not credential or endpoint tests. |

## Policy scope

- Missing/malformed/denied context denies; valid authority unavailability stays `unavailable`, not an anonymous user or an allowed result.
- Both supported policies require active lifecycle, current (not pending/revoked/expired) authentication and verified email. Own-data additionally requires personal scope and exact owner identity; operator scope is not a general private-tracker viewer.
- Operator access additionally requires a current authority-referenced staff grant, exact required capability and actual fresh TOTP assurance. Primary/generic MFA/recovery/stale TOTP and frontend admin/MFA flags are insufficient. Capability strings here are internal exact-match requirements, not an adopted role catalog or wildcard language.
- Freshness/current state are **facts supplied by a future trusted authority**, not computed/proved here. No TTL/algorithm/JWT/cookie/SQL/key policy is selected. Read-only types/defensive shape checks cannot distinguish a forged object from a genuinely trusted one; **never pass an actor from client JSON**.
- A pure allowed verdict does not authenticate anyone, establish an authorization point under concurrent revocation, enforce a database transaction or replace feature-specific ownership/policy checks. Future adapters and operation coordination retain those obligations.

No app composition/config/dependency/health-route change is needed. No credential reaches these types or verdicts. Errors/transport mappings, provider/guard integration, persistence, clocks, verified-email/recovery delivery, BFF/native and production security remain separately gated by the [adoption packet](../../../../../docs/cookbook/authentication-app-adoption.md). Full M02-T02/T07/M01 remain open.
