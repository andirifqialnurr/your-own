# M17 — Reposts and One-to-One Messaging

- **Status:** Planned
- **Depends on:** [M11](11-social-backend.md), [M12](12-admin-safety-a0.md), [M13](13-mobile-social-v1b.md), [M15](15-web-social-w2.md)
- **Targets:** API Social/Messaging/Notifications/Moderation/Data lifecycle; Flutter and user-web repost/message surfaces
- **Requirements:** SOC-09; DM-01–04; relevant NOT/SAFE/DATA/NFR; WEB-10/13; BE contact/realtime controls
- **Sources:** [PRD](../PRD.md), [Backend messaging](../BACKEND_TECH_SPEC.md#21-messaging-and-realtime), [Mobile messaging](../MOBILE_TECH_SPEC.md#19-messaging-and-realtime), [Website](../WEB_PRD.md), [Security](../cookbook/security.md)

## Goal

Finish the approved social scope with source-preserving reposts and durable one-to-one text/progress-card messages. No groups, calls, arbitrary media, unapproved read receipts, or end-to-end-encryption claims.

## Ordered tasks

- [ ] **M17-T01** — Approve detailed contact/repost/realtime policy and contracts. **Verify:** request defaults, limits, block behavior, retention/export/deletion treatment, message ordering, browser connection credentials and moderation evidence rules are recorded.
- [ ] **M17-T02** — Implement repost persistence, eligibility and invalidation. **Verify:** source references preserve attribution/audience, duplicate attempts are safe, and deleted/restricted sources disappear from feed/profile/detail without copied private content.
- [ ] **M17-T03** — Add conversation/request/message schema and handlers. **Verify:** participants, request transitions, per-conversation order, uniqueness, revisions, allowed message types and safe history pagination have real constraints/tests.
- [ ] **M17-T04** — Implement durable sends and contact/block coordination. **Verify:** commit/response loss and duplicate sends yield one accepted message; a racing block/request change is rechecked under the approved coordination boundary.
- [ ] **M17-T05** — Implement authorized history/unread/realtime recovery. **Verify:** database history is truth, reconnect/gap fill and event dedupe preserve order, and socket-room membership is not permanent authorization.
- [ ] **M17-T06** — Implement the approved browser realtime authentication path. **Verify:** server-held credentials remain private; limited tickets/proxy cannot impersonate another actor or authenticate REST/operator actions; expiry/replay/Origin controls are tested.
- [ ] **M17-T07** — Implement card-reference delivery and notification eligibility. **Verify:** recipient/source authorization is checked at view/delivery time, revoked card images/text are cleared, and generic pushes/device-token ownership follow current block/privacy state.
- [ ] **M17-T08** — Build Flutter repost and messaging workflows. **Verify:** attribution, requests/list/thread, DM-permission settings, user-scoped drafts, pending/accepted/failed states, stable retry IDs, history and safety actions work through resize/restart/offline interruptions.
- [ ] **M17-T09** — Build user-web repost and messaging workflows. **Verify:** BFF/realtime separation, requests/list/thread/composer, DM-permission settings, IME-safe send, retry/order, draft preservation, browser limitations and no-store/private media behavior match backend truth.
- [ ] **M17-T10** — Integrate reporting, blocking and restricted message evidence. **Verify:** users can report supported selected messages, staff see only approved evidence scope, and current contact denial affects subsequent sends across all clients.
- [ ] **M17-T11** — Extend export/deletion/retention and recovery behavior. **Verify:** participant history and selected evidence obey approved policy; exports never include unrelated conversations; deleted/revoked content is not resurrected by restore/retry.
- [ ] **M17-T12** — Verify concurrency and queue/realtime failures. **Verify:** send/block races, duplicate events, disconnect/reconnect, expired tickets, push uncertainty, delayed jobs and concurrent sessions have real integration evidence.
- [ ] **M17-T13** — Verify full source-permission and client matrix. **Verify:** owner/follower/non-follower/removed/blocked/suspended/deleted states cover posts, reposts, DM cards, notifications, metadata and media on mobile/web.
- [ ] **M17-T14** — Verify adaptive/accessibility/lifecycle messaging. **Verify:** four sizes, short landscape, keyboard-open composer, large text, screen readers, theme changes, account switches and native/browser resume preserve state and privacy.
- [ ] **M17-T15** — Update contracts, indexes and stage evidence. **Verify:** V1-C and W3 task outcomes are tracked separately, A0 can handle messaging reports, and each intended platform release has an explicit handoff to the applicable final gate.

## Exit gate

Reposts and messages preserve current permissions, ordering and operation identity under failure. This grouped milestone coordinates clients; a proposed split release must explicitly separate verified backend/mobile/browser tasks and approvals rather than pretending unimplemented parity exists.

## Task log

Use the [status/evidence workflow](README.md#task-workflow-and-evidence).

| Task | Status | Owner / date | Evidence | Notes / next action |
|---|---|---|---|---|
| — | Not started | — | — | Confirm contact/realtime/lifecycle policy before implementation. |
