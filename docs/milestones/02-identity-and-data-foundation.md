# M02 — Identity and Personal Data Foundation

- **Status:** Planned; only S0 preparatory contracts/pure policies brought forward under Decision 0024
- **Depends on:** [M01](01-foundations.md)
- **Targets:** API identity/users/authorization and database infrastructure; Flutter auth/onboarding/session scope, database, network, and sync primitives
- **Requirements:** ACC-01–03; NFR-02/03/05/06/09; applicable backend/security identity and ownership controls
- **Sources:** [Mobile](../MOBILE_TECH_SPEC.md), [Backend](../BACKEND_TECH_SPEC.md), [Schema](../cookbook/schema.md), [Security](../cookbook/security.md)

## Goal

Establish authenticated ownership and recoverable per-user storage before adding real tracker records. Full synchronization is proven with water in M03, not assumed here.

**Narrow preparation exception:** the owner's explicit S0 continuation in [Decision 0024](../cookbook/decisions/0024-local-identity-contract-s0.md) permits only the [uncomposed identity contract/pure-policy portion](../cookbook/identity-contract-s0.md) of T02 before full M00/M01 acceptance. No provider, verifier, DB, runtime context producer or route is composed. This is not authorization to execute the full ordered checklist or a waiver of any native/CI/real-data gate; every M02 task remains unchecked.

## Ordered tasks

- [ ] **M02-T01** — Implement approved backend schema/migration infrastructure. **Verify:** identity mapping, profile/preferences, revisions, receipts, owner sync state, and required metadata migrate reproducibly with reviewed constraints and synthetic seeds.
- [ ] **M02-T02** — Implement provider verification and application-user context. **Verify:** issuer/audience/expiry/key rotation and inactive/deleting users are handled correctly; client-supplied owner IDs never override authenticated context.
- [ ] **M02-T03** — Add explicit DTO validation, safe error mapping, and initial OpenAPI generation. **Verify:** Dart/TypeScript fixtures preserve exact integers/dates/nulls and reject unknown/invalid fields without leaking internals.
- [ ] **M02-T04** — Implement Flutter auth/session adapters and approved recovery flows. **Verify:** cold/warm callbacks, secure credential persistence, safe redirects, expired sessions, and logout behave according to the approved identity strategy.
- [ ] **M02-T05** — Implement minimal onboarding/profile/preferences. **Verify:** users can reach a private dashboard without following/posting, setting optional goals, or granting notifications; mode/timezone/unit/base-currency choices are explicit.
- [ ] **M02-T06** — Implement encrypted per-user mobile database lifecycle. **Verify:** key management, account switching, logout policy, backup restrictions, reopen, and migration preserve authorized pending data without crossing user scopes.
- [ ] **M02-T07** — Build local repository/outbox transaction primitives. **Verify:** local record metadata and its durable operation can commit together or roll back together; operations keep identity across restart and retry.
- [ ] **M02-T08** — Implement authenticated transport and retry boundaries. **Verify:** cancellation, timeout, auth refresh, safe errors, and redaction work; unknown mutation outcomes do not automatically generate a new operation ID.
- [ ] **M02-T09** — Implement backend mutation transaction/receipt/change-stream primitives. **Verify:** ownership, revision, normalized-payload replay checks, commit-safe owner ordering, and required writes share the same transaction under concurrency tests.
- [ ] **M02-T10** — Add privacy-safe session/cache disposal. **Verify:** no previous user's decrypted rows, images, drafts, or unauthorized screen flash survives account changes; temporary auth failure does not discard valid pending records.
- [ ] **M02-T11** — Verify the foundation and update contracts/indexes. **Verify:** synthetic unauthorized-user tests, migration/restart tests, recovery cases, and client generation pass; implemented capabilities are separated from still-planned sync behavior.

## Exit gate

An authenticated synthetic user can onboard and reopen isolated storage safely. Ownership and transaction primitives have real integration evidence. Real-user sensitive data remains gated by M09 and the applicable privacy/recovery checks.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Historical full-milestone checkpoint: await M01. |
| M02-T02 | S0 preparatory contract/policy portion implemented; full task unchecked | Project owner (explicit S0/order exception); coding agent (implementation) / 2026-10-26 UTC | [Decision 0024](../cookbook/decisions/0024-local-identity-contract-s0.md); [module](../../apps/api/src/modules/identity/README.md); [scope/evidence](../cookbook/identity-contract-s0.md) | Read-only internal contracts, unimplemented authority port and pure conservative policies with synthetic tests only. No credential verification/issuer/key/live-state/freshness/HTTP/DB authority proof. AppModule/config/dependencies unchanged; full M02 remains Planned. |
