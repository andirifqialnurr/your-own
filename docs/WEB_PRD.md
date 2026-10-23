# Your Own — User Website PRD & Next.js Specification

- **Version:** 0.7
- **Status:** Detailed draft; no website scaffold implemented
- **Confirmed framework:** Next.js for the user website
- **Shared backend:** NestJS; no separate web financial/social backend
- **Product authority:** [PRD.md](PRD.md)
- **Engineering overview:** [System architecture and cross-cutting documents](cookbook/architecture.md)
- **Related specifications:** [Mobile](MOBILE_TECH_SPEC.md) · [Backend](BACKEND_TECH_SPEC.md) · [Admin CMS](ADMIN_CMS_PRD.md)
- **Pending approval/validation:** Exact pins and remaining packages/primitives, identity/session integration, hosting/domains, browser baseline, release dates, anonymous/indexing policies and ApexCharts entitlement

> A useful browser experience for personal progress—not an endless social feed, and not a copy of the admin dashboard.

## Contents

- [1. Purpose and decision status](#1-purpose-and-decision-status)
- [2. Goals and non-goals](#2-goals-and-non-goals)
- [3. Audiences and journeys](#3-audiences-and-journeys)
- [4. Website scope and release stages](#4-website-scope-and-release-stages)
- [5. Information architecture and routes](#5-information-architecture-and-routes)
- [6. Recommended frontend stack](#6-recommended-frontend-stack)
- [7. Architecture and project boundaries](#7-architecture-and-project-boundaries)
- [8. Authentication and browser sessions](#8-authentication-and-browser-sessions)
- [9. API access and mutation correctness](#9-api-access-and-mutation-correctness)
- [10. Server rendering and cache privacy](#10-server-rendering-and-cache-privacy)
- [11. Responsive layout and accessibility](#11-responsive-layout-and-accessibility)
- [12. Public pages and app links](#12-public-pages-and-app-links)
- [13. Account onboarding and settings](#13-account-onboarding-and-settings)
- [14. Today and personal navigation](#14-today-and-personal-navigation)
- [15. Focus in the browser](#15-focus-in-the-browser)
- [16. Reading](#16-reading)
- [17. Intake](#17-intake)
- [18. Money](#18-money)
- [19. Progress calendars and cards](#19-progress-calendars-and-cards)
- [20. Profiles, feed, and interactions](#20-profiles-feed-and-interactions)
- [21. Messaging and notifications](#21-messaging-and-notifications)
- [22. State, drafts, and connectivity](#22-state-drafts-and-connectivity)
- [23. Privacy, security, and data controls](#23-privacy-security-and-data-controls)
- [24. Performance and observability](#24-performance-and-observability)
- [25. Testing and acceptance criteria](#25-testing-and-acceptance-criteria)
- [26. Delivery and deployment](#26-delivery-and-deployment)
- [27. Backend dependencies and open decisions](#27-backend-dependencies-and-open-decisions)
- [28. Website readiness definition](#28-website-readiness-definition)

## 1. Purpose and decision status

This document specifies the user-facing website, including product requirements and proposed Next.js implementation boundaries. The main PRD owns product behavior; this document adds browser-specific requirements rather than redefining financial calculations, tracking rules, or social permissions.

**Confirmed:** Flutter mobile, NestJS backend, and Next.js for both the user website and a separate admin CMS application.

**Selected visual tooling direction:** [Decision 0002](cookbook/decisions/0002-rounded-icons-and-chart-rendering.md) selects ApexCharts for user-web charts and requires a complete rounded icon family instead of Material/default starter icons. [Decision 0004](cookbook/decisions/0004-toolchain-directions-and-icon-family.md) selects **Hugeicons Free Stroke Rounded** and confirms ApexCharts installation/integration on hold pending licensing clarification. Exact pins, notices and integration evidence remain pending.

**Accepted supporting directions (Decision 0004):** App Router/React, strict TypeScript, Tailwind CSS with semantic tokens, TanStack Query, React Hook Form/Zod and owned accessible components in a lean pnpm workspace. Exact versions are not approved. shadcn/ui/underlying primitives, generated REST/OpenAPI tooling and specific browser-session/BFF libraries remain candidates.

Framework choices, the release-track priorities in [Decision 0001](cookbook/decisions/0001-scope-and-release-tracks.md), and the visual tooling direction above are confirmed. Exact versions, other libraries, identity provider, session protocol, database, and hosting still need approval/compatibility checks. Routes in this document are illustrative until the public URL contract is approved.

**Must** indicates a requirement of the stage in which the feature ships. **Proposed** indicates a reviewable default. **Later** is outside the initial web scope. Mobile V1 timing does not automatically commit the complete website to the same launch date.

## 2. Goals and non-goals

### Goals

- Make Your Own useful from a browser without requiring mobile installation.
- Support desktop productivity workflows and responsive phone/tablet browsing.
- Provide intentional public sharing and links that can open the mobile app where supported.
- Reuse the same identity, records, goals, permissions, and server calculations as mobile.
- Keep personal tracking valuable without social participation.
- Preserve the no-video, progress-only, finite-feed product identity.

### Non-goals

- A second backend implementation, direct application-database access, or a new financial ledger in Next.js.
- Admin/moderator access inside the ordinary user website.
- Guaranteed mobile-equivalent background timers or notification delivery.
- Automatic offline/PWA parity with Flutter.
- Reels, unrestricted posting, trending, advertising systems, or productivity rankings.
- A third marketing application: public product pages can live in this website.
- Editorial blog publishing or a general-purpose page builder unless approved separately.

## 3. Audiences and journeys

| Audience | Main needs |
|---|---|
| Visitor | Understand the product, privacy approach, and where to get the app |
| Recipient of a progress link | See authorized content or a safe access/login/request state |
| Private tracker | Manage tasks, books, intake, and money without publishing |
| Desktop user | Work with lists/details, keyboard input, and larger progress views |
| Social participant | Share a card, support friends, and message intentionally |

Primary journeys:
1. A visitor reads the product page and opens the app-store link or browser signup.
2. A user logs in, sees Today, completes a task, logs water, and leaves.
3. A reader updates a page position on web and later sees the accepted change on mobile.
4. A user edits a monthly plan, previews a percentage-only card, and publishes it deliberately.
5. A follower opens a shared card; removal of their access makes later reads unavailable.
6. A user visits the finite feed, comments, reaches the caught-up marker, and returns to their own work.

## 4. Website scope and release stages

Web stages are a separate rollout track; they map to backend capabilities rather than replacing the PRD's V1-A/B/C definitions.

| Stage | Scope | Dependency |
|---|---|---|
| **W0: Public presence** | Product, privacy/terms/support pages, app links, safe share-link resolution | Approved copy/domain and applicable backend public-link policy |
| **W1: Personal web** | Auth/onboarding, Today, four modes, private progress, own card preview/export, settings/data controls | Backend personal foundation, browser sessions, and private card preparation/export capability |
| **W2: Social publishing** | Profiles, public/private following, canonical publishing, feed, likes/comments, authorized sharing, reporting/blocking | Backend V1-B and operational admin moderation |
| **W3: Social completion** | Reposts, one-to-one DMs/requests, realtime recovery | Backend V1-C |

Accepted delivery priority: mobile personal utility first, minimal admin capability before public social, and user web on its independent track. W0 may be brought forward after its prerequisites; complete browser parity is not a condition of the first mobile pilot. Do not delay required moderation until all web trackers are built.

A W0 release must not suggest that all browser features already work. Hide unavailable entry points with honest availability copy; backend flags still enforce access.

### Full intended web scope

- Focus: lightweight tasks, labels, Today, countdown/count-up sessions, history.
- Read: manual books/shelves, page progress, completion, optional goals/history.
- Intake: water and coffee, target/history/corrections.
- Money: manual accounts, transactions/transfers, plans, savings, exact summaries.
- Personal progress and generated cards.
- The same social interactions selected for full product V1, delivered in the web stages above.

Browser limitations and the online-first scope must be communicated; "web version" does not mean invisible feature differences.

## 5. Information architecture and routes

### Public surfaces

| Illustrative route | Purpose |
|---|---|
| `/` | Product landing page |
| `/features` | Explain modes and progress sharing |
| `/privacy`, `/terms` | Approved policy documents |
| `/support`, `/account-deletion` | Support and account-deletion guidance/entry |
| `/u/:username` | Viewer-authorized profile |
| `/p/:postId` | Authorized shared progress post |
| `/login`, `/signup`, `/auth/callback`, `/recover` | Approved identity flows |

### Authenticated application

| Illustrative route | Purpose |
|---|---|
| `/app/today` | Default personal landing page |
| `/app/focus` | Tasks/timer/history and selected task/session |
| `/app/read` | Bookshelves and selected book |
| `/app/intake` | Quick logging, targets, history |
| `/app/money` | Accounts, transactions, budgets, savings |
| `/app/progress` | Calendars and summaries |
| `/app/circle` | Finite following feed |
| `/app/messages/:conversationId?` | Requests, list, thread |
| `/app/cards/compose` | Supported-source card creation |
| `/app/settings` | Privacy, units, notifications, export/deletion |

Use path/URL state for safe selection, period, pagination, and filters where useful. Do not put financial notes, message bodies, private draft text, credentials, or raw sensitive search terms into URLs/history.

Navigation adapts between bottom/drawer navigation and a sidebar. Today remains the default; the feed is not the automatic landing destination.

## 6. Recommended frontend stack

| Concern | Proposal / selected direction | Boundary |
|---|---|---|
| Framework | Next.js App Router | Framework confirmed; exact compatible version pending |
| Language | TypeScript strict | Types do not replace runtime validation |
| Styling | Tailwind CSS + owned semantic design tokens | Centralize responsive/content-width policy |
| Components | Owned accessible components; shadcn/ui/underlying primitives remain candidates | Direction accepted, specific primitives unselected; verify actual accessibility |
| Remote interactive state | TanStack Query | Session-scoped queries/mutations, not the domain source of truth |
| Forms | React Hook Form + Zod | Client feedback and typed forms; NestJS revalidates |
| API client | Generated TypeScript REST/OpenAPI client | Shared contract with mobile; no Prisma in product-page code |
| Browser sessions | Provider-aware server adapter + opaque secure session cookie | Specific library/store selected after identity approval |
| Icons | **Hugeicons Free Stroke Rounded**; first-party Flutter/React package directions, pins pending | Shared semantic adapter; no Material or starter/component-default glyphs; coverage/notices still need validation |
| Data charts | **ApexCharts selected in principle; integration on hold** pending licensing clarification | Browser-only adapter, exact-value/text alternatives, explicit theme/privacy controls after rights clearance |
| Calendar/progress primitives | Purpose-built accessible calendar/cells/bars where appropriate | Not a second data-chart library or a dependency on ApexCharts for every control |
| Dates/currency | Intl plus audited timezone/exact-amount utilities | No floating-point Money ledger calculations |
| Realtime | Socket.IO client if backend proposal approved | Authorized hints and gap recovery |
| Tests | Vitest or equivalent, Testing Library, Playwright, axe-based checks | Unit, component, browser/security/adaptive tests |
| Diagnostics | Privacy-configured error/performance tool | No private screen replay or input capture by default |

Pin tested package/runtime versions and the lockfile at bootstrap. Validate UI, query, form, API-generation, and deployment compatibility; this table is not a completed dependency audit. ApexCharts selection does not approve a paid license or establish compatibility: verify the chosen versions' applicable terms/entitlements before installation.

Follow the shared [rounded icon](cookbook/design-system.md#56-rounded-icon-system) and [chart rendering](cookbook/design-system.md#73-chart-rendering-and-platform-ownership) contracts. Isolate browser-dependent ApexCharts code behind a Client Component/browser-only adapter, with an accessible summary/loading/error frame and tested hydration. Override default palettes, typography and retained toolbar icons; disable unapproved export/download controls. Chart coordinates never become Money arithmetic, hidden values must not leak through labels/tooltips/exports, and account changes clear chart state. Do not substitute a shadcn Recharts chart or default icon imports for the selected system.

## 7. Architecture and project boundaries

```text
Browser UI
    |
Next.js: server-rendered shell + interactive client components
    |
Same-origin, allowlisted session/BFF handlers
    |
NestJS REST API
    |
Authoritative tracking, permissions, finance, posts, messaging
```

### 7.1 Application map

Recommended location: `apps/web/`, separate from `apps/admin/`. This is a proposed path map, not a scaffold or a commitment to ship every route in W0. Use the [cross-application ownership map](cookbook/architecture.md#51-application-and-shared-package-ownership) for shared-package boundaries.

```text
apps/web/
  README.md                            # Setup and navigation entry point
  package.json
  next.config.ts                       # Config form matched to pinned Next.js version
  tsconfig.json
  .env.example                         # Placeholders only; no secrets in NEXT_PUBLIC_*
  public/
    fonts/                             # Approved licensed local fonts
    images/                            # Genuinely public product assets only
  docs/
    FEATURE_INDEX.md
    ROUTE_MAP.md                       # URL -> route file -> feature -> BFF/API
    COMPONENT_CATALOG.md
    TRACEABILITY.md
    decisions/
  src/
    app/                               # Thin Next.js routing/composition layer
      layout.tsx
      not-found.tsx
      global-error.tsx
      (public)/
        page.tsx                       # /
        features/page.tsx
        privacy/page.tsx
        terms/page.tsx
        support/page.tsx
        account-deletion/page.tsx
        u/[username]/page.tsx           # Current-viewer authorization still required
        p/[postId]/page.tsx             # Current-viewer authorization still required
      (auth)/
        login/page.tsx
        signup/page.tsx
        recover/page.tsx
      auth/callback/route.ts           # Provider callback, not a rendered page
      (workspace)/
        layout.tsx                     # Authenticated shell; not sole auth enforcement
        app/                           # Literal /app URL segment
          page.tsx                     # Redirect to /app/today
          loading.tsx
          error.tsx
          today/page.tsx
          focus/page.tsx
          read/
            page.tsx
            books/[bookId]/page.tsx
          intake/page.tsx
          money/
            page.tsx
            accounts/[accountId]/page.tsx
            transactions/[transactionId]/page.tsx
            plans/page.tsx
            savings/page.tsx
          progress/page.tsx
          circle/page.tsx
          messages/
            page.tsx
            [conversationId]/page.tsx
          cards/compose/page.tsx
          settings/page.tsx
      api/
        session/route.ts               # Approved session operations
        bff/                           # Explicit allowlisted routes as slices ship
          money/
            summary/route.ts
            transactions/
              route.ts
              [transactionId]/route.ts
    features/
      auth/
      onboarding/
      today/
      focus/
      read/
      intake/
      money/
      progress/
      cards/
      social/                          # Feed/posts/comments/follows/safety
      messaging/
      notifications/
      profile/                         # Viewer-authorized profile and own editing
      settings/
    components/                        # Shared within this app; no feature rules
      shell/
      navigation/
      adaptive/
      ui/
      forms/
      charts/
      states/
    server/                            # Server-only modules, guarded at imports
      api/
        nest-client.server.ts          # Fixed backend origin, per-request credentials
      auth/
        session.server.ts
        session-store.server.ts
        callback.server.ts
      bff/
        mutation-guard.server.ts        # Session, Origin/CSRF, method/body constraints
        response-mapper.server.ts
      security/
      config/
      preferences/                     # Validated appearance cookie/SSR resolution
      diagnostics/
    lib/                               # Credential-free, browser-safe utilities
      http/
        bff.client.ts                  # Same-origin browser requests, not Nest tokens
      query/
      formatting/
      validation/
    providers/
      query-provider.client.tsx
    theme/
      appearance-provider.client.tsx
      appearance-preference.ts
    styles/
      globals.css
      tokens.css                       # Semantic light/dark mapping
  test/
    app/                               # Routing/composition tests
    features/                          # Mirrors feature paths
    components/
    server/
    contracts/
    e2e/                               # Browser user journeys
    fixtures/
    support/
  scripts/
```

Folders named `(public)`, `(auth)`, and `(workspace)` are organizational route groups and do not appear in URLs. The nested `app/` segment is why a route is `/app/money`, not `/money`. Route groups and layouts do not enforce all access: loaders, mutations, media, and BFF handlers must check their own current context. The public group name does not make `/u/...` or `/p/...` anonymously readable.

The tree shows representative deep routes and BFF handlers; add the rest alongside approved slices and record them in `ROUTE_MAP.md`. Onboarding and notification presentation can initially be embedded flows/panels; a feature folder does not automatically create a URL. Do not store private posters, exports, evidence, or uploads in Next.js `public/`.

### 7.2 Feature layout — Money example

```text
src/features/money/
  README.md
  index.ts                             # Explicit browser-safe exports only
  types.ts                             # Safe view types / approved contract references
  screens/
    money-overview-screen.client.tsx
    transaction-detail-screen.tsx
  components/
    account-card.tsx
    transaction-row.tsx
    amount-visibility-toggle.client.tsx
  forms/
    transaction-form.client.tsx
    transaction-form.schema.ts         # Client feedback, not authoritative ledger rules
  hooks/
    use-money-summary.ts
    use-create-transaction.ts
  api/
    money.client.ts                    # Calls same-origin /api/bff/money/...
  server/
    get-money-summary.server.ts        # Server Component loader -> NestJS directly
    create-transaction.server.ts       # Authorized, validated forwarding; no ledger logic
  mappers/
    money-view.mapper.ts               # Formatting/view shape, not recalculated balances
```

| Location | Owns | Boundary |
|---|---|---|
| `src/app/**/page.tsx` | URL params, server composition, authorized initial reads, feature screen | Keep business workflows out of large route files |
| `features/*/screens`, `components`, `forms` | Feature UI, accessible/adaptive arrangement, drafts | No direct domain database or provider credentials |
| `features/*/hooks`, `api` | Session-scoped browser queries/mutations via BFF | No bearer tokens in browser storage; no second Money engine |
| `features/*/server` | Feature-specific authorized read/forwarding adapters | Must be server-only; backend remains authoritative |
| `src/server` | Session/BFF infrastructure, backend transport, safe server config | Not another tracking/financial/social backend |
| `src/components`, `theme`, `styles` | Generic UI, layout and design-system adapters | No copies of feature repositories or API authorization policy |
| `src/lib` | Safe formatting/validation/query helpers | No catch-all `utils.ts`, no server secret exports |

Use explicit `import 'server-only'` in server entry modules and a tested import-boundary policy; `.server.ts` naming alone is not protection. Interactive entry components use `'use client'`; a `.client.tsx` suffix is a navigation convention, not a replacement for the directive. Avoid barrel exports that mix server loaders and client components. Only approved safe data is serialized to Client Components.

### 7.3 Route-to-file map

Representative mappings; the section 5 public URL contract remains proposed.

| Browser URL / method | Next.js path under `src/app/` | Feature / server owner |
|---|---|---|
| `/login` | `(auth)/login/page.tsx` | `features/auth/` |
| `/auth/callback` | `auth/callback/route.ts` | `server/auth/callback.server.ts` |
| `/app/today` | `(workspace)/app/today/page.tsx` | `features/today/` |
| `/app/read/books/:bookId` | `(workspace)/app/read/books/[bookId]/page.tsx` | `features/read/` |
| `/app/money` | `(workspace)/app/money/page.tsx` | `features/money/` |
| `/app/money/transactions/:transactionId` | `(workspace)/app/money/transactions/[transactionId]/page.tsx` | `features/money/` |
| `/app/messages/:conversationId` | `(workspace)/app/messages/[conversationId]/page.tsx` | `features/messaging/` |
| `/u/:username` | `(public)/u/[username]/page.tsx` | `features/profile/`, current authorized projection |
| `/p/:postId` | `(public)/p/[postId]/page.tsx` | `features/social/`, current authorized projection |
| `GET /api/bff/money/summary` | `api/bff/money/summary/route.ts` | Authorized forwarding to `GET /v1/money/summary` |
| `POST /api/bff/money/transactions` | `api/bff/money/transactions/route.ts` | CSRF/session validation, then `POST /v1/money/transactions` |

Bracketed filesystem segments become validated route parameters, never trusted ownership or an arbitrary backend path. Use URL-safe identifiers and approved filters only; private notes and draft amounts do not belong in URL state.

### 7.4 Read and mutation paths

**Server-rendered read:**

```text
app/(workspace)/app/money/page.tsx
  -> features/money/server/get-money-summary.server.ts
  -> server/auth/session.server.ts + server/api/nest-client.server.ts
  -> NestJS GET /v1/money/summary
  -> authorized safe view data -> feature screen
```

Server Components call the backend through the server adapter directly; they do not make an HTTP request back into their own BFF just to reach the same adapter. Private reads use explicit no-store/session-aware policy against the pinned Next.js version; no shared mutable API client with another user's token.

**Browser mutation:**

```text
features/money/forms/transaction-form.client.tsx
  -> hooks/use-create-transaction.ts -> api/money.client.ts
  -> app/api/bff/money/transactions/route.ts
  -> server/bff/mutation-guard.server.ts
  -> features/money/server/create-transaction.server.ts
  -> server/api/nest-client.server.ts
  -> NestJS money transport -> shared application handler -> transaction
```

- Preserve operation ID and expected revision through this path; invalidate only affected session-scoped queries after a known result. Unknown outcomes retain retry identity.
- BFF routes accept explicit methods/fields and map to fixed backend operations. Do not introduce `/api/proxy?url=...` or unrestricted path forwarding.
- Provider/access/refresh credentials stay in server-only session handling, never client bundles, props, localStorage, or public configuration.
- A dedicated least-privilege session-store adapter is an infrastructure exception, not permission to import the domain Prisma client or read domain tables.
- If Server Actions are introduced, they receive the same authentication, Origin/CSRF, validation, and operation-identity controls. They are not automatically authorized.
- Responsive layout stays in reusable components and feature screens; no `mobile/`, `tablet/`, and `desktop/` duplicate feature trees. Readable panes share query/draft/selection state.

### 7.5 Tests and traceability

- Examples: `test/features/money/forms/transaction-form.test.tsx`, `test/server/bff/mutation-guard.test.ts`, `test/app/api/bff/money/transactions/route.test.ts`, and `test/e2e/money-transfer.spec.ts`.
- Test browser UI, server/BFF boundaries, first-paint appearance, actual SSR/cache behavior, user switching, privacy, and responsive states. Unit tests do not prove a production Next.js cache configuration.
- `docs/FEATURE_INDEX.md` records feature ownership and entry screens; `ROUTE_MAP.md` records page and BFF routes, methods, feature modules, backend operations, and auth/cache policy.
- `docs/COMPONENT_CATALOG.md` links design-system component families to local/shared implementations and tests, rather than copying the token specification.
- `docs/TRACEABILITY.md` links product/WEB/SEC requirements to routes/features, tests/evidence, and W0–W3 stage. Planned/In progress/Implemented/Verified are distinct; Verified requires evidence.
- Keep these navigation indexes beside the application and update them with changes. Root PRDs, the cookbook, and generated backend contracts remain authoritative; do not duplicate those documents into each feature.

## 8. Authentication and browser sessions

### Recommended session model

The browser holds an opaque **Secure, HttpOnly, host-only** session cookie. Provider credentials/access/refresh tokens are handled server-side through the approved adapter/store, not persisted in browser localStorage.

Use suitable SameSite settings, session rotation, expiry, revocation, and secure OAuth state/PKCE/nonce handling. Select the exact protocol after the identity provider is approved.

The web and admin applications use separate session scopes/cookies. Do not set a broad parent-domain cookie that automatically signs regular user sessions into the admin application.

### Required behavior

- Restore only the current user's authorized state.
- Preserve a safe same-origin intended destination across login; reject open redirects.
- Use the same account/data as mobile, not a second web identity record.
- Recovery/login callbacks work on cold navigation and reject invalid/replayed state.
- Cookie-authenticated mutations require explicit CSRF protection, including strict Origin validation and an appropriate token strategy.
- SameSite alone is insufficient, particularly with sibling subdomains.
- Backend NestJS still verifies identity and current ownership/audiences on every operation.
- Logout clears session-bound client queries, drafts/caches under the approved policy, and realtime state; another user's login must not inherit them.
- Account suspension/deletion and token expiry route to safe states without a private-content flash.

Session-store technology, idle/absolute timeouts, reauthentication rules, and provider-specific recovery remain approval gates.

## 9. API access and mutation correctness

Use the backend's approved REST/OpenAPI contract through a central adapter. No new web-only Money or post-permission semantics.

- Send stable operation IDs for retriable mutations; an uncertain network result is not proof of failure.
- Use expected revisions for mutable aggregates and present conflict resolution rather than silently overwriting mobile changes.
- Retrying the same semantic operation reuses its ID; editing rejected input creates a new operation.
- Avoid blind automatic retries of non-idempotent writes.
- Distinguish saved, pending server response, rejected, and conflicted states.
- Canceling a fetch or closing a dialog does not guarantee the server canceled a mutation.
- Map safe errors/field validation consistently; never display raw backend stack traces.
- Page histories/feed/messages using approved cursors.
- Validate large integer/date/nullability behavior in generated clients.
- Never trust client-supplied owner or staff fields.

After a web mutation, refresh/invalidate only affected queries. The backend must emit the same personal change-stream updates as a mobile mutation so Flutter sync remains correct.

An owner-authorized operation-receipt lookup is a proposed recovery capability for unknown outcomes. Approve it with the backend rather than assuming an endpoint exists.

## 10. Server rendering and cache privacy

### Rendering policy

| Surface | Default policy |
|---|---|
| Product/policy pages | Cacheable only for approved genuinely public content |
| Login/session flows | Dynamic; no credential/session response caching |
| Own dashboard and Money | Authenticated dynamic reads, private/no-store handling |
| User profiles/posts | Current viewer authorization; conservative no-store initially |
| Private media/export | Reauthorizing delivery; no public optimizer/CDN caching |
| Public metadata | Only approved public snapshot fields after current eligibility checks |

Next.js data, route, fetch, client-router, and image caches must be configured deliberately against the selected version. Do not rely on changing framework defaults or assume a server-rendered page is private automatically.

### Required safeguards

- Never put personalized data in a global cached function or shared static page.
- Keep query clients/dehydrated data request- and user-scoped; serialize only fields needed for that authorized view.
- Do not place private records in public HTML, JSON-LD, metadata, preload data, or hidden CSS elements.
- Private card images must not pass through a publicly cacheable image optimizer simply because `next/image` is convenient.
- Default image delivery follows the backend private-media policy; use an explicitly safe authenticated path where needed.
- Public → private changes must affect new online reads immediately through authoritative policy, not merely a future revalidation timer.
- Handle logout/account changes and browser back/forward restoration with explicit cache clearing and session revalidation before showing sensitive restored content.
- No-store headers do not erase screenshots, previously delivered data, or every browser history snapshot. State the recall boundary honestly.

## 11. Responsive layout and accessibility

Follow the [Your Own design system, component inventory, and light/dark themes](cookbook/design-system.md). Provide System / Light / Dark with a persisted origin-local preference, explicit choice taking precedence, matching native `color-scheme`, and first-paint/hydration agreement. Theme all controls, overlays, charts, and states; preserve drafts, timers, focus, and privacy on appearance changes. Poster pixels retain their chosen/versioned appearance. Exact token values and font assets still require validation.

Use CSS viewport/container constraints, not device names. Initial classes align conceptually with Flutter but use **CSS pixels**:

| Class | Width | Behavior |
|---|---|---|
| Small | Below 600 | One primary pane, compact navigation, stacked forms |
| Medium | 600 to below 840 | Roomier grids, rail where usable |
| Large | 840 to below 1200 | Sidebar and suitable list/detail panes |
| Largest | 1200+ | Bounded multi-column workspace; readable feed/form columns |

- Constrain ordinary forms around the proposed 640 px and feed/text around 720 px, refined through testing.
- Derive book/dashboard grid columns from useful minimum widths.
- Collapse panes when large text, zoom, or limited height makes them unusable.
- Support 320 px baseline, tablet split-screen, landscape, large desktop, touch, pointer, and keyboard.
- Preserve editor/message input and selected records across resize; no duplicate submissions or restarted timers.
- Keyboard-visible mobile browsers must retain reachable Save/Send/timer controls.
- Use semantic landmarks/headings, visible focus, skip links, labels, error association, and meaningful dialog focus restoration.
- Meet applicable WCAG 2.2 AA expectations; test 200% text/zoom and reflow at higher zoom where applicable.
- Primary interactive controls target at least 48 x 48 CSS pixels where appropriate to the shared design.
- Charts and heatmaps need text summaries; color alone is insufficient.
- Reduced motion, screen-reader timer behavior, and localized long text are tested.
- Intentional chart/table scrolling is allowed; accidental whole-page overflow is not.

## 12. Public pages and app links

### Product and policy pages

Explain the four modes, private-by-default tracking, progress-only publishing, no-video/finite-feed approach, and actual platform availability. Use approved screenshots/copy only; no fake usage statistics or unimplemented feature claims.

Provide current privacy/terms versions, support contact, and account-deletion guidance consistent with real backend behavior. Marketing/consent analytics require separate approval.

### Shared profile/post pages

- Resolve the current viewer and request a backend-authorized projection.
- For a private card, show generic login/follow/access guidance without its title, metrics, thumbnail, or comments.
- A link never grants access by itself.
- Suspended/deleted/restricted content has a neutral unavailable state.
- Anonymous public rendering is still an open product decision. Until approved, links may require authentication and should not leak details to bots.
- Proposed default: user-generated profiles/posts are not search-indexed initially; marketing pages may be indexed. Robots directives are not access control.
- Open Graph/metadata generation uses the same eligibility rules; private links get generic metadata.
- Public metadata can remain in third-party caches after later privatization; disclose that limitation before sensitive public sharing.

### Mobile app linking

Serve approved App Links/Universal Links association files once domains and bundle/application IDs are confirmed. Open the app where supported and provide a usable browser fallback; do not trap users in repeated automatic redirects.

## 13. Account onboarding and settings

[Decision 0003](cookbook/decisions/0003-product-defaults.md) supplies shared product defaults when these browser features ship: account-required tracking without guest mode, private signup, followers-only new publication drafts, Today landing/selected modes, mL/US-fluid-ounce preferences, restricted historical Focus editing, one currency locked after monetary records and independent savings. The English-first Android pilot does not promise bilingual browser delivery; follow approved language coverage rather than inferring it from sample copy.

- Signup/login/recovery follows the approved identity adapter.
- Collect username/display name, visibility choice, mode selection, units/timezone, and base currency if Money is enabled.
- Avatar/bio/goals/notifications are optional.
- Explain discoverable profile fields separately from private trackers.
- Hiding a mode changes navigation, not historical records.
- Settings cover profile visibility, followers/blocks, DM permissions, units, targets, notification preferences, amount hiding, export/deletion, and support.
- Confirm audience widening and destructive actions explicitly.
- Export/deletion shows requested/preparing/ready/failed or processing states from the backend; a click is not immediate completion.

## 14. Today and personal navigation

Today composes the same private summary data as mobile:
- Today's tasks and start/resume focus.
- Currently reading books with page update.
- Water/coffee quick logging.
- Money capture shortcut with amounts hidden by default on this shared surface.
- Compact personal progress and optional recap entry.

Quick capture provides immediate interaction feedback, but server acceptance determines persistence in the online-first web design. Do not show "saved" before a successful acknowledged write.

A dashboard refresh must not clear active form input. More space adds useful grouping/panes rather than giant controls or another feed.

## 15. Focus in the browser

### Tasks

Support the PRD task fields, Today placement, due-date views, labels, completion/reopening, edit/delete, and optional session linkage. No project boards/dependencies in initial scope.

Use semantic forms and shortcuts that do not override browser/screen-reader controls. Enter-to-submit behavior must be explicit and must not duplicate saves.

### Timer

- Countdown/Pomodoro and count-up use the shared backend session identity/state machine.
- Display derives from timing state, not assumed reliable `setInterval` ticks.
- Hidden tabs, suspended devices, browser throttling, system clock changes, and reloads must be handled.
- A countdown stops at its intended end, not when the tab wakes hours later.
- Count-up elapsed time remains self-reported, not verified attention.
- Pause/resume/finalize/discard use idempotent server actions and exclude pauses/breaks.
- Editable defaults are 25-minute focus, 5-minute short break and 15-minute long break after four focus intervals; breaks/next intervals do not auto-start in V1.
- No manual historical session creation or duration edits; task/label/private-note correction and deletion remain supported.
- A browser tab and mobile device cannot silently create two authoritative online timers.
- BroadcastChannel or supported browser coordination may improve multi-tab behavior, but the server remains the authority. Never rely only on a localStorage lock.

A closed/suspended browser cannot guarantee a completion alert. Optional browser notifications/sound are best-effort, permission-controlled, and explained; mobile remains the stronger background-reminder experience.

## 16. Reading

- Manual book creation/edit/removal, shelves, current-page updates, completion confirmation, goals/history.
- Large layouts support book grid/list with detail alongside it.
- Unknown page totals remain unknown.
- Page deltas/history are computed by the backend, not trusted client arithmetic.
- Concurrent mobile/web updates produce a clear revision conflict with retained input.
- Private notes stay out of profile/preview metadata and cards unless deliberately selected.
- No external book catalog is required for basic use.

## 17. Intake

- Water quick amounts/custom positive amounts, user target, dated history, corrections/deletions.
- Supported display/input units use the agreed canonical conversion rules.
- Coffee cups/shots remain separate; no caffeine or hydration equivalence invented by the web UI.
- Target changes have effective dates; the browser does not rewrite history.
- Avoid unlimited reward visuals for exceeding a water goal.
- Browser reminders are optional enhancements, not an assumed replacement for Flutter's device-local schedule.

## 18. Money

- Account create/opening balance, rename/archive, eligible deletion, and explicit balance adjustment.
- Income, expense, and atomic transfer capture with safe category/account selection and history filters.
- Monthly budgets/planned savings, plan reviews, savings-goal entries, and summaries.
- Exact amount strings/minor units end to end. Do not parse ledger values through ordinary JavaScript Number arithmetic.
- Formatting/input uses currency metadata and locale without silently changing value.
- Transfers are not two separate browser requests; plans/contributions do not move money.
- Amount hiding applies to visible text, expanded panels, accessibility labels, and previews.
- No bulk arbitrary editing, bank integration, or financial recommendations.
- Conflicts preserve entered data and require resolution; do not last-write-win a changed amount/account.
- Savings progress remains separate from account assets under the PRD's proposed model.

**Acceptance:** Logging a transfer on web preserves combined balance and syncs to mobile once; retry after an uncertain response does not duplicate it.

## 19. Progress calendars and cards

### Personal progress

Use backend structured daily summaries with per-mode filters and accessible day detail. Apply the same contribution/goal/date meanings as mobile, not a separate web score.

Annual calendars adapt through readable period views or deliberate scrolling. Deleting/correcting a source refreshes the relevant summaries.

### Card creation

- Choose supported source, period, selected fields, template, caption, and audience.
- Require accepted sources for canonical publication.
- Show preparation/render/error states and the exact server-generated snapshot before explicit confirmation.
- Default Money amounts and task/private notes remain excluded.
- No arbitrary image/video/freeform status upload path.
- Existing posts are snapshots; corrections/regeneration require the PRD's explicit flow.
- Export only own cards through supported backend-authorized files.

Use Web Share/file-sharing APIs only when supported and allowed by user gesture; provide download/copy-link fallback. Export size is template-defined, not viewport-defined. External copies cannot be recalled.

## 20. Profiles, feed, and interactions

- Public/private account behavior, requests, removal, blocking, and per-post audience follow backend policy.
- Account visibility does not expose raw trackers.
- Feed is following-based, chronological, finite, with explicit Load Older and a truthful caught-up marker.
- New items do not move the current reading position automatically.
- Likes use desired state, comments use the permitted reply depth, and edits/deletions/reporting respect authorization.
- Shares use authorized links/card references; reposts preserve source attribution and eligibility.
- Hidden source cards never survive through stale UI counters/previews/reposts.
- Clear affected client data on known access revocation; revalidate sensitive views after resume/reconnect.
- No infinite scrolling, autoplay, engagement ranking, or social contributions to personal heatmaps.

## 21. Messaging and notifications

### Messaging

- Requests, accepted conversations, text/card references, unread state, pending/failed/retry indicators.
- Send through the canonical backend mutation with a stable client message ID.
- Server sequence/history determines ordering; socket events are not guaranteed delivery.
- Private card references reauthorize at view time; recipients do not gain rights merely by receiving a reference.
- Request decline, block, and report are explicit authorized actions.
- No arbitrary attachments/calls/groups/read receipts in initial scope.

### Browser realtime with server-side credentials

Do not expose a long-lived provider access token just to connect Socket.IO if the session architecture keeps credentials server-side.

Proposed integration: the authenticated BFF obtains a short-lived, audience-scoped realtime connection ticket from NestJS. The browser keeps only that temporary ticket in memory; the backend verifies scope/expiry/replay policy and revalidates continuing access. A compatible secure reverse-proxy arrangement is an alternative, requiring review.

This ticket capability is a backend dependency, not an already implemented endpoint. Do not put credentials/tickets in URLs or analytics.

### Notifications

In-app notifications are the baseline. Browser push requires a separately approved service-worker/permission/support plan; it is not automatically included because mobile uses FCM.

Default alerts/previews contain no financial amounts or message bodies. Foreground sound/desktop alerts are optional, quiet-hours aware, and never permission-gated prerequisites for tracking.

## 22. State, drafts, and connectivity

### State ownership

- NestJS owns accepted records and permissions.
- TanStack Query manages interactive server projections with user-scoped keys.
- URL state holds approved non-sensitive navigation/filter selections.
- Local component/form state holds edits; shared stores are added only where justified.

### Proposed web connectivity boundary

Initial web is **online-first**, unlike Flutter's proposed local-first database/outbox.

- Preserve in-memory input and show connection failure clearly.
- No indefinite offline replay of finance/social mutations.
- Network-unknown writes retain operation identity for safe retry/recovery.
- A minimal non-secret operation ID may be retained in session-scoped storage if approved; never use it as authorization or persist full sensitive payloads casually.
- Sensitive persistent browser drafts, IndexedDB synchronization, and PWA offline caching require a later threat model and explicit scope.
- No service worker may cache authenticated HTML/API responses/private media by default.
- A timer can display locally while disconnected, but server coordination/finalization remains unresolved until acknowledged; explain the limitation.

Cross-tab logout/account change must clear session-bound state, close realtime, and prevent stale data from another account resurfacing through navigation/history restoration.

## 23. Privacy, security, and data controls

- Server-only tokens/secrets, host-only secure cookies, approved CSRF strategy, safe redirects.
- No domain database credentials or provider service-role key in either server-rendered props or browser bundles.
- NestJS enforces every permission; frontend route protection is not sufficient.
- Render user text as untrusted content; no unsanitized HTML or arbitrary iframe embedding.
- Use a restrictive reviewed CSP and approved asset/connect sources without breaking required scripts/realtime.
- Restrict upload formats/size and use backend-issued upload permissions.
- Avoid third-party trackers/session replay on private screens; never capture input values by default.
- No broad page prefetch or analytics snapshot that serializes private details into a public context.
- Export/deletion flows require appropriate reauthentication and truthful status/retention messaging.
- Account-switch, back-button, private-media, metadata, and cache behavior are release-critical security tests.

## 24. Performance and observability

- Keep public landing pages lightweight; do not ship every tracker/chart/editor bundle to the homepage.
- Lazy-load heavy private features without making common logging slow.
- Use bounded tables/lists, appropriate image sizes, and selective query invalidation.
- Profile production builds on representative mobile/tablet/desktop browsers.
- Measure public Core Web Vitals and authenticated interaction/network latency separately; set numerical targets after baseline tests.
- Report redacted technical errors, route performance, failed mutations, and realtime recovery.
- Exclude balances, notes, message text, private query terms, and unpublished cards from logs/telemetry.
- Do not measure success by maximum feed session length.

## 25. Testing and acceptance criteria

### Test coverage

- Pure formatting/exact-amount/date helpers and form validation.
- Component loading/empty/error/conflict/unavailable states.
- Generated API contract fixtures and browser-session/CSRF behavior.
- Playwright journeys across agreed Chromium, Firefox, and WebKit/Safari baselines.
- Responsive widths 320, typical phone/tablet, boundary pairs 599/600, 839/840, 1199/1200, and large desktop.
- Touch/pointer/keyboard, portrait/landscape, 200% text/zoom, narrow reflow, keyboard-open forms.
- Reload/background/tab throttling, two tabs, mobile+web concurrent changes, expired session, interrupted requests.
- SSR/RSC/metadata/image-cache privacy, logout/account switch, browser back/forward, private link access, source revocation.
- Real Safari/iPad checks for browser-specific timers, keyboards, sharing, and app links where available.

| ID | Required proof |
|---|---|
| WEB-01 | Private trackers work without posting/following anyone |
| WEB-02 | Public/profile/card pages expose only current viewer-authorized fields, including HTML/metadata |
| WEB-03 | Cookie sessions resist cross-origin mutation and do not leak provider tokens to client storage |
| WEB-04 | A lost-response retry creates one accepted task/log/transfer/post/message effect |
| WEB-05 | Web edits appear in mobile sync with the same revisions and calculations |
| WEB-06 | Money amounts remain exact; transfers/savings never create duplicate assets |
| WEB-07 | Browser timer survives ordinary reflow/reload and does not double-run across tabs/devices |
| WEB-08 | All primary features remain usable across four size classes and accessibility checks |
| WEB-09 | Feed remains finite/chronological with no engagement-driven reordering |
| WEB-10 | Private post revocation applies to detail, feed, metadata, images, reposts, and DM previews |
| WEB-11 | Logout/account change/back-forward restoration does not expose another user's cached content |
| WEB-12 | Poster publication shows the exact canonical privacy preview and requires explicit confirmation |
| WEB-13 | Messaging retries/order/blocking work without assuming reliable sockets |
| WEB-14 | Export/deletion and unsupported browser capabilities show truthful, recoverable states |

No application tests have been run by creating this document; these are implementation acceptance requirements.

## 26. Delivery and deployment

- Separate `apps/web` and `apps/admin` builds/deployments, with shared packages only where appropriate.
- Development/staging/production domains, session secrets, origins, provider configuration, and API endpoints are isolated.
- Next.js server hosting must support the selected session/BFF runtime; static export alone is insufficient for that design.
- NestJS owns persistent sockets/workers. Hosting Next.js on serverless infrastructure does not move those responsibilities into functions.
- Configure CSP/cookies/headers, private cache rules, API connectivity, media delivery, association files, and environment markers explicitly.
- CI runs frozen installs, formatting/lint/type checks, unit/component tests, contract generation checks, production build, Playwright/security/adaptive tests, and dependency/secret review.
- Deploy through staging; coordinate API compatibility and session changes without requiring instant mobile upgrades.
- No exact hosting vendor, Next.js version, DNS names, or release date is selected here.

## 27. Backend dependencies and open decisions

### Required backend capabilities

- Identity/profile and browser-session-compatible token verification.
- Existing personal/social REST contracts and consistent personal change-stream mutations.
- Safe idempotency receipts/recovery, revisions, and cursor pagination.
- Canonical card preparation, explicit publication, reauthorizing media delivery.
- Minimal public/anonymous projections if that policy is approved.
- Realtime ticket/proxy integration consistent with server-side browser credentials.
- Export/deletion/reporting endpoints and operational admin readiness.

### Decisions before implementation

1. Decision 0004 accepts App Router/React, TypeScript, Tailwind, query/form and owned-component directions; validate and approve exact compatible pins, remaining primitives/testing tools and icon distribution notices. Resolve ApexCharts entitlement before installation/integration.
2. Approve identity/session library, secure session store, CSRF protocol, and logout behavior.
3. Confirm public URL/domain structure, association files, anonymous rendering, metadata, and indexing defaults.
4. Confirm online-first web scope, draft retention, timer limitations, browser baseline, and optional notifications.
5. W0–W3 sequencing is accepted in Decision 0001; approve concrete release scope, availability labels, dates and any deliberate parity deferral before shipping.
6. Approve hosting, exact performance budgets, analytics/consent, policy content ownership, and support process.

## 28. Website readiness definition

A web stage is ready when its declared browser features are useful and accessible across sizes, accepted changes share the same backend truth as mobile, private data cannot escape through rendering/caching/metadata, and users understand the actual browser limitations.

**Next.js delivers the web experience. NestJS remains the authority for records, money, and permissions.**
