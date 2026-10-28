# M00-T07 — Authentication app-adoption decision packet

- **Prepared:** 2026-10-26 UTC after `2891854`
- **Status:** Historical S0 recommendation checkpoint, later authorized in Decision 0024; current post-install recommendation is the [readiness supplement](auth-integration-readiness.md), not app adoption
- **Review scope:** [Decision 0023](decisions/0023-auth-app-adoption-review.md)
- **Authority:** [Backend](../BACKEND_TECH_SPEC.md#9-authentication-and-account-lifecycle), [security](security.md#3-identity-and-lifecycle), [schema](schema.md#3-identity-preferences-and-staff), [M02 prerequisites](../milestones/02-identity-and-data-foundation.md)

## 1. Recommendation and owner choice

**Do not enable product authentication or copy the fixture now.** Retain first-party auth **0.1.1** and the owned live-grant/shared-transaction approach as the leading evaluated candidate, with opaque access or another separately reviewed maintained integration still available. Public library hashing/reset/token/MFA services plus an owned persistence/policy adapter are a viable engineering direction; this evidence does not establish release stability or a production-ready integration.

Recommend authorizing **S0 only** next: a small, dependency-free, uncomposed backend identity contract/pure-policy slice with synthetic tests. It can start useful application-owned boundaries without pretending that protocol, database or platform adoption is complete. No provider/DB package, credential verifier, token issuance, password store, account creation, HTTP route or personal data belongs in S0.

**Owner question:** May the agent implement S0 only, including its explicit narrow task-order exception, while all provider/schema/auth-enable/M02/native/release gates below remain open? This packet's preparation is **not** an affirmative answer.

## 2. What the evidence actually supports

| Evidence | Demonstrated | Cannot be added together as proof of |
|---|---|---|
| [Decision 0018 real package](local-nest-authentication-spike.md) | Default-cost hashing/encrypted TOTP, actual services and memory/loopback tests | Durable accounts, production clock/key custody, all browser/native behavior |
| [Decision 0019 real store](prisma-auth-store-spike.md) | Four selected store contracts, real SQL barriers/rollback/roles/restart | A later changed adapter automatically satisfying the same published contracts |
| [Decision 0020 HTTP](durable-auth-http-spike.md) | Real module/guards/Origin/CSRF/TOTP over HTTP with durable selected stores | Durable users/account transactions; those user/grant records were memory fixtures |
| [Decision 0022 account prototype](account-transaction-prototype.md) | Durable synthetic users/grants, typed transactions, real COMMIT/rollback, owned live-state checks and independent processes | The new coordinator operating through Nest's route guard/provider authenticate path; RPC called its verifier/state method directly |

The existing application still imports **HealthModule only**. [AppModule](../../apps/api/src/app.module.ts), [application factory](../../apps/api/src/app.ts) and [module index](../../apps/api/docs/MODULE_INDEX.md) have no auth/database composition. Live health is 200, readiness remains 503, and product endpoints remain absent. Framework choice alone never supplies complete authentication.

## 3. Maintained integration versus fixture code

Acceptable future owned responsibilities: account/lifecycle lookup, least-privilege adapters, typed unit of work, conditional credential-generation recheck, current grant/policy evaluation, safe audit/outbox and post-commit response handling. Reuse maintained public crypto/session/MFA/reset services; do not recreate their algorithms, call private vendor modules or patch package code to get a pass. Compatibility-dependent token-digest routing is an adapter obligation to revalidate on upgrade, not an independent reset-verification algorithm.

**Reject direct porting of the prototype:**

- Its private IPC dispatcher includes seeding, arbitrary signing, fault/control modes, clock overrides, privileged cutoffs and raw result transport. Delete these from any eventual production design rather than hiding them behind an environment flag.
- It issues both session and token credentials in one fixture flow, uses fixture realms/claim names/audience/TTLs and a controlled clock. None selects native/web/admin protocols or separate BFF secret/origin policy.
- Its registered provider returns a minimal `{id}`; the actual guarded HTTP path and verified-email/account-context projection were not exercised. It is not a sufficient application principal for every policy. The live check alone is not verified-email onboarding, owner authorization or staff capability enforcement.
- Seed accounts were already email-verified and shared one synthetic initial password hash. The rollback boundary for verification ran; an unverified-to-verified transition did not. Public lookup/normalization/signup, account linking and provisioning remain unproved.
- Static cookie-idle integration mismatch: `cookie()` validates without opening an owned transaction, but the new store's `touchSession()` requires one. Library best-effort touch can hide that rejected write. Long-lived active cookie sliding was not tested; resolve the adapter/guard boundary and test idle behavior rather than disabling idle expiry or allowing global writes.
- The reset-request fixture drains `onModuleDestroy()` to inspect a memory sink. That is not a request-handler API or durable sender/job design. Never wait on shutdown hooks to simulate real email scheduling.
- Process reopen reused keys retained by a test parent. Global logger suppression, `any` IPC arguments and monolithic worker composition are test conveniences, not production validation/observability/configuration patterns.
- The new transaction-aware store implements published types but has not rerun the original full selected published contracts in its new composition. Retain those contracts and add HTTP/rollback/privacy tests; earlier different-adapter passes do not transfer automatically. Explicitly review MFA-failure visibility/denial commits and transaction ownership when adapting the published harness; do not conceal a semantic difference behind a type-compatible facade.

Stop/reconsider the candidate if acceptable integration requires a crypto fork/private import, transaction/root-client casts, weakening peer/hash policy, hidden positive eligibility cache, or silently committing technical partial failures. Early 0.1.x maturity, public seam compatibility and the maintenance burden need an explicit owner decision, not inference from passing samples.

## 4. S0 — Proposed smallest application slice

**Not implemented or authorized by this packet.** S0 would be a narrowly brought-forward preparatory part of M02-T02's boundary work, **not M02 start/completion or a waiver of M00/M01**. The owner must explicitly permit this order exception; keep all 224 task IDs/checklists and native/CI gates unchanged.

Proposed file ownership, all new paths until separately implemented:

| Target | Limited purpose |
|---|---|
| `apps/api/src/modules/identity/contracts/actor-context.ts` | Minimal application-owned actor/scope/assurance references, no password/hash/token/client profile claims. Trusted provenance is the authority's job, not JSON casting. |
| `apps/api/src/modules/identity/contracts/identity-authority.ts` | Protocol-neutral port and explicit authenticated/denied/unavailable outcomes; no concrete verifier or credential source. |
| `apps/api/src/modules/identity/domain/identity-access.ts` | Small conservative pure policy for already trusted context: ownership/scope/required assurance eligibility, explicit deny on absent/ineligible context. No fabricated successful authentication. |
| `apps/api/src/modules/identity/index.ts` | Deliberate type/port/pure-policy exports, no provider or infrastructure export. |
| `apps/api/test/identity-context.test.mjs` | Synthetic pure-policy cases, denial/unavailable distinction and import/compilation checks; existing root test command already discovers this file pattern. |
| API indexes/traceability and identity README | Declare uncomposed contract scope and planned integrations; do not list login routes or a working service. |

Keep business scope/assurance requirements separate from unapproved JWT names, SQL table names, cookie realms and expiry values. Detailed TypeScript names can be refined in S0 within these bounds; do not freeze `gid`/`cv`, prototype `staff:boolean`, a token parser or a runtime credential policy incidentally. No API DTO may accept a purported trusted actor. Type brands/private constructors are correctness aids, **not cryptographic proof or a security sandbox**.

S0 acceptance, all **Not run/not implemented** here:

1. Contract/domain files follow the existing [import policy](import-boundaries.md), with no framework/transport/I/O/vendor import; no boundary waiver or unapproved runtime alias.
2. Synthetic tests deny missing/ineligible/wrong-owner/wrong-scope context and distinguish unavailable authority from denied credentials. Staff access is not conferred by a frontend flag or generic MFA label. Only already trusted test contexts may exercise positive policy cases.
3. No concrete `authenticate`/mint/verify implementation returns a synthetic identity in the application; a declared port is not a working provider. Fail-closed/not-yet-implemented behavior must not become a development login bypass.
4. AppModule/config/dependency graph and actual HTTP endpoint set stay unchanged; health/readiness remain honest. No automatic database/container/worker starts or new `.env` inputs. Keep staging/production fail-closed.
5. Existing root checks plus new relevant tests, scanner negative controls and API indexes/traceability pass. A separate commit/push closes only this local slice; M02-T02/full T07 stay unchecked.

No empty framework/provider/DB scaffolding, Flutter auth screen, Next.js app or global SDK installation is needed for S0. The current scanner permits owned `modules/identity/contracts`, `domain` and `index.ts` while enforcing purity; API scripts compile source then run `test/*.test.mjs`. These are actual repository constraints, not newly invented commands.

**Subsequent S0 authorization/result:** after `bfbd918`, the owner answered the explicit S0-only/order-exception question with “continue”, recorded in [Decision 0024](decisions/0024-local-identity-contract-s0.md). Its [contract/pure-policy slice](identity-contract-s0.md) now exists with synthetic tests, no concrete authority or composition. That is separate permission/evidence, not this packet retrospectively approving later package/schema/route adoption or full M02.

## 5. Gates before later auth/DB integration

| Gate | Required next evidence/decision | Current status |
|---|---|---|
| Package/maturity | Explicit local candidate adoption, public extension/lifecycle semantics and upgrade/rollback ownership; maintained alternative if unacceptable | Pending; first-party artifact/runtime evidence only |
| One actual combined app graph | Resolve/review the intended importer/pins/peers, fresh advisory/notice/native review, strict frozen/script-denied repeat and safe install scope | [External frozen full/production dependency check](auth-database-install.md) passed; app adoption/generated client/integration and portable release artifact still pending |
| Owned schema/migrations | Review stable IDs/account state, grants/family binding, constraints/lock order, audit/outbox minimization, migration/rollback/restore policy and synthetic seeds | Pending; scratch migrations not adopted |
| Actual guarded HTTP | Real registered provider/AuthenticationGuard path with the new durable coordinator: DTO validation, no auth fallback, owner/email/lifecycle checks, post-commit cookies/results, Origin/CSRF/realm separation, replay/reset/races and secret-error redaction | Not run for the combined new composition |
| Mail/verification/recovery | Unverified state transition, generic request response, durable protected mail work and delivery/retry policy, safe reset UX and staff recovery/provisioning | Memory sinks/selected earlier cases only; real delivery not authorized |
| Operational security | Production key custody/rotation, current-authority outage policy, retention/maintenance/rate/capacity and clock/hash bounds, lost response/uncertain commit, backup restore preserving revocation | Pending; fixture values/samples not policy |
| Client/native/BFF | Flutter OS-secure persistence/callback/account switching, separate later Next BFF scopes/secrets, real browser HTTPS/cookie/cache tests and native/CI gates | Pending; no new platform work authorized |

Potential exact-version graph inputs for a **later review**, not install instructions: auth **0.1.1**, Prisma/client/adapter **7.10.1**, pg/types-pg **8.23.1**, current Nest **12.2.0** / TypeScript **6.0.3** / types-node **24.19.2**. Prefer runtime packages in runtime dependencies and migration/generation tooling in an explicitly reviewed development scope; do not cargo-cult the experimental manifest's classification.

The reviewed Prisma CLI graph also needed explicit React/DOM **19.3.1** peers for its tooling. Do not silently inject them into the API, auto-install peers, invent a CLI-free migration/generator or create another workspace/importer. Choose/review the actual tooling placement and graph first. No Next.js adoption follows, and Decision 0010 policy A is not applied. Keep its exact policy B, strict peers, scripts denied, exact pins and `verifyDepsBeforeRun:error`; revalidate at adoption/change/release or by **2026-11-23 UTC** at latest. Existing Prisma/native/image/embedded attribution obligations remain shipping gates; dated advisory evidence is not fresh full-graph clearance.

A later integration slice needs its own owner scope, resource preflight if experimental storage/DB is used, explicit graph/schema/protocol decisions and an honest readiness contract. It does not inherit permission from S0 or this review. Do not reuse the owner's R2/API `.env` as auth/key/DB configuration or commit new secrets/examples with real values.

**Subsequent graph/tooling review:** [Decision 0025](decisions/0025-auth-database-graph-review.md) separately authorizes the [saved-lock/placement review](auth-database-graph-review.md), not resolution/install/adoption. Root-development CLI/React/type peers are proposed, with explicit optional-CLI production-closure and Studio package-manager-engine gates. The 344-identity static union is not a product graph or fresh security/notice clearance.

**Subsequent lock-only result:** [Decision 0026](decisions/0026-local-auth-database-lock-only.md) separately authorizes the [external two-importer resolution/review](auth-database-lock-only.md). A 344-package lock, frozen repeats and dated advisory queries pass, but no installation or application adoption occurred. Optional CLI/Studio/React remain reachable from API runtime lock edges, and lint peer contexts change through jiti; clean production artifact/runtime/engine evidence remains open.

**Subsequent installation result:** [Decision 0027](decisions/0027-local-auth-database-install.md) authorizes the [reviewed external full/production phase](auth-database-install.md). Production actually selects 119 packages without CLI/Studio/React/TypeScript; exact archive/installed bytes, frozen repeats and bounded public imports/strict type/lint checks pass. This does not install into the app, test generation/queries/identity HTTP or clear notice/native/platform/early-package maintenance gates. A separate adoption/readiness choice must define any further integration scope.

**Subsequent readiness decision preparation:** [Decision 0028](decisions/0028-auth-integration-readiness-review.md) authorizes only the [post-install packet](auth-integration-readiness.md). Recommend holding application adoption and seeking explicit I1-only external adapter-contract and durable provider/guarded-HTTP proof. Static comparison records optional refresh claims/late-successor incompatibilities in the changed prototype; no contract is rerun, assertion waived or new experiment approved. The S0 question below remains the historical checkpoint, not a request to repeat S0 or inferred permission for M02.

## 6. Decision to record next

Recommend **S0 only** now; hold package/schema/auth-enable adoption. The owner can approve S0, defer it, or request a different explicitly bounded review. A direct continuation to the S0 question must be recorded as that slice/order exception, not blanket acceptance of the subsequent gates. No package is installed, no missing proof waived, no M02 task checked, and production authentication remains disabled.

## 7. Verification record

Evidence: `C:/Users/HP/AppData/Local/Temp/your-own-auth-adoption-cyscy2kr/` retains baseline/config hashes (no values), `source-review.json` and check/preservation logs. Actual app composition/package/scanner files and M02 plan were inspected; preceding prototype sources remain hash-identical, and all **215** installed candidate files still match the reviewed artifact. Static source-chain assertions support the idle-cookie/principal/request-hook findings; they do not reproduce runtime cookie failure or validate a new provider integration.

`pnpm check` passes on its first run: **142 existing root tests** (21 tooling + 14 design/artwork + 88 boundaries + 19 API), lint/types/build and **37-source / 131-directive** scan. Documentation passes **109 Markdown / 1,760 local links / four JSON examples**, plus 29 owned JS/TS/JSON whitespace checks. Precommit preservation/redaction retains exactly **eleven documentation paths**, app source/config/locks/policies/assets/native bytes, prior prototype sources and **13 snapshots / 67 requirement IDs / 224 tasks / 20 plans / seven checked tasks**. S0 paths are absent, M02 remains Planned, and no new package/model/order exception is approved.

No candidate install/execution/download, new graph resolution, database/auth-fixture listener/container, R2/mail/cloud, browser/native or global-tool action occurs. Existing root API health-test listeners run/close separately; no product-auth or S0 implementation test ran. Review artifacts are C:-only and below 10 MiB. Earlier experimental failures/results are preserved unchanged, not converted into adoption/production certification.
