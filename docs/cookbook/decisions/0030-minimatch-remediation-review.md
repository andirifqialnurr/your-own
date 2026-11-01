# Decision 0030 — Minimatch remediation review

- **Status:** Review prepared; E1 isolated validation proposed, not authorized; application/security gate remains blocked
- **Review authorized by:** Project owner, 2026-11-01 UTC
- **Recorded by:** Coding agent
- **Tasks:** Preparatory M00-T04/T06/T07; no checkbox/task-order change
- **Report:** [Minimatch remediation options and proposed E1](../minimatch-remediation-review.md)

## Authority and limits

After `2ca882e` recorded the [five-task batch security stop](../auth-integration-batch-security-stop.md), the assistant identified dependency-remediation review and approval as next. The owner replied **“continue”**. This permits the bounded review: maintained parent/backport metadata, exact published artifact/API/source/notice inspection as data, affected-call-site comparison, advisory checks and a proposed experiment. It does **not** approve an override or changed dependency graph, candidate execution, resolution/install, policy renewal, application changes or resumed I1 tasks.

## Reviewed outcome

The latest checked parents still depend on minimatch 10.x; no newer 10.x backport is published. Minimatch 11.0.3 and its new `@isaacs/nonrecursive-glob-match` dependency are materially different from 10.2.6: removed RegExp/AST APIs and changed partial/Windows/empty-segment semantics require runtime compatibility proof. Current callers use surviving common APIs, but all three declarations still exclude 11.x. A hypothetical version-list audit is not a resolved or installed graph.

Recommend requesting **E1 only**, the bounded external experiment in the report: preserve existing parent/tool versions and policy B, temporarily override only the three exact parent edges to 11.0.3, review the actual resulting graph/helper identity, then validate frozen/script-denied installs, CJS/ESM/glob/file-discovery/type-aware lint/build/test/security/notice behavior. No E1 action is executed or authorized by this review. Any changed graph, new finding, integrity/peer/engine/public-seam/behavior failure stops that experiment; no vendor patch, private import, broad override or ignored advisory.

## Completion boundary

The review may be committed/pushed separately under the owner's existing per-task instruction. Five integration tasks remain uncompleted; I1-B2–B6, full M00/M01/M02, native/browser/CI/real-data/release and notice/operational gates remain open. Root/application dependencies, locks, configuration, S0, ignored private files, historical fixtures/failures and 13 snapshots remain unchanged. E1 needs an explicit answer; neither a later E1 pass nor this recommendation adopts policy/application changes or renews Decision 0010's 2026-11-23 UTC latest deadline.
