# I1-A — External auth adapter and generated-client checkpoint

- **Verified subset:** 2026-10-28 UTC, after `471fc57`
- **Authority:** [Decision 0029](decisions/0029-local-auth-integration-i1.md), owner's “continue” to the I1-only question
- **Status:** I1-A passed; I1-B **Not run**, next within that authorization
- **Tasks:** Preparatory M00-T04/T06/T07 only; full tasks unchecked, seven tasks checked, full M02 Planned

## 1. Boundary

This is one external Windows PostgreSQL/store/generation phase, not a working application identity implementation or the completed [I1 readiness matrix](auth-integration-readiness.md#4-required-i1-acceptance-matrixall-not-run). Authentication **0.1.1**, the scratch account/grant schema and transaction/claim/realm values remain experimental candidates. The application still composes HealthModule only; S0 is unchanged and uncomposed. No application dependency, migration, provider, route, trusted actor producer or production policy is adopted.

I1-A resolves the newly recorded generic-refresh contract conflict for a new scratch adapter. It does not retroactively change the [earlier account prototype](account-transaction-prototype.md), rerun its old results under another label, or prove that a dead family cannot authenticate through the still-unrun HTTP coordinator. I1-B must use this same underlying adapter and rerun unchanged contracts after any changes.

## 2. Reviewed graph and generation

The external `full/` and `production/` workspaces preserve the [two-importer graph](auth-database-install.md), exact pins and policy B. Lock SHA-256 remains `adfc7066becca85096b249cafd3c60dd5d7bdb24e83bd5a6a5c65c398077d53f`. Node **24.18.0**, pnpm **12.8.1**, TypeScript **6.0.3**, Nest **12.2.0**, authentication **0.1.1**, Prisma **7.10.1** and pg **8.23.1** are unchanged. Strict peers/engines, automatic peers off, scripts denied and `verifyDepsBeforeRun:error` remain effective; no new importer, override or exception.

Fresh npm bulk and OSV queries for all **344 exact package versions** reported no findings at capture. All 344 previously reviewed official archives were rehashed against saved SHA-256/SHA-512 metadata before installation/execution. This is not a comprehensive vulnerability audit or new production acceptance. Original notice/attribution, embedded/native/WASM, portable delivery, early-package maintenance and Studio pnpm-declaration gates remain.

Frozen/offline script-denied installs select **344 full / 119 production packages**. The exact reviewed engine binary (`e6c4bb89d31f39f7ac601e264c998c0382c069df8485fb8810d0ba8fa806ea4a`) and Apache license hash were rechecked; its version reports revision `d1b3f377ca835d73fd50954a5e22128b9ebdd6b8`. Explicit Generate/repeat uses that engine and a closed-loopback extra-engine mirror, not enabled hooks, a checksum bypass or an old generated client. Both generations produce **19 identical files**. Strict compilation inherits the application's actual options, including `exactOptionalPropertyTypes:true` and `skipLibCheck:false`.

Only newly generated/owned emitted code is copied to the clean production workspace. **Two fresh production Node processes** perform actual generated-client PostgreSQL queries and bare refresh-record/successor/tombstone operations. Prisma CLI, Studio, React/DOM, TypeScript and `@prisma/engines` stay absent; no CLI fallback or historical absolute fixture import supplies the client. This is Windows runtime/DB proof for this graph, not Linux/container delivery or an authentication success.

## 3. One adapter, explicit lifecycle—not a permissive test substitute

- `full/apps/api/src/store.ts` implements the four public store ports using a typed active `Prisma.TransactionClient`. Reads/writes require that context; no root-client cast, nested transaction or global-write fallback. Completed contexts cannot be reused.
- `atomic-store.ts` is an explicit per-operation transaction facade for public contracts. The factory clears only private synthetic fixture tables, then returns this facade. Each method delegates unchanged arguments/results to the **same Store** used by account-bound owned checks. No mandatory synthetic claims, assertion edits, disabled concurrency or contract-only permissive adapter.
- Generic refresh persistence accepts absent and arbitrary claims unchanged. Family owner/binding cannot be reassigned, and later inserts cannot clear a revocation tombstone. Generic storage is not credential issuance or authorization.
- Account-bound operations lock the durable account row. A server-owned transaction binding looks up an Active account and matching nonrevoked credential-generation grant; it does not select that relationship from `record.claims.gid`. This limited binding check does not establish full expiry/realm/staff authority. Foreign owner/grant operations deny or match no row. Arbitrary claim data remains data, not trusted principal provenance.
- Context-scoped maintenance selectors do not touch another account's sessions/email rows. Unbound contract operations have an explicit standalone transaction over the generic fixture namespace; that factory is not an application identity bypass.
- MFA failure insertion/counting takes a per-user transaction advisory lock before insertion. Concurrent committed operations therefore do not each count only their own uncommitted row. The SQL namespace/cap/clock/timeout values are fixture choices, not adopted production policies.

A larger credential coordinator still must check current lifecycle/generation/grant/family/realm/verified-email/capabilities and actual fresh TOTP before issuing or authorizing credentials. This phase neither implements that trusted principal nor proves larger denial-effect, cookie or COMMIT-response boundaries.

## 4. Actual results

| Check | Result |
|---|---|
| Published contracts | **24 unchanged cases, twice**: seven sessions, five refresh, seven MFA, five email; `concurrent:true`, `maxPending:3` retained |
| Owned cases | **11, twice**: absent/nested/escaped context; bare-claim server binding/tombstones; arbitrary claims cannot select grant; foreign binding/write denial; owner selectors; recovery-batch rollback; four SQL barriers; runtime privileges |
| Positive totals | **35 cases twice**, no skipped/cancelled tests |
| Actual SQL waits | Per positive run: eight waiting TOTP claimers, eight refresh spenders, six email consumers and eight MFA insert/counters; exactly one consume/spend/step winner, MFA counts 1–8 |
| Negative controls | **Four expected-red single-case runs**: restore mandatory `gid`, clear tombstone on later save, bypass owner check, remove MFA count serialization |
| Production execution | Fresh generated/owned emitted code makes actual DB queries twice in the 119-package tree, without development tooling |
| Roles/migrations | Separate initialization/migrator/runtime roles; deploy/repeat/status pass. Runtime flags unprivileged; actual SQLSTATE **42501** for migration-metadata read, schema DDL and migrator-role escalation |
| Cleanup | Both sequential owned DB containers/volumes removed, random loopback ports closed; unrelated Redis/object-storage containers retained |

These contract tests use the published testing export, including its own synthetic crypto/services. Their helper hashing costs are not production password policy; no real email, user account or personal data is involved. No private vendor import/patch or global logger suppression is used.

## 5. Failures preserved—not converted into earlier passes

1. **Initial strict compile:** four TS2375 diagnostics exposed optional JSON/MFA properties emitted as explicit `undefined`. Preserve `build-first.log` and `attempt-type-store.ts`. Owned mappers now omit absent fields; strict options and public types are unchanged. Corrected builds pass.
2. **First real DB attempt:** **32/34 passed**, but published parallel MFA failure-count and burst-limit cases failed. With READ COMMITTED and a transaction spanning insert/count, different operations could count their own row before seeing another operation's uncommitted row. Preserve `attempt-1-mfa/` logs/source/teardown. Per-user SQL serialization fixes this actual semantic defect; a fourth SQL barrier and targeted removal control verify the mechanism. The 35-case corrected suite passes twice. I1-B did not start after that failure.
3. Read-only helper inspection hit a guessed archive-map path and Windows stdout encoding issue; correct archive maps and UTF-8 handling are used for final inventory. These are not package/DB/auth failures, skipped assertions or policy exceptions. An ambiguous edit was rejected before writing and then narrowed to unique text.

The first failed lifecycle lasted **23.134 s**; the corrected positive/control lifecycle **32.842 s**. No original result, prior fixture or snapshot is discarded or relabelled as a pass. `a-barriers.jsonl` retains three first-attempt observations followed by eight corrected-positive observations; the first three also remain in the archived failed attempt.

## 6. Resources and private evidence

Evidence: `C:/Users/HP/AppData/Local/Temp/your-own-auth-i1-di26qkc6/`:

- `baseline.json`, `prepare.py`, `prepare.log`, `advisories.json`, `osv.json`, install/generation/build logs and `generated-hashes.json`.
- `full/apps/api/src/{store,atomic-store}.ts`, `contract-a.test.mjs`, scratch schema/two original migrations and newly generated/emitted output; `production/apps/api/prod-query.mjs`.
- `attempt-type-store.ts`, `build-first.log`, `attempt-1-mfa/`, `a-contract-{first,repeat}.log`, `a-control-*.log`, `a-controls.json`, production logs, `a-barriers.jsonl`, isolation/teardown records.

Postexecution file inventory matches the reviewed archives exactly: **344 / 17,123 files / 333,609,508 payload bytes** in full, **119 / 4,652 / 88,011,496** in production. The scratch directory's fresh-stat, hardlink-deduplicated regular-file footprint at capture is **318,480,865 bytes**, including reused package bytes but excluding the existing Docker VHDX/prior evidence. This is distinct from both archive payload totals and whole-host free-space change.

Hash-baseline free space was **C: 24,226,299,904 / D: 220,308,770,816 bytes**. Before/after the corrected lifecycle, C: was **22,030,647,296 / 22,030,430,208 bytes**; monitored commands retained **≥20 GiB free / <3 GiB whole-host C: free-space decrease from that baseline**. That decrease is not an exact owned-file allocation measurement. All new experimental data is C:-only; D: has recovered ample space, not the old low-space condition. Desktop was initially unavailable and the existing installation started normally, without update or host/security changes.

PostgreSQL **18.6-bookworm/linux-amd64** uses the already reviewed platform digest `sha256:6b38fe68f2c02cafffbbce7496f76d110d8a947c039bd22c067e9a43c2250240`, rechecked locally with `--pull never`. One owned volume/container at a time: **2 CPUs / 1 GiB**, user 999, read-only root, cap-drop/no-new-privileges, no bind/app/socket mounts, random 127.0.0.1 port, bounded connections/WAL/log/temp. Final PGDATA was **42,696 KiB**. Disposable DB secrets are generated in memory, passed privately and redacted from retained output; owner `.env` files are never loaded/copied into these fixtures. No Docker prune, unrelated service/cache cleanup, R2/cloud/real mail/browser/native/hosted work occurs.

## 7. Repository checks and next gate

`pnpm check` passes on its first run: **176 root entries** (21 tooling + 14 design/artwork + 99 boundaries + 42 API), lint/types/build and **41 sources / 137 dependency directives**. Documentation passes **122 Markdown / 1,940 local links / four JSON examples / 34 whitespace checks**. These are existing root checks, not additional I1 or Flutter/browser/native tests. Application/S0/composition/configuration/dependencies/policies/pins, ignored private configuration, mobile/assets/native, earlier fixtures and **13 immutable snapshots** remain unchanged. Keep **67 requirements / 224 tasks / 20 plans / seven checked tasks** and full M02 Planned.

**Next: I1-B within Decision 0029's existing authorization**, after fresh resource/prerequisite checks. Exercise the actual durable registered providers/AuthenticationGuard through loopback HTTP, current verified-email/exact-capability/lifecycle projection to unchanged S0 policies, cookie touch/discard/failure ownership, real TOTP, post-COMMIT cutoff/reset/logout, races and credential-free rollback/denial/error outcomes. Preserve the full readiness matrix and same-adapter assertions. Store-level passes and older memory-user HTTP/durable IPC tests cannot be added together as this missing composition. No app adoption follows even from a later passing I1-B.
