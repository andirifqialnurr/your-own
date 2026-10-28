# Decision 0027 — Isolated frozen dependency installation and production check

- **Status:** External frozen full/production dependency phase passed; application adoption remains gated
- **Authorized by:** Project owner, 2026-10-28 UTC
- **Recorded by:** Coding agent
- **Tasks:** Preparatory M00-T04/T06/T07; full tasks remain unchecked
- **Inputs:** [Decision 0026](0026-local-auth-database-lock-only.md) and its [exact combined lock](../auth-database-lock-only.md)

## Explicit question and continuation

After `34ff6f2`, the assistant asked: **“Next: may I perform reviewed, isolated frozen installs to verify production dependencies—still no app or DB changes?”** The owner replied **“continue again”**. Authorize only the external prerequisite review, full/frozen repeat and separate clean production installation/inspection of that same graph, with bounded synthetic import/type/lint checks and documentation/commit/push. This does not adopt packages into the app or authorize subsequent identity integration.

## Execution boundary

- Fresh C:/D: space preflight; all new fixtures, archives, stores and evidence on C:, less than 3 GiB additional allocation and at least 20 GiB free. Bounded commands/logs and owned process cleanup. No DB/container or native SDK is needed.
- Preserve the exact two-importer manifests, 344-package lock, package-manager document, strict peers/engines, automatic peers off, scripts denied, exact pins, `verifyDepsBeforeRun:error` and exact policy B; no policy A. Two clean external copies test full versus production scope without changing importers/pins or the application graph.
- Review exact public metadata/advisories, official archives/integrities, declared lifecycle/native/engine requirements and notice limitations before linking/executing candidate code. Use sanitized child environments and explicit owned npm-auth/store/state configuration. Do not copy/load either `.env`, credentials, old generated clients or privileged fixture controls.
- Frozen script-denied installs only; no vendor lifecycle scripts, patch, additional peer/engine/integrity/security exception, silent optional-package exclusion, global upgrade or separate native-engine download/execution. If the pinned manager rejects Studio's pnpm declaration or another constraint, stop rather than waive it. A successful strict install does not change upstream support declarations.
- Inspect installed bytes and actual full/production dependency reachability and public runtime imports. Synthetic type/lint probes may test the changed peer context, but no concrete identity authority, password flow, application server/provider/guard, Prisma CLI/generation/migration or database call is authorized.
- The repository remains documentation-only for this phase. AppModule/config, source/S0, dependency manifests/locks/policies/pins, private config, mobile/assets/native, prior evidence and 13 snapshots remain unchanged. Existing root checks may run separately; no Flutter/browser/native/hosted/real-data/release acceptance follows.

## Recorded outcome and completion boundary

The [installation report](../auth-database-install.md) records 344 reviewed official archives, a 344-package full install and separate clean 119-package production install, frozen/offline repeats and exact installed-byte verification. CLI/Studio/React/TypeScript are excluded from this production tree; public runtime imports and strict synthetic type/lint probes pass with expected-red controls. No generated Prisma client, query, auth service, HTTP composition or real application integration is tested. Studio's upstream pnpm declaration remains unchanged; observed strict installation is not a support-policy rewrite. Archive/path/accounting helper corrections and notice/native limitations remain explicit.

Report the exact installed artifact/engine/peer results and blockers, not just manifest classification. Missing ISC/MIT attribution and embedded/native/WASM/image obligations remain shipping gates, not rights clearance through a successful install. Keep seven tasks checked and full M02 Planned. Future package/schema/provider/protocol adoption, guarded HTTP, key/mail/restore/operations and platform work need separate scope.
