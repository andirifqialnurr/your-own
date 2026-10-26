# Your Own — Security & Privacy Specification

- **Version:** 0.3
- **Status:** Required control design plus proposed implementations; not a security audit or compliance certification
- **Related:** [Architecture](architecture.md) · [Schema](schema.md) · [Testing](testing.md) · [Deployment](deployment.md)

This policy spans Flutter, both Next.js applications, NestJS, workers, storage, identity, queues, and staff operations. Provider integration, encryption-driver, session, retention and legal-region decisions remain approval gates. [Decision 0015](decisions/0015-auth-methods-and-local-protocol-spike.md) accepts initial email/password + verification/recovery and required staff TOTP directions. The [synthetic protocol report](authentication-session-spike.md) supplies local double/crypto/HTTP evidence only; required controls, real Supabase/session/MFA/browser/native proof, exact policies and store/key custody remain gates. The [review](authentication-session-review.md) retains its historical proposal matrix.

## Contents

- [1. Assets and trust boundaries](#1-assets-and-trust-boundaries)
- [2. Threat model](#2-threat-model)
- [3. Identity and lifecycle](#3-identity-and-lifecycle)
- [4. Ownership and social permissions](#4-ownership-and-social-permissions)
- [5. Browser sessions and CSRF](#5-browser-sessions-and-csrf)
- [6. Mobile storage and device behavior](#6-mobile-storage-and-device-behavior)
- [7. Staff access and report evidence](#7-staff-access-and-report-evidence)
- [8. Media, rendering, and caches](#8-media-rendering-and-caches)
- [9. Transactions, replay, and realtime](#9-transactions-replay-and-realtime)
- [10. Infrastructure, secrets, and abuse controls](#10-infrastructure-secrets-and-abuse-controls)
- [11. Data lifecycle and diagnostics](#11-data-lifecycle-and-diagnostics)
- [12. Incident response and release gates](#12-incident-response-and-release-gates)

## 1. Assets and trust boundaries

| Classification | Examples | Handling |
|---|---|---|
| Public editorial | Approved product/policy text, static assets | Cache only actually public published versions |
| Published personal | Selected progress card fields and captions | Current audience policy; public once does not mean permanently public |
| Private personal | Tasks, books/notes, water/coffee, goals, raw Money | Owner-only APIs/protected local projection; no public DTO reuse |
| Confidential conversations | Text history, message requests | Participant policy; no default staff-wide browsing |
| Restricted evidence/operations | Reports, selected evidence, staff grants, exports | Purpose/capability-scoped access and audit |
| Secrets | Refresh tokens, session secrets, DB/storage/push credentials, encryption keys | Managed secure storage, rotation, least privilege, no logs/bundles |

Boundaries include device→API, browser→BFF, BFF→API, API→DB, dispatcher→queue→worker, service→storage/provider, and staff→operator endpoints. All require explicit identity/authorization; a trusted server process is not automatically authorized to perform every action for every user.

IDs, hashes, and pseudonyms can still be personal data. Unguessability is not authorization.

## 2. Threat model

| Threat | Required defense |
|---|---|
| Changing an object/owner ID | Owner-scoped queries, typed DTOs, composite constraints, negative tests |
| Valid token for suspended/deleted account | Application lifecycle check; no stale-token rebootstrap |
| Stale follower/cache/media access | Authoritative current policy on every delivery path |
| CSRF or hostile sibling subdomain | Separate host-only sessions, Origin/token checks, safe callback state |
| XSS or malicious evidence | Escaped text, constrained markup, CSP, no executable user templates |
| Money duplicate/partial write | Idempotent operations, atomic postings, exact types, tested constraints |
| Block versus in-flight contact | Pair/conversation coordination and permission re-read under locks |
| Queue/socket impersonation or replay | Authenticated scopes, safe event IDs, durable source, limited tickets |
| Operator misuse/privilege escalation | MFA, current grants, scoped evidence, audit, no general table editor |
| Renderer/upload attack | URL allowlist/no arbitrary fetch, byte/pixel/CPU caps, raster validation |
| Private data in telemetry/backups | Minimization, redaction, retention, protected restore/deletion process |
| Credential leakage | No client service keys; separate secrets and least-privilege identities |

These controls address application threats; they do not prove identity, real-world activity, medical benefit, or financial correctness against external institutions.

## 3. Identity and lifecycle

- Verify approved token signature algorithms, issuer, audience, expiry, and applicable time claims using trusted configuration/rotating keys.
- Never accept request-supplied issuer/JWKS URLs as trusted identity configuration.
- Map identities by issuer+subject, not email alone.
- Keep credential/recovery behavior with the approved provider; do not add a second password system unintentionally.
- Resolve Active/Suspended/Deleting/Deleted application status independently of valid provider JWTs.
- Prevent stale tokens/offline commands from recreating deleted accounts.
- Define refresh, logout, all-session/per-device revocation, key rotation, and outage behavior against the actual provider. Short expiry alone is not immediate revocation.
- Server-side request authorization and sensitive transaction coordination must account for concurrent lifecycle changes.

Identity provider webhook signatures/replay rules must be verified. A JSON payload stating “user deleted” or “MFA verified” is not trusted by itself.

## 4. Ownership and social permissions

Default deny. Raw tracking and Money records are owner-only even on public profiles. Use allowlisted response projections, not hidden fields in raw database objects.

Effective post access includes current account status/visibility, persisted audience/publication generation, approved follow state, blocks, moderation, and source eligibility. See the proposed epoch rules in [schema.md](schema.md).

Apply the same policy to:
- Feed/profile/post/comment/reaction reads.
- Media bytes, link previews, SSR/RSC props, accessibility text, and metadata.
- Reposts and DM card references.
- Worker notification/render/publication operations.
- Idempotent receipt replays and cached responses.

A shared URL/card reference never grants permission. Reposts require a currently public source even when the reposter personally retains follower access.

Use safe unavailable responses for protected resource existence. Do not leak hidden titles/amounts through error details, counts, search, or suggestion previews.

Reads have a defined authorization point; responses already delivered/in flight cannot be universally recalled. Anonymous public rendering, if enabled, cannot prevent a blocked person viewing public data while signed out. Explain limits instead of promising identity enforcement outside authenticated access.

## 5. Browser sessions and CSRF

Recommended architecture: provider credentials stay in protected server-side session infrastructure; browsers hold opaque Secure/HttpOnly/host-only cookies.

- Separate web/admin realms, secrets, session state, and cookies. Proposed names can use the `__Host-` prefix with its required Secure/path/no-Domain properties.
- Do not use a parent-domain cookie to confer admin access across sibling applications.
- Choose compatible SameSite/OAuth state/PKCE/nonce handling; validate callbacks and rotate sessions after authentication/privilege transitions.
- Cookie-authenticated mutations require approved Origin/CSRF controls. SameSite is not a complete defense against sibling-subdomain requests.
- Allowlist BFF operations and destinations; no arbitrary URL proxy or browser-controlled actor override.
- Server Actions require the same authentication, policy, CSRF, validation, and retry review as route handlers.
- Keep secrets/provider tokens out of localStorage, client props, RSC payloads, URLs, and diagnostics.
- Clear session-scoped query/router/image state on logout/account change; revalidate before displaying sensitive back/forward-restored content.

User web is proposed online-first. No service worker/IndexedDB private cache or sensitive persistent browser draft storage without a separate threat-model approval.

## 6. Mobile storage and device behavior

- Use per-account isolation for databases, drafts, outbox, credentials, media caches, and notifications.
- Verify the authentication SDK's real persistence adapter; merely installing secure storage is not integration.
- Store secrets/keys through validated OS-backed secure storage; never bundle service credentials.
- Use app-private file protection and approved backup exclusions for sensitive records/exports.
- Application-level database encryption is recommended for production Money/messages. Validate the actual Drift/SQLite driver, isolate support, migration, key lifecycle, and recovery before real sensitive data.
- Encryption of credentials is not encryption of SQLite. OS device encryption does not eliminate application backup/key-management decisions.
- Obscure sensitive app-switcher views where supported. Hide-amounts settings also remove values from accessibility presentation, not just visible text.
- Logout must stop sync/socket activity and handle unsynced records deliberately before switching user scope.
- Rooted/jailbroken/compromised devices and screenshots are outside complete confidentiality guarantees; avoid false “impossible to extract” claims.

## 7. Staff access and report evidence

NestJS—not a Next.js layout—verifies current staff grants, scope, required MFA, and fresh assurance. Never trust browser `isAdmin`, `x-admin`, `x-mfa`, editable profile roles, or a normal low-assurance user session.

- Least-privilege support/moderation/operations/audit/editor roles; no default raw finance or unrelated DM browsing.
- Restricted out-of-band initial staff provisioning and recovery; no public staff signup.
- Step-up for designated high-impact actions and protection against self-escalation/last-admin lockout.
- Case-scoped intentionally submitted evidence; safe context is not permission to search entire conversations.
- Audit sensitive evidence access, sanctions, staff changes, and operational retries with minimal metadata.
- Keep appeal history; do not rewrite accepted past decisions.
- Audit append-only behavior is an application control, not a claim that database administrators cannot alter bytes.
- Exceptional break-glass access is not implemented by default; it requires a separately approved mechanism/policy.

The admin's proposed 15-minute idle/8-hour absolute/5-minute step-up windows remain reviewable defaults, not final policy.

## 8. Media, rendering, and caches

- Private storage keys, media IDs, and long-lived signed URLs are not access controls by themselves.
- Reauthorize private media at delivery through a suitable proxy/API path. An issued signed URL can remain usable until expiry.
- Do not use permanent public/CDN card URLs for content that can later become private without a compatible revocation design.
- Next.js data/route/image caches must be configured explicitly; no user/session/evidence data in global caches or static metadata.
- Do not run private images through a publicly cached optimizer inadvertently.
- Render only canonical allowlisted card fields; exclude private source objects from JSON, alt text, fonts/asset metadata, and image output.
- Use approved bounded templates/assets; no arbitrary remote fetch, user HTML/JavaScript/SVG execution, or custom executable template editor.
- Validate upload types, bytes, decoded dimensions, and content; strip unnecessary metadata and reject unsafe formats.
- External exported images/screenshots/link-preview caches cannot be reliably revoked. Warn before sensitive external sharing.

## 9. Transactions, replay, and realtime

- Stable operation identity plus canonical payload/type validation; changed input requires a new semantic operation.
- Idempotency receipts are actor-scoped/minimized; replay rechecks current lifecycle/access and never returns revoked sensitive snapshots.
- Transfers, revisions, receipts, stream entries, and required outbox work commit consistently.
- Revision conflicts preserve input; do not silently last-write-win Money/reading history.
- Tombstone/receipt expiration forces safe resync/rebase, not blind resurrection.
- Re-read block/contact permissions after acquiring relevant coordination; a pre-lock check is insufficient.
- Socket rooms and events are server-authorized; handshake-only indefinite permission is insufficient.
- Browser connection tickets, if adopted, have distinct audience/scope/expiry/replay rules and cannot authenticate ordinary REST/operator actions.
- Revalidate queued work before delivery. Websocket events carry minimal references rather than broad private snapshots.
- Do not claim E2E encryption unless implemented/evaluated, or exactly-once network/push delivery.

## 10. Infrastructure, secrets, and abuse controls

Production requires TLS, protected service connections, private database/queue access, separate environment credentials, approved at-rest encryption, secure backups, and restricted operational access.

- Scope API, worker, migration, session-store, storage, identity-admin, and push credentials separately where practical.
- No production secrets in Flutter, `NEXT_PUBLIC_*`, bundled `.env`, source control, images, test fixtures, logs, or shell output.
- Provider data APIs/RLS/grants must not expose a second unrestricted domain access path.
- CORS allowlists browser origins but does not authenticate clients.
- Use parameterized queries/reviewed raw SQL, strict DTO validation, request-size limits, safe headers/CSP, and no permissive production TLS bypass.
- Rate-limit identity-adjacent operations, search, unknown-sender contact, comments/publication, uploads, exports, and reports.
- Choose endpoint-specific limiter-outage policy; public posting/new contact must not silently become unlimited.
- Queue/worker credentials must not permit arbitrary command/SQL execution from a job payload.
- Rotate secrets and review dependencies/build artifacts with an incident-ready procedure.

## 11. Data lifecycle and diagnostics

Retention must cover primary rows, tombstones, receipts, snapshots, outbox/job references, evidence, sessions, exports, media, logs, and backups. Proposed offline horizon does not determine every legal retention period.

Exports require owner authentication/appropriate reauthentication, private expiring results, and safe external-copy warnings. Operator status access is not export download permission.

Deletion denies new normal activity/publication promptly, coordinates provider/session state, invalidates queued work, and purges/anonymizes copies under approved policy. Delivered-message retention, legal/abuse exceptions, backup delays, and deletion timing must be published before launch.

No message bodies, private notes, exact financial values, tokens, raw evidence, or broad screen replay in general analytics/logs. Record safe technical correlation and minimal scoped audit data. Redaction must be tested, not presumed from a logger setting.

## 12. Incident response and release gates

### Response sequence

1. Triage and appoint an incident owner; preserve appropriately restricted evidence.
2. Contain affected routes/jobs/credentials/grants without erasing required records.
3. Revoke/rotate and stop unsafe delivery; verify current authorization on recovery.
4. Determine affected users/data and applicable notification/legal obligations.
5. Restore/reconcile safely; old backups must not reactivate deleted users or revoked public/staff access.
6. Document cause, remediation, follow-up tests, and closure evidence.

### Release controls

| ID | Required control |
|---|---|
| SEC-01 | Verified identity plus application lifecycle and owner context |
| SEC-02 | Uniform authorization across APIs, media, workers, metadata, and caches |
| SEC-03 | Private browser sessions and tested CSRF/account-switch boundaries |
| SEC-04 | Validated mobile isolation, credential integration, at-rest/backup strategy |
| SEC-05 | Current staff grant, MFA/assurance, scoped evidence, and audit |
| SEC-06 | Exact/atomic Money and idempotent replay/conflict protection |
| SEC-07 | Safe source snapshots, image rendering/upload/media delivery |
| SEC-08 | Durable authorized messaging, contact-race handling, limited realtime credentials |
| SEC-09 | Secret/privilege separation, dependency/abuse controls |
| SEC-10 | Minimized diagnostics, exports, deletion, and explicit retention |
| SEC-11 | Tested incident/restore behavior preserving revocations/lifecycle state |
| SEC-12 | Approved age/region/privacy/community policies and named operators |

Implement evidence in [testing.md](testing.md) and operational procedures in [deployment.md](deployment.md). These documents are requirements, not evidence that the controls already exist.
