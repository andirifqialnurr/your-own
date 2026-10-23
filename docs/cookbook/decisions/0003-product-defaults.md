# Decision 0003 — Product Defaults

- **Status:** Accepted
- **Task:** [M00-T02](../../milestones/00-decisions-and-validation.md#m00-t02--product-defaults-review)
- **Approved by:** Project owner (user in this conversation)
- **Approval recorded:** 2026-10-23 UTC
- **Recorded by:** Coding agent, not the approver
- **Supersedes:** Pending/proposed wording for P01–P11; does not replace Decisions 0001 or 0002

## Approval and scope

After being asked to confirm M00-T02 recommendations P01–P11, the owner replied:

> Approve defaults

The owner accepts the following product defaults. This is not approval of the full toolchain, providers, numerical contracts, implementation, spending or production deployment.

## Accepted defaults

| ID | Decision | Accepted behavior |
|---|---|---|
| P01 | Account visibility | Private signup default with an explained public/private choice. Raw tracker data stays private in either case. |
| P02 | Post audiences | Public accounts support followers-only posts. Each new publication draft starts followers-only; public publication requires explicit selection and preview. Private accounts cannot publish publicly without an explicit account-visibility change. Private save/export never creates a post. |
| P03 | Guest use | Account required for personal tracking in V1; no guest mode or guest-to-account migration. This does not require connectivity for every mobile log: authorized offline/session behavior remains a later contract gate. |
| P04 | Names/navigation | Focus, Read, Intake, Money; Circle is the social destination, not a group feature. Today is the default landing screen. One account covers selected modes; hiding a mode preserves its history. |
| P05 | Initial language | English-first Android pilot with localizable strings from the start. Indonesian remains a later candidate, not promised pilot coverage. UI language does not select launch countries or currency. |
| P06 | Units/locale | Milliliters default; optional explicitly labeled US fluid ounces, not Imperial. Retain canonical volume without repeated conversion rounding. Coffee cups/shots remain separate. Suggest device timezone/formatting and allow correction; do not hardcode one country/timezone. |
| P07 | Tasks/timers | Required task title; optional note, due date and label. Today membership is independent of due date. Work/Study/Personal and custom labels. Editable Pomodoro defaults: 25-minute focus, 5-minute short break, 15-minute long break after four focus intervals. Breaks and next intervals require explicit start. |
| P08 | Historical Focus | No manual historical session creation or duration edits in V1. Allow task/label/private-note correction and deletion. Focus duration excludes pauses/breaks; recorded timing is not a claim of verified attention. |
| P09 | Currency/budgets | One user-selected base currency across wallets; amount-based monthly category budgets with planned savings separate. No FX/multi-currency totals. No base-currency change after monetary records exist, no silent relabeling and no destructive reset workaround. |
| P10 | Savings | Independent manual planning ledger. Contributions/withdrawals do not move wallet funds, reserve money or create assets/expenses. Progress cannot fall below zero; targets may be exceeded. |
| P11 | Cards | All CARD-07 outputs are required for private preview/export in V1-A, then deliberate publication in V1-B. Curated reusable layouts, no full editor. Exact Money amounts stay hidden unless explicitly selected and previewed. |

### P11 output coverage

- Focus: daily/weekly summaries and selected task/session milestones.
- Read: page updates, finished-book milestones and reading recaps.
- Intake: selected water/coffee daily/weekly recaps.
- Money: monthly plans, savings milestones and selected monthly recaps.
- Combined: selected-mode daily/weekly recaps.
- Reflections attach to supported recaps/plans, including difficult weeks; no standalone status posts.

Template dimensions, approved assets/fonts and renderer correctness remain M00-T09 and contract/implementation work. Private exports do not imply publication or verified achievements.

## Rationale and consequences

Private account/post defaults reduce accidental exposure. Account-required tracking avoids an unapproved guest migration path while leaving authorized offline behavior to its explicit design. English-first bounds the pilot's translation scope without preventing later localization. Stable units/currency and separate savings protect interpretation of manual records. Restricted historical timer edits avoid presenting fabricated durations as recorded sessions. Full private card coverage preserves the personal-first release without enabling social early.

These defaults apply to later clients when their corresponding features ship. They do not imply immediate web parity or alter the Android-first release sequence.

## Still pending

- Authentication methods/provider, secure session persistence, offline horizon and sync/conflict behavior.
- Exact supported currency codes/precision, supported ranges, canonical water representation and one-time conversion rounding. No global IDR/USD default is selected.
- DM contact defaults, anonymous public-link policy, retention/deletion, age/regions and operational policies.
- At this approval, the icon bank was still pending; [Decision 0004](0004-toolchain-directions-and-icon-family.md) subsequently selected Hugeicons Free Stroke Rounded and accepted bounded stack directions. Exact dependency pins, distribution notices, prototypes and chart integration/entitlement remain unresolved.
- Legacy app import: not promised; the reference audit cannot silently add a migration commitment.
- Scaffold and release approvals under the existing milestone gates.

## Authority and next action

Synchronize [PRD](../../PRD.md), [Mobile](../../MOBILE_TECH_SPEC.md), [Backend](../../BACKEND_TECH_SPEC.md), [Website](../../WEB_PRD.md), [Schema](../schema.md), [Design system](../design-system.md) and [milestone tracking](../../milestones/README.md). Existing [release priorities](0001-scope-and-release-tracks.md) and [icon/chart requirements](0002-rounded-icons-and-chart-rendering.md) remain intact.

M00-T02 is Verified as an owner decision. Next is **M00-T03: read-only reference-app audit**, not application scaffolding. No application test or implementation capability is verified by this decision.
