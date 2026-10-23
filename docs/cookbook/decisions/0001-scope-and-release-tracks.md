# Decision 0001 — Scope and Release Tracks

- **Status:** Accepted
- **Task:** [M00-T01](../../milestones/00-decisions-and-validation.md#m00-t01--scope-and-release-review)
- **Approved by:** Project owner (user in this conversation)
- **Approval recorded:** 2026-10-23 UTC
- **Recorded by:** Coding agent; not the approver
- **Supersedes / superseded by:** None

## Context and approval evidence

The project already specified four personal modes and separate mobile, backend, user-web and admin applications. M00-T01 requested an explicit decision on delivery priorities, the first mobile pilot, and decision-record ownership/location before moving to product defaults.

The owner replied to the three recommendations:

> Approve all - Android First.

This approves those M00-T01 recommendations only. It is not blanket acceptance of every proposed setting, dependency, schema, provider, privacy policy or future release in the specifications.

## Accepted scope and delivery

Keep Focus, Read, Intake and manual Money, private raw tracking, selected progress-card sharing, four adaptive window classes and System/Light/Dark. Keep Flutter mobile, one NestJS domain backend, and separate Next.js user/admin applications in the planned monorepo. No bank/payment operations, unrelated feed posts, videos/reels or endless engagement-ranked feed.

The existing stage boundaries remain:

| Stage | Accepted delivery boundary |
|---|---|
| V1-A | Accounts, all four personal modes, Today/Progress, private card previews/exports and data controls |
| V1-B | Profiles/follows, deliberate publication, finite feed, likes/comments/sharing, notifications and safety |
| V1-C | Reposts, one-to-one text/card DMs, requests and messaging safety |
| W0 | Public product/policy/support presence, app links and safe shared-link resolution |
| W1 | Personal browser tracking, progress/private cards, settings and data controls |
| W2 | Browser social publishing and interactions |
| W3 | Browser reposts, messaging/requests and realtime recovery |
| A0 | Staff access, minimal lookup, reports/evidence, moderation, audit and basic support/status |
| A1 | Safe job operations, appeals, staff management UI, data-request monitoring and operational overview |
| A2 | Optional editorial/configuration extensions; not scheduled or approved for implementation |

Prioritize M00 decisions/spikes, the API/mobile foundation and the verified water slice, then complete the other modes and private journeys. The first intended distribution is a **limited Android personal pilot after the V1-A readiness gate**, not a full V1 or public-social release.

A0, required policies and named operators must be ready before public social in either client. User web follows its independent W0–W3 track; W0 may be brought forward after its prerequisites, but complete browser parity is not required on the first mobile release date. A1 expands with operating needs. V1-C/W3 require their own acceptance evidence. Separate platforms can release verified scope independently; M18 is the combined review, not a promise of simultaneous releases.

## Android-first consequences

- Android phones/tablets are first in the limited-pilot distribution order, fitting the current Windows development environment.
- iPhone/iPad, including large iPads and multitasking, remain required targets. This decision does not waive any existing native spike, adaptive, security or release gate.
- All four usable window classes are designed from the foundation; Android-first does not mean phone-only.
- M00-T05 must still define OS/device baselines, coverage and macOS/Xcode access. Android results do not count as iOS/iPad evidence.
- Actual distribution, store submission, provisioning and production changes still require their explicit later approvals. No launch date is selected.

## Decision location and authority

Repository-wide decisions live in `docs/cookbook/decisions/` with stable numbered filenames. Each record identifies context, selected answer, rationale, affected specifications/tasks, status, approver, actual approval evidence/date and superseding records when applicable.

The project owner approves scope, product defaults, supporting stack/provider choices and releases, or explicitly delegates a named decision. Agents may investigate, recommend, implement authorized changes and record evidence; they cannot substitute their approval for the owner's.

App-local records reference repository-wide decisions instead of copying them. Authoritative specifications must be synchronized when an accepted decision changes them. Keep the historical approval trail when a later decision supersedes this one.

## Not approved by this decision

- M00-T02 product defaults: signup/post visibility, guest use, labels/languages/units, timer editing, currency/savings details and template coverage.
- Supporting libraries/versions, workspace manager, providers, API/schema/sync contracts, hosting or spending.
- Exact OS/browser minimums, retention, age/region policies, staff provisioning or operational access.
- Application scaffolding, production deployment or a claim of implementation/device/security verification.

## Sources and follow-up

- [Product stages and boundaries](../../PRD.md#7-release-scope-and-staging)
- [Mobile targets](../../MOBILE_TECH_SPEC.md#3-platform-support-and-native-boundaries)
- [Backend stages](../../BACKEND_TECH_SPEC.md#3-scope-and-release-stages)
- [Website stages](../../WEB_PRD.md#4-website-scope-and-release-stages)
- [Admin stages](../../ADMIN_CMS_PRD.md#4-release-scope-and-sequencing)
- [Architecture release gates](../architecture.md#16-release-dependencies-and-decision-gates)
- [Milestone index and current task](../../milestones/README.md)

M00-T01 can be marked Verified on this explicit owner approval and the synchronized documentation. Next: **M00-T02 — product defaults**, which remains a separate approval task. No application capability is verified by accepting this decision.
