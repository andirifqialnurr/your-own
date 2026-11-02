# I1-B2 — External cookie transaction and expiry checkpoint

- **Recorded:** 2026-11-02 UTC after `f6a6903`
- **Authority:** [Decision 0035](decisions/0035-external-i1-batch-resumption.md); [I1 acceptance matrix](auth-integration-readiness.md#4-required-i1-acceptance-matrixall-not-run)
- **Result:** Selected cookie checkpoint verified; **1/5 external batch checkpoints**, not complete I1 or app adoption
- **Tasks:** Preparatory M00-T04/T06/T07 only; seven checked tasks/full M02 Planned

## Fresh prerequisites

A new C:-only workspace uses the exact E1 patched **345-identity** combined lock, SHA-256 **`6db54e5a6235a489dbf98db5c5b22d6e2ef050741a35fd7811e1ed73fbb949f0`**, not the preserved affected 344 fixtures. Fresh actual-version npm/OSV queries report no findings; all pinned metadata/SRI/archive hashes and the minimatch/helper BlueOak notices match the reviewed versions. Original parent-range/Studio/notice/native/portable-artifact limitations remain; no new dependency identity, peer/engine/security exception, application policy or deadline renewal.

New pinned-native pnpm 12.8.1 full and clean-production frozen/script-denied installs and offline repeats pass. Before runtime, exact installed sets/hashes match **345 packages /17,134 files /333,882,302 payload bytes** and **119 packages /4,652 files /88,011,496 bytes**. Production excludes CLI/Studio/React/DOM/TypeScript/engines/minimatch. The reviewed official Prisma engine binary/license/hash is rechecked; explicit fresh Generate/repeat yields **20 identical files**. No old generated client, private key or IPC dispatcher is copied. The original Store/Context, AtomicStore, S0 sources and **35-case contract file remain byte-identical**; all 24 published +11 owned cases pass twice in the final DB lifecycle, with unchanged concurrency/SQL barriers.

## Actual maintained provider/guard proof

A new private runner/service uses the public AuthenticationModule, registered **SessionCookieProvider**, actual global AuthenticationGuard, maintained default PasswordHasher and low-level **SessionService.create/validate/rotate/revoke** operations. Low-level issued results are held until the enclosing transaction commits; cookies are set only afterward. No private vendor helper/import or bespoke password/session cryptography. Only synthetic loopback HTTP/manual Cookie headers are exercised—not browser HTTPS/BFF/native cookie behavior.

The original generic persistence adapter remains unchanged. A documented transport wrapper filters foreign realm before expiry/touch/discard, acquires the durable account row lock and rereads the session in the same active typed transaction. All cookie writes require the bound account frame. There is no implicit global writer or root-client cast. Current account/grant/version/realm/verified-email facts produce minimal internal personal actors for unchanged S0 policy; generic session MFA never produces operator authority.

**Mandatory touch failure is fail-closed in this experiment**, not a new production idle policy: the wrapper records failure on the current request frame, supplies only a minimized technical error to the library's best-effort diagnostic path, and refuses authorization before a returned stale session can become permission. The maintained library's best-effort touch behavior is unchanged. No global logger suppression; actual SQLSTATE 42501 and library diagnostics remain observable without raw credentials.

**18 HTTP cases pass in full workers, clean-production workers and restored production workers after controls.** Newly emitted code resolves runtime packages from the clean production tree, not parent tooling/old absolute imports. Actual cases cover:

- Credential login, Secure/HttpOnly/host-only cookie attributes, no raw token/session body; protected own-data success across independent processes and exact-owner/unverified/client-elevation denial.
- Durable interval-crossing and near-idle touch, below-interval no-write, exact idle refusal, unchanged absolute deadline and owned absolute-expiry discard.
- Foreign-realm token presented under the local cookie name cannot touch/discard—even past absolute expiry—or reach a successful fallback provider.
- Real runtime UPDATE privilege revocation gives **42501 /HTTP503**, rollback/no new cookie/no durable touch; restoration recovers without a waiver.
- Inactive current account's intentional local discard commits before terminal denial; malformed cookie terminates without alternate-provider permission.
- Fixed trusted Origin and session-bound CSRF checks before write-request activity can slide; hostile/missing/invalid proofs deny. Values/realms/intervals stay scratch-only, not accepted browser protocol.
- Actual **deferred-FK23503 at COMMIT** during issuance and rotation: safe503/no new cookie/credential/success body; fresh clients see no partial grant/session/outbox, and failed rotation preserves the old session.
- Public maintained rotation changes opaque identity and deletes old identity while preserving original creation/absolute expiry.
- Observed SQL account-row wait followed by committed grant revocation denies; logout commits before another process/clean replacement process refuses the old cookie. Sixteen concurrent two-owner requests remain isolated; no public seed/clock/fault/actor controls.

Three **specific expected-red controls** omit owned touch, foreign-realm isolation or current lifecycle enforcement. Each fails its intended assertion (IDLE_TOUCH_MUST_PERSIST, FOREIGN_REALM_MUST_NOT_DISCARD or inactive-account401), not startup/import/installation. Full production positives are restored after all controls. This is not a complete current-principal/staff/reset/refresh or operational acceptance claim.

## Preserved failed/preliminary attempts

- Initial file rehash command hits a **180-second orchestration cap**, produces no inventory and is not a pass. Unchanged exact-file checks subsequently finish under the previously used bounded600-second inventory budget; no checksum/assertion is omitted.
- Initial strict compile rejects unsupported **httpOnly** in CookieAttributes (TS2353); no emit occurs, and the premature DB driver fails before allocation because dist is absent. The corrected input uses published attributes; the library always serializes HttpOnly and the HTTP assertion remains. Original source/logs retained.
- First HTTP attempt: **2/16 pass, 14 fail** in a helper whose row callback shadows the outer HTTP response (`r.body.csrf`). Only the helper reference changes; original assertions remain. Both listeners/DB/volume are removed.
- A complete 16-case positive/control/restored checkpoint is preserved separately. Rotation and rotation-COMMIT cases then expand the final suite to18.
- The first worker-only lint pass rejects dropping a caught error's cause (preserve-caught-error). The final code keeps the original cause behind a minimized technical message; no rule/logger exception. Strict build/lint and the entire positive/control/restored runtime matrix are rerun after that code change.
- First expanded run passes18 in both dependency trees; the third negative control hits its unchanged **15-second worker-readiness timeout** before its intended assertion. It is **not** counted as a valid expected-red result. No worker remains. Cleanup gains explicit exit-waiting on failed startup; the single bounded rerun keeps the same readiness/request/control/assertion timeouts and completes the entire positive/control/restored matrix. The startup failure remains an unresolved environment/operational limitation, not a fixed latency guarantee.

## Resources, evidence and remaining boundary

Evidence: **`C:/Users/HP/AppData/Local/Temp/your-own-i1-resume-7ofj4g7c/`** — baseline/private hashes, prior hashes, fresh graph/security/metadata/archive/notices, exact installed inventories, frozen installs, engine/generation/build, `full/apps/api/src/cookie-worker.ts`, new `cookie.test.mjs`, unchanged contracts, final full/production/restored/control/barrier/resource/teardown logs and preserved `attempt-*`/`preliminary-16-cases/` inputs. Ordinary logs exclude session secrets/passwords/DB URLs; private fixture IPC is not an app protocol. No owner .env is loaded/copied.

The final current-code lifecycle takes **69.456 seconds** with PGDATA **42,800 KiB**; exact current values are cross-checked in the validation record. The repository's first normal pnpm check hits its previously recorded **10-second child-start null !== 1** (41/42 API cases); one **unchanged retry passes all176 existing entries**, lint/types/build and41-source/137-directive scanning. Neither timeout/assertions nor application code changes. Final new worker-only typed lint, strict compile and repeated full/clean-production exact-byte inventories pass. These do not rerun Flutter/native/hosted suites.

All owned PostgreSQL lifecycles use the digest-verified 18.6/linux-amd64 image, **2 CPUs /1 GiB**, non-root/read-only/cap-drop/no-new-privileges, bounded WAL/log/tmpfs/connections, random127.0.0.1 port and separate initialization/migrator/runtime roles. Each is below the ten-minute target and its container/volume/port is removed. Unrelated services/caches remain. All new allocations stay C:-only within **<3 GiB additional /≥20 GiB free**; no Docker settings/image upgrade/global prune. Exact counts/final preservation/checks are in the per-checkpoint validation record.

Repository changes are documentation only. API AppModule remains health-only, readiness503/auth routes absent, four S0 sources uncomposed, dependencies/policies/pins/private config/mobile unchanged. No accepted schema/claims/session/hash/clock/idle/availability/rate/recovery/retention/capacity/timeout policy; no production library, persistent keys, real mail/cloud/R2/browser/BFF/native/Flutter/hosted/restore/uncertain-COMMIT/lost-response proof. **2026-11-23 UTC latest policy review deadline remains.** Next within the authorized five-checkpoint batch: **I1-B3 maintained verified-email callbacks/current-address safety**, then B4/B5/B6; do not infer complete I1 or M02 from B2.
