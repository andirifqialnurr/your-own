# M13 — Mobile Social Publishing (V1-B)

- **Status:** Planned
- **Depends on:** [M09](09-personal-release-readiness.md), [M11](11-social-backend.md), [M12](12-admin-safety-a0.md)
- **Targets:** Flutter Cards/Social/Profile/Notifications/Settings and native app-link/push integration
- **Requirements:** CARD/SOC except reposts; FEED-01/02; NOT; SAFE; applicable NFR and privacy matrix
- **Sources:** [PRD social gate](../PRD.md#262-social-publishing-gate), [Mobile social](../MOBILE_TECH_SPEC.md#18-social-data-and-cache-permissions), [Design system](../cookbook/design-system.md), [Security](../cookbook/security.md)

## Goal

Add deliberate sharing and encouragement while keeping private tracking useful and ensuring A0 safety precedes public exposure. Reposts and DMs wait for M17.

## Ordered tasks

- [ ] **M13-T01** — Implement online canonical publication adapters/state. **Verify:** selected fields/audience, render status, exact preview/version, explicit confirmation and retry identity do not confuse render completion with publication.
- [ ] **M13-T02** — Build publish/composer and post-detail flows. **Verify:** source/template coverage, omissions, accessible text and cancel/retry match the canonical image; caption edits, explicit metric regeneration, post deletion, and source-change warnings/unpublish paths preserve snapshot semantics.
- [ ] **M13-T03** — Implement profiles and public/private settings. **Verify:** only published projections are exposed; own tracking stays private, visibility changes are explained, and no local flag grants access.
- [ ] **M13-T04** — Implement people search and follow lifecycle UI. **Verify:** follow/requested/approved/remove/unavailable states match server behavior; blocked/pending/removed users do not see restricted content.
- [ ] **M13-T05** — Build finite chronological feed and refresh behavior. **Verify:** bounded batches, deliberate Load Older/caught-up ending, stable reading position and no engagement ranking or automatic social landing.
- [ ] **M13-T06** — Implement likes/comments and authorized sharing. **Verify:** pending/retry/conflict states, count corrections, allowed delete/report actions, link/native-share distinctions and source audience rules are preserved.
- [ ] **M13-T07** — Implement report/block/unblock, blocked-account settings and unavailable-content flows. **Verify:** selected evidence only, safe confirmations, immediate current-policy behavior, and neutral placeholders without leaked titles/amounts/images.
- [ ] **M13-T08** — Implement notification inbox/preferences/push and deep links. **Verify:** device tokens are user-scoped, permission denial is optional, previews omit sensitive data, and cold/warm taps reauthorize their target.
- [ ] **M13-T09** — Implement social/media cache invalidation and session cleanup. **Verify:** deletion, privatization, follower removal, blocks, suspension, logout and account switching cannot continue serving revoked authorized app content.
- [ ] **M13-T10** — Run V1-B privacy/device/accessibility journeys. **Verify:** viewer matrix, background/retry/cache states, four sizes, iPad split view/share sheets, both themes, large text and screen readers have linked evidence.
- [ ] **M13-T11** — Reconfirm policies and A0 operating readiness. **Verify:** age/regions, community/privacy/retention, support/appeals, rate controls, actual staff coverage and incident/recovery paths are approved before enabling social.
- [ ] **M13-T12** — Authorize and execute the staged V1-B release. **Verify:** compatible API/mobile artifacts, migration/rollback plan, monitoring and real report handling pass smoke checks; unshipped repost/DM features remain disabled and honestly labeled.

## Exit gate

V1-B meets the PRD social gate across all online delivery surfaces, with actual A0 support. Public release is blocked by any privacy, moderation-readiness, or policy failure, regardless of UI completeness.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Public social requires M12; no bypass. |
