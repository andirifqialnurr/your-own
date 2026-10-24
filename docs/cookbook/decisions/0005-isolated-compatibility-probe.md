# Decision 0005 — Isolated Chart-Free Compatibility Probe

- **Status:** Authorized experiment; results and final pins not approved
- **Task:** [M00-T04](../../milestones/00-decisions-and-validation.md#m00-t04--toolchain-and-workspace-review), still In progress / unchecked
- **Approved by:** Project owner (user in this conversation)
- **Approval recorded:** 2026-10-23 UTC
- **Recorded by:** Coding agent, not the approver
- **Scope source:** [Proposed chart-free probe](../toolchain-compatibility.md#6-chart-free-compatibility-probe--authorized-scope)
- **Refines:** [Decision 0004](0004-toolchain-directions-and-icon-family.md) with permission for this temporary experiment only; does not approve M01 scaffolding or change the ApexCharts hold

## Approval evidence

After the metadata/support follow-up, the owner was asked:

> Authorize the proposed isolated, chart-free download/build/test probe? It may download several GB, but won’t change global tooling or create repository apps.

The owner replied:

> continue

This response authorizes the specific experiment just proposed. It is distinct from the earlier instruction to continue read-only investigation, which did not authorize downloads or execution.

## Authorized actions and limits

- Create a temporary workspace **outside the repository and reference apps**, with isolated tools, caches, configuration/home directories and synthetic data only.
- Download and verify the candidate Windows Flutter **3.47.7 / bundled Dart 3.13.5**, portable Node **24.22.1** and pnpm **12.15.0** from reviewed official sources. Verify archive identities before extraction/execution; stop on digest or provenance discrepancies. This is experimental use, not final project-pin adoption.
- Resolve the reviewed mobile/backend/web sample dependencies with lifecycle scripts initially disabled where supported. Record actual graphs, scripts, notices and targeted advisory results. Stop for unexpected licensing, scripts/native downloads or incompatible constraints; no bulk script approval or dependency overrides.
- Build/test disposable Flutter host widget/serialization/Drift-generation, Nest decorator/OpenAPI and separate Next user/admin composition probes with the selected query/form/icon directions. Candidate adapters/test tools are evaluated, not thereby selected for production.
- Bind any test server to loopback, use no secrets or real user data, stop owned processes and record evidence/failures. Do not copy probe code or lockfiles into repository applications automatically.
- Leave the unresolved maintained frontend lint graph explicitly blocked; do not force ESLint peers, use EOL ESLint 9 or claim missing lint coverage passed.

## Excluded

No global PATH/tool/SDK/Corepack changes, shared npm/Pub cache installation, Android SDK/Xcode/emulator installation, reference-app edits, personal-data access, cloud provisioning, paid accounts/services, supplier outreach, public deployment or production migration. No ApexCharts or alternative chart engine installation/integration; the licensing hold remains intact.

No native-device, encryption, real authentication/CSRF/staff-assurance, complete accessibility, full security or release certification is implied. Providers/ORM/queues and later M00 contracts remain separately gated. No M00 task is checked merely because this experiment was authorized.

## Evidence and stop conditions

Record actual tool identities, downloaded hashes/provenance limitations, temporary manifests/lockfiles/notices, commands/results and teardown. If a source cannot supply the expected artifact, or a hash/notice/constraint conflicts with the review, stop that lane and report it rather than choosing another version or bypassing validation. Other independently safe lanes may proceed only within this same scope.

The authorized root for this run is `C:/Users/HP/AppData/Local/Temp/yop-f3trxjn8/`. Initial free space on its volume was approximately 35.75 GiB. Recheck space before large extraction/install steps; avoid exhausting the volume. Repository HEAD at start was `aa76d1a4b8a3d7d5e5b7bd915b69b83bef752f15`, with a clean working tree.

The [execution report](../toolchain-probe.md) records isolated tooling and JS build/HTTP successes, plus the stopped mobile lane caused by retracted build_runner 2.17.0. The 2.16.2 retry was not covered as a silent version substitution; [Decision 0006](0006-mobile-probe-generator-retry.md) later authorized it separately. [Decision 0007](0007-isolated-lint-probe.md) subsequently amends the no-peer-exception boundary only for a new external lint experiment with three exact allowances. It does not retroactively alter this probe, authorize broader exceptions or change production policy.

Final adoption, any changed candidate versions, broader execution scope and the scaffold go/no-go require their own evidence and approvals. [Milestone tracking](../../milestones/00-decisions-and-validation.md) records the outcome; this decision authorizes the attempt, not its success.
