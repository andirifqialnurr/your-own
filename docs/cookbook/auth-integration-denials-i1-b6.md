# I1-B6 — Durable denial effects and scoped batch regression closure

- **Recorded:** 2026-11-02 UTC after `ecc230b`
- **Authority:** [Decision0035](decisions/0035-external-i1-batch-resumption.md), external five-checkpoint scope
- **Result:** Selected denial/regression checkpoint verified; **5/5 external checkpoints complete—stop this batch**
- **Tasks:** Preparatory M00-T04/T06/T07; seven checked tasks/full M02 Planned; **not full I1/app/production acceptance**

## Current composition and transaction boundary

The exact patched345/full/119-production graph,20-file generated schema/client and strict policies/pins remain. No new dependency identity, peer/engine/security exception or unsupported-parent/deadline renewal. Original Store/Context, AtomicStore, S0 and35-case contract stay byte-identical; **35 cases pass twice** in the final lifecycle. Current new worker-only typed lint and strict compile pass without rule changes.

The actual maintained **TokenService.refresh/revoke**, MfaService/TokenService factor verification and registered JwtBearerProvider/AuthenticationGuard run through HTTP. The library computes opaque-token hashes; the transport wrapper discovers server-owned family/grant/realm, locks/rereads the account and binds the exact grant before delegation. A foreign realm is refused before spending/revoking its credential. Generic optional claims/late-successor persistence remains separated from owned authentication policy, with no permissive contract-only adapter or global writer.

**Intentional refusal is not technical failure.** Owned refresh/MFA coordinators catch maintained credential refusals inside the typed transaction, write required minimized audit/outbox effects, commit, then return401 outside. Refresh-reuse tombstones, real failed-factor counts and intentional recovery-code consumption therefore survive denial. Technical SQL/COMMIT errors still throw/roll back and return503. No success pair/cookie/capability is emitted before COMMIT; no raw password/token/secret/row is logged. Public diagnostics are not substituted for durable audit/outbox.

## Executed proof

**20 denial/transport/current-authority HTTP cases pass in full, clean-production and restored production workers.** The final new composition also passes all **18 cookie +12 verification +13 reset +13 staff =56 preceding production HTTP cases**. Thus the final production checkpoint exercises **76 distinct selected HTTP cases**, not a manufactured complete-product identity pass.

- Maintained one-use refresh rotates within the same server-owned grant/family. Reuse returns401 only after family tombstone/audit/outbox COMMIT; both old and successor otherwise-signed access deny on later requests.
- Two concurrent refreshes produce one201/one401 and a committed dead family. This does not recall an earlier delivered response; new authorization after revocation COMMIT refuses it.
- Observed SQL account-row wait then committed family revocation refuses refresh without a successor. Token logout commits before old access/refresh refuse.
- Native transport cannot spend/revoke an admin refresh credential. Staff refresh preserves old server TOTP time; new JWT iat does not make stale TOTP fresh.
- Malformed/unknown refresh and client-selected authority fields refuse. Real **23503 deferred COMMIT** after successor creation restores the old unspent token/family and returns no pair; a legitimate retry is not mislabeled reuse.
- Technical reuse-denial COMMIT failure restores the partial tombstone/audit; safe503 is distinct from intentional401. A later successful denial commits the required effects.
- Real wrong-factor401 commits failed count/audit/outbox; missing factor adds no fictitious failed-code attempt. Five parallel guesses reach exactly the configured three counted failures, deny a correct factor while locked, and recover after the test window with a real new TOTP.
- Actual **23503** during the MFA denial journal rolls back counts/grant/audit instead of pretending it was an ordinary credential refusal. Restored journal yields a committed real failure. Intentional consumed recovery proof never creates active staff authority.
- Actual maintained JWT verification refuses wrong issuer/audience/type/algorithm/key without successful fallback; current suspended/deleting/deleted accounts deny even signed credentials.
- A held guarded snapshot followed by committed token logout cannot perform a sensitive mutation: its separate transaction rechecks current account/grant/family. Actual mutation COMMIT failure leaves no success/audit/outbox.
- Replacement workers read durable denial; private seed/clock/fault/enrollment/job/mail/coordination operations are not public routes.

Two **assertion-specific expected-red controls** deliberately throw refresh-reuse or MFA refusal inside the unit of work after intended writes, reproducing rollback-erased denial effects. They fail REUSE_DENIAL_MUST_COMMIT /MFA_DENIAL_MUST_COMMIT, not startup/import. Complete production denial positives and all56 previous HTTP cases restore afterward. Across the five checkpoints there are **13 targeted controls** (3+3+2+3+2); their expected failures are not counted as clean runtime invocations. No vendor/default hash/contract/concurrency/assertion/timeout waiver occurs.

## Resources, evidence and preservation

The final B6 DB lifecycle takes **321.841 seconds** (below ten-minute target), PGDATA **44,256 KiB**; **25 service/listener lifecycle rows close**. Container/volume/port removal and preservation of unrelated services are verified. Keep digest-verified PostgreSQL18.6,2CPU/1GiB, non-root/read-only/cap-drop/no-new-privileges, bounded WAL/log/tmpfs/connections, separate initialization/migrator/runtime roles and no host/app/socket mount. New experimental data stays C:-only within <3GiB additional/≥20GiB free; no global tool/host/image/settings/prune action.

Evidence: **`C:/Users/HP/AppData/Local/Temp/your-own-i1-resume-7ofj4g7c/b6-final/`**, new current worker/denial test/runner, final full/production/restored/13-control-across-phases and regression logs, actual SQL barriers/resource/teardown, exact installed bytes/fresh advisories, normal root/documentation/preservation validation and publication record. B2–B5 inputs/failures/preliminary checkpoints and2466 earlier evidence files stay immutable. No new failed B6 runtime attempt is relabeled green. B2 capped inventory/helper/lint/15-second readiness and known root10-second failures, and B4 helper/lint failures, remain explicit unresolved environment/operational limitations where applicable.

Final checkpoint revalidation passes **normal repository pnpm check on its first run:176 existing entries** (21 tooling +14 design/artwork +99 boundaries +42 API), lint/types/build and41-source/137-directive scanning. Current worker typed lint/compile and exact final full345/production119 installed inventories pass. Fresh actual345 npm/OSV responses remain empty at **2026-11-02T11:37 UTC**. Documentation passes **140 Markdown /2,134 local links /four JSON examples /34 owned whitespace checks**. Independent validation covers exactly **11 documentation paths** in this final commit, unchanged app/dependency/policy/private bytes and2466 prior evidence files. Conservative scratch regular-file capture is **1,003,190,996 bytes**, C: **31,799,574,528 free**, D: **222,016,385,024 free**; free space varies and is not package payload size. No Flutter/native/hosted suite is inferred.

## Final batch disposition—not application adoption

The requested bounded external sequence **B2 cookies →B3 verification →B4 reset →B5 staff TOTP/capabilities →B6 denial/regressions** now has five separate genuine checkpoints/commits. Stop after B6; do not create a sixth implementation task or automatically adopt the fixture.

Repository AppModule still imports HealthModule only, live200/readiness503/auth-product routes absent and four S0 sources uncomposed. App/config/dependencies/locks/policies/pins/private .env/mobile/assets and13 snapshots remain byte-preserved. Preserve67 requirements/224 tasks/20 plans/seven checked/full M02 Planned and **2026-11-23 UTC latest policy review deadline**.

**Full I1/adoption remains gated:** new-composition normal-user pending-MFA cookie/client flows, production staff provisioning/recovery and separate BFF/HTTPS/CSRF/browser/cache/device secure persistence; exact library maturity/support/upgrade/rollback ownership and production schema/claims/protocol; key/hash/clock/idle/freshness/availability/rate/retention/capacity/timeout policy; durable external mail/outbox delivery and crash reconciliation; uncertain COMMIT/lost response, physical restore and portable/native/embedded notices. Memory mail completion, deterministic test clocks and deferred constraints are not those proofs. No real mail/cloud/R2/browser/BFF/Flutter/native/hosted/deployment/real-data execution occurs. Any next review or application slice needs separate bounded scope and fresh prerequisites, not inferred from five completed external tests.
