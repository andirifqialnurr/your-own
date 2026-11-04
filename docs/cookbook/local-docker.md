# Local Docker start/stop

**Scope:** [Decision0036](decisions/0036-local-docker-helpers.md), manual synthetic PostgreSQL sandbox only. Application auth/database integration and roadmap work remain stopped. Helpers are implemented/unit-tested; **live DB lifecycle verification is blocked by C: free space**.

## Use from Windows

Open a terminal in the repository:

```bat
docker-start.cmd
docker-stop.cmd
```

In PowerShell use `./docker-start.cmd` and `./docker-stop.cmd`. Both also work from another working directory by using their full path. No arguments or installed project packages are needed; use the pinned Node24.18.0 and existing Docker Desktop installation.

- **Start:** checks C:≥20GiB free, verifies the explicit local Desktop Linux context and cached reviewed image, then creates/starts only `your-own-local-postgres`. It can open the existing Desktop installation if necessary; it never installs/updates Docker or pulls an image. A random **127.0.0.1** port is displayed when ready.
- **Stop:** stops only that owned container. **Data volume `your-own-local-postgres-data`, container and image are preserved.** It does not stop Desktop, Redis, object storage or all containers. No reset/prune/delete command is supplied.
- Same-name resources with different ownership/image/safety settings are refused, not adopted/repaired/replaced. Start/stop are idempotent; startup failure attempts to stop only a sandbox started by that invocation, without deleting data.
- Runtime limits:2CPU/1GiB, non-root UID999, read-only root/cap-drop/no-new-privileges, bounded logs/WAL/temp/connections, no host/app/socket mounts. Persistent-volume growth is **not a filesystem quota**; monitor disk space and stop when finished. This manually stopped sandbox is separate from the disposable ten-minute external integration fixtures.

After a successful start, open a synthetic inspection shell:

```bat
docker --context desktop-linux exec -it your-own-local-postgres psql -U postgres -d your_own_local
```

The initialization password is randomly generated, passed only via Docker environment and never printed or written into the repository. **Docker administrators can inspect container secrets**; this is not production secret custody. The above shell is a sandbox administrator, **not** an application runtime role. Do not put real/personal data here, point the API at this account or copy owner .env. Future app/migrator/runtime credentials/schema/migrations need their own scope; these helpers do none of that. No R2 or mail operation occurs.

## Which images are used?

| Owner-provided ID | Observed local image | Used by Your Own? |
|---|---|---|
| `sha256:b51665e66f00759be7c3152ad5ac3c66fb2f619c13ef62dea7cc1f9914524635` | `redis:8.2-alpine`, merchant-dev-redis-1 | **No**; unrelated service preserved |
| `sha256:30292fc2eeacc67a36993b01f7a7a5e3361a19cced0e80c1d71cfa2a4b0a2499` | `versity/versitygw:v1.8.0`, merchant-dev-object-storage-1 | **No**; unrelated service preserved |

The cached PostgreSQL image used in earlier external experiments and selected for this helper is **PostgreSQL18.6/linux-amd64**, immutable reference:

```text
postgres@sha256:6b38fe68f2c02cafffbbce7496f76d110d8a947c039bd22c067e9a43c2250240
```

Identity verification is not a fresh image-vulnerability audit or application/production adoption. Redis may be considered for later queue work, but these helpers do not provision it. Storage direction remains Cloudflare R2, not local Versity.

## Checks and current blocker

- Read-only Docker image metadata confirms all three identities. Existing merchant container IDs/services/images/context remain untouched.
- **16 dependency-free Node unit/safety tests and ESLint pass**: own-resource selection, no pulls, local named-pipe only/no remote override or owner-secret inheritance, resource/mount/port drift rejection, collision refusal, mock persistence/idempotence, bounded readiness/failed-start cleanup, argument handling and quoted wrapper paths. The initial fake context output omitted Docker's JSON quotes, yielding8 pass/8 fail; the fixture now matches the real CLI and specific negative-case assertions remain. Original failure log is retained, not a pass.
- Real `.cmd` invocation from a C: path **with spaces** and an unrelated working directory reaches the resource guard correctly. At capture, C: has **20,639,789,056 bytes (~19.2GiB) free**, less than **21,474,836,480 bytes (20GiB)**. It refuses before creating a sandbox container or volume; absent stop returns successfully. No data/password is created and no unrelated service is stopped. The smoke driver's follow-up inspection of the intentionally absent sandbox also fails; that orchestration failure is retained.
- **Not passed/not run:** actual PostgreSQL startup/readiness, stop/restart/SQL persistence and live failure cleanup. Do not present mock persistence or a refused start as proof of those operations. No guard is lowered, unowned cache/file is deleted or retry-until-green performed. Free space with owner-controlled actions, leaving20GiB plus headroom, before invoking start or repeating the bounded lifecycle smoke. The helper does not free space automatically.
- Full root pnpm/Flutter/native/hosted/DB/auth suites are **not rerun** at this resource stop. Static docs/lint/unit/preservation checks do not close full M01/M02, native/CI/privacy/release gates or change the November23 latest policy-review deadline.

Evidence: **`C:/Users/HP/AppData/Local/Temp/your-own-docker-helper-9mlspef9/`** contains hash-only baseline/private preservation, image/guard/space observations, initial/corrected unit logs, lint, quoted-path smoke inputs/failure logs and final validation/publication records. No credentials or owner configuration contents are copied into probes. The five previous external I1 checkpoints and13 snapshots remain historical, immutable evidence—not automatically resumed by this convenience task.
