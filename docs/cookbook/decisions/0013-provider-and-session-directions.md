# Decision 0013 — Provider and session directions

- **Status:** Accepted for the scoped directions below; full M00-T06 remains open
- **Approved by:** Project owner, 2026-10-26 UTC
- **Recorded by:** Coding agent
- **Sources:** [Provider review INF-01–05](../provider-baseline-review.md), [T06 acceptance](../../milestones/00-decisions-and-validation.md#m00-t06--infrastructure-and-provider-review)

## Owner response and interpretation

After the review was published as `eb30d49`, the assistant asked:

> Rekomendasi:
> - PostgreSQL + Prisma
> - Supabase Auth + private Storage
> - Session web/admin server-side, terpisah
>
> Setuju arah ini? Budget, region, dan deployment tetap belum disetujui.

The owner replied **“continue”**. In this direct question/reply context, record acceptance of those technical directions only—not full infrastructure acceptance, a login-method decision, a spending authorization or execution of a spike. Preserve the prior review's recommendation-only checkpoint as historical evidence.

## Accepted subset

| ID | Accepted direction | Required boundary |
|---|---|---|
| INF-01 | PostgreSQL for canonical domain persistence | NestJS remains the sole domain API/transaction authority; a hosted Postgres vendor, major version and region are not selected. In particular, Supabase-hosted Postgres is not implied merely by choosing its Auth/Storage. |
| INF-02 | Prisma as the Nest-owned database adapter/migration tooling direction | Application migration authority is `apps/api/prisma/` when implemented; no duplicate Next.js migration tree. Use reviewed SQL where needed for constraints, indexes and locking. Exact packages/driver/generated output and working migrations still need review and execution evidence. |
| INF-03 | Supabase Auth behind owned interfaces | Provider handles credentials/recovery, Nest validates trusted identity and current application lifecycle/ownership. Login method, issuer/project, refresh/revocation/assurance protocol and actual mobile secret persistence are not yet selected or tested. No second password system. |
| INF-04 | Supabase private Storage behind an API/media adapter | Current authorization, denial-first deletion/retry and object-backup reconciliation remain mandatory; no public poster bucket or instant signed-URL revocation claim. No bucket/endpoint is created by this choice. |
| INF-05 | Separate **server-side web/admin sessions** with opaque host-only cookies | Provider credentials stay server-side; Nest independently verifies staff grants/MFA/assurance. PostgreSQL is the proposed backing store, **not a separately approved store library/schema/key system or hosting choice**: the short owner question approved the server-side/separate approach, not every implementation detail in the review table. |

This is acceptance of directions, not proof that the candidates meet every requirement. The review's broad-role quickstart, Data API exposure, JWT/logout, browser-SDK/BFF, SMTP and DB-versus-object-backup limitations still apply. Do not implement an insecure default merely because a provider is now named.

## Not accepted or authorized here

- No final PostgreSQL/Prisma/SDK/driver pins, dependency installation, package-policy bypass, Docker image pull/database start or application schema/migration execution.
- No Supabase project/account/bucket, hosting vendor, domain, region, plan, price/currency/budget, SMTP/sender, external email or deployment.
- No auth method (password, magic link, Google/Apple), anonymous/guest mode, MFA/expiry/revocation policy, session encryption keys or operational custody. The app remains account-required; no real credentials/data are requested.
- No full M00-T06/T14, M01 native/CI exit, M02 start, real-data or release approval. Existing SDK pins, exact Multer exception and Decision 0010's owner/review deadline remain unchanged.

M00-T06 stays **partially accepted / unchecked** until its remaining hosting/region/cost/isolation/secret/recovery criteria and required validation are resolved. Native device/Mac availability is not invented or waived.

## Recording checks

On 2026-10-26, the existing Windows workspace's `pnpm check` passed **142 tests** (21 tooling + 14 design/artwork + 88 boundaries + 19 API), lint/types/API build, 37-source/131-directive import checks and **86 Markdown / 1,466 local links / four JSON examples**. This verifies the documentation/unchanged foundation, not any accepted provider. No package/image installation, provider/native/Flutter test or Docker command ran for this decision record. Preservation checks retain seven checked tasks, all existing app/policy/lock/asset bytes and 13 historical snapshots.

## Next bounded action

The [local database spike plan](../local-database-spike-plan.md) is prepared but **not executed or authorized by this decision**. Ask separately before reviewing/installing its exact package graph and running a synthetic PostgreSQL/Prisma probe. It must use an isolated disposable workspace and only task-owned local resources, not add M02 application functionality. No cloud provider or email integration is needed for that probe.
