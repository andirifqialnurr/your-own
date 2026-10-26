# M00-T06 — Local PostgreSQL / Prisma spike results

- **Checkpoint:** 2026-10-26 UTC, repository base `8d77fe1f4c87ae61d388534ff2cc0ed248fd1ab4`.
- **Authorization:** Owner **“silahkan”** to the explicit local test question, [Decision 0014](decisions/0014-local-database-spike.md).
- **Status:** **Partial / Prisma engine blocked.** Ten real PostgreSQL/driver cases passed. Prisma generation, generated-client build/runtime and Prisma Migrate did **not** pass; no M02 or full T06 acceptance follows.

## 1. Isolated tools, dependencies and image

Used installed Node **24.18.0**, pnpm **12.8.1** and Docker client/engine **29.8.1** (Desktop **4.93.0**, Linux amd64). Initial `docker version` failed because the Linux engine pipe did not exist. `docker desktop start --timeout 90` succeeded; no account, installer, host setting, driver, reboot or engine switch was needed. Existing Docker Desktop remains running; it was not stopped because that could interrupt unrelated resources. Only test-owned containers were stopped/removed.

The disposable workspace is `D:/my_project/mini-projects/.your-own-db-probe-g956tvgc/`; evidence is retained separately at `C:/Users/HP/AppData/Local/Temp/your-own-database-htyek1ng/`. Neither is a new product/workspace package. The original `.env`, app source/manifests/locks/policies and native assets were not copied into the experiment or modified.

| Probe-only package | Exact pin / disposition |
|---|---|
| `prisma`, `@prisma/client`, `@prisma/adapter-pg` | **7.10.1**; stable matching set selected explicitly. The registry's CLI `latest` was **8.0.0-rc.27**, not adopted. |
| `pg`, `@types/pg` | **8.23.1**; actual driver/typed test fixture uses these, not a generated Prisma client |
| `typescript`, `@types/node` | **6.0.3**, **24.19.2**; strict NodeNext/ES2024, `skipLibCheck:false`, no type suppression |
| `react`, `react-dom` | **19.3.1**; explicit **CLI Studio peer support only**, not installed web/admin applications or a running Studio |

Initial seven-direct-package lock-only resolution failed strict peers because the Prisma CLI transitively brings Studio/React controls. No installation occurred at that point. After reviewing the exact React metadata, a nine-direct-package retry supplied the missing peers explicitly; **strict peers remained enabled**, automatic peers/lifecycle scripts stayed disabled, and no peer allowance/override/force switch was introduced. The extra Studio/PGlite tooling is a concrete cost of this CLI graph, not a recommendation to use it as the server database.

The lock contains **171 registry identities: 15 manager + 156 probe application identities**. All exact metadata/archive integrity comparisons passed; **55 declared Node ranges** accepted the installed Node. Archives/full available notice files, lifecycle hooks and native/WASM inventory were reviewed before installation. Script-denied frozen install added 156 application packages (72 reused / 84 downloaded); a frozen **offline** repeat passed with identical lock bytes:

```text
probe pnpm-lock.yaml SHA-256
1b3ab2922e11746cec7e068c675e1490857db7caa6d3696de1f79f160caf4bec
```

The OSV batch for 171 exact npm identities reported **zero matching advisories**, saved **2026-10-26 03:45:22 UTC**. This is bounded/date-specific, not a native-engine/image/security certification. License declarations include MIT, Apache-2.0, ISC, MIT and ISC, BSD-2/3-Clause, EPL-2.0 and Unlicense. Seven packages lack standalone notice files: `pg-types`/`pgpass` include MIT text in README; pinned upstream Radix MIT and postgres.js Unlicense texts were recovered. **`@prisma/dev` ISC and `remeda` MIT attribution/distribution completeness remain unresolved.** PGlite/WASM and all transitive/bundled notice obligations still require final artifact review; this local-only experiment is not release dependency/legal clearance or permission to copy the graph into the application.

### PostgreSQL image

Selected the official image's **18.6-bookworm / linux/amd64** manifest, not a mutable `latest` execution:

```text
platform manifest (pulled/run):
sha256:6b38fe68f2c02cafffbbce7496f76d110d8a947c039bd22c067e9a43c2250240
multi-platform index:
sha256:bbf83594798e144bff365a9c191c5d779f181fb3135902064ab8ff11918020fc
image config:
sha256:63d4ad6f3de5e288238b3044970a677dcb0e77004d8b6050732aa0cbbeedf5d7
```

Official-images metadata points to docker-library/postgres commit **`e00e1bd34ec5c8a8e7ad89b273b3d42efaf6d5bc`**. Its Dockerfile/entrypoint, image license and PostgreSQL COPYRIGHT were retrieved/reviewed; config/manifest hashes, local descriptor/RepoDigest, platform and RootFS layer identities matched. The pinned image is **623,509,410 bytes** uncompressed (registry compressed layers **157,268,716 bytes**). Docker 29's OCI inspection identifies this image by its **manifest** digest, not the config digest; an initial helper's wrong-field assertion was corrected using the descriptor plus verified config/RootFS comparisons, not by dropping identity verification.

The image contains PostgreSQL **18.6-1.pgdg12+2** and Debian components, not solely PostgreSQL-licensed bytes. PostgreSQL/base copyright files were retained from the running image. Official build-source review and non-root/runtime isolation do **not** constitute an exhaustive OS-layer CVE scan, release SBOM/notice bundle or deployed TLS/hosted-network validation. No image was rebuilt or vendor-patched.

## 2. Prisma engine blocker — no bypass

The pinned engine revision is **`d1b3f377ca835d73fd50954a5e22128b9ebdd6b8`**. Static engine-package review shows the postinstall/CLI can fetch `schema-engine.exe` separately; dependency lifecycle scripts remained denied. Requests to both official checksum URLs returned **HTTP 403**:

```text
https://binaries.prisma.sh/all_commits/d1b3f377ca835d73fd50954a5e22128b9ebdd6b8/windows/schema-engine.exe.gz.sha256
https://binaries.prisma.sh/all_commits/d1b3f377ca835d73fd50954a5e22128b9ebdd6b8/windows/schema-engine.exe.sha256
```

No native engine archive was downloaded, checksum ignored, TLS disabled, vendor source patched or alternate untrusted mirror used. Generation with an explicitly nonexistent engine path failed path validation. A second controlled generation invocation removed that override and pointed automatic fetches at closed loopback `127.0.0.1:1`, preventing unreviewed remote download; it failed fetching the checksum with `ECONNREFUSED`. This is a **failed availability guard**, not a passing generation or a substitute engine. No generated Prisma client exists in the probe; Prisma Migrate was not run.

The independently useful PostgreSQL tests below use **reviewed `pg` + explicit scratch SQL**, not Prisma. Their results cannot close the blocked Prisma cases or validate Supabase Auth/Storage/poolers. No silent Prisma/engine version downgrade or package-policy waiver was made.

## 3. Executed PostgreSQL cases

One container at a time, uniquely named/labeled `your-own.db-probe`, used the immutable image. Runtime user **999:999**, read-only root, dropped capabilities, no-new-privileges, 128-PID cap, **2 CPUs / 1 GiB memory**. Test data/socket/temp paths used bounded tmpfs; no bind mount, anonymous/named volume, Docker socket or application-directory mount. The only host binding was a randomly allocated **127.0.0.1** port. Credentials were randomly generated in the helper's memory and passed without recording values/connection strings; initialization SQL with credentials was not persisted or printed.

Initialization provisioned two empty scratch databases and separate migrator/runtime roles. Both roles had no superuser, CREATEDB, CREATEROLE or BYPASSRLS flag. The runtime received only required schema usage/table DML, not migration-table or DDL access. Provider schemas, user/session tables and product schema were not created.

| Case | Actual evidence / result |
|---|---|
| Server and strict driver fixture | Real PostgreSQL 18.6; TypeScript 6 build passed without suppression. This builds the **pg fixture only**, not a Prisma client. |
| SQL migration reproduction | Same hashed scratch SQL applied and repeated idempotently to **two empty databases**; columns/indexes/constraints matched. **Not Prisma Migrate.** |
| Role flags | Real catalog queries verified both migrator and runtime lack elevated flags. |
| Exact BIGINT | `9007199254740993` persisted/reloaded and JSON-encoded as the exact string; no `Number` conversion. Not an approved Money range/currency contract. |
| Runtime DDL/privilege denials | Creating a table/schema/role returned PostgreSQL `42501`; intended DML succeeded. |
| Migration metadata denial | Runtime read of the scratch migration table returned `42501`. |
| SQL constraints/partial index | Nonpositive amount rejected with `23514`; duplicate active amount rejected with `23505`; archived duplicate allowed under the partial index. |
| Atomic failure | Failed two-write transaction rolled back; a **fresh connection** verified no intended rows persisted. |
| Concurrent revision update | Coordinator held a row lock; two real contender connections were confirmed lock-waiting through `pg_stat_activity` before release. Exactly one update affected a row and the other affected zero; revision became 2 once. |
| Duplicate operation key | Two concurrent inserts with the same synthetic key produced one effect and one unique violation. Not a full receipt/payload-replay/auth protocol or exactly-once network guarantee. |

**Ten cases passed** in `database-tests.log`/`probe-results.json`; test/container execution including teardown took **5.15 seconds**. The first DB attempt failed because the fixture read `SHOW server_version` under the wrong result-column name; its container/port was still torn down. The fixture was corrected to an explicit column alias and rerun from new empty databases. The original failure and teardown remain in `database-attempt-1/`, not recounted as a pass.

## 4. Teardown, footprint and preservation

Both task-owned container IDs were checked against their unique name/label/image before stop/removal. Both no longer exist; final loopback port closure was verified. Owned connections closed in `finally`. No unrelated container, volume, image, process or global cache was stopped/removed/pruned. Docker Desktop, the pinned downloaded image and dependency/evidence caches remain; no database/listener remains for the experiment.

Final recorded owned file sizes: evidence **445,975,744 bytes**, disposable workspace **308,665,243 bytes**, plus image **623,509,410 bytes** (about **1.28 GiB** combined). Shared package/cache allocation is not fully attributed by these path totals; observed C:/D: free-space deltas also remained under the **3 GiB** experiment limit, with each volume still over the **20 GiB** reserve. Final measurements were approximately C: **23.43 GiB**, D: **26.74 GiB**. These are local experiment observations, not native/emulator/product budgets or permission to clean other files.

The repository keeps **no probe packages, container config, generated client, migration, credential or synthetic database**. Existing application locks/policies/tool pins, fonts/OFL/goldens/native wrappers and all 13 historical snapshots are preserved. No Supabase account/project/bucket, external email, app endpoint, deployment, native/Flutter execution or M02 implementation occurred.

## 5. Evidence and next action

External evidence includes `baseline.json`, Docker start/version logs, exact registry metadata and `dependency-review.json`, verified archives/notices and engine-hook source, both lock-only attempts, OSV request/response, image manifests/config/build source, installation/offline-repeat logs, failed generation logs, strict TypeScript logs, `database-attempt-1/`, `probe-results.json`, `container-isolation.json`, `teardown.json` and `footprint.json`. Disposable SQL/typed driver fixtures remain in the external workspace; they are not installed product features.

Review-helper failures are also retained: package-section regex initially spanned multiple lines, archive manifest lookup assumed a `package/` prefix instead of the actual scoped-type archive root, one console print hit Windows encoding, and the initial Docker OCI ID assertion used the wrong identity field. Corrected checks independently verified all intended identities; none of those initial failures is claimed as a passing gate.

Repository regression checks: the first `pnpm check` hit the existing API child-start **10-second timeout** despite serial test files; it is retained in `pnpm-final.log`. A separate repeat (`pnpm-repeat.log`) passed **142 root tests** (21 tooling + 14 design/artwork + 88 boundary + 19 API), docs/lint/types/API build and import scan. No assertion, concurrency policy or timeout was relaxed. Documentation checks passed **88 Markdown / 1,485 local links / four JSON examples**. Preservation checks retain 67 requirement IDs, 224 tasks/20 plans/seven checked tasks and the unchanged application bytes/policies/snapshots. `git diff --check` passed. No Flutter/native test was run in this slice; the ten external driver cases are separate from the root test count.

**Next:** resolve official engine/checksum availability for this exact Prisma revision and its notice/native-artifact review before retrying the blocked Prisma cases. Do not bypass the 403, checksum or lifecycle policy or silently change versions. Report or request a separately reviewed exact candidate/retry if needed. T06 operational choices, M00 identity/contracts/sync/native gates and M01 native/CI exit remain open; these driver results do not authorize M02 or real data.
