# Isolated auth/database lock-only result

- **Date:** 2026-10-28 UTC
- **Authority:** [Decision 0026](decisions/0026-local-auth-database-lock-only.md), owner's “continue for some tasks” after `efb4a56`
- **Tasks:** Preparatory M00-T04/T06/T07 only; full tasks unchecked, full M02 Planned
- **Status:** External lock-only phase passed; no installation, runtime compatibility or application adoption

## 1. Inputs and actual commands

One C:-only workspace reproduces the existing root/API importer layout, starting from the repository lock and the [exact proposed manifest split](auth-database-graph-review.md#2-recommended-placement-to-evaluate). Only manifests/workspace policy/seed lock are copied; no `.env`, application source, generated client or privileged auth fixture. Node **24.18.0** / pnpm **12.8.1** and existing pins/policies remain unchanged. Fresh preflight had C: **25,810,268,160 bytes** and D: **220,240,408,576 bytes** free; no experimental data is allocated on D: and no cleanup is inferred.

Actual resolution, in the external workspace only:

```bash
pnpm install --lockfile-only --ignore-scripts --no-frozen-lockfile --reporter append-only
pnpm install --lockfile-only --frozen-lockfile --ignore-scripts --offline --reporter append-only
```

The first command updates only the external lock; it is not a package installation. Resolution passes in **4.882 seconds**, followed by a byte-identical frozen/offline lock-only repeat. The same hash is then reproduced from the original repository seed using explicit owned `--store-dir`, `--state-dir`, empty `--npmrc-auth-file` and public `--registry` arguments, followed by another frozen/offline lock-only repeat. Effective config confirms strict peers/engines, automatic peers off, scripts denied, exact saves, `verifyDepsBeforeRun:error`, the two-importer layout and exact policy B. Policy A stays absent.

No `node_modules`, linked dependency tree, archive, candidate import, Prisma CLI/engine/generation, DB/container or product authentication is created/executed. Lock resolution is not installation-time engine enforcement or a runtime build. Studio still declares pnpm `8`; the lock-only commands do not reject it. Do not interpret that as upstream pnpm 12 support or permission for an engine bypass.

## 2. Resolved graph and exact delta

The application document now has **two importers / 344 packages / 344 snapshots**. The package-manager document is byte-identical to the repository's. Lock SHA-256:

```text
adfc7066becca85096b249cafd3c60dd5d7bdb24e83bd5a6a5c65c398077d53f
```

There are **144 added package identities versus the current repository**, but **zero new/removed identities or changed package metadata/integrities versus the prior 344-identity auth/DB union**. All 200 current repository package records remain identical. Direct declared pins and intended runtime/development ownership match the proposal. Exactly one Multer **2.5.0** identity remains, reached through the exact Nest adapter parent edge; no additional override/peer waiver or affected 2.4.0 is introduced. Original repository locks are unchanged.

**The snapshots are not a literal concatenation.** Eight old-root lint peer contexts change because Prisma → `@prisma/config` → `c12` supplies **jiti 2.7.0**, satisfying ESLint 10.13.0's declared optional `jiti: '*'` peer. ESLint gains that optional edge and its callers' peer-qualified snapshot keys change. The reviewer checks that these are the only changes to prior root snapshots after that exact substitution; no unrelated version/integrity/body delta is accepted. This needs combined-install lint/type regression evidence later; the current repository's passing lint does not test the new peer context.

## 3. Production delivery is still not proved

Static API-runtime reachability, **including optional/peer/platform edges**, visits **249 snapshots**. In particular:

```text
API runtime @prisma/client
  -> optional prisma CLI peer
  -> @prisma/studio-core
  -> React / React DOM
```

TypeScript is also an optional client peer, and adapter-pg reaches `@types/pg` as its own dependency. Root `devDependencies` classification does not erase these lock edges. The 249 figure is not an installed-production package count: no production prune, platform selection, clean install, generated-client packaging or artifact inspection ran. Do not claim the CLI/Studio/React are excluded, ship them silently, drop optional peers globally or create a new importer to hide this result. Review and test the actual intended production boundary before adoption.

## 4. Fresh advisory and selected metadata evidence

Two direct verified-HTTPS public database queries on **2026-10-28 UTC** cover all **344 exact package/version identities**: npm bulk advisories returns no affected package, and OSV batch returns no affected query. A separate lookup of historical **Multer 2.4.0** returns its known advisory, demonstrating the npm endpoint is not merely returning an empty response for everything. That control is not added to the graph or installed. Raw responses, request UTC/server dates and hashes are retained; no advisory is suppressed.

Ten exact public registry records (nine proposed direct additions plus Studio core) match locked integrity strings and have no deprecation marker at capture time. Declared peers/engines/scripts/licenses are recorded as metadata only; archives are not downloaded. These checks do **not** revalidate every graph artifact, establish complete retraction history, prove source/installed-byte integrity, clear missing attribution/native/WASM/image obligations or certify absence of vulnerabilities. pnpm's cached “supply-chain policies” line is explicitly **not** the fresh advisory evidence. Decision 0010's owner accountability, regression/notice gates and **2026-11-23 UTC** latest review date are unchanged, not renewed by this experiment.

## 5. Corrections, evidence and remaining work

Evidence: `C:/Users/HP/AppData/Local/Temp/your-own-auth-lock-only-488kmehf/` contains hash-only baseline, external manifests/locks, exact command/config/result logs, graph/peer/reachability reports, selected registry records, both advisory responses/control and preservation checks. Task-owned files remain below 10 MiB, C: remains above the 20 GiB reserve, and no owned service/listener requires teardown. Shared-cache deltas are not claimed as exact per-task attribution.

Preserved helper corrections: legacy `NPM_CONFIG_*` path settings were not reflected by pnpm 12 config output, so documented explicit flags were used for the additional repeat. An initial assertion incorrectly expected the auth-file argument in serialized config (`KeyError`) before that repeat; the argument is accepted but not serialized. The first graph helper incorrectly assumed old peer-qualified snapshot keys could not change (`KeyError`); its original source is retained, then corrected against the explicit jiti edge. During the explicit seed reproduction, the resource monitor also encountered an atomically removed pnpm temporary file (`FileNotFoundError`); the command finished with the same lock hash and its owned process exited. Its helper/log are preserved, then monitoring was corrected for disappearing temporary files with process cleanup in `finally`; the complete explicit seed/frozen sequence passes. A Git Bash path-conversion error in the owned PID query was corrected without changing a process. No peer/engine/security rule, resource threshold, timeout or product assertion was relaxed. Earlier fixtures/snapshots/failures remain intact.

A next separately authorized phase could review archive/script/native/engine prerequisites and perform **external frozen, script-denied full/production installs and artifact/import/lint checks**, without app changes or DB. Stop if engine/peer/integrity/security constraints fail. This phase does not authorize it. New adapter contracts, actual registered-provider/guarded HTTP, cookie-idle transactions, verified-email projection, key/mail/restore/operations and native/BFF acceptance remain in the [adoption gates](authentication-app-adoption.md#5-gates-before-later-authdb-integration). S0 stays dependency-free/uncomposed, health stays 200/503, and full M02 remains Planned.

`pnpm check` passes on its first run: **176 existing root entries** (21 tooling + 14 design/artwork + 99 boundaries + 42 API), lint/types/build and **41 sources / 137 dependency directives**. Documentation passes **116 Markdown / 1,869 local links / four JSON examples**, plus 34 owned JS/TS/JSON whitespace checks. These exercise the unchanged repository, not the combined candidate, Flutter/browser/native or an installed production artifact.

Preservation/redaction checks cover exactly **eight documentation paths**. Application/S0/composition/configuration, dependencies/locks/policies/pins, ignored/untracked `.env`, mobile/assets/native, preceding prototype sources and **13 immutable snapshots** remain unchanged. **67 requirement IDs / 224 tasks / 20 plans / seven checked tasks** are retained; full M02 remains Planned. No raw credential/JWT is added to the patch/logs, and no operational identity or release gate is closed.

**Subsequent installation permission/result:** the owner's next “continue again” is [Decision 0027](decisions/0027-local-auth-database-install.md). Its [separate frozen install phase](auth-database-install.md) now verifies exact installed bytes for full 344-package and clean 119-package production trees; CLI/Studio/React/TypeScript are excluded from the latter. That real selection is separate from this earlier 249-snapshot static reachability. Public imports and synthetic strict type/lint checks pass, not generated-client/DB/auth/provider/platform or app adoption.
