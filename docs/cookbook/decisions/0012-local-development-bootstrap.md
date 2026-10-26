# Decision 0012 — Start Local Development with Existing Tools

- **Status:** Accepted for bounded local setup; not production/release approval
- **Approved by:** Project owner, 2026-10-24 UTC
- **Recorded by:** Coding agent
- **Scope:** M01-T01–T03 initial workspace, NestJS entry point and Flutter shell

## Owner instruction

> pakai saja yang ada di laptop saya. kalau butuh docker silahkan launch. tidak perlu melakukan sampai sedetail itu. ini sudah bisa ngoding kan. mulai saja dari setupnya dulu

The owner explicitly requests implementation/setup now using the existing laptop, rather than further WHPX/GPU inventory. This supersedes the documentation-only/scaffold-order restriction for this bounded local bootstrap. It is not a positive answer to the preceding hardware-inspection question.

## Working decision

- Use installed Node 24.18.0, pnpm 12.8.1 and Flutter 3.38.9 / Dart 3.10.8. Do not upgrade global tools or adopt the experimental workspace/lockfiles. These are local-development pins, not a current security/support certification or release baseline.
- Create the lean workspace and API/mobile foundations; install only needed dependencies, generate new lockfiles, run local lint/type/unit/widget/build checks, and document actual commands. No reference app code, data or assets are copied.
- NestJS/TypeScript follow the previously reviewed direction. The still-current Nest 12.2.0 adapter declares affected Multer 2.4.0: retain only Decision 0010's exact parent-scoped 2.5.0 override and recheck it against the actual bootstrap graph and regressions. Strict peers and disabled dependency lifecycle scripts remain. Policy A is unnecessary without the later Next.js apps and is not applied.
- Flutter starts with SDK widgets/tests and Flutter lints only. Riverpod, routing, networking, encrypted persistence, charts and brand/font/icon integration wait for the corresponding implementation slice. No unreviewed starter icon artwork is retained.
- Docker may be launched if necessary for local development. It is **not needed for this dependency-free health API/mobile shell**, so no daemon, image or container is started. This does not select PostgreSQL/Prisma, a provider, or authorize destructive container/volume operations.
- Native wrapper generation is setup, not an Android/iOS build or device result. Do not install an emulator, change virtualization/security settings or request unavailable Mac/phone details as a prerequisite to writing this shell.
- The API listens on loopback only and rejects staging/production environments. No authentication, tracker writes, upload endpoint, worker, database, real personal data or deployment is enabled. Mobile staging/production entry points fail closed until configured in a later approved slice.

## Local foundation continuation

After the initial setup result, the owner replied **“continue”** on 2026-10-24 UTC. In the context of the explicit instruction to keep coding with the existing laptop, continue with **M01-T04's local module/import boundaries** while T03's native prerequisites remain pending. This is one bounded, device-independent continuation, not blanket roadmap/release approval. It requires no new dependencies, Docker, hardware inspection or native execution; T03 remains unchecked rather than being reported as a native pass.

## Appearance continuation

The owner's next **“continue”**, following the explicit M01-T05 next-step summary, authorizes local Flutter semantic tokens and System/Light/Dark appearance with non-sensitive per-installation preference storage. Use the existing SDK; review and pin the needed preference adapter and bundle the selected DM Sans font with its license. This does not authorize personal-data persistence, runtime font downloads, a new icon family, Docker, emulator setup or release. Native storage/system-bar behavior remains to be checked on actual targets; T03 and full M00 gates remain open.

## Per-task publication instruction

On 2026-10-25 UTC the owner requested **“continue and commit and push each tasks”**. Commit and push reviewed task-sized changes separately, beginning with the existing T05 implementation. A commit records implemented work and its verification limits; it does not turn an unchecked/native-pending task into Verified. Use the existing repository remote and normal pushes, not force pushes or history rewriting. Preserve unrelated changes and stop/report authentication or remote-history conflicts rather than bypassing them. This instruction changes the earlier no-unrequested-commit/push boundary, not deployment/release authority or permission to execute the entire roadmap unattended.

## Adaptive-shell continuation

The same 2026-10-25 **“continue and commit and push each tasks”** instruction follows the T06 next-step summary. The next bounded slice is **M01-T06**, using go_router's state-preserving shell and the existing SDK. Review/pin the SDK-compatible router and the minimum Hugeicons Free Stroke Rounded navigation adapter; do not substitute built-in glyphs. T07's full icon/component catalog remains separate. This brings forward local adaptive/route work while T03/T05 native checks remain open; no real tracker, social/auth service, device setup or release is authorized. T05 was committed and pushed separately as `983de74`; commit/push T06 only after its checks and honest status update.

## Shared UI continuation

The owner's next **“continue”** on 2026-10-25 follows the explicit T07 next-step report after T06 was committed/pushed as `df3a85c`. Continue with **M01-T07's first shared primitives and synthetic development catalog**, including the existing Hugeicons Free Stroke Rounded adapter, widget/semantic/visual checks and a separate task commit/push. Reuse the installed SDK and packages; no new library, real-data workflow, native setup or release is authorized. T03/T05/T06 native gates remain open; this is one bounded local slice, not unattended roadmap execution.

## Indexes and local-check automation continuation

On 2026-10-25, after T07 was published as `c07236e`, the owner requested **“continue some tasks. commit and push it each”**. Address **M01-T08's app-local indexes**, then **M01-T09's reproducible local check entry point**, sequentially with a separate commit/push for each. Reuse the installed tools and existing dependency graph. Documentation verification can close T08; T09 remains partial until an approved macOS/native path and applicable CI evidence exist. Do not create or run hosted workflows, provision runners, install native SDKs, use signing credentials or claim native passes from host checks. No deployment, feature/provider adoption or automatic M02 continuation follows.

## Fresh-checkout continuation

After T08/T09 were separately published as `b4c4f0c` / `28c5e2f`, the owner's **“continue”** on 2026-10-25 authorizes **M01-T10's bounded local fresh-checkout review**. Use a separate local Git checkout of the published foundation, existing tools/caches and synthetic configuration only; a second clean retry is permitted for concrete reproduction fixes while preserving the original result. Reproduce host checks, inspect safe startup/failure behavior and record unresolved native/environment blockers; fix concrete reproduction defects if found and publish this task separately. Do not copy the owner's ignored configuration/data, install native SDKs, provision hosted CI, perform native builds or begin M02/provider adoption. A warm-cache checkout is not a clean-machine/cold-cache or native-release result.

The review found pnpm 12's default `verifyDepsBeforeRun: install` ran before the helper's pin/offline guards on a fresh checkout. Correct only that bootstrap behavior to `verifyDepsBeforeRun: error` and document the dependency-free `node scripts/check-local.mjs` entry. Do not disable dependency verification or relax strict peers, disabled lifecycle scripts, exact pins, the Multer override or Decision 0010's review controls. A separate clean retry and real-pnpm regression verify the correction.

## Provider-baseline review continuation

Following publication of T10 as `7b9fc4e` and its explicit next-step proposal, the owner's **“continue”** on 2026-10-26 authorizes a bounded **M00-T06 infrastructure/provider decision review**, before T04/T05 and M01's native/CI exit are complete. Review existing contracts and public official documentation, recommend choices and request the owner's decision; no provider/database/ORM selection is inferred from this reply. Record unresolved hosting/regions/costs, secrets/recovery ownership and session/native requirements. This exception changes only review order: no package installation, database/container start, account creation, credential collection, supplier contact, hosted resource, spending, deployment or M02 execution is authorized by it. Keep T06 unchecked until its approval criteria are met; ordinary separate commit/push remains authorized.

The subsequent owner reply to the review's explicit direction question is recorded separately in [Decision 0013](0013-provider-and-session-directions.md). It accepts scoped directions, not retrospective approval of provisioning, full T06 or the proposed local DB spike. The review-only authorization above remains its historical checkpoint.

## Retained gates and tracking

[M00](../../milestones/00-decisions-and-validation.md) remains open. T04 and T05 blockers, full baseline acceptance and T14's full acceptance criteria are not retroactively marked Verified. [M01](../../milestones/01-foundations.md) may begin this bootstrap and the separately recorded local T04/T05/T06/T07/T08/T09/T10 continuations before those tasks finish; web/admin and later features retain their roadmap order. Native Android/iPhone/iPad, actual Safari, accessibility, persistence/privacy and release evidence remain required before their affected use/release gates.

Decision 0010's owner, exact selectors, maintenance controls and **2026-11-23 UTC** latest review deadline remain unchanged; local setup is an earlier revalidation trigger, not automatic renewal. ApexCharts remains held. Existing thirteen immutable snapshots and failed experiments are preserved.

Results and limitations belong in the [bootstrap report](../local-development-bootstrap.md) and M01 task log, rather than another exhaustive host study. No milestone is complete merely because scaffolds exist.
