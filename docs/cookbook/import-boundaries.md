# Application Import Boundaries

- **Task:** M01-T04; local foundation work under [Decision 0012's continuation](decisions/0012-local-development-bootstrap.md#local-foundation-continuation)
- **Authority:** [Architecture](architecture.md#51-application-and-shared-package-ownership), [backend module layout](../BACKEND_TECH_SPEC.md#72-module-layout--money-example), [mobile layers](../MOBILE_TECH_SPEC.md#4-architecture-and-dependency-rules)
- **Scope:** API TypeScript source and Flutter Dart libraries; no new dependency or feature behavior

## Current ownership

- `apps/api/src/app.module.ts` composes `HealthModule`. `health/health.module.ts` owns its controller; the application no longer imports the controller directly. HTTP behavior stays unchanged, and no worker is introduced.
- `apps/mobile/lib/app/app.dart` owns app configuration, localization and theme composition. `features/setup/presentation/setup_screen.dart` owns the existing setup screen, without networking or persistence. There is still one Flutter source tree, not separate phone/tablet applications.
- No product domain, repository or cross-feature service exists yet. Do not create empty mode folders or pretend the checker fixtures implement Money/Read/Progress.

## Enforced import policy

| Area | Allowed direction / prohibited dependency |
|---|---|
| API source ownership | Root composition plus `config/`, `common/`, `infrastructure/`, `health/`, `modules/<name>/` |
| Flutter source ownership | Environment mains plus `app/`, `core/`, `features/<name>/`, `shared_ui/`, `l10n/`; no top-level phone/tablet/Android/iOS app copies |
| Feature layers | API: domain, contracts, application, transport, infrastructure. Flutter: domain, contracts, data, presentation. Feature-root files are explicit public/module entries |
| Domain / contracts | Local domain/contracts or pure `common/domain` / `core/domain` code; no framework, Node I/O or third-party imports. Dart allows only core/async/collection/math/convert/typed_data SDK libraries |
| Cross-feature access | API `modules/<name>/index.ts`; Flutter `features/<name>/public.dart`. These are **contract-only** entries, checked with the same purity rules; they cannot re-export private adapters or widgets |
| API composition | `.module.ts` composition files may import `<name>.module.ts` or `<name>.http.module.ts`, not another module's controller/service. Worker composition must not import an HTTP module entry |
| API internal direction | Application must not import transport/infrastructure; transport must not import its concrete infrastructure directly |
| Flutter internal direction | Presentation must not import data; data must not import presentation. UI may use pure core-domain contracts, not core infrastructure; direct I/O/transport/storage packages are rejected |
| UI packages | Flutter, Flutter localizations and intl only for now; new state/router/icon packages require an explicit policy update alongside their reviewed dependency addition |
| Shared code | Cannot import feature code or application composition. Application composition can wire its owned feature implementations |
| Application isolation | Relative and self-package imports may not escape `src/` or `lib/`. Encoded/query/fragment/backslash URIs and unrecognized source extensions are rejected |

Public entries are added only when a real feature exposes contracts. They must not become catch-all barrels. Concrete infrastructure is wired by composition and injected through domain interfaces; widgets/controllers should not obtain implementations through shared helpers.

## Commands and implementation

From the repository root:

```bash
pnpm check:boundaries
pnpm test:boundaries
pnpm check
```

`pnpm check` runs the boundary tests and source scan **before** the existing lint/type/API tests. Flutter analysis/tests remain separate commands in the [mobile README](../../apps/mobile/README.md#host-setup-and-checks).

| File | Responsibility |
|---|---|
| `scripts/check-boundaries.mjs` | Scan real API/Flutter source, report file/import/reason, exit nonzero for violations |
| `scripts/architecture/imports.mjs` | Existing TypeScript compiler AST; small lazy Dart library-directive lexer |
| `scripts/architecture/policy.mjs` | Shared ownership/layer policy, including relative and Dart self-package paths |
| `scripts/architecture/boundaries.test.mjs` | Positive/negative rules, syntax variants and actual CLI exit-code controls in owned temporary fixtures |

The TypeScript reader includes imports, type imports, re-exports, literal dynamic imports and `require`/`require.resolve`; computed loading fails. The Dart reader checks imports, exports, URI-based parts and **every conditional branch**, skipping comments/annotation strings and stopping before declarations. Escaped/interpolated dependency URIs and named `part of` forms are unsupported and fail rather than silently pass. New TS aliases/import maps need resolver support before adoption. The optional CLI `--root` is used for disposable test fixtures, not a second application workspace.

This is a static architecture guard, **not a security sandbox or proof of runtime purity**. It does not discover arbitrary reflective loading, validate every Dart body construct, detect all dependency cycles, or replace code review, TypeScript compilation, Flutter analysis and behavior tests. Compilers still own module existence/type correctness. Platform adapters may live inside their owned infrastructure; native wrappers outside `lib/` are not duplicate Flutter application trees.

## Verification — 2026-10-24 UTC

All **72 boundary tests** pass, including actual CLI pass/fail exit controls in isolated synthetic fixtures. The local source scan passes for **16 source files / 36 dependency references**. Existing strict lint/types/build, **19 API tests** (including the ten unchanged Multer regression areas) and **12 Flutter host tests** pass after the ownership refactor. Formatting reports ten owned Dart files unchanged. No dependencies, lockfile, SDK, provider, database, Docker service or native target was added. Native build/access work remains pending in T03; M00 and release gates remain open.
