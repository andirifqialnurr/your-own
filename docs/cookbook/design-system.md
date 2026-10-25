# Your Own — Cross-Platform Design System

- **Version:** 0.10
- **Status:** Standalone design specification; initial Flutter tokens/appearance/adaptive shell implemented and host-tested; full components and native visual-accessibility validation pending
- **Applies to:** Flutter mobile, Next.js user web, separate Next.js admin, and generated progress posters
- **Accepted icon/chart direction:** [Decision 0002](decisions/0002-rounded-icons-and-chart-rendering.md) and [Decision 0004](decisions/0004-toolchain-directions-and-icon-family.md); Hugeicons Free Stroke Rounded, ApexCharts for user web on integration hold pending licensing clarification, native/custom Flutter charts where needed
- **Design provenance:** Initially informed by an Awesomic-inspired light-style reference; adopted values, adaptations, and rationale are recorded here. This is Your Own's system, not an official third-party component library.
- **Related:** [Architecture](architecture.md) · [PRD](../PRD.md) · [Mobile](../MOBILE_TECH_SPEC.md) · [Web](../WEB_PRD.md) · [Admin](../ADMIN_CMS_PRD.md) · [Testing](testing.md) · [Security](security.md)

This document is the standalone source of truth for Your Own's design system and replaces the earlier visual mapping. Your Own now follows **editorial zinc neutrals, generous rounding, hairline card borders, a single geometric sans, neutral primary actions, and sparse orange badge accents**. Orange is not the primary button color. Four rainbow mode themes, blue focus rings, pure-black canvases, and serif headings are not part of this direction.

Light/dark palettes, typography, geometry, component states, adaptive behavior, accessibility requirements, and product workflows are specified below. **System / Light / Dark** appearance is required; System is the proposed default. Exact token values are implementation candidates, not shipped components or an accessibility certification.

**Implementation checkpoint:** [M01-T05](mobile-appearance-foundation.md) adds `design/tokens.json`, its generated Flutter adapter, bundled DM Sans and the local appearance selector. This foundation subset does not complete the full catalog, native/system-bar/persistence checks, web/admin or poster rendering. Token contrast tests are not full accessibility certification. [M01-T06](mobile-adaptive-shell.md) implements the shared width/height policy, stable branch layout, bounded pages and four Free Stroke Rounded navigation aliases. Rail labels are measured with current text scaling; compact navigation scrolls deliberately with a visible scrollbar/semantic hint, and sidebar labels wrap. [M01-T07](mobile-shared-ui.md) subsequently adds the first shared controls/surfaces/dialogs, 28 semantic aliases and a synthetic development catalog with ten reviewed host goldens. Full product icon/component coverage and native visual review remain pending.

**Reference retirement:** The original root `DESIGN.md` is no longer required and can be deleted. Its adopted guidance and the rationale for departures have been incorporated here; implementation and documentation navigation must not depend on that file. Historical comparisons below are explanatory, not instructions to consult another specification.

Use this document together with the linked product/security requirements; older visual references do not override Your Own's accessibility, privacy, tracking semantics, or four-class adaptive policy. A component's presence in this catalog does not introduce a new feature: implement it only for its approved release stage and platform scope.

## Contents

- [1. Experience principles](#1-experience-principles)
- [2. Token model and platform mapping](#2-token-model-and-platform-mapping)
- [3. Typography, color, and visual hierarchy](#3-typography-color-and-visual-hierarchy)
- [4. Adaptive layout system](#4-adaptive-layout-system)
- [5. Navigation and core components](#5-navigation-and-core-components)
- [6. Forms and data entry](#6-forms-and-data-entry)
- [7. Progress and contribution views](#7-progress-and-contribution-views)
- [8. Cards and social interactions](#8-cards-and-social-interactions)
- [9. State, feedback, and motion](#9-state-feedback-and-motion)
- [10. Privacy and administrative interfaces](#10-privacy-and-administrative-interfaces)
- [11. Accessibility and localization](#11-accessibility-and-localization)
- [12. Governance and design acceptance](#12-governance-and-design-acceptance)

## 1. Experience principles

- **Personal first:** Today and quick capture lead. Social is a destination, not the default attention trap.
- **Calm and encouraging:** Small steps, rest, setbacks, and restarting are valid; no shame-based copy or competitive consumption.
- **Neutral editorial identity:** Strong typography, rounded surfaces, and clear grouping do most of the visual work. Color is punctuation, not decoration everywhere.
- **Useful density:** Larger windows provide meaningful panes/grids, not enlarged phone controls or excessive whitespace around routine logs.
- **Truthful state:** Saved on device, accepted by server, rendering, and published are different states.
- **Privacy visible:** Show what will be shared and with whom. Extra screen space never reveals hidden financial fields.
- **Familiar without copying:** Recognizable likes/comments/shares/reposts/DMs; no reels, autoplay, endless feed, or engagement ranking.
- **One language across platforms:** Shared semantic tokens and interaction contracts, with platform-appropriate widgets and native integrations.
- **Operational restraint:** Admin is precise, accountable, and role-scoped—not an unrestricted private-data viewer.

### 1.1 Source-to-product mapping

| Historical inspiration (summarized here) | Your Own mapping | Decision / reason |
|---|---|---|
| Zinc neutrals, almost achromatic UI | Zinc light/dark foundations; neutral mode identity and charts | Adopt the identity, not a generic multicolor tracker |
| Dark filled primary action `#09090B` | Obsidian/white in Light; near-white/obsidian in Dark | Dark mode needs an equally visible primary action; not literal dark-on-dark copying |
| Ember `#FF5A00` credential/category badge | Optional, sparse editorial highlight badge | No fake credentials, verified status, or YC claims; never general actions/errors/links |
| White text on orange badge | Obsidian text on orange | White/orange is about 3.13:1; too low for ordinary badge text |
| Cosmica; DM Sans substitute | DM Sans implementation default until licensed Cosmica is approved | One family across UI/posters; do not assume supplied font assets or licensing |
| Compact 14–15 body text | 16 body/input baseline; 14 for secondary/dense content | Mobile readability, text scaling, and form usability take priority |
| 56–64 bold display headlines | Marketing/large editorial surfaces only | Do not make every dashboard card a hero section |
| 36 cards, 14 controls, 12 badges | Same default roles; 24 compact cards as explicit adaptation | Protect usable content at 320-wide windows; preserve the rounded character |
| Quick-start generic radii include 6, despite “not below 12” | Named component radii win; small data glyphs/check marks are separate | Avoid contradictory geometry rules copied into components |
| Hairline `#ECECEE` borders; no card shadows | Decorative card borders; stronger interactive boundaries | Decorative borders are not sufficient to identify all controls |
| Transparent email-input border, pale placeholders | Visible label, contrast-safe placeholder and control border | Form accessibility overrides the marketing sample |
| 1200 page max, 28 card padding, 80 section gap | 1200 workspace max; responsive card padding; 80 reserved for marketing | Keep forms/feed bounded and everyday capture compact |
| Dark feature blocks `#18181B` / `#27272A` | Derived dark surfaces ordered by actual lightness | Source “Deep Dark” wording does not make `#27272A` darker than `#18181B` |
| Photographic/category cards and grayscale logos | Real book covers, approved avatars/posters; optional public-page photography | No unrelated media feed, copied logos, fake testimonials, or fabricated metrics |
| Rotating hero words and horizontal showcase | Static by default; explicit navigation if a gallery is used | No required animation, auto-advancing carousel, or hidden essential content |
| Rare magenta decoration | Not adopted initially | One sparse orange accent is enough; avoid a second decorative palette |
| No complete dark theme or breakpoint policy | Sections 3 and 4 define derived behavior | These are Your Own rules, not discovered source measurements |

## 2. Token model and platform mapping

### 2.1 Token layers

Maintain one reviewed platform-neutral token source, with Flutter and web adapters. No generated token package exists yet. React components cannot be imported into Flutter.

1. **Reference primitives:** zinc colors, geometric sans, 4-unit spacing family, named radii.
2. **Semantic tokens:** surface, text, border, action, selection, status, mode, activity; light/dark mappings.
3. **Component tokens:** field, button, navigation, card, chart, table, poster; reference semantics rather than raw colors.

| Family | Examples | Rule |
|---|---|---|
| Surface/text | `surface.canvas`, `surface.default`, `text.primary`, `text.muted` | Every foreground has a known background |
| Interaction | `action.primary.bg`, `focus.ring`, `selection.bg`, `border.control` | Explicit states in both themes |
| Status | `status.error.fg`, `status.warning.bg`, `status.success.icon` | Semantic independence even when colors share neutral values |
| Mode | `mode.focus.icon`, `mode.read.label`, `mode.intake.icon`, `mode.money.label` | Labels/icons, not four hue palettes |
| Activity/chart | `activity.none` … `activity.level4`, `chart.axis`, `chart.grid` | Accessible legends/value access; not a universal success scale |
| Geometry | `space.16`, `radius.control`, `radius.card`, `content.form.max` | Numeric spacing suffix is the design-unit value, not an ordinal |
| Typography/motion | `type.body`, `type.display`, `motion.fast`, `motion.reduced` | Respect accessibility preferences |

### 2.2 Geometry, imagery, and elevation

| Family | Mapped defaults | Use |
|---|---|---|
| App spacing | 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 48 | Based on source 4-unit scale |
| Editorial spacing | 64, 68, 80, 120 | Public-page sections only where useful, not routine form gaps |
| Card padding | 20 compact; 28 expanded; 16 for dense nested sections | Do not put a large card inside another large card unnecessarily |
| Radii | Badge/nav item 12; button/input 14; compact panel/card 24; standard card/dialog 36 | Circles for avatars/thumbs; pill 10000 only for appropriate chips/nav CTAs |
| Special imagery | 48/64 section rounding; 40 icon-container rounding | Optional public visual sections, not every small icon |
| Borders | 1 decorative/control; 2 selected marker; 3 keyboard outline | Control boundary uses stronger semantic token |
| Touch targets | At least 48×48; 8 gap between adjacent discrete controls where practical | Grow for text; no overlapping invisible hit areas |
| Content limits | Form 640; feed/reading 720; workspace/marketing 1200 | Maximums, never minimum viewport widths |
| Navigation | Rail 80; sidebar 240 | Fall back when content/height is constrained |
| Pane minima | List 280; detail 360; gap 24 | Baselines, raised for content or larger text |
| Grid minima | Summary card 296; book tile 144 | Useful content width determines column count |
| Motion | Fast 120 ms; standard 180 ms; reduced 0 ms for nonessential movement | No default theme cross-fade or repeated celebration |

- Content cards use **no drop shadow**. Hierarchy comes from surfaces, grouping, typography, and borders. Dark cards use progressively lighter zinc surfaces, not brighter colored glows.
- Primary buttons use a solid accessible fill with a thin border. Any future inset highlight/gradient requires its complete values and contrast evidence to be added here before adoption; do not import an unspecified effect from an external reference.
- Menus/dialogs may use subtle `0 4px 12px rgba(0,0,0,0.04)` in Light if helpful, plus a clear boundary. Dark overlays rely on surface/border contrast. Shadow cannot be the only indication of a control or dialog edge.
- Scrims use obsidian `#09090B` at candidate 40% in Light, 64% in Dark. Test these product-specific defaults on actual underlying content.
- Web layer order: content 0, sticky 10, popover 20, modal backdrop/content 30/40, noninteractive toast 50. A menu opened inside a modal belongs to that modal's overlay layer. Stacking never substitutes for focus containment; Flutter uses equivalent overlay semantics.
- Checkboxes, chart marks, heatmap cells, dividers, and full-window edges are functional glyphs/structure, not rounded content cards. Their geometry can differ; keep checkbox and radio shapes distinguishable.
- Use original media pixels; never grayscale a user's cover/avatar/poster to match the UI. Public-page photography must be licensed, relevant, and nonessential to comprehension. No brand logos/photography are supplied or licensed by this mapping.

### 2.3 Platform adapters

| Concern | Flutter | Next.js user web/admin |
|---|---|---|
| Theme | Explicit `ThemeData`, `ColorScheme`, `ThemeExtension` roles | Semantic CSS variables under resolved root theme |
| Typography | Bundled approved font, `TextTheme`, supported `TextScaler` | Locally hosted font, `rem` sizes, unitless line heights, system fallback |
| Layout | Logical pixels; `LayoutBuilder` and parent constraints | CSS viewport/container constraints; actual available content width |
| Components | Customized Material 3 primitives/shapes/states; explicitly supplied app icons, not built-in glyph defaults | Owned/customized React primitives; no accidental default shadcn colors/radii/icons |
| Icons | Semantic icon adapter using the approved external rounded family | Same family and semantic aliases through a React adapter; no starter-icon fallback |
| Data charts | Native widgets/custom painting where needed, with explicit semantics | ApexCharts for user website; browser-only adapter; admin chart integration needs scope/license review |
| Appearance | `theme`, `darkTheme`, `ThemeMode` | Light/dark tokens plus matching native `color-scheme` |
| Navigation | One route/selection state across shell variants | One URL/selection model across compact/expanded variants |
| Posters | Explicit template-version palette/font | Same canonical rendering contract, not browser theme inheritance |

Do not rely on a seeded Material palette to generate these neutrals. Map primary/onPrimary, surfaces, selected states, and state overlays explicitly. Supporting library versions remain unselected; style examples do not approve a project dependency version.

Illustrative token structure, not an implemented file:

```json
{
  "space": { "4": 4, "8": 8, "12": 12, "16": 16, "20": 20, "24": 24, "28": 28, "32": 32, "36": 36, "40": 40, "48": 48 },
  "radius": { "badge": 12, "control": 14, "compactCard": 24, "card": 36, "pill": 10000 },
  "content": { "formMax": 640, "readingMax": 720, "workspaceMax": 1200 },
  "breakpoints": { "medium": 600, "large": 840, "largest": 1200 },
  "appearance": { "default": "system", "options": ["system", "light", "dark"] },
  "font": { "implementationDefault": "DM Sans", "licensedAlternative": "Cosmica" },
  "type": { "caption": 12, "label": 14, "body": 16, "title": 24, "display": 32 }
}
```

## 3. Typography, color, and visual hierarchy

### 3.1 Typography

**DM Sans** is the implementation default. **Cosmica** may replace it only after licensing, assets, glyph coverage, and mobile/web/poster rendering are approved. Use one chosen family, not different brand fonts on each platform. Web fallback: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; Flutter uses script-appropriate fallbacks. No runtime font download is required for basic rendering.

| Role | Baseline size / line height | Weight | Use |
|---|---|---|---|
| Caption | 12 / 20 | 400 | Supporting timestamps; never sole essential instructions |
| Label / compact body | 14 / 20 | 400; 500/600 strong | Secondary content, table metadata, labels |
| Body / input / button | 16 / 24 | 400 body/input; 500 button | All form factors; no automatic phone shrink |
| Reading emphasis | 18 / 26 | 400 | Optional long-form introductory text |
| Section title | 20 / 30 | 600 | Cards and sections |
| Compact page title | 24 / 32 | 600 | App screens and dialogs |
| Expanded title / metric | 32 / 40; 40 / 52 when useful | 600 | Workspace headers and important totals |
| Focus timer | 48 / 56; 64 / 72 when it fits | 600 | Tabular digits; short-height fallback |
| Marketing display | 40 / 52 compact; 56 / 72 or 64 / 72 expanded | 600; 700 sparingly | Editorial/public hero only |

These are design-unit baselines, not rendered caps. Respect browser font/zoom preferences and Flutter text scaling; allow wrapping/growth. No global scaling clamp or viewport-proportional body text. Letter spacing starts at normal/0. Use tabular figures for timers/Money and right-align numeric columns. Show currency/unit labels and a way to read exact amounts, not only abbreviations.

### 3.2 Light and derived dark palettes

Both palettes below belong to Your Own. Dark mode is derived from the adopted zinc primitives, not an official Awesomic dark theme or a dependency on an external theme file. No pure `#000000`, invert filter, or accidental white modal on a dark screen.

| Semantic token | Light | Dark | Role |
|---|---|---|---|
| `surface.canvas` | `#F4F4F5` | `#09090B` | App/page background |
| `surface.default` | `#FFFFFF` | `#18181B` | Cards, fields, navigation |
| `surface.raised` | `#FFFFFF` | `#27272A` | Floating menus/dialogs |
| `surface.muted` | `#FAFAFA` | `#27272A` | Nested group, neutral hover surface |
| `text.heading` | `#09090B` | `#FAFAFA` | Headings and key metrics |
| `text.primary` | `#18181B` | `#FAFAFA` | Body and labels |
| `text.secondary` | `#52525B` | `#D4D4D8` | Supporting text |
| `text.muted` | `#52525B` | `#A1A1AA` | Placeholder/caption, without added opacity |
| `icon.default` | `#52525B` | `#D4D4D8` | Essential icon strokes |
| `border.default` | `#ECECEE` | `#3F3F46` | Decorative cards/dividers |
| `border.control` | `#71717A` | `#A1A1AA` | Required control/field boundary |
| `link.default` | `#18181B` | `#FAFAFA` | Underlined inline links; no blue accent |
| `focus.ring` | `#09090B` | `#FAFAFA` | Opaque 3-unit outline, 2-unit surface-colored offset |
| `selection.bg` | `#ECECEE` | `#3F3F46` | Selected navigation/tab/list state |
| `selection.fg` | `#18181B` | `#FAFAFA` | Selected text/icon/marker |
| `disabled.bg` | `#F4F4F5` | `#27272A` | Inactive filled control |
| `disabled.fg` | `#52525B` | `#A1A1AA` | Readable disabled label plus semantics |
| `accent.badge.bg` | `#FF5A00` | `#FF5A00` | Sparse optional editorial highlight |
| `accent.badge.fg` | `#09090B` | `#09090B` | Accessible orange-badge text |

`border.default` is decorative, not proof of usable control contrast. Interactive fields and outlined controls use `border.control`. Selected items add a marker/weight and semantic current/selected state. Text inside selected/pressed surfaces uses the paired selected/action foreground; do not reuse muted text on a darker selected fill without testing that pair. An orange badge is not selectable, verified, successful, urgent, or destructive merely because it is orange.

Optional dark editorial feature sections on a Light page use a scoped dark surface/text/action/focus token context, not dark background with inherited dark text. This local context does not change the user's global appearance preference. Images retain their original pixels.

### 3.3 Actions and semantic statuses

| Token | Light | Dark |
|---|---|---|
| `action.primary.bg` | `#09090B` | `#FAFAFA` |
| `action.primary.fg` | `#FFFFFF` | `#09090B` |
| `action.primary.hover` | `#27272A` | `#ECECEE` |
| `action.primary.pressed` | `#3F3F46` | `#D4D4D8` |
| `action.secondary.bg` | `#FFFFFF` | `#18181B` |
| `action.secondary.fg` | `#18181B` | `#FAFAFA` |
| `action.secondary.hover` | `#F4F4F5` | `#27272A` |
| `action.secondary.pressed` | `#ECECEE` | `#3F3F46` |

Ghost/icon actions use primary text on their parent surface, with neutral hover/pressed fills. Loading retains a readable label and spinner; disabled uses dedicated tokens, not a blanket opacity on the entire component. Focus is visible with keyboard and external-keyboard use. Do not layer untested translucency over these pairs.

To preserve Your Own's achromatic identity, **status semantics use neutral paired surfaces, distinct icons, and explicit headings—not red/green/blue fills**:

| Status | Foreground / background in Light | Foreground / background in Dark | Mandatory distinction |
|---|---|---|---|
| Info | `#18181B` / `#F4F4F5` | `#FAFAFA` / `#27272A` | Info icon + context text |
| Success | Same neutral pair | Same neutral pair | Check icon + exact accepted/completed outcome |
| Warning | Same neutral pair | Same neutral pair | Warning icon + consequence/review instruction |
| Error | Same neutral pair | Same neutral pair | Error icon + error title/message; `aria-invalid`/equivalent |
| Destructive | Neutral outlined action; filled primary only at final confirmation | Same role-based policy | Explicit verb/target, destructive icon, consequence text, separate confirmation where needed |

Keep separate status tokens despite shared values so future accessibility findings can be addressed without rewriting components. Do not introduce colored severity fills casually. Admin severity uses text, icons, ordering, and borders—not shade alone. Error fields have a strong boundary, linked error text, and semantic invalid state. More spending, coffee, or water never becomes “greener = better.”

### 3.4 Modes, charts, and activity

| Mode | Neutral identity | Required recognizable content |
|---|---|---|
| Focus | Timer/checklist icon + “Focus” | Tasks, duration, sessions |
| Read | Book icon + “Read” | Cover/title, pages, shelf |
| Intake | Cup/drop icon + “Intake”; separate water/coffee labels | Units, amounts, water target, coffee count |
| Money | Wallet/ledger icon + “Money” | Currency, account, exact values and privacy control |

Mode foregrounds use ordinary text/icon tokens. No separate violet/ochre/blue/green themes. In multiseries charts, use direct labels, different line/point patterns, grouped bars, or separate small charts. An accessible data table/summary remains available; five gray lines without labels are not sufficient.

| Activity token | Light | Dark |
|---|---|---|
| `activity.none` | `#ECECEE` | `#27272A` |
| `activity.level1` | `#D4D4D8` | `#52525B` |
| `activity.level2` | `#A1A1AA` | `#A1A1AA` |
| `activity.level3` | `#52525B` | `#D4D4D8` |
| `activity.level4` | `#18181B` | `#FAFAFA` |

Intensity means **0–4 distinct modes recorded**, not quantity consumed/spent or likes received. Adjacent swatches are not guaranteed 3:1 apart: provide date/count access, legend, selected-day detail, and a non-color list/calendar alternative. Do not use these swatches as arbitrary text backgrounds. `chart.axis` uses secondary text; decorative grid lines use border tokens; essential plotted marks use contrast-tested foregrounds and patterns.

### 3.5 Appearance behavior

- Offer **System / Light / Dark** in mobile, user-web, and admin settings. Default System; explicit choice wins. System alone follows OS/browser changes.
- Persist per installation/browser origin initially. Cross-device synchronization is not implied. User-web and admin preferences remain separate; appearance is not a credential.
- Flutter resolves local preference early and sets `ThemeMode`, including appropriate system-bar contrast. Native launch-screen behavior requires actual-device testing; no dynamic launch assets are claimed implemented.
- Web uses a validated non-sensitive preference such as an allowlisted `system/light/dark` cookie for explicit server-rendered choice. System resolves via `prefers-color-scheme` before first paint. CSS and hydrated state must agree; any bootstrap must comply with CSP. Do not hide mismatches with a blank page or hydration-warning suppression.
- Set native `color-scheme` consistently, including native fields/scrollbars where supported. Admin does not read user-web credentials to obtain a preference.
- Theme the entire component inventory: sheets, dialogs, menus, tooltips, pickers, tables, charts, skeletons, empty/error states, composer, previews, and settings—not just the dashboard.
- Preserve focus, selected records, drafts, scroll, hide-amounts, and timers when appearance changes. No domain write, replayed success animation, or private-screen cross-fade.
- Book covers, avatars, and published images retain original pixels. Viewer theme changes their surround, not their content.
- Poster appearance is an explicit versioned template choice. Viewing a post in Dark never regenerates an existing light poster.

### 3.6 Contrast evidence and limits

Calculated with the WCAG sRGB relative-luminance formula for opaque pairs. Values are rounded for display; test thresholds use unrounded values.

| Pair | Contrast | Result for this pair |
|---|---|---|
| Source white on orange `#FF5A00` | 3.13:1 | Fails ordinary badge text; replaced |
| Source ash `#A1A1AA` on white | 2.56:1 | Fails ordinary placeholder text; replaced in Light |
| Light heading on canvas / body on card | 18.10 / 17.72:1 | Clears ordinary-text threshold |
| Light secondary on muted / muted text on canvas | 7.41 / 7.03:1 | Clears ordinary-text threshold |
| Dark heading on card / secondary on muted / muted text on muted | 16.97 / 10.08 / 5.81:1 | Clears ordinary-text threshold |
| Light primary label: default / hover / pressed | 19.90 / 14.89 / 10.44:1 | Clears ordinary-text threshold |
| Dark primary label: default / hover / pressed | 19.06 / 16.86 / 13.46:1 | Clears ordinary-text threshold |
| Obsidian label on orange badge | 6.36:1 | Clears ordinary-text threshold |
| Light control border on canvas / dark control border on muted | 4.40 / 5.81:1 | Clears 3:1 required non-text contrast for these pairs |
| Light focus ring on canvas / dark focus ring on muted | 18.10 / 14.27:1 | Clears 3:1 for these backgrounds |
| Light / dark selected foreground on selected background | 15.02 / 10.01:1 | Clears ordinary-text threshold |
| Light / dark status foreground on status background | 16.12 / 14.27:1 | Clears ordinary-text threshold |

These calculations do not certify complete UI components. Test real compositing, text, focus adjacency/occlusion, all states, charts, native controls, and images. Normal text targets 4.5:1; qualifying large text and essential non-text boundaries target 3:1. Do not apply the large-text exception to a 16-unit button label. Source descriptions such as “readable gray” are not contrast evidence.

## 4. Adaptive layout system

### 4.1 Layout policy and authority

Your Own uses a 1200 maximum content width, rounded surfaces, and the four Small/Medium/Large/Largest window classes. Sections 2 and 4 specify the spacing, content constraints, and mobile/tablet/desktop conditions together; no external breakpoint or layout reference is needed.

Classify usable window space, not device identity. A large iPad in split view or a narrow desktop browser may be Small. A 1024-wide tablet is Large, not “desktop” because of a device-name rule. Portrait/landscape alone never selects the layout.

### 4.2 Window and content conditions

`W` is available app-window width after relevant left/right safe insets and before app navigation/page gutters. Flutter uses logical pixels and parent constraints; web/admin use available CSS viewport/container width, accounting for scrollbars/insets. A narrow child pane remains narrow inside a large window.

| Class | Width condition | Typical context, not detection | Default shell | Side gutter / grid gap |
|---|---|---|---|---|
| Small | `W < 600` | Phone, narrow split view/browser | Bottom/compact navigation; one main pane | 16 / 16 |
| Medium | `600 <= W < 840` | Tablet portrait, medium window | 80 rail when height/content fit; otherwise compact | 24 / 16 |
| Large | `840 <= W < 1200` | Tablet landscape/large portrait, laptop window | Rail; 240 sidebar only if content stays usable | 32 / 24 |
| Largest | `W >= 1200` | Large iPad landscape, expanded desktop | 240 sidebar where useful; bounded workspace | 40 / 24 |

**Layout rules:**

- Content width `C = min(1200, W - actual navigation width - 2 × side gutter)`, further reduced by local container constraints. Reduce gutters if accessibility/embedded layouts need room.
- Summary grid columns at baseline size: `max(1, min(3, floor((C + gap) / (296 + gap))))`. If only one card fits, it shrinks to the available width; 296 is not a forced overflow minimum. Raise the minimum or use a list at large text sizes.
- A 1200-wide window with sidebar/gutters may fit only two cards, not three. Read book tiles use their own 144 baseline minimum and title-access rules.
- Two panes require `C >= 280 + 24 + 360` plus useful height and actual content fit. Width class permits panes; it does not guarantee them. Third panels require all local minima or fall back to detail navigation.
- Forms remain within 640; feed/long text within 720; workspace/public content within 1200. Do not fill a large monitor with stretched text, giant controls, or a second feed.
- Available interactive height excludes keyboard and relevant top/bottom insets. Below candidate 480 height, prefer compact navigation and scrollable sequential content. Any retained rail must be scrollable with all destinations reachable.
- Small/short-height editors use scrollable full-screen flows or suitable sheets. Wider windows can use bounded dialogs/side panels with reachable actions. Text scaling can still require full-screen.
- Compact cards use radius 24/padding 20; expanded cards use radius 36/padding 28. Keep card identity while reclaiming usable width. Buttons/fields retain radius 14 and accessible targets at all sizes.
- Preserve selected entity, unsaved data, timer/session, navigation history, and practical scroll context. Reflow cannot duplicate writes, create a second timer, or reveal hidden fields.
- Minimum verification width is 320, not a global forced `min-width: 320`. Support narrower effective reflow without hiding essential features. No accidental whole-page horizontal overflow; intentional chart/table/calendar scrolling is labeled and operable.

### 4.3 Mobile, tablet, and desktop verification matrix

Sizes below are representative viewports before platform-specific insets, not exact guarantees about every device. Actual usable `W` determines the class.

| Condition | Representative viewport(s) | Expected behavior |
|---|---|---|
| Phone portrait | 320×568, 360×800, 390×844, 430×932 | Small; stacked content, quick capture, reachable actions |
| Short phone landscape | 568×320; 844×390 | Small then potentially Large by width; short height still prevents forced tall/two-pane flows |
| Tablet portrait | 768×1024, 820×1180 | Medium before insets; rail/grid only when usable |
| Tablet landscape | 1024×768, 1180×820 | Large; practical list/detail, not mandatory panes |
| Large iPad-style portrait/landscape | 1024×1366, 1366×1024 | Large / Largest; bounded useful workspaces |
| Tablet split/floating windows | 375×1024, 600×1024, 820×1024 | Small / Medium / Medium if these are usable widths |
| Narrow desktop browser | 560×900, 800×900 | Small / Medium despite desktop hardware |
| Laptop / ordinary desktop | 1280×800, 1440×900 | Largest if usable width permits; no stretched feed/forms |
| Large desktop | 1920×1080, 2560×1440 | Largest; content stays max 1200, remaining space intentional |
| Class transitions | 599/600, 839/840, 1199/1200 usable width | Exactly one transition; no gaps/overlap or state reset |
| Short-height transition | 479/480 interactive height | All destinations/actions reachable in either layout |
| Accessibility/input | 200% text; web 400% zoom/reflow where applicable; keyboard visible | Content reflows, focus/Save/Send remain reachable |

Run both Light and Dark, System changes, live resizing, portrait/landscape, touch, pointer, and external keyboard. Physical display resolution/DPR does not define breakpoints. Actual supported-device testing is still required.

### 4.4 Screen-specific adaptation

| Surface | Small / constrained | Medium | Large / Largest when content fits |
|---|---|---|---|
| Today | Priority and quick actions, stacked summaries | One/two-column summaries | Bounded 2–3-column dashboard, not empty decorative cards |
| Focus | Task list and timer/detail sequential | Can remain sequential | Tasks beside timer/detail |
| Read | List/compact cover grid; separate detail | Responsive grid | Grid with optional book-detail pane |
| Intake | Quick log, then summary/history | Grouped capture/history | Capture and summary beside history |
| Money | Overview, history, editor as focused routes | Summary grid and history | Accounts/history/detail only when minima fit; constrained editor |
| Progress | Period and accessible day detail | Stacked/paired calendar and detail | Calendar beside selected-day detail |
| Circle/feed | One readable chronological column | Still one column | One max-720 feed plus optional detail, never multiple feeds |
| DMs | List then thread | Split only when minima/height fit | List beside thread; composer keyboard-safe |
| Settings/onboarding | Grouped sequential sections | Bounded form | Category navigation plus bounded section; no oversized form |
| Poster composer | Sequential choices and fit/zoom preview | Preview and controls if useful | Bounded preview beside controls; fixed export dimensions |
| Admin | Drawer, stacked evidence/cases; intentional table scroll | Rail and compact case views | Table/detail workspace with readable confirmation context |
| Public web | Stacked headline/CTA, authentic visuals | Optional feature pairs | Editorial composition, max 1200, not an app dashboard clone |

## 5. Navigation and core components

### 5.1 Universal component contract

Every component below must specify:

- Semantic purpose, accessible name/role, keyboard/focus behavior, and touch target.
- Light/Dark rendering; default, hover (pointer only), pressed, focus-visible, selected/checked, disabled, read-only, loading/pending, invalid, and unavailable states **where applicable**.
- Small through Largest behavior, short height, long localized content, 200% text, RTL-ready structure where practical, and browser reflow.
- Empty/error/retry/data-unavailable behavior, plus permission/hidden-value behavior where it contains data.
- Safe async behavior: no double submit, truthful outcome, retained input, and focus restoration.

Do not implement unrelated variants just to satisfy a checklist. Static cards do not need a hover effect; links need native link behavior, not a fake disabled-button state. Appearance alone never grants permission.

### 5.2 Navigation and discovery inventory

| Component family | Contract | Adaptive behavior |
|---|---|---|
| `AppShell`, `BoundedPage` | Shared routes, safe insets, current destination, readable width | Bottom/compact → rail/sidebar with same state |
| `BottomNavigation`, `NavigationRail`, `Sidebar`, `NavItem` | Icon + label; current indicator; 48 target; no color-only selection | Same logical destinations; rail/sidebar must scroll if short |
| `PageHeader`, `BackButton`, `PageActions` | Clear title/context, predictable back, ordered primary/overflow actions | Wrap actions; do not truncate the only title/target identifier |
| `Tabs`, `SegmentedControl` | Distinguish navigation tabs from value choices; selected semantics and keyboard pattern | Wrap or labeled deliberate scroll; never tiny compressed segments |
| `Breadcrumbs` | Web/admin hierarchy, links except current item | Collapse ancestors into an accessible menu, not all context |
| `SearchField`, `SearchResults`, `FilterBar`, `FilterChip` | Visible query/filter state, clear action, loading/no-results; accessible suggestions if used | Filters become sheet/dialog; same active filter model |
| `DateRangeFilter`, `SortControl` | Explicit range/order/timezone context where needed | Bounded popover or full-screen picker; no hidden sort reversal |
| `Pagination`, `LoadOlder`, `CaughtUp` | Labeled page/load control, loading state, stable focus/scroll | Server-paginated admin lists; finite social batches, not infinite scroll |
| `StepIndicator` | Progress through onboarding/card creation; back preserves input | Textual current/total on small screens; no arbitrary mandatory steps |
| `NotificationEntry`, `UnreadBadge` | Accessible unread count/description; never flashing or fake urgency | Header entry stays reachable; count has text equivalent |
| `PublicHeader`, `PublicFooter`, `AppLink` | Product/policy/platform links; auth/app availability truthful | Public nav may collapse; app's daily navigation is not hidden behind marketing menus |

### 5.3 Actions, selection, and surfaces

| Component family | Geometry and treatment | Interaction/state requirements |
|---|---|---|
| `PrimaryButton` | Radius 14, padding at least 12×16 as content needs; min target 48 | Neutral primary pair; one dominant action per task group; pending label/spinner |
| `SecondaryButton`, `GhostButton`, `TextLink` | Neutral surfaces/text; control border where needed; inline links underlined | Visible press/focus; no orange CTA; link stays a link |
| `IconButton`, `OverflowButton` | 48 hit target; 20/24 baseline icon | Accessible name, tooltip where useful; never unlabeled destructive action |
| `DestructiveAction` | Neutral outlined by default, explicit verb/icon | Explain target/effect; final confirmation separate from routine Save |
| `QuickCaptureAction` | Clear icon, label, unit/amount; neutral button | Immediate feedback, correction path, no duplicates; direct mode access remains possible |
| `Checkbox`, `Radio`, `Switch` | Distinguishable checked/radio/on shapes; 48 labeled hit region | Checked/indeterminate/disabled semantics; Space/arrows per platform; no auto-save ambiguity |
| `ChoiceChip`, `Tag`, `StatusBadge`, `AccentBadge` | Radius 12, 4×8 visual padding; interactive hit box grows | Static vs selectable/removable clearly distinguished; orange only optional highlight |
| `Card`, `SummaryCard`, `SectionPanel` | Radius 24 compact / 36 expanded; border, no shadow | Static cards do not pretend to be buttons; nested actions are independently accessible |
| `MetricBlock`, `MetricRow` | Strong number, unit, period, descriptive label | Exact-value access, hidden/unknown states, no fabricated zero |
| `Divider`, `SectionHeading`, `KeyValueList` | Hairline decorative border and clear hierarchy | Reading order and heading levels remain meaningful |
| `Accordion`, `Disclosure` | Neutral outlined/grouped section, explicit expanded state | Keyboard activation; essential error/privacy information not hidden by default |
| `StickyActionBar` | Surface/border separates content; safe-area padding | Cannot obscure fields/errors; scroll/reflow when keyboard or short height intervenes |

Controls grow beyond baseline height as needed. A 16/24 field plus 12 vertical padding already needs 48 before borders; do not hard-clip it to a reference screenshot's height. Dense admin rows reduce whitespace, not touch accessibility.

### 5.4 Overlays, media, and data display

| Component family | Contract | Responsive / safety condition |
|---|---|---|
| `Dialog`, `AlertDialog`, `ConfirmDialog` | Named dialog, meaningful initial focus, focus containment/restoration; clear Cancel | Radius 24/36; bounded on large, full-screen when small/short; don't default focus to destructive confirm |
| `BottomSheet`, `SideSheet`, `Drawer` | Close control, appropriate modal semantics; no drag-only dismissal | Small capture/filters can become bounded panel; preserve draft and selection |
| `Popover`, `DropdownMenu`, `ContextMenu` | Correct menu/listbox/dialog semantics; Escape closes; returns focus | Reposition to fit; essential actions also reachable without right-click/hover |
| `Tooltip`, `HelpDisclosure` | Supplementary description, not sole label/instructions | Keyboard/touch equivalent for required information; no private data in generic tooltip |
| `Avatar`, `AvatarGroup`, `ImageFallback` | Name/initial fallback, appropriate alt text/decorative semantics | No broken-image leak; do not expose unauthorized profile details |
| `BookCover`, `MediaFrame`, `PosterPreview` | Original image pixels, loading/error fallback, aspect ratio | Bounded fit; no cropping essential poster text; zoom has accessible controls |
| `AvatarUpload`, `CoverUpload` | Preview/remove/retry/progress, supported type/size feedback | Only approved upload contexts; no arbitrary social/DM media attachments |
| `HistoryList`, `ListRow`, `Timeline`, `DetailPanel` | Stable identity/order, metadata, current selection, empty state | List/detail collapse preserves selected record; no private fields added on expansion |
| `DataTable`, `TableToolbar`, `RowActions` | Header associations, server sort/filter/page state, focusable actions | Stack meaningful fields or use labeled local scrolling; optional virtualization preserves access |
| `ChartFrame`, `Legend`, `DataSummary`, `ProgressBar`, `ProgressRing` | Label/value/period, unknown/zero states, text alternative, clamped visual goal indicator | Neutral marks with patterns; no color-only meaning or inaccessible hover-only values |
| `Calendar`, `ContributionGrid`, `DayDetail` | Date/count semantics and selection, legend, keyboard/date-list alternative | Compact month/list vs annual overview; tiny cells not sole tap target |

Uploads/cropping are provided only when supported by the approved media flow; do not invent external catalog search, a graphic editor, or arbitrary attachments. Native mobile share sheets require platform-specific placement/anchors, including iPad popovers.

### 5.5 Public and editorial compositions

These compositions apply only where the website's approved content needs them; they are not mandatory new features.

| Composition | Mapping and constraints |
|---|---|
| `HeroSection`, `ProductCTA` | Bold single-family heading, short explanatory copy, truthful platform/download/sign-in action; stacked on Small, optional split composition when content fits |
| `FeatureGrid`, `ImageTopCard` | Radius 24/36, real approved product imagery, title and optional tags; content-fit columns, no unrelated portfolio/video feed |
| `DarkFeaturePanel` | Rounded neutral feature section with scoped dark tokens, labeled list items, and accessible actions; no auto-inverted media |
| `StatsRow` | Metric block plus description and scope/date; only verifiable approved product facts, not invented user counts or claims |
| `LogoStrip`, `QuoteBlock` | Optional only with legitimate permissions and accurate attribution; omit rather than fabricate social proof |
| `PhotoDivider` | Optional licensed static image, appropriate alt/decorative semantics, 48/64 section rounding; not necessary to understand the page |
| `PolicyArticle`, `SupportContent` | Semantic headings, bounded reading width, lists/links, version/date where relevant; readable in both themes, no hidden consent or fake support availability |

Automatic rotating keywords, auto-advancing carousels, and newsletter/email-capture workflows are not implied by this design system. A later approved gallery needs explicit controls, keyboard access, meaningful image alternatives, and reduced-motion handling.

### 5.6 Rounded icon system

Use **Hugeicons Free — Stroke Rounded only**, selected in Decision 0004 across mobile, user web, admin and icon-bearing poster templates. “Rounded” describes the glyph contours, caps and joins, not only its container. The [static review](toolchain-review.md#5-rounded-icons--selected-family-and-coverage-evidence) supports the family choice, not full visual/coverage or distribution-notice verification. Flutter's local `hugeicons 1.2.0` adapter now has 28 core aliases and host contact-sheet checks; React, full product/native coverage and final distribution/poster checks remain unverified. No Pro packs or mixed-style/family fallbacks.

- Cover mode identities, navigation, back/close/menu/chevrons, capture/edit/delete, privacy, sync/status, social/messaging, settings and staff workflows in one visual family. Audit implicit picker/dialog/menu/component icons too.
- Do not use Material Icons/Material Symbols, including Rounded variants, or Flutter's built-in Material/Cupertino icon sets for app-owned iconography. Next.js has no built-in icon family; replace icons copied from starters/shadcn or supplied by component defaults rather than accepting them automatically.
- Define semantic names through `AppIcon`-style Flutter/React adapters and an icon catalog. Features reference meaning, not vendor-specific glyph names scattered through screens. Keep stroke weight, optical size and any selected/unselected variants coherent within the chosen family.
- Review actual glyph coverage and matching source assets/Flutter/React support, license, cost, attribution and poster-output rights. Bundle approved used assets locally; do not require a runtime icon CDN. No silent fallback to another library, emoji or an unlicensed paid asset when a glyph is missing.
- Baseline visual size is 20/24 within the existing minimum 48×48 action target. Preserve contrast, accessible names, meaningful labels and appropriate directional mirroring; decorative icons do not duplicate spoken text.
- This icon-artwork restriction does not prohibit accessible Material widget primitives or Flutter's `Icon` renderer. OS-owned share sheets/keyboards and approved provider brand marks keep their required artwork; they are not app-icon fallback sources.
- Validate a representative icon contact sheet in Light/Dark and at actual sizes, then add source/asset and component checks against prohibited or implicit default glyphs. No particular icon package is approved just by writing this rule.

## 6. Forms and data entry

### 6.1 Form primitives

| Component family | Required behavior |
|---|---|
| `FormSection`, `FieldLabel`, `HelperText`, `FieldError`, `ErrorSummary` | Persistent label, explicit required/optional, programmatic association; summary links to invalid fields |
| `TextField`, `TextArea` | Plain-text entry by default; long content wraps; max-length feedback where limits exist; preserve on failure |
| `EmailField`, `UsernameField` | Correct input mode/autocomplete; validation timing does not interrupt typing; safe availability/error messaging |
| `PasswordField`, `CodeField`, `AuthProviderButton` | Only for selected authentication methods; password-manager/paste support, reveal control, no split-code accessibility trap |
| `Select`, `Combobox`, `MultiSelect` | Label and selected state, keyboard navigation, clear/no-results/loading; native picker or accessible custom equivalent |
| `DatePicker`, `TimePicker`, `DateRangePicker` | Manual-entry alternative where practical; locale-aware input; distinguish date-only from instant/timezone |
| `AmountField`, `CurrencyField`, `UnitField` | Exact string/minor-unit parsing, visible currency/unit; locale formatting cannot change meaning |
| `NumericStepper`, `QuantityPreset` | Explicit bounds/units, keyboard/manual input alternative, reachable ± targets; no rapid accidental duplicate logging |
| `Slider` | Only when approximate selection fits the domain; labeled value and keyboard/manual equivalent; not sole exact Money/page input |
| `CheckGroup`, `RadioGroup`, `AppearancePicker` | Group label, current value, correct selection semantics; System/Light/Dark distinct options |
| `FileField`, `UploadProgress` | Allowed contexts/type/size, progress/error/retry/remove; authenticated upload result is not publication |
| `FormActions`, `PendingSubmit`, `UnsavedChangesGuard` | Reachable Save/Cancel, retained input, idempotent retry; confirm discard only when a real draft would be lost |

### 6.2 Data-entry rules

- Keyboard/input mode assists entry without unsafe numeric parsing. Money does not use floating-point browser `Number` as canonical ledger data.
- Required/optional labels and units remain visible after input. Placeholder is an example, not a label.
- Validate locally for feedback and server-side for authority. Preserve input on conflict, rejection, expired session, and uncertain outcome where safe.
- Submit/Enter must not double-log. Pending UI is not idempotency; retry retains operation identity.
- Save/Send and validation stay reachable with keyboard open, short landscape height, and enlarged text. Return focus meaningfully after picker/dialog close.
- Distinguish disabled (unavailable), read-only (inspect/copy allowed where safe), and loading (being resolved). Explain unavailable actions when useful without leaking permissions/data.
- Date-only records and occurrence instants are distinct; show timezone context where meaningful. Locale display cannot change historical snapshot meaning.
- Undo calls the valid repository/API correction/cancel/delete flow. Removing a row/toast alone does not undo a pending or accepted operation.
- Do not force a wizard for one-field water/page capture. Do not place routine data entry in a decorative marketing card with excessive padding.

### 6.3 Identity, onboarding, and settings compositions

| Composition | Components / states |
|---|---|
| Authentication / recovery | Bounded form, approved provider controls, validation, submitting/error/recovery confirmation; no unapproved auth methods implied |
| Onboarding | Username/profile, account visibility explanation, mode choices, timezone/units, conditional base currency; optional goals/avatar; skip/back preserve data |
| Profile editor | Avatar preview/upload, display name/bio, username rules, save/unsaved state; plain-text handling |
| Appearance / preferences | Appearance picker, language where supported, unit/timezone/currency context, mode visibility; local theme change never writes domain records |
| Notification / device permission settings | Category toggles, contextual permission explanation, denied/permanently-denied/open-system-settings states; no permission wall |
| Account / security / data | Session/account controls supported by backend, sign-out confirmation when needed, export job status, deletion consequences/reauthentication |
| Privacy / blocking | Public/private account setting, DM permission choices, blocked-account list and explicit unblock confirmation where needed |

## 7. Progress and contribution views

### 7.1 Shared progress semantics

The proposed 0–4 intensity counts distinct modes with qualifying recorded activity. Label it **activity recorded**, not productivity, health, wealth, or a universal life score. Goals and quantities are separate views.

- Show period, legend, selected date, and accessible day detail. Filters/mode visibility do not delete history.
- Distinguish no-data, scheduled rest/non-goal, and applicable missed-goal states without shame.
- Annual overview can be compact, but tiny cells are never the only access. Provide larger month/day view, period/date picker, keyboard navigation, or day list.
- Avoid hundreds of unstructured screen-reader nodes. Meaningful group summaries and deliberate date navigation are required.
- Charts always have readable value/summary access; grayscale levels alone are insufficient.
- Focus excludes pause/break time; unknown book total is not 0% or 100%; water target visuals stop escalating after attainment; coffee and water remain separate.
- Money shows manual balances, income/expense, plans, and savings status separately. Bigger values do not imply better progress; savings planning does not create assets or move funds.

### 7.2 Personal-domain component coverage

| Area / release | Compositions and components | Required edge states |
|---|---|---|
| Today / V1-A | Date header, priority/task list, active-session strip, mode summary, quick-capture tray, currently-reading row, compact week summary | All modes hidden, first-use, partial failure, offline/pending, hidden Money totals |
| Focus tasks / V1-A | Task row/check, task editor, label picker, Today filter, task detail, completion feedback | Long title, completed/reopened, deleted/unsynced, no task selected; no project-management expansion |
| Focus timer / V1-A | Timer display, countdown/count-up choice, start/pause/resume/finish/cancel, active-session strip, session history/detail | Idle/running/paused/break/finished, restart recovery, overlap conflict, background/notification denial; no per-second screen-reader announcement |
| Read / V1-A | Shelf filter, book tile/list, cover fallback, manual book form, page update field, progress indicator, finish confirmation, history/goal summary | Unknown total, long title, missing cover, correction/backdate, finished/reopened; no catalog integration assumed |
| Intake / V1-A | Water/coffee selector, amount presets, unit selector, quantity input, water-target meter/editor, history row/edit, reminder settings | Optional target, over-target without celebration escalation, offline/pending/correction; no inferred caffeine/medical advice |
| Money accounts / V1-A | Account tile/list, account editor, balance row, hide-amounts action, account detail | Manual/unverified label, empty/archived account, hidden amount, exact large/negative value |
| Money transactions / V1-A | Type selector, amount/currency, category/account/date/note, transfer account pair, transaction row/detail/editor | Income/expense/transfer/adjustment explicitly labeled; same-account/invalid amount errors; atomic transfer; no Pay/Connect Bank controls |
| Money plans / V1-A | Month selector, budget category row, planned/actual summary, savings-goal card/editor, contribution history | Plan vs transaction distinction, over/under plan, missing target, withdrawal/correction; no asset duplication |
| Progress / V1-A | Contribution grid, period/mode filters, goal summary, metric chart/table, selected-day timeline, shareable recap entry | Empty/partial/loading, timezone boundary, corrected history, hidden/unavailable values; rest/restart without guilt |

Goal bars/rings show numeric actual/target separately; visual saturation stops at the goal while over-target numbers remain truthful. This does not erase records or turn unlimited spending/intake into achievement.

### 7.3 Chart rendering and platform ownership

**User website: ApexCharts is selected in principle, with installation/integration on hold pending licensing clarification under Decision 0004.** Core/React-wrapper versions, license/entitlements, Next.js compatibility, browser support and bundle cost must still pass M00-T04/M00-T09 review. Do not substitute a starter's Recharts/Chart.js component without an explicit decision. Admin may reuse this adapter for approved operational charts after scope/license review; this adds no private staff tracking dashboard.

- Keep ApexCharts behind a browser-only entry/adapter. Do not evaluate browser-dependent chart modules during server rendering; if an SSR-disabled dynamic import is needed, place it inside a Client Component. Keep a stable accessible summary/loading/error frame and test actual production build/hydration behavior.
- Load chart code only where a released feature needs it, not on every public page. Use bundled/local approved assets; no hosted chart/embed service receiving private records.
- Override library defaults with semantic light/dark tokens, typography, neutral/patterned series, direct labels and rounded line ends/bar corners where suitable. Rounding must not distort values, stack boundaries or zero/negative meaning. Do not smooth curves into fabricated intermediate measurements.
- Replace any retained toolbar icons with the selected rounded icon family or disable unused controls. Downloads/CSV/image export require explicit feature/privacy review; a library default does not grant that capability.
- Provide keyboard/touch access and readable exact-value summaries/tables independent of hover, color or the chart library's claimed accessibility. Respect reduced motion, all four sizes and local container changes without resetting selection.
- Money calculations and formatted labels/tooltips/tables use exact canonical values. Bounded approximate plotting coordinates are presentation only; handle large/negative/missing values without silently rounding the ledger or reporting false precision. Hide/unmount/redact sensitive series when hidden values could otherwise be exposed; clear chart state on session/account changes.
- Contribution calendars/date navigation and simple progress bars/rings may remain purpose-built semantic components. ApexCharts is the user-web data-chart engine, not a requirement to turn every calendar/control into a chart or a replacement for the versioned poster renderer.

**Flutter: native/custom where needed.** Use widgets and, where needed, `CustomPainter` behind reusable chart contracts. Supply explicit semantics/data alternatives, hit testing and selection when interactive, constraint-aware layout, text scaling, reduced motion and bounded repaint cost. A painted chart without accessible values is incomplete. No Flutter chart library is selected; any dependency requires review, and an ApexCharts WebView is not implied.

## 8. Cards and social interactions

### 8.1 Progress poster contract

A template defines type/version, approved font/assets, fixed export dimensions, fields, units/period, attribution, accessible text, and safe overflow. Candidate portrait 1080×1350 may be evaluated; final dimensions remain unselected. Output never depends on screen size/DPR.

- Curated templates, not a full graphic editor or arbitrary post creator.
- Only selected snapshot fields enter rendering; CSS hiding is not privacy.
- Exact canonical preview before explicit publication. Rendering completion is not publishing.
- Missing/hidden data is not replaced with invented achievements. Plans say “plan”; self-entered records are not “verified”; omitted amounts stay omitted.
- Setbacks/restarts attach to supported recaps/plans, not standalone-post loopholes.
- Apply the chosen single-font hierarchy, zinc surfaces, generous card geometry, and sparse badge accents. No fake button/credential decoration in posters.
- Optional Light/Dark poster variants are explicit versioned choices captured with the template. Viewer theme cannot recolor an existing publication.
- Test the actual image at export and reduced feed size, with long localized content. A UI palette check does not prove poster legibility.
- External export warns that downloaded images/screenshots cannot be recalled.

### 8.2 Publishing and social inventory

| Component family / release | Contract |
|---|---|
| `CardSourcePicker`, `TemplatePicker` / V1-A preview, V1-B publish | Supported records/plans only, current source eligibility, curated preview, empty/unavailable state |
| `FieldSelection`, `AmountOmission`, `AudiencePicker` / appropriate stage | Explain exact included fields and allowed audience together; privacy defaults are explicit |
| `PosterComposer`, `CanonicalPreview`, `RenderStatus` / V1-A/B | Preserve draft; preparing/failed/ready distinct; preview data/image match; no publish while unauthorized/unready |
| `ExportAction`, `PublishConfirmation` / V1-A/B | Export vs publication clearly separate; native-share/download progress/error, audience confirmation, stable operation identity |
| `ProfileHeader`, `ProfileStats`, `PublishedCardGrid` / V1-B | Published projection only; public/private state, own edit action, unpublished trackers never surfaced |
| `FollowButton`, `FollowRequestRow`, `PeopleResult` / V1-B | Follow/requested/following/accept/decline/unavailable states; safe discovery and removal/block behavior |
| `FeedPost`, `PostHeader`, `PostActions`, `PostDetail` / V1-B | Author, period, accessible poster text, audience where appropriate; one finite chronological feed |
| `LikeAction`, `LikeCount`, `CommentList`, `CommentComposer` / V1-B | Clear toggled/submit states, counts/limits, delete/report options where allowed; failure rollback and draft retention |
| `ShareMenu`, `CopyLink`, `ReportDialog`, `BlockAction` / V1-B | Share preserves source audience; native/app/copy paths explicit; report reason and safe confirmation |
| `RepostAction`, `RepostAttribution`, `UnavailableSource` / V1-C | Repost is a source reference, not copied private content; unavailable source removes old title/metrics/image |
| `NotificationList`, `NotificationRow`, `NotificationPreferences` / V1-B/C | Category/read status, safe preview, authorized target resolution, unavailable target state |

The feed uses finite batches, deliberate Load Older, and a caught-up ending. New content does not jump the scroll position. Likes/comments do not affect personal heatmaps or rank whose progress matters. Share sends a link/reference; repost publishes a source reference to followers. Neither can widen source permissions.

### 8.3 Messaging inventory — V1-C / web W3

| Component family | Contract |
|---|---|
| `ConversationList`, `ConversationRow`, `ThreadHeader` | Safe last-message preview, unread marker, current contact/block state; list/thread adaptation preserves selection |
| `MessageBubble`, `MessageGroup`, `DateSeparator` | Plain-text content, author/time semantics, long-word wrapping; no arbitrary HTML/attachments |
| `MessageComposer`, `SendAction`, `DraftIndicator` | Keyboard-safe input, explicit send behavior, preserved draft, no send on resize/theme switch |
| `MessageDeliveryState`, `RetrySend`, `HistoryLoadControl` | Pending/accepted/failed/unknown distinguishable; server acceptance is not recipient reading; stable message identity on retry |
| `MessageRequestPanel` | Accept/decline/block/report actions and contact-policy explanation; no composer that bypasses request rules |
| `SharedCardMessage`, `UnavailableCardMessage` | Source reauthorized on view; removed access clears stale image/title/amount/alt text |
| `ConversationSafetyMenu` | Authorized block/report controls, explicit effect, safe navigation after revocation |

No group chat, calls, voice/video, arbitrary uploads, or unapproved read receipts/typing indicators are introduced by this catalog. Keyboard behavior respects IME composition; Send is not triggered by every Enter key event indiscriminately.

## 9. State, feedback, and motion

| State / component | Presentation and behavior |
|---|---|
| `Skeleton`, `LoadingIndicator`, `ProgressStatus` | Neutral stable geometry, busy semantics, readable loading label; shimmer optional and reduced-motion aware |
| `RefreshIndicator` | Retain permitted useful data and input; subtle refresh state |
| `EmptyState`, `NoResults` | Explain next useful action or clear filters; no fake records/illustrative private data |
| `OfflineBanner`, `SyncStatus` | Distinguish cached, saved-on-device, pending, retrying, accepted; web offline scope not falsely equal to mobile |
| `InlineAlert`, `FormError`, `PageError` | Explicit error title/cause/action; retained input; status icon plus text, not color |
| `Toast`, `Snackbar`, `UndoAction` | Short non-sensitive feedback; important actionable information persists elsewhere; meaningful screen-reader announcement |
| `ConflictPanel` | Current/local mismatch and explicit resolution, preserved draft; avoid silently discarding newer accepted data |
| `UnknownOutcome`, `RetryAction` | Do not claim failed commit; retry preserves operation ID and avoids duplicate effect |
| `RenderProgress`, `ExportJobStatus` | Preparing/ready/failed/expired state; generated output is not automatically published |
| `SessionExpired`, `PermissionDenied`, `UnavailableState` | Safe reauthentication/back/retry path; no stale private title, metric, thumbnail, or evidence |
| `PermissionPrompt`, `PermissionDeniedHelp` | In-context explanation, continue without optional permission, route to settings when appropriate |

Animations orient or acknowledge; they do not capture attention. No autoplay videos, flashing achievements, animated orange confetti, or escalating notification patterns. Screen readers do not announce a countdown every second. Theme/size changes must not replay success, submit again, or restart a timer.

## 10. Privacy and administrative interfaces

### 10.1 Privacy patterns

- Separate private tracking from published follower/public content with labels and preview—not an ambiguous lock icon alone.
- Show selected fields and intended audience together before sharing. Hide-amounts removes values from visible and accessible presentation; it is not encryption or authorization.
- Expanded panes and theme changes cannot reveal hidden amounts, unpublished records, or revoked source previews.
- DM/feed previews reauthorize; unavailable content must not retain cached private image/title/alt text.
- Admin shows environment, exact target/effect, required reason, current assurance/permission, and accepted audit reference.
- Hidden/disabled controls are not security boundaries. NestJS decides access; staff receive safe scope, not everyone's private dashboard.

### 10.2 Admin component coverage

Admin uses the same font, zinc tokens, neutral actions, and dark-mode rules, with compact 24-radius panels and fewer decorative cards. Evidence and operational density matter more than marketing styling.

| Area / stage | Components | Safety / states |
|---|---|---|
| Staff entry / A0 | Staff auth, required MFA/assurance challenge using the selected provider, session-expiry view, environment banner | Approved staff only; unsupported assurance blocks the affected operation rather than bypassing it; safe reauth and no normal-user session reuse |
| Operations overview / A0–A1 | Status metric, queue summary, health/incident notice, scoped shortcut | No fabricated live metrics; loading/stale/denied visible |
| Report queue / A0 | Filter/search bar, server-paginated table, severity/type badge, assignee/status | Distinguish severity with words/icons, not orange; no unapproved bulk actions |
| Case/evidence / A0 | Case header, scoped evidence viewer, safe excerpt/media, audit timeline | Report scope only; missing/revoked/redacted evidence explicit; no general DM/finance viewer |
| Moderation decision / A0 | Action picker, reason field, target/effect summary, confirmation, conflict notice | Current revision/permission/MFA checked; failure can mean unknown outcome; audit reference shown |
| Appeal review / approved stage | Appeal summary, prior decision context, review form, result timeline | No unreviewed policy automation; distinguish current and historical state |
| User/support lookup / A1 | Minimal account search/result, lifecycle status, allowed support action | Scoped fields only; no private tracking drilldown by default |
| Data requests / A1 | Export/deletion request status, identity/assurance context, safe job timeline | No routine staff download of user exports; retention/deletion consequences clear |
| Jobs / A1 | Job table, attempts/detail, safe payload summary, eligible retry/cancel confirmation | No replay of financial commands or automatic publication; no secret payload display |
| Staff/access / A1 | Staff list, grant editor, assurance/revocation status, audit search/detail | Separate grants, least privilege, no self-escalation; reason/confirmation required |
| Editorial/configuration / optional A2 | Structured editor, asset picker, preview, version comparison, publish/rollback confirmation | Only if approved; sanitized content, allowlisted configuration, audited change; not arbitrary database/HTML editing |

Phone/tablet staff workflows remain usable, with stacked evidence and deliberate table scrolling. Destructive confirmation keeps environment/target/effect visible even when keyboard is open. Export/table tools and batch selection appear only when the corresponding permission/feature is approved.

## 11. Accessibility and localization

Target applicable WCAG 2.2 AA through actual testing, not source appearance or calculated swatches alone.

- Semantic headings/landmarks, skip links on web, correct widget roles, labels, errors, focus order, modal containment/restoration, and keyboard operation.
- At least 48×48 logical/CSS-unit touch boxes for discrete controls. Inline text links use readable text and adequate separation rather than square line boxes. Never overlapping hit areas.
- Text/zoom/reflow, safe/keyboard insets, pointer/touch, external keyboard, reduced motion, and non-color alternatives. No display-size guesses or global text-scale clamps.
- Test Light, Dark, System changes, browser forced-colors/high-contrast modes, 200% text, and applicable 400% web zoom. Do not suppress OS contrast/focus overrides to preserve brand colors.
- Disabled/placeholder styling cannot make required information unreadable. Neutral error/success styling still needs explicit icons, titles, and programmatic states.
- Tables/charts/calendars have text/value access. Virtualization must preserve meaningful keyboard/screen-reader navigation or offer an accessible alternative.
- Tooltips are supplementary. Drag/swipe/reorder gestures, if introduced for approved flows, require equivalent explicit controls; no hover-only or gesture-only primary action.
- Respect password-manager/autofill/paste and IME composition. No inaccessible custom control merely to reproduce the marketing sample.
- [Decision 0003](decisions/0003-product-defaults.md) accepts an English-first Android pilot with localizable strings; Indonesian remains a later candidate. Use the accepted Focus/Read/Intake/Money/Circle labels and stable mode keys. Format dates/numbers/currency without changing stored units or snapshot meaning.
- Test long titles/names, translated controls, large/negative Money values, and missing glyphs. Truncation requires access to the full essential value; privacy-hidden values stay hidden everywhere.

## 12. Governance and design acceptance

### 12.1 Scope and ownership

- This standalone file owns Your Own's design tokens, rationale, light/dark themes, adaptive rules, and component contracts. The retired visual-inspiration file is not a dependency; record future design changes here rather than restoring that dependency.
- Record approved font/icon licenses, assets, chart integrations and token changes; exact values remain candidates until visual/device validation. Do not maintain a second ad hoc palette or component system in admin/mobile.
- Build a synthetic component/state catalog with the section 5 contract, then test real Flutter/web/admin adapters. Screenshots alone do not prove semantics or authorization.
- Version poster templates independently from app theme updates; old publications do not silently change.
- Add visual, keyboard, screen-reader, privacy, resize, theme persistence, and first-paint checks with components. See [Testing](testing.md#8-adaptive-ui-and-accessibility).

### 12.2 Coverage and release ownership

| Surface | Shared catalog coverage | Implementation scope |
|---|---|---|
| Auth, onboarding, profile/settings | Sections 5–6, 9–11 | V1-A / web W1; actual auth methods only |
| Today, Focus, Read, Intake, Money, Progress | Sections 5–7, 9, 11 | V1-A / web W1 |
| Private poster preview/export | Sections 5, 8–9, 11 | V1-A; user-web stage per web PRD |
| Profiles, follow lifecycle, posts/feed/comments, reporting, notifications | Sections 5, 8–11 | V1-B / web W2; admin A0 ready first |
| Reposts, DMs, message requests | Sections 5, 8–11 | V1-C / web W3 |
| Public product/policy/app-link pages | Sections 2–5, 11 | Web W0; no fake testimonials/logos/metrics |
| Staff moderation/support/operations | Sections 5–6, 9–11 | A0 safety, then A1 operations |
| Editorial/configuration editor | Sections 6, 10 | Optional A2 only after approval |

The inventory covers current planned component families, not every speculative future widget. Command palettes, arbitrary rich-text editors, date schedulers, charts requiring new domain metrics, bulk moderation, public galleries, and extra social attachments are not implied. Add missing approved components through the same contract before implementation.

### 12.3 Design acceptance checklist

- [ ] All screens in the current release stage have component/state coverage, including first-use, offline/pending, failures, permission denial, and revoked content.
- [ ] Small/Medium/Large/Largest, phone/tablet/desktop, short height, split-screen, keyboard, and live resize are covered in both themes.
- [ ] Zinc surfaces, neutral CTAs, 12/14/24/36 role geometry, single-font hierarchy, and sparse orange badges match this mapping; no old palette/radius rules remain.
- [ ] Approved font and fallback scripts are bundled/hosted appropriately and legible, including poster rendering.
- [ ] One licensed rounded icon family covers app-owned explicit and implicit glyphs; no Material/built-in/starter fallback icons remain.
- [ ] User-web ApexCharts loading/license/theme/privacy checks pass; Flutter custom charts have tested semantics, exact-value alternatives and resize/performance behavior.
- [ ] System/Light/Dark persists locally; explicit choice wins; System responds to OS changes; web first paint/hydration agree.
- [ ] Fields, dialogs, native controls, tooltips, charts, tables, skeletons, and error states work in Dark—not only page backgrounds.
- [ ] Real component contrast, status recognition, focus visibility, keyboard/screen-reader interaction, and text scaling pass testing.
- [ ] Resizing/theme changes preserve drafts/timers/selection/scroll and privacy; no duplicate mutation or hidden-value reveal.
- [ ] Canonical poster preview and fixed/versioned export are independent of viewer theme/window and contain only selected fields.
- [ ] Manual Money, truthful states, finite feeds, and staff permission boundaries remain intact.

This update produces documentation and selected color calculations only. No application components, generated tokens, final visual assets, live-device tests, or accessibility certification are claimed.
