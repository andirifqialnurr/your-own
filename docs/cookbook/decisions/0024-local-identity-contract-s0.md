# Decision 0024 — S0 local identity contracts and pure policies

- **Status:** S0 local contract/pure-policy artifact scope implemented and verified; full identity tasks remain open
- **Authorized by:** Project owner, 2026-10-26 UTC
- **Recorded by:** Coding agent
- **Sources:** [Decision 0023](0023-auth-app-adoption-review.md), [S0 packet](../authentication-app-adoption.md#4-s0--proposed-smallest-application-slice)

## Explicit question and answer

After `bfbd918`, the assistant asked: **“May I implement S0 only next—uncomposed identity contracts and pure-policy tests, with no new dependencies, database or auth routes? This would be a narrow ordering exception, not full M02 approval.”** The owner replied **“continue”**.

Authorize only S0, a preparatory part of M02-T02's application boundary work, brought forward while full M00/M01/M02 prerequisites remain open. This is an explicit narrow order exception, not start/approval/completion of the full M02 milestone, provider adoption or a native/CI/real-data/release waiver. Keep all task IDs/checklists; full M02-T02 and T07 remain unchecked.

## Implementation scope

- Dependency-free `apps/api/src/modules/identity/contracts`, pure `domain` policy, deliberate `index.ts`, synthetic `test/identity-context.test.mjs` and useful module README/index/traceability updates. Application scope/assurance vocabulary is internal, not a JWT/cookie/SQL/wire protocol. Detailed TypeScript shapes may be refined within the packet's bounds.
- A declared request-bound authority port and explicit authenticated/denied/unavailable outcomes, **no concrete credential authority/verifier**, password/reset/token code, provider/store/DI module or new HTTP/job entry. Do not port fixture seeding/signing/control/clock commands or introduce a development login bypass.
- Pure policies use only already trusted authority context; deny missing/ineligible/wrong-owner/wrong-scope/insufficient-assurance input, preserve unavailable distinctly. Type/shape checks are correctness aids, not proof of identity, freshness or live state. No API DTO may turn client JSON into a trusted context. Staff context needs current authority-owned grant/capability and actual fresh TOTP evidence; generic MFA/recovery/frontend flags do not suffice.
- AppModule/factory/config, manifests/locks/policies/tool pins, ignored `.env`, Flutter/native/assets and prior evidence remain byte-preserved. No new dependency/graph resolution, auth/DB/provider execution, Docker allocation, R2/mail/cloud/browser/native/hosting/deployment or original credential use. Health remains live 200/ready 503 and unavailable product routes remain 404.
- Existing root checks plus focused unit/type/import negative controls, owned temporary C:-only type fixtures/evidence and updates to relevant documentation are permitted. No lifecycle/peer/hash/TLS/checksum bypass, policy weakening, global changes, unrelated cleanup or history rewrite. Ordinary separate commit/push remains authorized.

## Recorded local result

The [S0 report](../identity-contract-s0.md) maps four pure source files, 23 synthetic identity/compiler cases, additional import controls and health/auth-absence assertions. Full root checks pass 176 entries; source scan is 41 files / 137 dependency directives. AppModule/factory/config, dependency/lock/policy pins and original ignored config remain unchanged. No concrete authority, credential/source/store, route or runtime integration is enabled; all seven checked tasks and 13 snapshots are retained.

## Completion boundary

Report actual code/tests and scope limits; preserve failures, existing config/assets/snapshots and seven checked tasks. Close only S0's local artifact scope, not full M02-T02/T07/M01 or operational identity acceptance. Package/model/schema, combined graph, real provider/guarded HTTP, cookie idle/verified-email, operational and platform gates from Decision 0023 still require separate decisions/evidence.
