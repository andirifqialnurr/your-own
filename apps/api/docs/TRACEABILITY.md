# API requirement and evidence index

[README](../README.md) · [Modules](MODULE_INDEX.md) · [Endpoints](ENDPOINT_MAP.md) · [Jobs](JOB_MAP.md)

This index navigates existing evidence; it does not copy or approve requirements. **Verified below describes a bounded foundation task, not the complete linked product/security requirement.** Planned entries have no implementation. Full BE/SEC acceptance remains open.

| Requirement / task | Stage and current status | Implementation | Tests / evidence and remaining limits |
|---|---|---|---|
| [M01-T02](../../../docs/milestones/01-foundations.md); [NFR-05](../../../docs/PRD.md#nfr-05--security) | Local foundation task Verified; security requirement only partially supported | [Configuration](../src/config/environment.ts), [entry](../src/main.ts), [HTTP factory](../src/app.ts), [health](../src/health/health.controller.ts) | [Config/failed-start tests](../test/environment.test.mjs), [real HTTP](../test/health.test.mjs), [bootstrap results](../../../docs/cookbook/local-development-bootstrap.md#checks-actually-run). No identity, rate limits, TLS deployment or personal-data protection claim. |
| [M01-T04](../../../docs/milestones/01-foundations.md); [architecture boundaries](../../../docs/cookbook/architecture.md#5-repository-and-code-boundaries) | Local foundation task Verified | [AppModule](../src/app.module.ts), [HealthModule](../src/health/health.module.ts), [boundary policy](../../../scripts/architecture/policy.mjs) | [Boundary tests](../../../scripts/architecture/boundaries.test.mjs), [checkpoint](../../../docs/cookbook/import-boundaries.md). Static imports are not a runtime sandbox. |
| [SEC-09](../../../docs/cookbook/security.md#release-controls), [Decision 0010](../../../docs/cookbook/decisions/0010-conditional-dependency-exceptions.md) | Local maintenance control implemented; full security gate pending | [Exact workspace override](../../../pnpm-workspace.yaml) | [Runner](../test/multer.test.mjs), [ten synthetic regressions](../test/multer-regressions.cjs). Not a new advisory scan, upload API or release approval; owner review due 2026-11-23 UTC at latest, or earlier trigger. |
| [BE-01–BE-18](../../../docs/BACKEND_TECH_SPEC.md#292-critical-acceptance-requirements) | Planned for the affected V1-A/B/C slices | None | Identity/transactions/sync/social/media/jobs/operator/compatibility proofs are not implemented. [Milestone ordering](../../../docs/milestones/README.md#milestone-map) controls their introduction. |
| [SEC-01–SEC-12](../../../docs/cookbook/security.md#release-controls) | Full release gates pending | No complete implementation (narrow SEC-09 control above only) | [Required security strategy](../../../docs/cookbook/security.md); no production security certification follows from a health server. |
| [PRD tracking/social/data requirements](../../../docs/PRD.md), [backend PRD mapping](../../../docs/BACKEND_TECH_SPEC.md#294-prd-traceability) | Planned V1-A/B/C | None | No raw tracking, account, Money, publishing, DM, notification or lifecycle capability exists. Health/404 tests do not fulfill those requirements. |

The [T09 local verification lane](../../../docs/cookbook/local-verification.md) now automates the documented checks, without introducing a hosted/native/release pass.

For each new slice add specific requirement IDs, actual code and test links, release stage, execution environment/result and unresolved manual/operational proof. Keep historical checkpoint counts dated rather than treating them as a perpetual current test total.
