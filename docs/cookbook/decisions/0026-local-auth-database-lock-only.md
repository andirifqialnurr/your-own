# Decision 0026 — Isolated auth/database lock-only resolution

- **Status:** Bounded lock-only phase passed; installation, production closure and adoption remain gated
- **Authorized by:** Project owner, 2026-10-28 UTC
- **Recorded by:** Coding agent
- **Tasks:** Preparatory M00-T04/T06/T07; full tasks remain unchecked
- **Inputs:** [Decision 0025](0025-auth-database-graph-review.md) and its [placement proposal](../auth-database-graph-review.md#2-recommended-placement-to-evaluate)

## Explicit question and continuation

After `efb4a56`, the assistant asked: **“Next: may I run an isolated lock-only combined resolution, with no installs, app changes or DB?”** The owner replied **“continue for some tasks”**. Interpret this as that bounded resolution plus its graph review, verification and separate commit/push, not approval for unspecified roadmap tasks or subsequent installation/integration.

## Authorized boundary

- One C:-only external workspace with the existing root/API importer layout, the proposed exact manifest additions and unchanged repository strict-peer/script/engine/version policy, including exact policy B and no policy A. Seed from the current application lock; never replace the repository graph.
- Fresh storage preflight: less than 3 GiB additional allocation and at least 20 GiB free. Bounded commands/logs, public registry metadata only, owned empty npm configuration and sanitized child environment; do not copy/load either `.env`, credentials, app source, earlier generated client or privileged fixture controls.
- Pinned pnpm lock-only resolution and frozen lock-only repeat if the first resolution succeeds; inspect both documents, pins, peer contexts, integrity/transitive delta, optional/production dependency reachability and actual strict-engine behavior. Registry advisory queries and static metadata review may inform this lock-only result; they do not clear all security/notice/native obligations.
- Stop on peer/engine/integrity/security/resource blockers. Preserve failures. No waiver, automatic peer, extra override, vendor patch, global upgrade, signature/hash/TLS/checksum bypass or silent pin substitution.
- **No package installation/linking/tarball fetch, lifecycle execution, candidate import/CLI/generation/native engine, DB/container, auth route/provider/schema adoption, R2/mail/cloud/browser/native action or application change.** Repository checks may exercise the existing health/S0 code only. No production-only install/artifact claim follows from static closure analysis.

## Recorded outcome and completion boundary

The [lock-only report](../auth-database-lock-only.md) records 344 packages/snapshots in two importers, no new package identity/integrity beyond the reviewed union, frozen offline repeats and dated registry/OSV checks. Eight lint peer contexts change through optional `jiti`; API runtime reachability still includes optional CLI/Studio/React. No installed/pruned artifact or engine-installation compatibility is proved. Setup/analysis corrections remain recorded, and no packages or candidate code were installed/executed.

Publish the bounded outcome and remaining gates separately. Keep seven checked tasks and full M02 Planned; S0 stays dependency-free and uncomposed. Later installation, source/native/notice revalidation, provider/store/guarded HTTP and package/schema/protocol adoption need explicit further scope.
