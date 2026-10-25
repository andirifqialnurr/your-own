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

## Retained gates and tracking

[M00](../../milestones/00-decisions-and-validation.md) remains open. T04 and T05 blockers, full baseline acceptance and T14's full acceptance criteria are not retroactively marked Verified. [M01](../../milestones/01-foundations.md) may begin this bootstrap and the separately recorded local T04/T05/T06 continuations before those tasks finish; web/admin and later features retain their roadmap order. Native Android/iPhone/iPad, actual Safari, accessibility, persistence/privacy and release evidence remain required before their affected use/release gates.

Decision 0010's owner, exact selectors, maintenance controls and **2026-11-23 UTC** latest review deadline remain unchanged; local setup is an earlier revalidation trigger, not automatic renewal. ApexCharts remains held. Existing thirteen immutable snapshots and failed experiments are preserved.

Results and limitations belong in the [bootstrap report](../local-development-bootstrap.md) and M01 task log, rather than another exhaustive host study. No milestone is complete merely because scaffolds exist.
