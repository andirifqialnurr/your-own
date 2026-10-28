# Isolated auth/database frozen installation result

- **Date:** 2026-10-28 UTC
- **Authority:** [Decision 0027](decisions/0027-local-auth-database-install.md), owner's “continue again” after `34ff6f2`
- **Tasks:** Preparatory M00-T04/T06/T07 only; full tasks unchecked, full M02 Planned
- **Status:** External dependency-installation scope passed; no application package/schema/auth adoption

## 1. Reviewed inputs and permission boundary

Fresh preflight found C: **25,796,550,656 bytes** and D: **220,237,426,688 bytes** free. All new work uses C:, with the existing less-than-3-GiB allocation / at-least-20-GiB reserve and bounded owned commands/logs. No DB/container, app/config change, `.env` copy, generated client, R2/mail/cloud/native SDK or global-tool action occurs.

Two clean external root/API workspaces use the [previously resolved exact graph](auth-database-lock-only.md): Node **24.18.0**, pnpm **12.8.1**, the same manifests, both lock documents and policies. Lock SHA-256 remains **`adfc7066becca85096b249cafd3c60dd5d7bdb24e83bd5a6a5c65c398077d53f`**. Runtime/development placement is tested, not adopted. Strict peers/engines, automatic peers off, scripts denied, exact saves, `verifyDepsBeforeRun:error` and exact policy B remain; policy A remains absent.

Before linking/execution, fresh exact-version registry metadata for **344 identities** matches locked integrity values and has no deprecation marker at capture time. Both npm bulk-advisory and OSV 344-version queries report no findings on this date. All **344 official archives** are SHA-512 verified and inspected without extraction/execution: **93,415,711 compressed bytes / 333,609,508 payload bytes / 17,123 files**. Some reviewed cached archives are reread/rehashed; the rest are downloaded from the official registry with verified HTTPS and no redirects. This is not an exhaustive source-security, retraction, license or release certification.

## 2. Actual frozen installations

In each separate external workspace, with explicit owned store/state paths, empty npm-auth input, public registry and sanitized child environment:

```bash
pnpm install --frozen-lockfile --ignore-scripts --reporter append-only
pnpm install --frozen-lockfile --ignore-scripts --offline --reporter append-only
```

The production workspace adds **`--prod` to both commands**; neither uses `--no-optional`, a changed importer or another override. Both full and clean production installs and frozen/offline repeats pass without changing either lock document. The full initial install reports **1m 32.6s** and slow-download warnings; the production install reuses reviewed bytes from the owned store and reports **1.7s**. Further controlled offline repeats pass with corrected allocation accounting. No script/engine/network limit was relaxed to obtain these results.

| Observed installed tree | Packages | Exact verified files | Package payload bytes |
|---|---:|---:|---:|
| Full development | 344 | 17,123 | 333,609,508 |
| Clean production | 119 | 4,652 | 88,011,496 |

Every installed package file's size/SHA-256 and full file set match its reviewed archive. No vendor patch or unexpected generated/native-engine file is accepted. These are package payload sizes, **not** complete deployable-image sizes, capacity targets or proof of a self-contained release artifact.

Studio's metadata still declares **`engines.pnpm: '8'`**. The actual installs pass with `engineStrict:true` under the pinned pnpm 12.8.1; no bypass is used. This records observed installer behavior only, not upstream pnpm 12 support, exhaustive engine enforcement or production maturity acceptance.

## 3. Production selection and bounded code checks

The earlier **249-snapshot static runtime reachability** included optional/peer/platform edges; it was explicitly not a production package count. The actual clean production selection has **119 packages**, with **Prisma CLI, Studio, React, React DOM, TypeScript and `@prisma/engines` absent**. Runtime auth/client/adapter/pg, transitive `@types/pg` and patched Multer remain. Root and Prisma Client-context resolution probes also report the development tooling unavailable in production; a hidden optional-peer CLI link is not treated as exclusion proof merely because the root link is absent.

Public imports load in both trees: Nest authentication, adapter-pg, pg and **`@prisma/client/runtime/client`**. Only export shapes are checked; no hasher/auth service/pool/client is instantiated. **The generated Prisma Client entry, queries and database availability are not tested**. Do not substitute this runtime-module load for generation or authenticated ownership evidence.

A synthetic full-workspace TypeScript fixture imports the published four store interfaces, adapter and driver types. The pinned strict NodeNext compiler with `skipLibCheck:false` passes; the repository's unchanged type-aware ESLint configuration passes in the newly bound **jiti** peer context. Separate deliberately invalid fixtures fail at **TS2322** and **`@typescript-eslint/no-explicit-any`**, not a missing module or disabled rule. Negative source is removed in `finally`; final positive compile/lint pass again. No application source, credential controls, provider or route is ported into the fixture.

## 4. Scripts, native payloads, notices and corrections

All vendor lifecycle scripts stay denied, including Prisma preinstall and engines postinstall. Registry `prepare` declarations are inventoried, not assumed to run on an ordinary published install. No Prisma CLI, separate schema-engine download, generation/migration, WASM execution or native build is invoked. Filename-based review records WASM in PGlite/dev/CLI payloads; embedded JS/base64/native/other-platform obligations are **not exhaustively inventoried or cleared**.

The standalone-notice filename scan flags twelve roots, a heuristic rather than twelve new rights determinations: for example PostgreSQL's `postgres` package has the previously reviewed `UNLICENSE` file outside that scan's conventional names. Prior attribution mappings remain scoped; **`@prisma/dev` ISC / `remeda` MIT original-attribution gaps**, embedded/native/WASM/image obligations and a real delivery notice bundle remain shipping gates. Local installation and parent license metadata do not clear them or lift the ApexCharts hold.

Preserved helper corrections before code execution:

- The archive reader's assumed `package/` prefix rejected valid DefinitelyTyped and Git-tree roots. It now verifies one safe root, exact manifest identity, regular unique files, path/size bounds and unchanged official/locked SHA-512; original attempts remain.
- Windows cached `DirEntry.stat()` returned inode zero, making the initial **130,015-byte peak allocation counter invalid**. Do not use it as acceptance. Fresh `os.stat()` IDs correctly deduplicate hard links; subsequent checks enforce the same thresholds. Initial free-space/time/log limits remained active. Corrected owned footprint is approximately **461 MB**, with more than 20 GiB C: free; shared/unrelated deltas are not exact attribution.
- A 261-character installed path falsely appeared absent to the ordinary Python lookup. Read-only extended Windows paths prove the exact expected bytes and allow every file/file set to be verified. No OS long-path/security setting, vendor byte or hash assertion changes. A diagnostic quoting error is retained separately; it changed no resource. A later read-only final rehash exceeded its initial 180-second harness budget; the identical byte/file-set check then completed within a bounded 600-second budget. That is not a changed installer, package, application assertion or API's 10-second startup timeout.

Evidence: `C:/Users/HP/AppData/Local/Temp/your-own-auth-install-fh5og9pn/` — baseline, 344 metadata/archive/file maps, advisory responses, both workspace/config/install logs, inventory, public import results, strict compiler/linter controls, corrected resource observations and original helper failures. Owned command processes exit; no candidate server/listener, container or DB requires teardown. Reviewed external fixtures/caches remain; no global prune or unrelated cleanup.

## 5. Remaining gates and next boundary

This establishes the selected Windows-host dependency split and bounded import/type/lint behavior, not an application-adopted graph or portable deployment artifact. Linux/container/image packaging, generated client and schema/migration ownership, new store contracts, actual registered provider/AuthenticationGuard HTTP, cookie-idle transaction ownership, verified-email/current-context projection, key/mail/restore/operations and Flutter/BFF/native acceptance remain in the [adoption packet](authentication-app-adoption.md#5-gates-before-later-authdb-integration).

Next eligible preparation is a **bounded adoption/readiness decision** using this result: choose whether the early auth candidate and proposed tooling split are acceptable for a separately specified integration experiment, or retain alternatives. No package enablement, database, provider port or M02 expansion follows automatically. Decision 0010's review/notice/regression requirements and **2026-11-23 UTC** latest calendar deadline remain unchanged, not renewed by this experiment. Keep seven tasks checked, full M02 Planned and S0 dependency-free/uncomposed.

The first `pnpm check` hits the existing API child-start 10-second timeout (`null !== 1`); `root-first.log` is preserved. An unchanged retry passes **176 existing root entries** (21 tooling + 14 design/artwork + 99 boundaries + 42 API), lint/types/build and **41 sources / 137 dependency directives**. Documentation passes **118 Markdown / 1,888 local links / four JSON examples**, plus 34 owned JS/TS/JSON whitespace checks. No test/timeout is changed; these checks exercise the existing app, not working combined authentication or Flutter/browser/native behavior.

Preservation/redaction covers exactly **eight documentation paths**. App/S0/composition/configuration, dependency/lock/policy/tool pins, ignored/untracked `.env`, mobile/assets/native, preceding fixture sources and **13 immutable snapshots** remain unchanged. **67 requirement IDs / 224 tasks / 20 plans / seven checked tasks** are retained; full M02 stays Planned. No owner credential/raw JWT is added to the patch/logs; no operational identity or release gate is closed.
