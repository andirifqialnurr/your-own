# Reference Flutter Apps — Static Audit

- **Version:** 0.2
- **Status:** M00-T03 Verified as a static audit on 2026-10-23 UTC. No runtime, dependency-selection or copying clearance.
- **Observed:** 2026-10-23 UTC, Windows/Git Bash
- **Task:** [M00-T03](../milestones/00-decisions-and-validation.md#m00-t03--reference-app-audit)
- **Authority:** [PRD](../PRD.md), [mobile reuse boundaries](../MOBILE_TECH_SPEC.md#25-existing-app-reuse-assessment), [accepted defaults](decisions/0003-product-defaults.md), [icons/charts](decisions/0002-rounded-icons-and-chart-rendering.md)

## 1. Scope and evidence limits

This is a read-only assessment of sibling repositories, not approval to copy code, assets, schemas or dependencies. Source and test assertions describe intended behavior; **no reference test suite, `flutter analyze`, build or device journey was run**. No dependencies were installed, migrations executed, personal databases opened or reference files edited. No runtime/security/accessibility certification is implied.

Paths below are relative to each named reference repository, located alongside `your-own` under `D:/my_project/mini-projects/`. They are source locators, not files promised in this repository. HEAD identifies the committed baseline; coffee/book observations also include the existing working-tree state.

| Reference | Observed HEAD | Working tree at inspection | Test-file inventory |
|---|---|---|---|
| `personal_finance_tracker` | `768894d996ffc6d35b1a99b8ae9bfa5cabde22f4` | Clean | 24 `*_test.dart` files |
| `water_intake_logger` | `435dd2b0008a50d7a4bcb77d7a537433f2a4ac0c` | Clean | 1 `*_test.dart` file |
| `coffee_shot_track` | `dad568e8832a1ea02043edc484f554fd569796a0` | Existing manifest/lockfile, launcher/native project changes and untracked launcher resources; preserved | 5 `*_test.dart` files |
| `book_read_tracker` | `a47d16237a2a5d2ea66bcc88eb1c79a029ce400e` | Existing untracked `android/.kotlin/`; preserved | 6 `*_test.dart` files |

These counts are files, not test cases or passing tests. Review covered manifests/READMEs, all four lockfiles, all 22 distinct direct hosted package/version LICENSE files, targeted nested notices, source/test inventories and the representative paths below—not every source line or transitive package. The [dependency/provenance register](reference-app-licenses.md) records exact resolved versions, notice hashes, limitations and non-reuse dispositions.

## 2. Dependency and asset inventory

The following are **manifest constraints**, not newly selected versions. All four have a `pubspec.lock`; no lockfile was regenerated. All declare Flutter and `flutter_test` SDK dependencies.

| Reference | Direct non-SDK runtime dependencies | Direct non-SDK development dependencies |
|---|---|---|
| Finance | `cupertino_icons ^1.0.8`, `flutter_riverpod ^2.6.1`, `sqflite ^2.4.2+1`, `path_provider ^2.1.6`, `apexcharts_flutter 0.1.2` | `flutter_lints ^6.0.0`, `sqflite_common_ffi ^2.4.0+3`, `flutter_launcher_icons ^0.14.4` |
| Water | `cupertino_icons ^1.0.8`, `flutter_bloc ^9.1.1`, `equatable ^2.0.8`, `drift ^2.34.0`, `drift_flutter ^0.3.0`, `path_provider ^2.1.6`, `dio ^5.9.2` | `flutter_lints ^6.0.0`, `drift_dev ^2.34.0`, `build_runner ^2.15.0` |
| Coffee | `cupertino_icons ^1.0.8`, `sqflite ^2.4.2+1`, `path ^1.9.1`, `get ^4.7.3`, `shadcn_ui ^0.53.6`, `google_fonts ^8.2.1`, `image_picker ^1.2.3`, `path_provider ^2.1.6` | `flutter_lints ^6.0.0`, `sqflite_common_ffi ^2.4.0+3`, `flutter_launcher_icons ^0.14.4` |
| Book | `flutter_riverpod ^2.6.1`, `google_fonts ^6.2.1`, `image_picker ^1.1.2`, `path ^1.9.0`, `path_provider ^2.1.5`, `sqflite ^2.4.1` | `flutter_lints ^3.0.0`, `flutter_launcher_icons ^0.14.4` |

Finance/water/coffee declare Dart `^3.10.8`; book declares `>=3.3.0 <4.0.0`. The inspected lockfiles require Flutter `>=3.38.4`; their Dart lower bounds are `3.10.8` for finance/water/coffee and `3.10.3` for book. These are recorded resolver constraints, **not evidence of the installed SDK or successful compatibility**. Do not select the new toolchain from a README or broad manifest range alone.

### License/provenance inventory — no copying clearance

- A filename scan for LICENSE/license/NOTICE/COPYING/OFL in the inspected source trees, excluding Git/build/tool-cache directories, returned no matches. That does not establish ownership, absence of all embedded notices, or redistribution permission.
- `publish_to: 'none'` is a package publication setting, not a source/asset license.
- Finance bundles Montserrat; water bundles Plus Jakarta Sans and an image directory. Coffee/book declare Google Fonts; launcher image names include `money.png`, `coffee-beans.png`, and `book-stack.png`. Font/image provenance and applicable redistribution rights have not been established. Do not copy them as Your Own assets.
- All four contain app-owned `Icons.*`/`CupertinoIcons.*` source references (16/7/12/13 matching source files respectively). These require replacement under Decision 0002; a Flutter component library's glyph defaults are not an approved icon bank.
- Correction to the preliminary description: `apexcharts_flutter 0.1.2` is a native Dart/CustomPainter **port**, not a WebView wrapper. Its cached MIT LICENSE/NOTICE claims derivation from ApexCharts.js v4.7.0. That supplier claim is not independently verified upstream and cannot establish the license/entitlement of the separately selected user-web JS core/React integration.
- The [completed register](reference-app-licenses.md) inventories all direct resolved notices and explicitly excludes uncleared source/assets and inherited dependency trees. Unreviewed transitive/native obligations remain unapproved, not presumed permissive. M00-T04 owns independent new-stack selection/compatibility/entitlements; M00-T08 owns encrypted native integration.

## 3. Finance findings

**Feature inventory:** README and source/test paths cover local accounts, income/expense/transfers, categories, filters, balances, recurring templates, monthly budgets, savings, reports, exports/backups and appearance settings. README explicitly describes a local app without login/cloud dependencies. This does not prove every advertised feature works.

**Inspected paths:** `lib/main.dart`, `lib/data/flow_database.dart`, `flow_balance_service.dart`, `flow_repositories.dart`, `lib/data/models/transaction.dart`, `savings_goal.dart`, `lib/components/flow_apex_chart.dart`; `test/balance_service_test.dart`, `flow_store_test.dart`, `planning_features_test.dart`.

- `flow.db` uses sqflite schema version 2, foreign keys and integer monetary columns. Income/expense and both transfer directions are included in the balance query. This is a useful exact-integer reference—not a floating-point ledger.
- The transfer model is one transaction row with source/destination account IDs. It is not Your Own's proposed header/posting, receipt, revision and outbox contract. Do not mistake a local single-row transfer for distributed retry/concurrency proof.
- Settings seed IDR/light. The settings repository replaces the row without a monetary-history currency lock; the store test saves USD after writing records. That behavior must not carry into the accepted user-selected, locked base-currency contract.
- `main.dart` catches SQLite-open failures and substitutes an in-memory store with a debug message. Your Own must not silently acknowledge sensitive records as durable after persistent storage fails.
- Savings stores `manual_contribution` plus an optional account link. The planning test expects a linked savings-account balance plus manual contributions. That is incompatible with P10's independent manual ledger; rebuild contribution/withdrawal history and never count linked wallet balances as goal contributions.
- `FlowApexChart` delegates JSON options to `ApexChart.fromJson`. Do not reuse this chart adapter for the new Flutter app; native/custom rendering, accessible values and the new privacy/design contracts apply.

**Candidate test ideas, not copied fixtures:** integer balance recalculation after income edits and transfer deletion; both affected accounts; close/reopen persistence; category/month budget filtering; explicit recurring-template review rather than automatic ledger writes. Rewrite expectations for accepted currency/savings rules and add owner isolation, exact transport, idempotency, atomic postings, conflict and migration tests. Existing tests have not been executed here.

### 3.1 Export, backup and import follow-up

Additional inspected source: `lib/data/flow_{backup_codec,csv_exporter,csv_importer,report_exporter,store}.dart`, relevant methods in `lib/state/flow_controller.dart`, `lib/utils/flow_file_access.dart`, Android `MainActivity.kt`/`res/xml/flow_export_paths.xml` and iOS `AppDelegate.swift`. Additional test reads: `test/flow_{csv_importer,csv_exporter,report_exporter}_test.dart`.

- **Backup:** `flow.local-backup` JSON format version 1 serializes local IDs, integer amounts, settings and planning arrays. That format version is distinct from SQLite schema version 2. It is plaintext in application documents; schema/version checks do not establish bounded input, ownership or full referential validation. The new personal export must carry documented exact currency/unit/date semantics and authenticated access, not merely copy these models.
- **Restore:** SQLite `replaceSnapshot` deletes the current tables' contents and reinserts the snapshot inside one transaction. Atomic replacement is useful as a failure-boundary example, but destructive local restore is not an import/sync strategy for account-owned records, tombstones, receipts, drafts or pending operations. Do not copy it into Your Own.
- **CSV:** Export escapes quotes/commas/newlines but has no currency/precision metadata or stable transaction ID. It does not neutralize spreadsheet formula prefixes in free-text fields. Name-based import mapping and value/timestamp/note deduplication can conflate distinct identical transactions or ambiguous names; this is not stable operation identity. Input bounds, malformed quoting, formula safety and exact metadata need new contracts/tests if that format is chosen.
- **Partial import:** Controller `importCsv` persists rows one by one; its guard records errors but does not wrap the batch in a database transaction. A failure can leave earlier rows committed. No resumable/batch-atomic import contract is established.
- **PDF:** A small handwritten writer clips fields and replaces characters outside ASCII 32–126 with `?`. Tests inspect the PDF header, strings, xref and EOF, not rendered Unicode, tagged accessibility or viewer behavior. It is not a candidate poster renderer or proof of a complete/lossless personal-data export.
- **Native save/open:** Android uses a custom channel with FileProvider and ACTION_CREATE_DOCUMENT. Provider roots cover broad application-document/external-file areas, not just a dedicated export directory. The Dart adapter has no iOS branch and throws UnsupportedError there; the inspected AppDelegate supplies only normal plugin registration. Rebuild narrow, account-safe temporary-export delivery, cleanup and iPhone/iPad share-sheet behavior; Android source is not iOS evidence.

Useful new test scenarios: deterministic ordering including timestamp ties; quotes/newlines and formula-leading text; exact large integers with currency metadata; duplicate-looking but distinct records; malformed/oversized inputs; cancellation/process death during native save; Unicode and accessibility. Legacy import remains **unpromised**; identifying its failure cases does not add it to V1.

## 4. Water findings

**Feature inventory:** repository/Bloc paths provide quick capture, correction/removal, entry history, daily totals/targets, week summaries and streak/profile summaries. The README is Flutter starter text, not an implementation contract.

**Inspected paths:** `lib/data/local/app_database.dart`, both files under `lib/data/local/tables/`, `lib/data/repositories/hydration_repository.dart`, `lib/features/hydration/bloc/hydration_bloc.dart`, `lib/widgets/charts/bar_chart/{painter,cover_widget}.dart`, `test/widget_test.dart`.

- Drift schema version 1 stores integer mL, timestamp/local-date text, timestamps and a nullable deletion marker. Daily goals are unique by date with a 2000 mL default. This is not the new optional/effective-dated target contract or an approved universal health target.
- `removeWater` appends a negative entry after reading the day's total; totals are clamped to zero. Your Own's positive entries and explicit edit/delete operations need a new rule set; do not hide invalid history behind clamping or infer a safe concurrent correction protocol.
- Date keys are derived from supplied/device `DateTime`; there is no named-zone/effective-goal contract in these inspected tables. Preserve useful date grouping ideas, but design explicit activity context and timezone-change behavior.
- The deletion marker is a useful concept, not a complete sync tombstone/receipt/retention implementation. Integer autoincrement IDs also need new account-scoped/server identity mapping.
- The lockfile includes `sqlcipher_flutter_libs 0.7.0+eol` and `sqlite3_flutter_libs 0.6.0+eol`; their cached READMEs explicitly describe no-op compatibility packages. This is not evidence of encryption, and it does not change the inspected database open path's lack of key configuration.
- The custom bar painter is an example of native drawing, not a reusable accessible chart certification. Its inspected wrapper repeats wave animation without a reduced-motion branch; these two files provide no chart semantics/value-table contract. They need theme/layout/empty-data/scale/semantics and repaint review rather than direct copying.
- The only inventoried test is a starter counter smoke test. It does not supply hydration repository, goal-history, timezone, migration or deletion evidence. No claim is made about whether it currently passes.

**Candidate test ideas:** editing 250 mL to 200 mL changes the total by exactly 50; deleting an entry removes its contribution; no-target and over-target states; historical target preservation; US-fluid-ounce conversion performed once; day boundaries, retry identity and deleted-record reconciliation. These should be newly written against Your Own's contracts, not lifted from a counter test.

## 5. Coffee findings

**Feature inventory:** beans, brew measurements/ratings/favorites, brew-again, menus, cafes, orders and images. Much of this exceeds Your Own's lightweight cups/shots/time/note scope; a reference feature is not permission to expand Intake.

**Inspected paths:** `lib/data/shot_database.dart`, `shot_store.dart`, `image_storage.dart`, `lib/app/shot_binding.dart`, `lib/domain/espresso_shot.dart`, `shot_metrics.dart`; `test/shot_metrics_test.dart`, `shot_store_acceptance_test.dart`.

- `shot_tracker.db` has schema version 5 with beans/shots/menus/cafes/orders and legacy shot-to-order migration. Migration uses `legacy_shot_id` uniqueness and insert-ignore; this is an internal legacy-app migration, not a Your Own importer.
- Storage and reactive state are combined in a GetX controller. Rebuild behind the new framework-independent feature/repository contracts rather than importing that controller/binding or another navigation system.
- Brew dose/yield and order price use REAL columns. Do not reuse an order price as a Money amount. Brew measurements do not establish a cups/shots equivalence or caffeine estimate.
- The schema declares foreign keys, but its inspected open path does not enable `PRAGMA foreign_keys`; actual enforcement needs execution evidence. `deleteBeanOrArchive` checks shots, not order-only references. These are review risks, not device-tested defect reports.
- `ImageStorage` copies gallery files into application documents under `shot_images`. The inspected helper does not establish account-scoped encryption, revocation, replacement cleanup or backup policy. None of these guarantees can be inherited.
- Ratio/rating and copy-without-mutating-source tests are useful examples of bounded pure rules. The store test named restart creates a second controller over the same database object; it is not a process-death or native persistence test.

**Reuse recommendation:** retain only interaction lessons relevant to quick logging, edit/delete and repeat entry without mutating the source. Rebuild the small coffee model and synthetic fixtures. Do not bring beans/cafes/orders/prices/photos, GetX or shadcn UI into scope implicitly.

## 6. Book findings

**Feature inventory:** library/search/filter/sort, metadata/covers, progress, explicit finish/review, reading goals, statistics and appearance. README's dependency-free/in-memory prototype description is stale relative to the manifest and SQLite repository.

**Inspected paths:** `lib/core/database/{app_database,migrations}.dart`, `lib/domain/books/{book_rules,book_repository}.dart`, `lib/data/books/sqflite_book_repository.dart`, `lib/data/progress/progress_history_dao.dart`, `lib/features/books/book_providers.dart`, `lib/features/books/widgets/cover_picker.dart`, `lib/features/stats/stats_providers.dart`; `test/book_rules_test.dart`, `provider_test.dart`.

- `shelf.db` uses schema version 1 in application documents with foreign keys, book/status/page constraints, tags, yearly goals, progress history and settings. Book updates and changed-page history are written in one transaction: a useful atomicity pattern to rebuild with revisions and operation identity.
- `BookRepository` extends Riverpod `StateNotifier`; despite its domain directory, it is not framework-independent. Keep the interface intent, not the inherited reactive architecture.
- Page rules clamp into bounds and return no ratio for unknown/zero totals. Review UI clamping separately from server rejection of invalid writes; the reference's `999999` cap is not an approved Your Own limit.
- `ProgressHistoryDao.getBooksFinishedPerMonth` counts progress-history rows, not distinct finished books. Do not use that query as the new completion metric. The inspected UI provider calculates differently; this is not a claim that the UI calls that DAO query.
- The chart provider generates only eight months and filters by `finishedAt`, not explicitly by finished status. Rebuild complete date-window/status rules, including reopen/correction, instead of copying the statistics implementation.
- CoverPicker retains the gallery path directly; the inspected picker does not establish durable owned-file copying, encryption or cleanup. New cover/media lifecycle needs explicit tests.
- The inspected provider tests use in-memory overrides. They provide interaction expectations, not SQLite migration, durable restart, multi-device conflict or native picker evidence.

**Candidate test ideas:** unknown-total progress, bounded pages, explicit finish, rating/review preservation when reopening, search/status/sort and immutable snapshots. Re-express these with synthetic data and accepted review/history rules; add transactional history, corrections, distinct completion counting, 12-month windows and media lifecycle cases.

### 6.1 Migration and fixture assessment across references

| Reference | Source migration path inspected | Evidence limit / disposition |
|---|---|---|
| Finance | Schema 2; version loop dispatches migration 2 to create planning tables; backup JSON has a separate version 1 contract | Close/reopen and codec test assertions exist; no old-schema upgrade/failure matrix established. Rebuild local migrations, never substitute snapshot replacement for synchronization. |
| Water | Drift schema 1, default connection, no custom upgrade policy in the database class | Starter counter test does not cover migration. Do not transplant generated `.g.dart`; generate from the new reviewed schema. |
| Coffee | Schema 5; version conditions add menus, cafes, orders/legacy mapping and bean image path | The inspected legacy conversion test invokes the conversion helper on a current schema; not proof of each historical version upgrade or rollback. Out-of-scope orders/beans are not migration targets for Your Own. |
| Book | Initial schema 1 creation; no onUpgrade callback in the inspected open path | In-memory provider tests do not verify SQLite upgrade/history preservation. Rebuild projection and migration fixtures with account identity and revisions. |

No existing synthetic fixture implementation is selected for copying. Test **ideas** below will be rewritten as new requirement-based fixtures after contracts are approved. No user database, cover image or exported personal file was opened to obtain fixtures.

## 7. Final reuse assessment and import boundary

These are audit dispositions under existing product/architecture constraints, not approval of a new stack or a promise of feature delivery. **Reference-only** means learning from an interaction/invariant, not copying source or fixture bytes; **rebuild** means implement the approved requirement anew; **exclude** means do not carry the material/feature into the new app.

| Requirement / area | Final audit disposition | New verification to implement / task |
|---|---|---|
| MON-01/02 accounts and transactions | Reference-only integer balance cases and correction interactions; rebuild account-scoped exact ledger, currency lock and atomic postings | Transfers preserve combined assets, retries do not duplicate, opening balances stay outside income; M00-T10/T11, M07 |
| MON-03/04 planning/savings | Reference-only budget filtering and deliberate review; rebuild monthly plans/review events and independent savings entries; exclude wallet-linked contribution totals | Plans never move funds; withdrawals cannot go negative; savings never increases assets; M07 |
| INT-01/03, PROG-04 water/goals | Reference-only quick capture, grouping and deletion-marker concept; rebuild positive-entry edits/deletes, optional effective-dated goals, named-zone context and reminders | 250→200 mL changes total by 50; one-time US-fl-oz conversion; goal history, timezone and retry cases; M00-T08/T10/T11, M03/M06 |
| INT-02 coffee | Reference-only repeat/edit interaction; rebuild cups/shots/time/note model; exclude beans, menus, cafes, orders, prices and coffee photos | Cups/shots remain distinct; no hydration/caffeine inference; M06 |
| READ-01–03 | Reference-only shelf/search/explicit finish and unknown-total behavior; rebuild framework-independent book/history/review rules and summaries | 40→58 yields 18 pages; correction/reopen cannot inflate completion; full date windows; M04 |
| DATA-01–03 export/deletion | Reference-only preview/cancel and parsing edge cases; rebuild authenticated export, scoped file lifecycle and deletion reconciliation; exclude legacy destructive restore | Exact metadata, safe text, stable snapshots, expiring access, iPhone/iPad cancellation/cleanup; M00-T08/T12, M08 |
| Storage and synchronization | Rebuild encrypted account-scoped projection, durable operation IDs/revisions/outbox, explicit failures and preservation migrations | No silent memory fallback or unsynced-data loss; M00-T08/T10/T11, M02 |
| NFR-01/07–09 shell/design | Rebuild one adaptive shell, semantics, themes and rounded icon adapters; exclude the old navigation/theme/state-stack combination and uncleared assets | Both themes, four window classes, reduced motion, screen readers and large text; M00-T04/T09, M01 |
| CARD-01–07 / charts | Rebuild selected private snapshots/renderers; no reference chart or PDF writer selected for copying; user-web ApexCharts and Flutter custom rendering remain separate contracts | Hidden-value privacy, accessible exact values, immutable output and native/browser rendering gates; M00-T04/T09/T13, M08 |
| Identity/social/Focus | No reusable implementation established among the inspected reference paths; do not infer coverage from local CRUD | Existing auth, sync, timer and social prerequisites remain; M00-T07/T08/T10/T11 and later milestones |
| Legacy import | **Not promised.** Existing CSV/backup and coffee migration helpers do not create a commitment | Owner approval only if requested; then a separately scoped, versioned import contract |

If import is later requested, separately define supported versions, source ownership/consent, synthetic fixtures, stable identity/deduplication, currency/unit/date mapping, negative-water handling, savings semantics, image transfer, dry-run/validation and rollback. Never open or transform a person's existing database as an incidental audit step.

## 8. Audit acceptance and remaining gates

| M00-T03 criterion | Evidence / conclusion |
|---|---|
| Features | Per-app inventories and explicit exclusions in sections 3–7 |
| Dependencies/licenses | Full source lockfiles, resolved direct notices/hashes, targeted nested notices and explicit unknown/non-reuse dispositions in the companion register |
| Storage/migrations | Source paths and schema versions above; encryption, identity, sync and preservation gaps recorded |
| Tests | 36 test-file inventory and representative assertions inspected; no runtime pass claims |
| Reusable rules/fixtures | Requirement-based scenario ideas recorded; no source or fixture bytes selected for copying |
| Rebuild decisions | Reference-only/rebuild/exclude table tied to requirement IDs and future tasks |
| Import commitment | None; no personal data accessed and no legacy importer promised |
| State boundaries | No navigation/state stack, schema or dependency graph merged; reference working trees preserved |

The static audit is Verified on source/inventory evidence and documentation/notice-hash checks recorded in the milestone log. This does not claim runtime results or clear unused assets. M00-T04 is the next eligible task, **not started**. It must independently validate and obtain approval for the actual supporting stack, rounded icon family and user-web ApexCharts versions/entitlement. Native encryption/design/session/sync/scaffold gates remain in M00; no application implementation is authorized by this audit.

## 9. Inspection commands and outcomes

Executed in Windows/Git Bash; complete command/output and file reads are in the agent session:

- `date -u '+%Y-%m-%d %H:%M:%S UTC'` — observed the date above.
- `git status --short`, plus `git -C "$p" rev-parse HEAD` and `git -C "$p" status --short` for each sibling — recorded source identity and existing changes; no Git mutation commands used.
- `rg --files` over reference `lib/` and `test/`, and `find "$p/test" -type f -name '*_test.dart'` — source/test inventory and counts above.
- `rg --files --hidden -g '!.git' -g '!build' -g '!.dart_tool' -g '!**/.gradle/**' -g '*LICENSE*' -g '*license*' -g '*NOTICE*' -g '*COPYING*' -g '*OFL*' -g '*pubspec*' -g '*_test.dart' "$p"` — manifests/tests found; no matching notice filenames returned in that scope.
- `rg -l '(\bIcons\.|\bCupertinoIcons\.)' "$p/lib"` — the four icon-reference file counts above; not a full implicit-glyph scan.
- Initial manifest, lockfile SDK-tail and representative source/test reads were followed by complete lockfile/direct-license reads and the targeted export/import/native/migration assessment above. Inline standard-library `python -` counted resolved package entries and hashed lockfiles/notices; the companion register records results and scope limits.
- No `flutter pub get`, `flutter test`, `flutter analyze`, `flutter build`, app launch, network license lookup or database connection was performed. Package README/platform/license claims remain supplier statements unless explicitly supported by separate inspection; no runtime result is inherited.
