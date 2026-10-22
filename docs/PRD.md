# Your Own — Product Requirements Document

- **Version:** 0.5
- **Status:** Draft for product review
- **Product:** Your Own
- **Technical stack:** Flutter mobile, NestJS backend, and Next.js for the user website and separate admin CMS are confirmed; remaining choices pending approval
- **Engineering overview:** [System architecture and cross-cutting documents](cookbook/architecture.md)
- **Related specifications:**
  - [Flutter mobile](MOBILE_TECH_SPEC.md)
  - [NestJS backend](BACKEND_TECH_SPEC.md)
  - [Next.js user website](WEB_PRD.md)
  - [Next.js admin CMS](ADMIN_CMS_PRD.md)

> Track the life you are building. Share the parts you choose. Then get back to living it.

### Quick navigation

- [Product summary](#2-product-summary) and [confirmed direction](#3-confirmed-direction-and-draft-assumptions)
- [Release scope](#7-release-scope-and-staging) and [navigation](#8-information-architecture)
- [Focus](#11-focus-mode), [Read](#12-read-mode), [Intake](#13-intake-mode), [Money](#14-money-mode)
- [Progress calendars](#15-shared-progress-and-contribution-calendars) and [progress cards](#16-progress-cards-and-publishing)
- [Profiles and privacy](#17-profiles-following-and-visibility), [feed](#18-feed-and-engagement), [sharing/reposts](#19-sharing-and-reposting), [DMs](#20-direct-messaging)
- [Safety](#22-safety-moderation-and-account-controls), [data control](#23-data-control-and-privacy-lifecycle), [quality requirements](#24-accessibility-reliability-and-experience-requirements)
- [User journeys](#25-primary-end-to-end-journeys), [acceptance gates](#26-release-acceptance-gates), [success measures](#27-success-measures)
- [Existing apps](#28-existing-application-review), [open decisions](#30-decisions-to-resolve-before-implementation-or-launch), [future roadmap](#31-future-roadmap--explicitly-outside-v1)

## 1. Document purpose

This PRD defines the product vision, detailed functional requirements, privacy rules, release boundaries, and acceptance criteria for Your Own.

It describes the intended full first version, including four tracking modes and the agreed social interaction model. Delivery is staged; features assigned to a later V1 stage are not silently removed from the full V1 scope.

**Requirement language:**
- **Must:** Required for the release stage identified in this document.
- **Should:** Recommended, subject to scope review.
- **Later:** Explicitly outside V1.
- **Proposed:** A product default suggested in this draft, not an already approved decision.

Flutter is confirmed for mobile, NestJS for the backend, and Next.js for two separate web applications: the user website and the admin CMS. API conventions, database, hosting, supporting libraries, mobile state management, and detailed architecture recommendations remain subject to approval.

## 2. Product summary

Your Own is a personal progress application with a social layer. Users organize everyday activities into four modes:

1. **Focus:** Tasks, focused work, study, and timers.
2. **Read:** Bookshelves, reading progress, and finished books.
3. **Intake:** Water and coffee logging.
4. **Money:** Manual financial tracking, budgets, and savings goals.

A shared dashboard and GitHub-style contribution calendars help users understand their activity over time. Users can optionally publish generated progress cards, interact through Instagram-like social mechanics, and message one another.

Unlike a general social network, the public posting format is restricted to progress-related cards derived from the user's records or plans. There are no videos, reels, unrelated image posts, or standalone status posts.

The defining product loop is:

**Do → Track → Review → Optionally share → Encourage others → Return to life.**

## 3. Confirmed direction and draft assumptions

### 3.1 Confirmed through discussion

- Product name: **Your Own**.
- Mobile framework: **Flutter**.
- Backend framework: **NestJS**.
- User-facing website framework: **Next.js**.
- Separate internal admin CMS framework: **Next.js**, using the same NestJS backend rather than a second domain backend.
- Adaptive phone and tablet layouts are required across **Small, Medium, Large, and Largest** window sizes, including large iPads.
- Visual direction follows the standalone [Your Own design system](cookbook/design-system.md); dark mode and System / Light / Dark appearance controls are required. Exact rendered tokens/assets still need validation.
- Four initial modes: **Focus, Read, Intake, Money**.
- Focus includes lightweight task management, not only a timer.
- Intake groups water and coffee; meals are a possible future expansion.
- Money includes manual tracking, finance plans, savings, and cash/account records.
- Money does not connect to banks, execute payments, or move actual funds.
- Contribution-style progress visualization is a signature feature.
- Social publishing uses generated progress posters/cards.
- No video or reels.
- Social features include likes, comments, sharing, reposts, DMs, and public/private accounts.
- The product must avoid encouraging doomscrolling.
- Training, games, and additional trackers are future possibilities.

### 3.2 Proposed in this draft

- Mobile-first rollout; launch platform order remains open. The Flutter design must support phones and tablets, including iPad, rather than assuming phone-only use.
- Personal dashboard as the default landing screen.
- One account for all modes; users can hide modes they do not use.
- Optional per-post followers-only visibility for public accounts.
- One-to-one text and progress-card DMs only in V1.
- One base currency per user in V1.
- No named group/circle management in V1; following and approved followers provide the initial social graph.
- English and Indonesian are localization candidates; launch language coverage needs approval.

## 4. Problem and opportunity

People often spread personal tracking across unrelated apps. This fragments their history and makes everyday progress hard to recognize.

Existing social platforms make sharing easy but reward attention, polished lifestyles, and endless consumption. People need a way to share meaningful progress without turning daily life into content production or a competition.

Your Own should provide:
- Fast, specialized logging in one coherent product.
- A visible history of personal consistency.
- Optional accountability and encouragement.
- Familiar social interactions with natural stopping points.
- A useful private experience even for people who never post.

## 5. Goals, non-goals, and principles

### 5.1 Product goals

- Make common logging actions quick enough to fit into real life.
- Help users see meaningful progress across their chosen modes.
- Support small steps, flexible goals, rest, setbacks, and restarting.
- Make sharing selective, understandable, and privacy-safe.
- Give friends a useful way to encourage each other.
- Deliver value without requiring a large follower network.

### 5.2 V1 non-goals

- A general-purpose social network or creator platform.
- A full project-management suite.
- Banking, payments, investment advice, or financial-account aggregation.
- Medical guidance, nutrition prescriptions, or competitive consumption targets.
- GPS fitness tracking, workout programming, or a Strava replacement.
- Recipes, meal planning, or calorie/macro tracking.
- Games, a virtual economy, or productivity leaderboards.
- A universal custom-tracker builder.
- An enterprise/team workspace.

### 5.3 Product principles

1. **Personal utility first:** Social participation is optional.
2. **Share progress, not noise:** Posts must have a supported progress or plan source.
3. **Privacy before aesthetics:** A beautiful poster must never expose an unexpected detail.
4. **More is not always better:** Spending, caffeine, and water are not unlimited achievement scores.
5. **Personal context over comparison:** No global ranking of wealth, productivity, or consumption.
6. **Natural stopping points:** Success is not measured by time spent scrolling.
7. **Low-friction capture:** Routine logging should not require composing content.
8. **Honest records:** User-entered activity is self-reported, not verified proof.

## 6. Target users and jobs to be done

### 6.1 Initial audience

- Students balancing study, reading, and daily routines.
- Individuals managing personal work, projects, and money.
- Readers who want a bookshelf and visible reading history.
- Friends or partners who want lightweight mutual accountability.
- Private users who want tracking without public participation.

### 6.2 Core jobs

- "Help me decide what to work on and record focused time."
- "Help me keep track of what I read and where I stopped."
- "Let me log water or coffee without navigating through several screens."
- "Help me understand my spending and plan for a savings goal."
- "Show me that small efforts are adding up."
- "Let me share an update without exposing all of my private records."
- "Let me support a friend without getting pulled into an endless feed."

## 7. Release scope and staging

The **full V1** includes every required capability below. Staging is an implementation and validation sequence, not a change to the agreed product vision.

| Stage | Scope | Exit condition |
|---|---|---|
| **V1-A: Personal foundation** | Accounts, onboarding, four tracking modes, Today, progress views, private card previews/exports, core data controls | Users can complete the principal private tracking journeys reliably |
| **V1-B: Social publishing** | Profiles, public/private accounts, follows/requests, progress posts, chronological feed, likes, comments, sharing, notifications, blocking/reporting | Sharing and interaction respect all audience and safety rules |
| **V1-C: Social completion** | Reposts, one-to-one DMs, message requests, messaging safety controls | Full V1 social scope passes privacy, abuse, and delivery acceptance tests |

If an earlier stage is released to testers, it must be described as a limited release rather than a completed full V1.

### 7.1 Scope matrix

| Area | Required in full V1 | Outside V1 |
|---|---|---|
| Focus | Tasks, Today list, labels, countdown/Pomodoro, count-up timer, history | Projects, dependencies, team assignments, complex recurrence |
| Read | Manual books, shelves, page progress, history, simple goals | Book clubs, highlights, automatic catalog integrations, reading timer |
| Intake | Water, coffee, history, water target | Meals, recipes, nutrition, automatic caffeine calculations |
| Money | Manual accounts, transactions, budgets, savings goals, summaries | Bank sync, investments, loans/debt engines, recurring transactions, FX |
| Progress | Overall and per-mode calendars, summaries, optional goals | Global scores, competitive leaderboards |
| Publishing | Activity, milestone, plan, and recap cards; attached reflections | Freeform posts, video, unrelated media, full graphic editor |
| Social | Public/private profiles, follows, likes, comments, shares, reposts | Algorithmic discovery, trending feeds, creator monetization |
| Messaging | One-to-one text and progress-card messages | Groups, calls, voice/video, arbitrary attachments |
| Expansion | None required | Training, couple games, shared challenges, custom trackers |

"Outside V1" is not a promise to add a feature later. Videos/reels, unrelated feed content, and competitive consumption/wealth rankings conflict with the current product direction and are not on the roadmap.

### 7.2 Web and admin rollout

Next.js user web and admin CMS are separate applications with separate access/session boundaries, sharing the NestJS domain authority. Public product/marketing pages may live within the user website; a third web application is not required.

The user website's W0–W3 stages are defined in [WEB_PRD.md](WEB_PRD.md). They do not require complete browser parity on the mobile launch date. Browser offline/background behavior must be stated explicitly rather than assumed identical to Flutter.

The admin A0 safety/moderation capability defined in [ADMIN_CMS_PRD.md](ADMIN_CMS_PRD.md) must exist before public social launch, even if the full user website ships later. Initial CMS scope means operational administration; editorial publishing/configuration extensions need separate approval and must not expose raw private tracking data.

## 8. Information architecture

### 8.1 Primary destinations

**Proposed navigation:**
- **Today:** Personal dashboard, tasks, active reading, quick logs, start/resume focus.
- **Progress:** Overall calendar, per-mode history, goals, summaries.
- **Circle:** Following feed, social activity, access to people search.
- **You:** Profile, published cards, account controls, settings.

Messaging must have a clearly visible entry point and unread state. Its exact placement is a design decision, not a requirement for a fifth navigation tab.

"Circle" is a proposed label for the social destination; it does not imply group-chat or named-circle functionality in V1.

Primary navigation must adapt to available window space: bottom navigation on compact layouts, with a navigation rail or sidebar on wider layouts where appropriate. Destinations, permissions, and user state must remain consistent across layout changes. See NFR-07 and NFR-08.

### 8.2 Mode access

- Each mode must have a dedicated overview and detailed history.
- Today must expose common actions without requiring entry into a mode.
- Users can hide unused modes from their dashboard without deleting their data.
- Restoring a hidden mode restores access to its existing records.
- "Mode" is an organizational label; entering a mode must not disable other tracking.

## 9. Account, onboarding, and settings

### ACC-01 — Account lifecycle

Users must be able to create an account, authenticate, sign out, recover access, and request account deletion. Authentication methods are selected during technical planning.

Tracking must not require following anyone or publishing a post. Guest use is an open decision, not a V1 assumption.

### ACC-02 — Onboarding

Onboarding must collect only what is necessary:
- Unique username and display name.
- Initial public/private account choice, explained before confirmation.
- Preferred timezone and units, with sensible device-derived suggestions.
- Base currency if Money is enabled.
- Selected modes; no requirement to enable all four.

Goals, avatar, bio, and notification permission requests are optional. Permission prompts should appear in context, not as a wall of requests during signup.

### ACC-03 — Settings

Users must be able to manage:
- Profile details and account visibility.
- Mode visibility.
- Appearance: System / Light / Dark, with a persisted local preference.
- Water units and default quick-add amounts.
- Timezone, date/number formatting, language where supported.
- Reminder and social-notification preferences.
- DM permissions and blocked accounts.
- Data export, account deletion, and support/report access.

**Acceptance:** A new user can reach a usable private dashboard without adding friends, setting every goal, or granting notifications.

## 10. Today dashboard

### DAY-01 — Personal landing screen

Today must prioritize actions and personal context over social content:
- Date and compact progress overview.
- Today's unfinished tasks.
- Start/resume focus and current timer state.
- Currently reading book(s) with quick page update.
- Water quick-add and current total against the optional target.
- Coffee quick-add.
- Money transaction shortcut; financial totals hidden by default on shared-screen surfaces.

### DAY-02 — Quick capture

Common repeated actions, such as adding a saved water amount, should need no more than two interactions from an already open Today screen, excluding necessary confirmation or correction.

Quick actions must provide immediate feedback and an easy correction/undo path. Retrying after a connection failure must not create duplicate records.

### DAY-03 — Optional daily recap

Users should be able to open a private summary of the day and choose whether to turn selected items into a recap card. No automatic social publishing.

## 11. Focus mode

### FOC-01 — Lightweight tasks

Users must be able to:
- Create a task with a required title.
- Add an optional note, due date, and label.
- Edit, complete, reopen, and delete a task.
- Add or remove a task from Today independently of its due date.
- View Today, upcoming, overdue, and completed tasks.

Labels should support Work, Study, Personal, and user-created labels. A label is not a separate project-management system.

Completing a task does not require a timer. Starting a timer does not require a task.

### FOC-02 — Focus timers

V1 must support:
- Pomodoro-style countdown sessions.
- A count-up focus timer.
- Editable focus and break durations.
- Start, pause, resume, finish early, and cancel.
- Optional task and label association.
- A clear distinction between focus and break time.
- Optional completion notification/sound.

**Proposed defaults:** 25-minute focus, 5-minute short break, 15-minute long break after four completed focus intervals. Breaks and subsequent intervals must not start without an explicit user action in V1.

Only one authoritative active focus timer is allowed per account. Online attempts to start another must offer to resume or end the existing session. If temporarily offline devices create conflicting sessions, surface the conflict during reconciliation; never silently count overlapping time twice. Exact reconciliation behavior is finalized during technical planning.

### FOC-03 — Session recording and history

- Record actual focused time, excluding pauses and breaks.
- A normally completed timer records a completed session.
- Finishing early lets the user save an interrupted session or discard it.
- Cancel/discard must not create completed focus time.
- Restore the active timer state after ordinary app backgrounding or restart.
- Show a clear resolution path if the active state conflicts across devices.
- Session history includes date, duration, status, task/label where present, and an optional private note.
- Users can correct a session's label/task, or delete an incorrect session.

V1 does not require manual creation of historical focus sessions. Whether duration corrections are allowed is an open decision; edits must never be presented as verified timer output.

### FOC-04 — Focus summaries

Show focused minutes, completed sessions, and completed tasks for day/week/month. Keep these measures distinct; do not combine them into a universal productivity score.

Users should be able to set an optional daily focused-time target and select the weekdays on which it applies.

Task titles and notes must be excluded from share cards by default. Users may explicitly include selected titles after previewing them.

**Acceptance:** Completing two 25-minute sessions produces 50 focused minutes, not 60 minutes including breaks. A deleted session updates private totals and contribution history.

## 12. Read mode

### READ-01 — Bookshelf

Users must be able to add a book manually with:
- Title, required.
- Author, optional.
- Total pages, optional.
- Status: Want to Read, Reading, Finished; an optional Paused status is proposed.
- Optional start/finish dates and private notes.

Users must be able to edit book details, change status, and remove a book. Removing a book with progress history requires confirmation and must explain the effect on totals and any existing published snapshots.

V1 must work without an external book catalog. Placeholder covers are acceptable. Any later catalog or cover integration requires separate feasibility and licensing review.

### READ-02 — Progress updates

- Users can record their current page with an activity date.
- The app derives pages advanced from the previous valid progress state.
- Prevent negative page values and pages beyond a known total.
- A book can be marked finished even without a known total page count.
- An unknown total must not produce a fabricated percentage.
- Corrections and deleted entries must recalculate affected progress and summaries.
- Moving a book to Finished prompts the user to confirm completion, rather than silently treating an accidental page update as a social milestone.

V1 supports one reading history per book entry. Re-reading editions and multiple reading cycles are later enhancements; users may create a separate entry if needed.

### READ-03 — Reading goals and history

- Show active books, books finished, pages advanced, and active reading days.
- Support an optional weekly reading-days goal and annual finished-books goal.
- Goals must be editable and optional.
- Reading notes remain private unless specifically included in a card caption.

**Acceptance:** Moving from page 40 to page 58 records 18 pages advanced. Correcting a mistaken update must not leave inflated totals or duplicate a finished-book milestone.

## 13. Intake mode

### INT-01 — Water

Users must be able to:
- Log a configurable quick-add amount or a custom positive amount.
- Choose milliliters or supported fluid-ounce display units.
- Set an optional personal daily target.
- Edit amount/time and delete an entry.
- View daily totals, history, and days meeting their own target.

Unit conversion must not repeatedly round or inflate stored totals. The app must explain which ounce unit is supported.

Targets are user-defined tracking preferences, not medical prescriptions. Exceeding a target must not generate escalating rewards, rankings, or prompts to drink more.

### INT-02 — Coffee

Users must be able to:
- Record an entry as cups or espresso shots, with a positive count.
- Record a time and optional short note.
- Edit or delete entries.
- View cups and shots separately in daily and weekly history.

Do not treat one cup as equivalent to one espresso shot, infer caffeine content without reliable inputs, or count coffee toward a water target in V1.

### INT-03 — Reminders

- Optional water reminders with user-selected active hours and frequency.
- Easy pause/disable controls.
- No guilt-based copy or escalating notifications.
- No coffee-consumption reminder by default.

### INT-04 — Intake sharing

Individual glass/coffee logs remain private records by default. Share templates prioritize daily/weekly summaries and user-chosen milestones rather than encouraging a post for every drink.

**Acceptance:** Editing a 250 ml entry to 200 ml immediately reduces the day's total by 50 ml. Coffee entries never inflate hydration-goal completion.

## 14. Money mode

### 14.1 Product boundary

Money is a manual record and planning tool. It is not a bank, payment service, authoritative account statement, investment adviser, or guarantee of financial outcomes.

Displayed balances reflect what users enter. Users must be able to correct missed or inaccurate records.

### MON-01 — Wallets/accounts

Users must be able to:
- Create named records for Cash, Bank, E-wallet, or Other.
- Enter an opening balance and effective date.
- View current recorded balance and account-specific history.
- Rename or archive an account.
- Delete an empty account; accounts with transaction history should be archived rather than orphaning records.
- Record an explicit balance adjustment when reconciling with reality.

Opening balances and balance adjustments must be distinguished from ordinary income/expenses in reports.

V1 uses one user-selected base currency across all wallets. No exchange-rate conversion or multi-currency aggregation. Changing currency after records exist must not silently relabel historical amounts.

### MON-02 — Transactions

Support:
- Income: amount, account, date/time, category, optional note.
- Expense: amount, account, date/time, category, optional note.
- Transfer: source account, destination account, amount, date/time, optional note.
- Editing and deleting records, with balances and reports recalculated consistently.
- Filtering by date, account, category, and transaction type.
- Basic editable income/expense categories.

Rules:
- Entry amounts must be positive; direction comes from the transaction type.
- Transfers must not count as income, expense, or new savings by themselves.
- Transfers affect both accounts atomically; no half-completed transfer state.
- Transfer fees, when recorded, are separate expenses.
- Opening balances must not inflate monthly income.
- Amounts must remain exact to the supported currency precision.
- An expense that exceeds the recorded balance should warn the user but allow accurate logging of reality; it must not imply overdraft banking support.

### MON-03 — Finance plans / budgets

V1 must support one saved finance plan per month per user, with access to past plans:
- Select a month.
- Set an optional planned-income reference.
- Allocate monetary budgets by expense category.
- Optionally add planned savings allocations, separate from expense budgets.
- Compare category actual spending with its expense budget.
- Show planned spending, planned savings, and unallocated planned income when available.
- Display over-budget categories without shaming language.
- Copy a previous month's plan into a new draft, then confirm it.
- Explicitly mark a plan as reviewed, recording a private dated review event.

Planned savings must not become an expense or a completed savings contribution merely because it appears in a plan. Saving a plan never changes an account balance.

Percentage-based social cards may be derived from selected allocations, including savings. The denominator must be explicit: for example, share of total planned allocations or share of planned spending, not automatically share of actual income. If only a subset is shown, the card must explain whether the percentages represent that subset or the complete plan.

Percentage-only plan editing, multiple scenarios, budget rollover, and automatic recurring plans are later unless promoted through scope review.

### MON-04 — Savings goals

Users must be able to create a goal with:
- Name and target amount.
- Optional target date.
- Manually recorded contributions and withdrawals/corrections.
- Current recorded progress and contribution history.

**Proposed V1 model:** A savings goal is a separate planning ledger. Recording a contribution does not move money, change a wallet balance, or create an expense. If funds actually move between wallets, the user records a transfer separately.

The interface must explain this distinction. Savings-goal totals must not be added to account balances to calculate assets, and contributions must not imply that the app has reserved or verified the funds.

Goal withdrawals/corrections must not reduce recorded progress below zero. Progress may exceed the target, but reaching a target must not trigger automatic publishing.

Automatic wallet-linked earmarking and preventing the same real-world money from being assigned to multiple goals are later features. The manual model's limitations must be visible rather than disguised as verified savings.

### MON-05 — Overview and privacy controls

Show:
- Total recorded account balances, clearly labeled.
- Income and expenses for the selected period.
- Expense-category breakdown.
- Monthly budget status.
- Savings-goal progress, separate from account totals.

Provide a hide-amounts control for Money screens. Notification previews and Today should not reveal amounts by default.

### MON-06 — Shareable financial content

Supported cards:
- Monthly finance-plan allocation.
- Savings-goal milestone, optionally percentage-only.
- Selected monthly summary or reflection.

Default exclusions: account names, exact balances, transaction notes, counterparties, and individual transaction details. Exact amounts can be included only through explicit selection and preview.

A card about a plan must be labeled as a plan, not as actual spending or verified financial performance. User plans are personal examples, not personalized financial advice.

**Acceptance:** Starting with Rp500,000 in Cash and Rp1,000,000 in Bank, transferring Rp200,000 from Bank to Cash leaves the total at Rp1,500,000 and does not change income/expenses. Adding Rp200,000 to a savings-goal ledger does not increase that total either.

## 15. Shared progress and contribution calendars

### PROG-01 — Overall view

Provide a contribution-style calendar with:
- Day, month, and year navigation appropriate to the screen.
- A clear legend and accessible text alternative.
- A daily detail view listing contributing activities by mode.
- Per-mode filtering.
- Distinction between no record, a scheduled rest/non-goal day, and a missed goal where relevant.

**Proposed overall intensity rule:** Number of distinct modes with qualifying recorded activity that day, capped at four. Explicit calendar filters can narrow the view; hiding a mode from Today must not erase its historical contributions. Do not sum incomparable units such as pages, currency, water, and minutes.

The overall view means "activity recorded," not "health," "wealth," or "a successful life."

### PROG-02 — Qualifying activity

Proposed contribution rules:
- Focus: A saved session with positive focused time or a task completed that day.
- Read: Positive page progress or a confirmed book completion.
- Intake: At least one valid water or coffee record.
- Money: A valid transaction, savings-goal update, or explicitly recorded plan review.

Opening an app, viewing a screen, liking a post, reposting, or sending messages does not create personal-tracking contributions.

Editing the same record repeatedly must not inflate intensity. Deleting or correcting a qualifying record must update the relevant day. Coffee/money contributions indicate logging, not that more consumption/spending is desirable.

### PROG-03 — Mode-specific views

Each mode must preserve its meaningful metrics:
- Focus: Focused minutes, sessions, completed tasks.
- Read: Pages, active reading days, finished books.
- Intake: Water volume, optional target attainment, cups/shots separately.
- Money: Logging/review activity, income/expenses, budgets, savings progress.

Money-calendar intensity must not reward a larger spend or a larger balance. Intake-goal views must not reward exceeding a water target.

### PROG-04 — Goals and time boundaries

- Goals are optional and editable.
- Goal/target changes apply from a visible effective date; do not silently rewrite historical target attainment.
- Goals should support realistic schedules rather than assuming every activity happens every day.
- No permanent punishment for broken streaks; streaks must not be the primary product score.
- Use a clearly defined user timezone and preserve the intended activity date for historical records.
- Backdated manual entries are allowed where supported, and remain self-reported.
- Timer minutes crossing midnight should be apportioned to the relevant local days; a session count belongs to its completion day.
- Changing timezone must not unpredictably move all historical entries to different dates.

**Acceptance:** One coffee and five coffees can both mark an Intake logging day; the latter must not automatically represent five times the positive progress.

## 16. Progress cards and publishing

### CARD-01 — Supported card types

| Card type | Examples | Source requirement |
|---|---|---|
| Activity summary | Today's focus, reading update | Existing qualifying record(s) |
| Milestone | Finished book, savings target reached | Current source state supports the milestone |
| Plan | Monthly spending allocation | Saved plan, clearly identified as planned |
| Recap | Weekly reading or multi-mode summary | Selected period and included source records |
| Reflection | Restarting, a difficult week, adjusting a goal | Attached to a supported recap or plan; never a standalone status |

A reflection is attached content, not a way to bypass the progress-only publishing rule.

### CARD-02 — Creation flow

1. User chooses Share Progress from a record, mode, goal, or recap.
2. App generates a structured card from selected source data.
3. User chooses a supported template and included fields.
4. User optionally adds a caption/reflection.
5. User selects the audience.
6. App displays the exact final preview.
7. User explicitly publishes, saves privately, or exports.

No automatic posting after a log, timer, goal completion, or book finish.

### CARD-03 — Templates and visual output

- Provide a small curated template set, not a full poster editor.
- Include author attribution, relevant period, and understandable units/labels.
- Include a small contribution graphic only when appropriate.
- Do not imply verification or app certification of a user's achievements.
- Preserve readable text at normal feed size.
- Provide an exportable image suitable for external sharing.
- Private saves/exports do not create feed posts.

Exact image dimensions, template names, and visual branding are design decisions.

### CARD-04 — Structured content and accessibility

A post must retain structured content and an accessible text representation, not only a flattened image. It must be possible to understand its author, activity, period, and metrics using assistive technology.

A card renderer must only receive explicitly selected public/shareable fields. Hidden raw records must not be embedded in exported image metadata or public previews.

### CARD-05 — Snapshot behavior and edits

- Published cards are snapshots, not live views into private trackers.
- Later private logging does not silently modify an existing post.
- Caption edits are allowed and identified as edited where appropriate.
- Correcting/deleting a source record must warn that a published snapshot may now be outdated and offer to unpublish or regenerate it.
- Updating a published card's metrics requires a new preview and explicit confirmation; identify the update and recheck all sharing permissions.
- Deleting a post removes its in-app visibility and invalidates its reposts and shared-card displays. A limited "unavailable" placeholder may remain in conversation history.
- Already exported images/screenshots cannot be recalled; explain this before sensitive external sharing.

### CARD-06 — Content restrictions

No standalone freeform feed posts, videos, reels, unrelated photos, arbitrary attachments, or quote-repost editor in V1. Profile avatars are a separate permitted image type; any book-cover metadata is not a general photo-posting mechanism.

### CARD-07 — Initial template coverage

Templates may reuse layouts, but must cover these supported outputs:

| Mode | Required outputs | Default privacy behavior |
|---|---|---|
| Focus | Daily/weekly summary, selected task/session milestone | Omit task titles and private notes |
| Read | Page-progress update, finished-book milestone, reading recap | Include only the selected book and period |
| Intake | Daily/weekly water or coffee recap | Show only selected measures; no excess-consumption celebration |
| Money | Monthly plan, savings milestone, selected monthly recap | Hide exact amounts and all account/transaction details unless explicitly selected |
| Combined | Daily/weekly multi-mode recap | Start with chosen modes only; Money values remain hidden |

A neutral period recap with an attached reflection must support restarting or a difficult week; a positive achievement is not required to share a meaningful reflection.

**Acceptance:** A user can share a savings percentage without the underlying amount appearing in the poster, accessible text, link preview, or public post data.

## 17. Profiles, following, and visibility

### SOC-01 — Profile

Profile information includes username, display name, optional avatar/bio, account visibility, follow controls, and the viewer-authorized progress-post collection.

A user may choose to publish a specific progress summary, but profiles must never automatically expose private calendars, full bookshelves, raw logs, or financial records.

### SOC-02 — Public/private accounts

**Public account:**
- Public posts are viewable by other users and through permitted public links.
- Users can follow without approval, unless blocked.
- Proposed option: restrict an individual post to followers only.

**Private account:**
- Following requires approval.
- Posts and progress-card details require approved-follower access.
- A minimal discovery profile can show username, display name, avatar, and an explicitly public bio; onboarding must explain that these fields remain discoverable.
- Post thumbnails, card metrics, comments, and likes must not leak through discovery or link previews.

Every tracker remains private unless its selected information is explicitly published, regardless of account visibility.

### SOC-03 — Follow lifecycle

Users must be able to follow, unfollow, request, approve/decline/cancel requests, and remove followers. Removing a follower immediately revokes follower-only access.

Previously public posts can remain visible to non-followers while the account is public; unfollowing alone is not a privacy control for public content.

### SOC-04 — Visibility changes

- Switching public → private immediately restricts existing posts to approved followers and suppresses external repost displays.
- Existing followers remain approved unless removed or blocked; communicate this before confirmation.
- Switching private → public must not automatically republish historical follower-only cards to everyone.
- Widening an existing post's audience requires explicit confirmation.
- Narrowing audience or deleting a post must be respected by feeds, profiles, links, search results, reposts, comments, notifications, and DMs.

### SOC-05 — People search

Provide basic username/display-name search and follow actions. No trending-post, hashtag-trending, contact-upload, location-discovery, or algorithmic content-discovery system is required in V1.

**Acceptance:** A public account with a private Money tracker exposes only the financial fields selected in its published cards, never its transaction list or balances.

## 18. Feed and engagement

### FEED-01 — Following feed

- Feed consists of authorized cards/reposts from followed accounts and the user's own posts.
- Chronological order based on publication/repost time, not engagement ranking.
- Likes/comments must not bump an old post to the top.
- No inserted unrelated recommendations, autoplay media, or engagement-bait modules.
- An empty feed helps users find people intentionally or return to their own progress.

### FEED-02 — Finite browsing

- No automatic infinite scrolling.
- Show a finite page/batch with an explicit action to load older content.
- Show "You're caught up" when there is no newer followed content since the relevant visit boundary.
- Older content remains available intentionally; users are not forcibly locked out.
- Do not auto-refresh and move the user's scroll position while reading.
- Feed use and social reactions do not improve contribution calendars.

Exact batch size is a usability decision; the finite behavior is mandatory.

### SOC-06 — Likes

- One like per user per post, removable.
- Require current permission to view the post.
- Counts and viewer-accessible like details must respect post visibility.
- No dislike mechanism or leaderboard based on likes.
- Like counts must not control the feed's chronological ordering.

### SOC-07 — Comments

- Text comments and a simple reply thread, limited to one reply level in V1.
- Comment authors can edit/delete their comments.
- Post owners can remove comments on their posts.
- Authorized viewers can report abusive comments.
- Comment/reply notifications respect visibility and blocking.
- No arbitrary comment attachments in V1.
- Deleted or restricted posts make associated comments unavailable to unauthorized viewers.

**Acceptance:** Refreshing the feed after someone likes an old post does not move that post above newer posts.

## 19. Sharing and reposting

### SOC-08 — Share

Sharing sends a post to a recipient or external destination; it does not create a new post on the sharer's profile.

Support:
- Send an authorized card through DM.
- Copy/share a link.
- Export the user's own card image through the device share flow.

A shared private/follower-only link must still require authorization. Public link previews must contain only authorized post content; private links use a generic preview. Whether public pages support full logged-out rendering is an open platform decision; privacy rules do not change.

Other users' cards may be shared as authorized links. V1 does not require a built-in image-export feature for someone else's card.

### SOC-09 — Repost

- Reposting republishes a reference to an existing public card to the reposter's audience.
- Preserve original author, content, and source link.
- Allow undoing a repost.
- Do not create a detached copy or transfer ownership.
- Only currently public, accessible cards are eligible in V1.
- Private and followers-only cards cannot be reposted to a wider audience.
- Original deletion, account privatization, moderation removal, or permission loss must suppress the repost content wherever displayed.
- Reposting a card does not count as the reposter's own tracking progress.
- No quote-repost editor in V1.

**Acceptance:** A recipient without follower approval cannot open a private card sent through DM. A repost of a formerly public card becomes unavailable after the source account turns private.

## 20. Direct messaging

### DM-01 — Conversation scope

V1 supports one-to-one conversations containing:
- Text messages.
- References/previews of progress cards the recipient is authorized to view.

No group chats, arbitrary image/file attachments, voice notes, calls, video, disappearing messages, or live location in V1.

### DM-02 — Requests and permissions

Users can choose who may initiate messages:
- People they follow.
- Anyone, through message requests.
- No new conversations.

**Proposed default:** People the recipient follows can message directly; other senders enter requests. Private-account status must not be treated as automatic consent to receive messages.

Requests must support accept, decline, block, and report. Limit repeated requests and message volume from unknown senders. Existing conversations and later permission changes need clear, predictable controls.

### DM-03 — Message behavior

- Show pending, sent, failed, and retry states where applicable.
- Retrying must not duplicate a message.
- Support conversation history and unread indicators.
- Preserve understandable ordering after reconnecting.
- Sender can remove a message for themselves; unsend-for-everyone is not required in V1.
- Deleting/hiding a conversation for one participant must not imply deletion for the other.
- Read receipts, typing indicators, and online presence are not required in V1.

### DM-04 — Privacy and safety

- Only conversation participants may read messages, subject to documented moderation/reporting processes.
- Do not claim end-to-end encryption unless it is actually implemented and independently evaluated.
- Blocking stops new messages and requests immediately.
- Report flow lets the user intentionally submit relevant messages for review.
- Shared-card access is rechecked when rendered; unauthorized/deleted cards show a neutral unavailable state.
- Sensitive financial values and message bodies must not appear in notification previews by default.

**Acceptance:** Sending a private finance card to a non-follower does not grant them card access. Blocking a sender prevents further requests and messages, including retries from stale clients.

## 21. Notifications and reminders

### NOT-01 — Categories

Provide separate controls for:
- Focus completion and user-scheduled reminders.
- Water reminders.
- Follow requests/approvals.
- Likes, comments, replies, and reposts.
- DM requests and messages.

Budget and reading reminders are optional enhancements, not V1 requirements.

### NOT-02 — Attention and privacy rules

- Ask for notification permission in context.
- Group high-volume social activity where appropriate.
- Allow quiet hours and per-category opt-out.
- Avoid guilt, artificial urgency, follower-loss warnings, and "you are missing out" prompts.
- Do not send notifications merely to increase feed visits.
- Deleted/restricted source content must not remain accessible through a notification link.
- Notification payloads and lock-screen previews must follow privacy settings; hiding content after delivery cannot erase a preview already seen.

## 22. Safety, moderation, and account controls

### SAFE-01 — Blocking

Blocking must remove the follow relationship, revoke follower-only access, stop new interactions/messages, and prevent discovery/interaction routes from bypassing the block where feasible within the app.

Historical messages may remain visible to participants under the documented retention policy, but no new contact is allowed. Existing public exports or screenshots cannot be revoked.

### SAFE-02 — Reporting

Users must be able to report accounts, posts, comments, and messages for issues such as harassment, spam, scams, impersonation, and unsafe content.

Reports must capture sufficient context for authorized review without giving reviewers unrestricted casual access to unrelated private records.

### SAFE-03 — Moderation capability

Before social launch, operators need a restricted review workflow to:
- Review and triage reports.
- Remove content or restrict/suspend an account.
- Record moderation decisions and access.
- Handle support requests and appeals through a documented process.

Community guidelines must prohibit abusive content, financial scams, and encouragement of dangerous consumption or self-harm. The product's progress-only format does not replace moderation.

Age eligibility, treatment of minors, and launch-region obligations must be decided before public social release.

## 23. Data control and privacy lifecycle

### DATA-01 — Record control

Users can edit/delete their own tracking records subject to the recalculation rules above. Deleting records must not leave inflated statistics, orphaned transfers, or misleading goal states.

### DATA-02 — Export

Provide a personal-data export covering tracking records and published content in a documented, usable format. Define DM-history export rules without exposing other users' unrelated data.

Export generation must require authenticated access; downloadable exports must not remain publicly accessible indefinitely.

### DATA-03 — Account deletion

- Explain what is deleted, anonymized, retained, or delayed before confirmation.
- Require a clear confirmation and appropriate reauthentication.
- Revoke account access and public content visibility promptly after confirmed deletion processing begins.
- Remove/suppress posts and repost references consistently.
- Define treatment of messages already delivered to other people.
- Publish concrete retention/deletion timelines before launch.
- Document limited retention for backups, abuse investigations, and legal obligations where applicable.

### DATA-04 — Collection and analytics

- Collect only data needed for product operation and explicitly approved measurement.
- Do not include message bodies, task notes, transaction notes, account balances, or exact savings values in general analytics events.
- Do not sell or use financial/health-adjacent tracking records for advertising in V1.
- Do not upload device contacts by default.
- Provide a privacy policy consistent with actual behavior.

## 24. Accessibility, reliability, and experience requirements

### NFR-01 — Accessibility

- Target WCAG 2.2 AA for applicable interfaces.
- Support screen readers, scalable text, meaningful focus order, adequate contrast, and appropriate touch targets.
- Contribution calendars must not rely on color alone.
- Every poster/card has an equivalent readable text representation.
- Provide reduced-motion behavior where animations exist.

### NFR-02 — Data integrity and recovery

- A confirmed saved record must not silently disappear after restart or reconnection.
- Repeated submissions/retries must not duplicate logs, transfers, likes, posts, or messages.
- Derived totals must agree across dashboard, detail views, exports, and cards for the same snapshot.
- Financial entries must not accumulate rounding drift.
- Private records must not be temporarily exposed while permissions load.
- Backups and recovery procedures must be verified before real user data is entrusted to production.

### NFR-03 — Offline and poor connectivity

**Proposed V1 expectation:** Existing users can view recently available personal data, log water/coffee, capture reading updates/tasks/transactions, and operate a focus timer during temporary connection loss.

- Distinguish saved-on-device, pending-sync, failed, and fully-synced states where relevant.
- Preserve offline entries after app restart.
- Reconcile without duplicate entries or inconsistent transfers.
- Publishing, follow approval, reposts, and permission-sensitive sharing require an online authorization check.
- DMs may remain drafts/pending, but must never claim delivery before successful acceptance.

Cross-device merge rules and the supported offline boundary must be finalized during technical planning. Any reduction from this proposed expectation must be documented before implementation.

### NFR-04 — Performance

- Common quick logs must provide immediate visible acknowledgement.
- Expensive card rendering or network operations must not freeze tracking interactions.
- Long histories and conversations must remain usable without loading all records at once.
- Failed actions must preserve user input and provide a clear recovery path.
- Numerical performance budgets and supported device profiles will be set during technical planning; no untested latency promise is made here.

### NFR-05 — Security

- Protect authenticated sessions and sensitive data in transit and at rest.
- Enforce ownership and audience permissions independently of client-side UI.
- Apply abuse/rate controls to authentication, search, follows, publishing, messaging, and reports.
- Restrict operational access to private data and maintain appropriate access records.
- Keep secrets and sensitive record content out of routine logs and public artifacts.
- Review image generation, deep links, caches, and notification previews as privacy surfaces.

### NFR-06 — Localization and dates

- Use localized currency, number, date, and time formatting.
- Examples using rupiah do not imply IDR is the only supported base currency.
- Define week-start behavior and timezone handling consistently.
- Store sufficient context to explain the activity date shown to the user.
- Avoid copy that equates a missed day with personal failure.

### NFR-07 — Responsive and adaptive Flutter layouts

Responsive phone and tablet support is a V1 requirement, not a later enhancement. Larger screens must receive layouts designed for their available space, not a magnified or stretched phone interface.

#### Window classes

The following are **proposed starting breakpoints**, measured in Flutter logical pixels using the usable app-window width, not physical display pixels or a device-model label:

| Class | Available width | Proposed layout behavior |
|---|---|---|
| **Small** | Below 600 | Single primary pane, bottom navigation, stacked content |
| **Medium** | 600 to below 840 | Roomier content or grids; navigation rail and secondary panes only where content and height permit |
| **Large** | 840 to below 1200 | Navigation rail/sidebar; two-pane layouts for suitable workflows |
| **Largest** | 1200 and above | Expanded navigation where useful, constrained multi-column dashboards, master/detail workspaces |

These classes are window sizes, not permanent phone/tablet categories. A large iPad in a narrow split-screen window must receive a compact layout. Breakpoints may be refined after design testing; support for all four classes is mandatory.

#### Layout and interaction rules

- Support portrait, landscape, and supported iPad multitasking/window resizing. Do not lock the entire app to portrait.
- React to available width **and height**. A wide but short landscape window must keep controls reachable through appropriate scrolling/reflow.
- Respect safe areas, display cutouts, system bars, keyboard insets, and system text scaling.
- Preserve selected records, active timers, scroll context where practical, and unsaved form/message input when layouts reflow. Layout changes must not duplicate writes, restart timers, or discard drafts.
- Use constraint-driven Flutter layouts, for example `LayoutBuilder` for local space and `MediaQuery` for insets/accessibility context. Do not determine layout solely from orientation, device name, or a global `isTablet` flag.
- Do not globally scale every font, icon, spacing value, and control in proportion to screen width. Use shared design tokens, flexible layouts, and explicit content constraints.
- Keep text-heavy surfaces readable with maximum widths. Proposed starting limits: 640 logical pixels for ordinary forms and 720 for a feed/card reading column; refine through usability testing.
- Add useful columns or panes where they improve the workflow; do not force multiple columns when content, height, or enlarged text no longer fits.
- Adapt dialogs, sheets, and editors: compact-screen sheets/full-screen flows can become constrained dialogs or side panels on larger windows.
- Maintain touch targets of at least 48 by 48 logical pixels for primary interactive controls. Support pointer, keyboard focus, and external-keyboard text entry where available; no touch-only requirement for basic flows.
- Avoid unintended whole-page horizontal overflow. Intentionally scrollable heatmaps, charts, and tables are permitted when their navigation and labels remain accessible.
- All size classes must retain the same feature access and privacy rules. More space must not automatically reveal hidden financial values or unpublished records.

#### Mode-specific adaptation

| Surface | Compact layout | Expanded layout |
|---|---|---|
| Today | Stacked summaries and quick actions | Bounded dashboard grid with useful grouping |
| Focus | Task list and timer opened sequentially/as a compact workspace | Tasks and timer/details side by side when space permits |
| Read | List or compact book grid; detail on its own screen | Responsive book grid, optional selected-book detail pane |
| Intake | Stacked totals, quick logging, history | Summary/logging alongside history without oversized controls |
| Money | Stacked overview; separate account/transaction detail | Summary and history/detail panes with constrained forms |
| Progress | Smaller period view or deliberate calendar scrolling | Larger calendar and selected-day detail alongside it |
| Circle | Single readable feed column | Still a readable, width-constrained feed; optional post detail pane, not an engagement-driven multi-feed wall |
| DMs | Conversation list and thread as separate views | Conversation list alongside the selected thread when space permits |
| Card preview | Fit the preview within the available space | Constrain and center the preview; export dimensions remain template-defined, not screen-size-dependent |

### NFR-08 — Adaptive layout validation

For each release stage, its screens must be tested across all four window classes before that stage is considered complete.

Required checks:
- Small-phone baseline such as 320 x 568 logical pixels and a typical phone such as 390 x 844.
- Short landscape phone layout such as 568 x 320.
- Tablet portrait/landscape layouts such as 768 x 1024 and 1024 x 768.
- Large iPad-style layouts such as 1024 x 1366 and 1366 x 1024.
- Narrow and medium tablet split-screen windows, plus live resizing between classes.
- Widths immediately below and at each chosen breakpoint; for the draft thresholds, include 599/600, 839/840, and 1199/1200.
- Large accessibility text, including 200% scaling and platform accessibility settings where supported; layouts must reflow instead of disabling scaling.
- Keyboard-visible forms and conversations, long labels/user content, empty/loading/error states, and long histories.

Use automated Flutter layout/widget tests for representative sizes and breakpoint transitions, supplemented by emulator/simulator and real-device checks where available. Tests must cover no clipped essential controls, unintended overflow, lost input, broken navigation, duplicate actions, or incorrect permission-dependent content.

**Acceptance:** A user can resize or rotate an iPad while viewing a task, editing a transaction, or drafting a message without losing state. Every primary action remains reachable on a small phone and a large iPad. A card export preserves its template dimensions and selected content regardless of the preview window size.

### NFR-09 — Appearance and shared visual system

- Follow [the Your Own design system](cookbook/design-system.md), which defines the product's light/dark themes, component contracts, and adaptive behavior without requiring an external style-reference file.
- Provide System / Light / Dark on mobile, user web, and admin as those surfaces ship. Default System; an explicit choice overrides OS appearance. Persist per installation/browser origin initially; cross-device synchronization is not implied.
- Theme all applicable components and states, including forms, overlays, charts, tables, errors, and loading states. Both themes must pass accessibility and adaptive-layout checks for the current release stage.
- Appearance changes preserve drafts, timers, focus, selected records, and hidden-value privacy; they cannot duplicate mutations.
- Published poster appearance remains tied to its chosen/versioned template, not viewer theme.

## 25. Primary end-to-end journeys

### Journey A — Private daily use

1. User signs up, chooses private visibility, and enables preferred modes.
2. Adds a task, completes a focus session, updates a book, and logs water.
3. Reviews Today and the contribution calendar.
4. Leaves without posting or following anyone.

**Success:** The application provides a complete useful experience without social participation.

### Journey B — Sharing a finished book

1. User confirms a book is finished.
2. Opens Share Progress and selects a finished-book template.
3. Adds a reflection and chooses an audience.
4. Reviews and publishes the card.
5. A permitted follower likes/comments; the user receives a controlled notification.

**Success:** Private notes and other books are not exposed.

### Journey C — Sharing a finance plan

1. User saves a monthly category budget.
2. Creates a plan card showing percentages only.
3. Preview identifies the month and denominator and excludes amounts/accounts.
4. User publishes to the chosen audience.

**Success:** The post is clearly a plan, and exact financial records remain private.

### Journey D — Savings milestone

1. User records a manual contribution to a savings goal.
2. Goal progress updates without changing wallet balances.
3. User shares a percentage-only milestone.
4. Later edits to the goal do not silently change the published snapshot.

**Success:** No money is duplicated and no external funds movement is implied.

### Journey E — Private card shared through DM

1. An approved follower receives a private card reference in a conversation.
2. The card opens while authorization is valid.
3. The creator removes that follower or narrows access.
4. Subsequent opens show unavailable content rather than a stale private preview.

**Success:** Messaging does not bypass card visibility.

### Journey F — A short social visit

1. User opens Circle and views a finite set of new cards.
2. Likes a friend's update and leaves a reply.
3. Reaches a caught-up marker with an intentional option to view older content.
4. Returns to a task or exits.

**Success:** The app supports connection without an endless attention loop.

## 26. Release acceptance gates

### 26.1 Personal foundation gate

- Every mode supports create, view, correct, and delete flows for its primary records.
- Focus excludes pauses/breaks and recovers after ordinary app restart.
- Reading corrections do not inflate totals.
- Water/coffee remain distinct and consumption is not competitively ranked.
- Transfers preserve combined balance and do not inflate income/expenses.
- Savings progress is clearly separate from actual account balances.
- Contribution calendars update after edits/deletions.
- Private card generation/export exposes only selected fields.
- Today and all four modes pass the Small, Medium, Large, and Largest layout checks in NFR-08, including tablet rotation and split-screen behavior.

### 26.2 Social publishing gate

- Public/private and per-post audiences work across all entry points.
- Follow approval/removal, blocking, and account visibility changes immediately affect access.
- Likes/comments follow the source audience.
- Private links and previews do not leak card content.
- Feed is chronological and finite; engagement does not reorder it.
- Reporting and an operator review process exist before opening social features to the public.

### 26.3 Full V1 gate

- Reposts preserve attribution and disappear when source permissions invalidate them.
- DMs support requests, blocking, failure/retry, and reliable ordering.
- Shared cards are authorized at view time.
- Account deletion/export behavior and retention policy are documented and tested.
- Accessibility, data recovery, security, and permission regression tests pass.
- Social publishing, reposts, and messaging pass NFR-08 across all four window classes; responsive support is not limited to the personal tracking screens.
- All unresolved launch-blocking decisions below have approved answers.

### 26.4 Required privacy test matrix

Test post/profile/feed/link/repost/comment/notification/DM access for:
- Owner.
- Approved follower.
- Non-follower.
- Pending follow requester.
- Removed follower.
- Blocked account.
- Logged-out viewer where public links are supported.

Repeat after post deletion, audience narrowing, public-to-private switch, account suspension, and account deletion. Previously cached content must not continue to be served as authorized app content after access is revoked.

## 27. Success measures

### 27.1 Proposed primary outcome

**Weekly meaningful tracking users:** Users recording valid activity on a personally relevant number of days during a week. The threshold should be validated rather than assuming daily use is correct for every mode.

Pair behavioral measurement with user feedback: "Does Your Own help you notice progress and follow through?"

### 27.2 Supporting measures

- Onboarding-to-first-valid-log completion.
- Time/interaction cost of common logging actions.
- Weekly and monthly return to tracking, by enabled mode.
- Share-preview-to-publish completion and cancellation reasons.
- Meaningful encouragement: replies, conversations, and follow-up feedback rather than raw reaction volume alone.
- Self-reported usefulness, privacy confidence, and perceived pressure.
- Data correction, duplicate-record, synchronization, and permission failure rates.
- Reports, unwanted DM requests, notification opt-outs, and blocking trends.

### 27.3 Anti-goals

Do not optimize for total feed time, endless session length, notification opens at any cost, compulsive posting, or larger consumption/spending values.

Numerical targets are set after baseline testing. Sensitive tracker values and message content are not required for these metrics.

## 28. Existing application review

Potential reference/reuse repositories:
- `D:\my_project\mini-projects\personal_finance_tracker`
- `D:\my_project\mini-projects\water_intake_logger`
- `D:\my_project\mini-projects\coffee_shot_track`
- `D:\my_project\mini-projects\book_read_tracker`

An initial dependency review across these repositories and selected representative-code inspection have been completed. A full feature, architecture, and reuse audit remains outstanding; compatibility, feature parity, and code reuse are not assumed.

The review should inventory:
- Existing user-facing features and useful interaction patterns.
- Domain models, validation, calculations, and edge cases.
- Storage, export, and any migration expectations.
- Test coverage, dependencies, and accessibility.
- What can be reused, adapted, or should be rebuilt.

Flutter has been confirmed for the new mobile application. Existing apps' state management, persistence, and other architecture choices do not automatically determine the new implementation.

## 29. Risks and mitigations

| Risk | Mitigation |
|---|---|
| Four trackers plus social becomes too broad | Narrow each mode; stage delivery; enforce the V1 non-goals |
| Social use overtakes real-world activity | Dashboard-first navigation, finite chronological feed, no engagement-driven ranking |
| Financial/private details leak | Field-level preview, private defaults, audience checks on every surface, privacy test matrix |
| Productivity becomes comparison or guilt | No global scores, optional goals, setbacks/reflections, neutral language |
| Small logs flood the feed | Summary-first templates, deliberate publishing, rate controls for abuse |
| Self-reported activity is mistaken for verified proof | Clear language; no verification badge or competitive rewards tied to totals |
| Manual savings appears to be actual reserved money | Separate planning ledger, explicit explanation, no addition to account balances |
| Offline/cross-device edits corrupt data | Defined pending states, duplicate prevention, conflict handling and recovery tests |
| DM abuse and moderation workload grow | Requests, limited media scope, permissions, rate controls, blocking/reporting |
| Exported sensitive posters circulate externally | Clear export warning; never promise screenshot/export revocation |

## 30. Decisions to resolve before implementation or launch

### Product/scope approval

1. Approve the four-mode boundary and staged full V1 definition.
2. Confirm launch platforms and whether an earlier limited release is desirable.
3. Confirm public/private signup default; **proposed: private**.
4. Confirm per-post followers-only publishing for public accounts.
5. Confirm initial labels: Focus, Read, Intake/Asupan, Money, Circle.
6. Confirm lightweight task fields and whether historical focus-duration edits are allowed.
7. Confirm savings as an independent manual planning ledger rather than wallet-linked allocation.
8. Confirm one base currency and amount-based monthly budget editing for V1.
9. Confirm which card templates are required at each stage.
10. Confirm launch languages and unit support.

### Technical planning inputs — remaining choices

11. Decide authentication methods, guest-use policy, and offline scope.
12. Define cross-device timer/conflict behavior and exact recovery guarantees.
13. Define public-link rendering, supported deep links, and export formats.
14. Establish supported device profiles, measurable performance budgets, and backup/recovery targets.
15. Review existing apps before estimating reuse or migration effort.

### Public launch blockers

16. Set minimum age, launch regions, and requirements for minors if supported.
17. Publish community guidelines, moderation/support ownership, and appeal procedures.
18. Finalize privacy policy, data export, deletion/retention timelines, and message-history treatment.
19. Define initial anti-spam limits and report-response operating targets.
20. Approve analytics events/consent and confirm no sensitive content is collected unnecessarily.

## 31. Future roadmap — explicitly outside V1

- **Training:** Manual workouts first; GPS routes and background tracking as a separate project.
- **Expanded Intake:** Meals, recipes, planning, and optional nutrition tools.
- **Accountability:** Shared challenges, book clubs, named circles, and group focus.
- **Games:** Cooperative/couple activities connected to real-world participation.
- **Money expansion:** Copy another user's public plan as a private template, wallet-linked goal allocation, richer planning.
- **Focus expansion:** Recurring tasks, deeper organization, optional shared sessions.
- **Customization:** Carefully scoped custom trackers after common patterns are validated.
- **Messaging expansion:** Groups or richer message types only when justified by user demand and safety capacity.

## 32. Definition of the product

Your Own is successful when someone can log a meaningful part of their day, understand their progress, encourage a friend if they choose, and leave feeling supported rather than distracted.

**Four personal modes. One coherent progress history. Optional, privacy-conscious social connection.**
