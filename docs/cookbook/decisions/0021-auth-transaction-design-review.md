# Decision 0021 — Account transactions and access-invalidation review scope

- **Status:** Review scope authorized; recommendations prepared, implementation/adoption pending
- **Review authorized by:** Project owner, 2026-10-26 UTC
- **Recorded by:** Coding agent
- **Sources:** [Decision 0020](0020-durable-auth-http-spike.md), [HTTP evidence](../durable-auth-http-spike.md), [design review](../authentication-transaction-review.md)

## Continuation and limit

After `24a97a8`, the assistant named durable account transactions and access-token invalidation design as the next step. The owner replied **“continue”**. Authorize M00-T07 decision preparation using current specifications and already reviewed local candidate/store sources. This does not accept the proposed model, install/adopt a package, authorize another DB/HTTP experiment or begin M02.

Keep application/dependency/config bytes, existing evidence, R2 and unrelated services unchanged. No new candidate execution/download, Docker allocation, real account/mail, provider, browser/native, hosting or deployment action. Existing repository checks and a small C:-only review-evidence directory are within scope. Ordinary separate commit/push remains authorized.

## Direction conflict resolved for this review

Decision 0016 already withdrew Supabase/provider-managed auth as the implementation assumption. The schema guide's unconditional identity-provider-owned-schema row was stale: for the current Nest-owned direction, backend migration ownership must include whichever credential/session adapter is eventually selected. Provider-owned namespaces and issuer+subject mappings remain conditional on a future explicit external-provider adoption. This clarification does not adopt the scratch seven-table store, a production credential schema or another password authority.

## Recommendations, not adopted policy

The [review](../authentication-transaction-review.md) recommends evaluating an authoritative account credential generation plus revocable per-sign-in grant, including live state checks for any access JWT. Credential reset and authority changes need a shared transaction boundary; database callbacks alone, double revocation and in-process events do not establish it. Opaque access remains an alternative; bearer expiry alone does not satisfy post-revocation authorization.

The real reset service hashes and emits events inside its operation, and current stores open independent transactions. A transaction-aware composition therefore needs a bounded-cost/side-effect/rollback proof before it is selected. Do not vendor-patch the candidate, copy its password/reset crypto, trust client claims or imply this static review supplies that proof.

## Next decision

Owner acceptance of the proposed direction and separate authorization of one external account-transaction/live-grant prototype are still needed. Recheck current C: reserve, exact reviewed graphs/image/engine and original resource envelope before proposing execution; do not reuse an old free-space observation. No package/protocol/algorithm/expiry/key/recovery/retention/hosting choice or complete T06/T07/M01/M02 acceptance follows from this review.
