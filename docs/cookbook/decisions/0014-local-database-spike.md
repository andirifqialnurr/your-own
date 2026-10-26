# Decision 0014 — Bounded local PostgreSQL / Prisma spike

- **Status:** Authorized local experiment and verified same-revision retry completed; not a product/production baseline
- **Approved by:** Project owner, 2026-10-26 UTC
- **Recorded by:** Coding agent
- **Scope:** M00-T06 local DB/ORM validation only, before full M00/M01 exit; no M02 implementation

## Owner authorization

After [Decision 0013](0013-provider-and-session-directions.md) was published as `8d77fe1`, the assistant asked:

> Berikutnya: uji PostgreSQL/Prisma lokal dengan Docker dan data sintetis, tanpa Supabase/cloud, biaya, atau migrasi aplikasi.
>
> Boleh saya jalankan uji lokal tersebut?

The owner replied **“silahkan”**. This authorizes the [proposed local spike](../local-database-spike-plan.md), including needed exact package/image review and a disposable local execution using installed tools, with Docker launch if needed. It does not approve every candidate version, a new application dependency graph, provider resource or a release baseline.

## Execution boundaries

- Use installed Node 24.18.0 / pnpm 12.8.1; no global upgrade. Keep strict peers, no automatic peers, disabled lifecycle scripts and fail-closed pre-script verification. Review exact graph/engine/peer/license/advisory/native/hook behavior before installation. Stop on unreviewed downloads/hooks or policy failures rather than bypassing them.
- Review and pin one official PostgreSQL image/tag/platform/digest before pull/run. Use one uniquely labeled task-owned container, random **127.0.0.1** host port, ephemeral test storage, no privileged mode/socket/application-directory mounts. Separate initialization, migration and runtime identities; no broad runtime role copied from a provider quickstart.
- Local allocation envelope: at most **3 GiB additional task footprint** across the workspace/cache/image allocations, retaining **20 GiB free on each affected Windows volume**. Container limit at most **2 CPUs / 1 GiB memory**, bounded ephemeral data; test execution at most ten minutes, individual preparation commands time-bounded. These are experiment stop limits, not product budgets or permission to clean unrelated files. Account for image/cache footprint and stop if it cannot be bounded.
- Launch existing Docker Desktop if needed. If daemon access/start requires installation, account/terms interaction, admin/security/virtualization changes, reboot or repair, stop and report. Do not inspect unrelated containers/secrets, stop existing services, change the default engine/settings or prune shared caches/volumes/images.
- Synthetic scratch data only; no original `.env`, cloud credentials, real account, external email or private records. No Supabase project, full Supabase stack, hosted service, spending, application schema/migration, endpoint, worker or deployment.
- Retain failed attempts and sanitized evidence; stop/remove only verified task-owned DB resources and close owned connections. Preserve pre-existing resources and the application/reference trees. Image/package cache bytes may remain and must be reported, not globally pruned.

The expected generation/build, migrations, exact BIGINT, role denials, transaction/concurrency/constraint and teardown cases remain those in the plan. A setup failure is not a DB test pass; local PostgreSQL does not prove Supabase pooler/auth/storage/session/native or complete sync/Money/recovery behavior. Full T06, M00-T04/T05/T07–T14 and M01 native/CI gates remain open.

## Engine-access continuation

After the partial result was published as `1386ab1`, the owner's next **“continue”** on 2026-10-26 follows the explicit next step to resolve engine access. Continue one bounded review/retry of the **same exact revision**, official URL derivation, response provenance and checksums. If official artifact/checksum access succeeds, verify bytes and native notice/platform identity before reusing the isolated probe for the blocked generation/client/migration cases under the same limits. Do not ignore checksums, weaken TLS/proxy/security settings, use an untrusted mirror, silently switch package/engine/platform versions or alter the app graph. If the official artifact remains unavailable or a different candidate is required, report the evidence and proposed separately reviewed retry instead of manufacturing a pass. Preserve the earlier failed checkpoint.

## Tracking

Use the M00-T06 task log and the [experiment report](../local-database-spike.md) for actual commands, exact identities, results/limits and next action. The initial strict-peer failure was resolved by reviewing/explicitly providing React peers without disabling the policy; native checksum 403 was not bypassed. The [same-revision follow-up](../prisma-engine-follow-up.md) later obtained official checksums/artifact, verified both hashes/platform/version before execution, and passed generation/build, actual Prisma migrations and seven generated-client cases. The original partial/failed checkpoint remains preserved. No final package/image pin adoption follows. Commit/push reviewed task-sized results under the existing owner instruction, without copying disposable probe code into the product or automatically starting M02. Decision 0010's exact policy, owner and 2026-11-23 UTC latest review deadline are not renewed by this experiment.
