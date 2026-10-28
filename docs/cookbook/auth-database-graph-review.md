# Auth/database dependency and tooling review

- **Date:** 2026-10-28 UTC
- **Authority:** [Decision 0025](decisions/0025-auth-database-graph-review.md), bounded continuation after `e7f7577`
- **Status:** Static review prepared; proposed placement, not a resolved graph or package adoption
- **Tasks:** Preparatory M00-T04/T06/T07 only; seven tasks remain checked, full M02 Planned

## 1. Actual graph accounting

Read the actual [root manifest](../../package.json), [API manifest](../../apps/api/package.json), [workspace policies](../../pnpm-workspace.yaml), both lock documents and saved account-prototype graphs. The manager document is separate from the application graph; it is identical across all three locks.

| Saved application document | Importers | Packages / snapshots |
|---|---|---|
| Current repository | Root and `apps/api` | 200 / 200 |
| External auth graph | Root and `apps/api` | 201 / 201 |
| External DB graph | One scratch root | 156 / 156 |

The existing root entries are unchanged in the auth graph; its only added package is authentication 0.1.1. Auth/DB share **13 package identities** with identical metadata, integrity and snapshot bodies. Their static union is **344 identities**, with 15 package names having multiple observed versions. This is bookkeeping, **not a combined resolution, package-count prediction, peer pass or advisory clearance**. Peer contexts and ranged transitives can change under the actual importer layout. Do not concatenate locks or flatten versions: even the DB graph legitimately contains Prisma debug/platform 7.2.0 and 7.10.1.

The DB lock has no Nest/Multer override; the auth lock retains exact policy B. A combined candidate must start from the repository policy, not overwrite it with the scratch DB policy. The historical DB lock SHA-256 remains `1b3ab2922e11746cec7e068c675e1490857db7caa6d3696de1f79f160caf4bec`.

## 2. Recommended placement to evaluate

**Proposal only; no manifest below is applied.** Retain the current workspace membership (`apps/api`) and its existing root/API importers. No tools package, extra workspace, web/admin, second backend or CLI-free migration substitute is proposed.

| Existing importer / classification | Proposed additions | Reason |
|---|---|---|
| Root `devDependencies` | `prisma` **7.10.1**, `react` / `react-dom` **19.3.1**, `@types/react` **19.3.0** | Generation/migration toolchain and explicit Studio peer providers, not product UI |
| API `dependencies` | `@nestjs/authentication` **0.1.1**, `@prisma/client` / `@prisma/adapter-pg` **7.10.1**, `pg` **8.23.1** | Maintained identity services and durable runtime client/adapter/driver candidate |
| API `devDependencies` | `@types/pg` **8.23.1** | Direct typed pool/driver callers, not a hand-written type shim |

Keep current Node **24.18.0**, pnpm **12.8.1**, TypeScript **6.0.3**, Nest **12.2.0**, Node types **24.19.2** and all other direct pins. React types 19.3.0 are an already observed DB-graph identity, newly proposed as an explicit tooling input, not an application-adopted version.

The candidate includes direct `pg`/types for a future owned pool/driver boundary; that boundary is not implemented or approved here. If later code uses only adapter-owned connections, review whether these direct declarations are needed rather than importing undeclared transitives. The adapter already declares `pg ^8.16.3` and `@types/pg ^8.16.0` as dependencies. Calling type packages development-only in our manifest does **not** remove the adapter's transitive type dependency from delivery.

Root tooling would orchestrate the **single Nest-owned** schema/migration tree. It must use an explicit API-owned Prisma config path, not default discovery that loads the owner's root `.env`. Migration credentials stay separate from runtime credentials; no startup migration, Studio server or `db push` fallback. Actual config/generated-output paths, compiler/scanner ownership, migration scripts, engine provisioning and deployment jobs need later review/authorization. None is created by this proposal.

## 3. Concrete peer, engine and delivery traps

- Auth 0.1.1 has no non-peer runtime dependency. Its required Nest/reflect/RxJS ranges encompass the saved pins; microservices/websockets peers are optional, not permission to add services. This is declaration-level evidence, not a merged graph or maturity guarantee.
- Prisma CLI 7.10.1 depends on Studio core **0.33.0**, which requires React, React DOM **and `@types/react`**. DOM 19.3.1 requires React `^19.3.1`; the proposed explicit root providers fit those ranges. Do not rely on transitive type visibility or automatic peer installation. No `@types/react-dom` requirement was found in these inspected declarations; do not add it speculatively.
- Studio's published metadata and saved lock also declare **`engines.pnpm: '8'`**, while this project pins 12.8.1. Earlier strict frozen experiments passed; that does not establish how every package-manager engine declaration is enforced. A new combined experiment must record actual pnpm enforcement and the scope of its checks. If the pinned manager rejects it, stop: no engine bypass, downgrade, vendor metadata patch or unsupported compatibility claim. Node 24.18.0 fits the inspected auth/Prisma Node ranges; that does not resolve this manager declaration.
- Most importantly, the saved Prisma Client snapshot binds optional peers **`prisma` and `typescript`**, and that Prisma context includes Studio's React providers. Moving CLI declarations into root development scope is **not proof that production pruning excludes them**. Before adoption, inspect the newly resolved runtime closure and a clean production-only frozen install/artifact. Demonstrate required runtime imports, generated client availability and actual exclusions; do not silently ship CLI/Studio/React or drop optional packages/peers to manufacture exclusion.
- `pg-native` is an optional peer, not a reason to install native libpq/build tools. JavaScript driver operation does not clear CLI-native engines, WASM or embedded artifacts. The reviewed Windows schema engine is tooling evidence, not proof of deployment-platform compatibility.

The root-development split is a recommendation to test, **not an accepted solution to these traps**. If a clean runtime closure cannot meet the intended boundary, bring back the concrete result and alternatives for owner review; do not create another importer or alter the stack/policy silently.

## 4. Required next experiment gates — not run

1. Obtain explicit scope for one external C:-only candidate using these two importers, exact proposed inputs and current policies. Freshly check free space/resource bounds; do not copy either `.env`, generated fixture controls or private data. Keep all repository dependencies/source unchanged.
2. Resolve **lock-only first**, scripts denied and strict peers/engines retained. Inspect both documents, direct pins, actual peer providers, platform/optional edges, complete transitive/integrity delta and manager-engine behavior. No automatic install or migration/generation follows from lock-only resolution. Stop on any unexplained identity, peer/engine/integrity/security blocker.
3. Refresh exact-graph advisories, retractions/deprecations and source/notice/script/native inventory before any bounded installation/execution. Preserve [Decision 0010](decisions/0010-conditional-dependency-exceptions.md) policy B and its regression floor; policy A remains absent without Next. Adoption/change/release triggers precede the **2026-11-23 UTC** latest calendar review date; this static review is not renewal.
4. Only within explicit experiment permission and after review, frozen script-denied install/repeat, strict type/build/import checks and a separately clean production-only closure/artifact check. No lifecycle scripts, CLI/engine downloads, DB or service startup by inference. Generation/native execution needs its reviewed artifact/command scope; do not point at historical absolute C: generated-client paths to fake application compatibility.
5. Produce exact source/lock/artifact hashes and notice disposition. `@prisma/dev` ISC / `remeda` MIT attribution gaps, bundled/native/WASM/image obligations and early auth-package maintenance/upgrade ownership remain acceptance gates. A historical audit or a parent license does not clear all delivered bytes. Tooling charts do not select product charts or lift the ApexCharts hold.

Even a successful graph experiment would not adopt packages or resolve the [integration packet's](authentication-app-adoption.md#5-gates-before-later-authdb-integration) actual registered-provider/guarded HTTP, cookie-idle transaction ownership, verified-email projection, changed-store contract rerun, key/mail/restore/operations, browser/BFF/native or real-data gates. S0 stays uncomposed; health remains 200/503 and auth routes absent.

## 5. Evidence, corrections and verification

Evidence: `C:/Users/HP/AppData/Local/Temp/your-own-auth-graph-review-txcrksz6/` — hash-only baseline, owned static scanner, source hashes, final accounting/selected public package metadata and proposed manifest data (not a runnable workspace). The initial scanner omitted inline-empty snapshot entries, incorrectly reporting fewer snapshots and false body differences. The corrected constrained scanner accounts for every two-space entry including `{}`; initial report/helper are retained under `attempt-parser/`, not acceptance evidence. Python's optional YAML module was unavailable; no parser/package was installed.

No resolution, install, candidate/CLI/DB/container/R2/mail/cloud/browser/native execution or global-tool action occurred. Review evidence uses C: only; current free-space observations supersede historical low-D: observations without inferring cleanup. Ordinary root checks exercise the existing health API/S0, not merged auth/database behavior.

The first `pnpm check` hit the existing API child-start 10-second timeout (`null !== 1`); `root-first.log` is retained. An unchanged repeat passes **176 root entries** (21 tooling + 14 design/artwork + 99 boundaries + 42 API), lint/types/build and the **41-source / 137-directive** import scan. No timeout/assertion was relaxed. Documentation passes **114 Markdown / 1,850 local links / four JSON examples**, plus 34 owned JS/TS/JSON whitespace checks; Flutter/browser/native and combined-candidate tests were not rerun or claimed.

Preservation/redaction checks cover exactly **eight documentation paths**: application/S0 source, composition/configuration, dependency locks/policies/tool pins, ignored/untracked `.env`, mobile/assets/native, prior prototype sources and **13 immutable snapshots** remain unchanged. **67 requirement IDs / 224 tasks / 20 plans / seven checked tasks** are retained; full M02 stays Planned. Static review and the successful root retry do not close graph/adoption, operational identity or release acceptance.

**Subsequent bounded execution:** the owner's next “continue for some tasks” is [Decision 0026](decisions/0026-local-auth-database-lock-only.md). Its [external lock-only result](auth-database-lock-only.md) resolves 344 packages/snapshots in two importers with frozen repeats and dated advisory checks. No new package identity/integrity appears beyond this review's static union, but eight lint peer contexts change through optional jiti and API runtime reachability still includes optional CLI/Studio/React. No install/artifact, app graph change, provider/DB integration or adoption follows.
