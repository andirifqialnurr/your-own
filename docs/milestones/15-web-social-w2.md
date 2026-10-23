# M15 — Social User Website (W2)

- **Status:** Planned
- **Depends on:** [M11](11-social-backend.md), [M12](12-admin-safety-a0.md), [M14](14-web-personal-w1.md)
- **Targets:** User-web Cards/Social/Profile/Notifications and authorized shared routes/media
- **Requirements:** W2; WEB-02/04/08–12; applicable CARD/SOC/FEED/NOT/SAFE/NFR
- **Sources:** [Website](../WEB_PRD.md), [PRD social gate](../PRD.md#262-social-publishing-gate), [Security](../cookbook/security.md), [Design system](../cookbook/design-system.md)

## Goal

Bring deliberate progress sharing to browsers without leaking private content through SSR, metadata, images, or caches. Reposts and DMs remain gated until M17.

## Ordered tasks

- [ ] **M15-T01** — Add approved social BFF/read adapters and query scopes. **Verify:** backend contracts, field allowlists, current audience, mutation identity/revisions and safe error/unavailable states apply to both direct pages and interactive calls.
- [ ] **M15-T02** — Implement canonical publishing and preview confirmation. **Verify:** source/template/field/audience choices match the exact snapshot; explicit publish/retry cannot duplicate or widen content; caption edits, new-preview metric updates, deletion and source-change warning/unpublish/regenerate paths preserve snapshot semantics.
- [ ] **M15-T03** — Implement viewer-authorized profiles and follow controls. **Verify:** own editing, search, requested/approved/removed/blocked states, visibility changes and safe user projections follow backend truth.
- [ ] **M15-T04** — Implement finite feed, post detail, likes and comments. **Verify:** chronological bounded batches, caught-up ending, stable scroll, safe drafts, reactions and deletion/report controls remain accessible across sizes/themes.
- [ ] **M15-T05** — Complete share-link routes and metadata/media policy. **Verify:** `/u/...` and `/p/...` use current permissions, logged-out defaults match approval, and private cards do not leak through HTML/RSC/JSON-LD/preloads/image optimization or stale caches.
- [ ] **M15-T06** — Implement report/block and safe notification inbox flows. **Verify:** selected evidence only, generic sensitive previews, authorized target navigation, unavailable content and preference changes work; optional browser permissions never gate tracking.
- [ ] **M15-T07** — Verify revocation and browser restoration. **Verify:** privatization/deletion/follower removal/block/suspension/logout affect feed/detail/comments/media/metadata and back-forward/session caches without leaking prior private content.
- [ ] **M15-T08** — Run W2 browser/accessibility and cross-client journeys. **Verify:** loss/retry, mixed mobile/web edits, long content, all four classes, supported browser engines, keyboard/screen readers and poster text access have evidence.
- [ ] **M15-T09** — Reconfirm A0 and release operations. **Verify:** actual operators, report/appeal/support policies, incident response, age/region/privacy rules and current moderation readiness cover the website audience.
- [ ] **M15-T10** — Approve and execute the staged W2 release. **Verify:** compatible backend/browser artifacts, safe migrations/caches, monitoring/smoke checks and updated traceability reflect only declared W2 capabilities.

## Exit gate

Browser social interaction meets the same privacy/finite-feed rules as mobile. Backend correctness alone does not waive browser-specific SSR/cache/media testing or actual A0 readiness.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Await M11/M12/M14. |
