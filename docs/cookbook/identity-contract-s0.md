# S0 — Uncomposed backend identity contracts

- **Scope:** [Decision 0024](decisions/0024-local-identity-contract-s0.md), owner's explicit continuation to S0-only/order-exception question after `bfbd918`
- **Status:** Local S0 contract/pure-policy artifact scope verified; no working authentication service
- **Date:** 2026-10-26 UTC
- **Task boundary:** Preparatory M02-T02 contract/policy portion only; full M02 remains Planned and M02-T02/T07 unchecked

## 1. Actual files and behavior

The [identity README](../../apps/api/src/modules/identity/README.md) maps four new dependency-free source files:

- [ActorContext](../../apps/api/src/modules/identity/contracts/actor-context.ts): internal, read-only user/context references, personal/operator application intent, lifecycle/current-authentication/email eligibility and authority-owned assurance/staff-grant facts. No password/hash/token/profile or wire/storage representation.
- [IdentityAuthority / IdentityResolution](../../apps/api/src/modules/identity/contracts/identity-authority.ts): request-bound **interface only**, no concrete credential source, implementation or DI. Outcomes explicitly separate authenticated, denied and unavailable; no raw error/credential field.
- [evaluateIdentityAccess](../../apps/api/src/modules/identity/domain/identity-access.ts): pure server-owned requirement evaluation for already trusted authority snapshots. No I/O, crypto, clock or authentication. Missing/malformed/ineligible context denies; valid authority unavailability stays unavailable. Own-data requires personal scope/exact owner; operator additionally needs a current referenced staff grant/exact capability/actual fresh TOTP. Both require active/current/verified-email context. Generic MFA, recovery, stale TOTP and frontend flags do not confer operator access; operator scope does not widen access to raw personal trackers.
- [Public entry](../../apps/api/src/modules/identity/index.ts): type exports plus that one pure function, no actor factory, provider, infrastructure or runtime authority export.

Scope/assurance names are internal contract vocabulary, **not** accepted JWT claim names, cookie realms, SQL schema, capability catalog, algorithm/expiry or provider policy. Current/fresh facts must be established by a future trusted authority. Shape checks cannot distinguish a forged client object from a real authority snapshot; no API DTO may accept one. Read-only types are correctness aids, not credential verification or a security sandbox. An allowed policy verdict does not create a principal, validate freshness, read current grants or establish transaction-level authorization under concurrent revocation.

[AppModule](../../apps/api/src/app.module.ts), factory/config and dependencies remain byte-identical. Identity has no Nest module/decorator/registration and is not imported into application composition. API liveness stays 200/readiness 503; synthetic auth/identity paths stay 404. No login/bootstrap/store/migration/worker/queue/Flutter/Next feature or development bypass is enabled. No package/model/schema choice or full M02 acceptance follows.

## 2. Verification scope

[Identity tests](../../apps/api/test/identity-context.test.mjs) use synthetic **pretrusted test fixtures only**. Cases cover missing/denied/unavailable/malformed context, lifecycle and pending/revoked/expired authentication, exact owner/scope/capability, verified email, staff grant absence/revocation, malformed/sparse capability arrays, primary/generic MFA/recovery/stale TOTP, no frontend-flag escalation, immutable inputs and verdict-only output.

A real pinned TypeScript compiler checks a valid external `.mts` caller, then rejects invalid scope/outcome/assurance/authority return and read-only mutation (`TS2322` / `TS2540`). It uses no suppression or dependency install; its owned temporary C: type fixture is removed in `finally`. Only type/contract correctness is established, not authority provenance.

[Boundary cases](../../scripts/architecture/boundaries.test.mjs) add three allowed edges and eight negative cases for identity framework/I/O/config/transport/infrastructure imports and cross-feature bypass. The existing policy is unchanged; this is not a new waiver. [HTTP tests](../../apps/api/test/health.test.mjs) extend real-loopback absence assertions for synthetic identity/login/refresh/reset paths; no route contract is thereby adopted.

Build, focused tests, type-aware lint and boundary checks initially passed. Sparse-array rejection was then hardened with `Array.from(...).every(...)` and a new assertion in the existing grant case; no positive assertion was relaxed. A no-op attempted health-test edit failed its exact match before the correct targeted edit; it changed no file and is not a test pass. No application test/timeout was weakened, no external auth fixture was ported, and original evidence/failures remain untouched.

## 3. Repository checks and preservation

`pnpm check` passes on its first full run: **176 root entries** (21 tooling + 14 design/artwork + 99 boundaries + 42 API, including 23 S0 cases), lint/types/API build and the **41-source / 137-directive** import scan. The existing 142 cases are retained, with 23 identity cases and 11 boundary cases added; no old assertion/timeout is weakened. Separate focused build/identity/lint/boundary checks also passed. Documentation passes **112 Markdown / 1,827 local links / four JSON examples**, plus 34 owned JS/TS/JSON whitespace checks.

Precommit preservation/redaction checks pass for exactly **24 paths**. Four pure source files and one new test are added; prior application composition/factory/config, dependency/lock/policy/tool pins, ignored/untracked `.env`, mobile/font/golden/native bytes, preceding external fixture sources and **13 snapshots** remain unchanged. **67 requirement IDs / 224 tasks / 20 plans / seven checked tasks** retained; full M02 remains Planned. No credential/raw JWT appears in the patch/logs.

Evidence: `C:/Users/HP/AppData/Local/Temp/your-own-identity-s0-p0yh71jx/` — baseline/config hashes (no values), source hashes, focused/full check logs and preservation validator. Evidence/type fixtures are C:-only and small; owned temporary type callers are cleaned by the test. No dependency install/graph resolution, candidate/DB/auth-fixture/container/R2/mail/cloud/browser/native or global-tool action occurred. Existing API health-test listeners run/close separately; S0 does not establish credential/provenance/current-state/freshness, native/browser/provider/DB or production identity behavior.

## 4. Remaining gates and next action

S0 closes only its local contract/pure-policy artifact scope. No concrete authority or trusted-context producer exists, and type/shape compatibility must never substitute for credential/current-state validation. Keep M02-T02, full T07/M01 and other 217 task gates open; no tracker/real-data/release approval follows.

Next scoped preparation: review the **actual combined auth/database graph and tooling placement** and candidate adoption constraints before any provider/store integration. The [adoption packet](authentication-app-adoption.md#5-gates-before-later-authdb-integration) retains guarded HTTP/provider, idle-cookie write ownership, verified-email, key/restore/mail/operations and platform gaps. Do not automatically install packages, choose production protocols or expand S0 into S1/M02.
