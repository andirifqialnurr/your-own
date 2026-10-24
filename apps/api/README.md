# Your Own API

Local NestJS HTTP foundation only. There is no database, authentication, upload endpoint, queue consumer or tracker implementation. No Docker service is needed yet.

## Run

From the repository root, with Node **24.18.0** and pnpm **12.8.1**:

```bash
pnpm install --frozen-lockfile
cp apps/api/.env.example apps/api/.env
pnpm dev:api
```

PowerShell can use `Copy-Item` instead of `cp`. Do not overwrite an existing `.env`; this initial setup already created a local copy. The server binds **127.0.0.1:3000**, never all interfaces. Stop with Ctrl+C. `dev:api` compiles then starts; it does not yet hot-recompile TypeScript. Restart it after editing source.

- `GET /v1/health/live`: **200**, `{"status":"ok"}`.
- `GET /v1/health/ready`: deliberately **503**, `{"status":"not_ready"}`. Services required for real records do not exist yet.
- Both responses use `Cache-Control: no-store`. No credential/CORS configuration or domain endpoint is enabled.
- `APP_ENV` is required: only `development` or `test`. `API_HOST` is loopback only; `API_PORT` defaults to 3000 and must be 1–65535. Staging/production fail before opening a listener. Errors never echo invalid environment values.

## Check

From the repository root:

```bash
pnpm check
pnpm build
pnpm audit
```

`pnpm check` runs typed ESLint, strict TypeScript and Node's built-in test runner. Tests open ephemeral loopback ports and close their own servers; they need no external service. The ten process-isolated Multer regressions are synthetic maintenance tests, **not an application upload API**.

## Code and ownership

| Path | Responsibility |
|---|---|
| `src/main.ts` | Validate environment, start HTTP, report sanitized startup failures |
| `src/config/environment.ts` | Pure configuration validation; no provider/secret fallback |
| `src/app.ts` | HTTP factory and response headers; testable without starting a listener |
| `src/app.module.ts` | HTTP-only composition root; no workers imported |
| `src/health/health.controller.ts` | Liveness and intentionally unavailable readiness |
| `test/environment.test.mjs` | Configuration boundaries and actual failed CLI startup |
| `test/health.test.mjs` | Real loopback health/404/header checks |
| `test/multer.test.mjs` | Exact override regression runner |
| `test/multer-regressions.cjs` | Owned synthetic fixture, carried from Decision 0009 |

No `worker.ts` exists until there is a real worker slice. A future worker must have a separate composition root, not start consumers merely by importing this API module.

[M01-T01–T03 evidence](../../docs/cookbook/local-development-bootstrap.md) · [Backend specification](../../docs/BACKEND_TECH_SPEC.md) · [Architecture](../../docs/cookbook/architecture.md) · [Scoped dependency policy](../../docs/cookbook/decisions/0010-conditional-dependency-exceptions.md)
