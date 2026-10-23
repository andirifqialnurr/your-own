# M07 — Manual Money

- **Status:** Planned
- **Depends on:** [M03](03-water-vertical-slice.md); approved Money/currency/savings decisions from M00
- **Targets:** API Money schema/handlers; Flutter Money models, local storage, sync, forms and summaries
- **Requirements:** MON-01–06; applicable DATA/PROG/NFR and backend integrity/security controls
- **Sources:** [Money requirements](../PRD.md#14-money-mode), [Backend Money](../BACKEND_TECH_SPEC.md#16-money-service), [Schema](../cookbook/schema.md), [Testing](../cookbook/testing.md)

## Goal

Implement an exact manual ledger and planning experience, not bank integration or real money movement.

## Ordered tasks

- [ ] **M07-T01** — Implement exact amount/currency primitives and fixtures. **Verify:** minor-unit conversion, locale input, bounds, negative values, currency exponent, and decimal-string transport beyond JavaScript safe integers avoid floating-point loss.
- [ ] **M07-T02** — Implement account/transaction/posting migrations and constraints. **Verify:** ownership, references, revisions, valid transaction types, transfer structure and query indexes survive migration and rollback tests.
- [ ] **M07-T03** — Implement account lifecycle and opening/adjustment operations. **Verify:** archive/history and eligible deletion semantics are explicit; opening balances and reconciliation are not ordinary income.
- [ ] **M07-T04** — Implement income/expense and atomic transfer handlers. **Verify:** header/postings, receipts, revisions, change stream and required events commit together; same-account/invalid-currency/invalid-owner inputs fail safely.
- [ ] **M07-T05** — Test transfer failure and concurrency boundaries. **Verify:** transferring 200 between 500 and 1,000 preserves combined 1,500, income/expense exclude transfers, halfway failure commits neither side, and duplicate/concurrent retries do not inflate assets.
- [ ] **M07-T06** — Implement monthly plans/categories/reviews. **Verify:** planned versus actual expense/savings amounts, month/date boundaries, copy-as-draft, and explicit dated review events are correct; plan editing cannot move a balance or imply a completed savings contribution.
- [ ] **M07-T07** — Implement independent savings goals and entries. **Verify:** contribution/withdrawal/correction/deletion follow approved aggregate constraints and do not create assets, reserve actual funds, or execute transfers.
- [ ] **M07-T08** — Implement Flutter repositories, local projections and sync. **Verify:** pending values are explicit, large exact values round-trip, aggregate revisions prevent silent overwrite, and dependencies/migrations preserve pending transfers.
- [ ] **M07-T09** — Build accounts/history/transaction editor flows. **Verify:** exact entry, currency labels, filters/editable categories, type/account selection, correction and Save work with keyboard and short-height/large-text layouts; insufficient recorded balance warns without preventing truthful manual expense entry.
- [ ] **M07-T10** — Build plan/savings/detail views and hide-amounts. **Verify:** readable bounded panes, selected account/draft continuity, accessible hidden values, and meaningful unknown/empty states work in both themes.
- [ ] **M07-T11** — Expose authoritative summary and private card-source contracts. **Verify:** Today/Progress do not recalculate another ledger; selected public snapshots cannot accidentally include raw balances/notes. Publishing remains gated.
- [ ] **M07-T12** — Verify Money end to end and update traceability. **Verify:** real DB concurrency, offline/mobile restart, cross-device edits, deletion/reconciliation, four-size accessibility and privacy tests cover MON requirements and exact-value invariants.

## Exit gate

Every primary record supports the approved create/view/correct/delete semantics; atomic transfer and independent savings proofs pass. Labels say manual/recorded, never bank-verified. No Pay, Connect Bank, or real-fund action exists.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Await M03 and approved Money semantics. |
