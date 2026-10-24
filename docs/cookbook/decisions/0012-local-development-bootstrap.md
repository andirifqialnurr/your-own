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

## Retained gates and tracking

[M00](../../milestones/00-decisions-and-validation.md) remains open. T04 and T05 blockers, full baseline acceptance and T14's full acceptance criteria are not retroactively marked Verified. [M01](../../milestones/01-foundations.md) may begin only this bootstrap before those tasks finish; web/admin and later features retain their roadmap order. Native Android/iPhone/iPad, actual Safari, accessibility, persistence/privacy and release evidence remain required before their affected use/release gates.

Decision 0010's owner, exact selectors, maintenance controls and **2026-11-23 UTC** latest review deadline remain unchanged; local setup is an earlier revalidation trigger, not automatic renewal. ApexCharts remains held. Existing thirteen immutable snapshots and failed experiments are preserved.

Results and limitations belong in the [bootstrap report](../local-development-bootstrap.md) and M01 task log, rather than another exhaustive host study. No milestone is complete merely because scaffolds exist.
