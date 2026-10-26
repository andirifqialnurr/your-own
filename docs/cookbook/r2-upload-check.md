# M00-T06 — Synthetic R2 upload/read/cleanup and asset prefixes

- **Checked:** 2026-10-26 UTC, starting 07:18:28
- **Status:** Both buckets pass synthetic authenticated PUT/GET/DELETE; known-public-file CDN GET still 403; full storage/T06 acceptance remains unchecked
- **Authority:** [Decision 0017](decisions/0017-r2-synthetic-upload-and-prefixes.md), explicit owner upload/prefix request
- **Prior checkpoints:** [Read-only connection checks](r2-connection-check.md); their original empty-list/403 results remain unchanged

## 1. Scope and organization

The owner explicitly permitted upload testing and folders for public/private assets. Used the existing ignored `.env` in an external Python-standard-library experiment, not app source or a storage SDK. No new packages, Docker, account/bucket provisioning, settings/CORS/lifecycle change, private public enablement, auth integration or M02.

Actual retained organization:

| Bucket role | Prefix | Retained object | Meaning |
|---|---|---|---|
| Public | `public/assets/` | `public/assets/.keep`, zero bytes | Folder marker for deliberately public non-sensitive assets |
| Private | `private/assets/` | `private/assets/.keep`, zero bytes | Folder marker for restricted assets; public delivery must remain disabled |

R2 folders are **object-key prefixes**, not physical directories or authorization. Only these two new zero-byte markers remain; no permanent test file or empty-directory marker under `connection-tests/` remains. The prefixes are organizational, not an adopted product media schema. Do not store private/followers-only content in the public bucket, regardless of a key's name.

## 2. Real upload/read results

One random run-specific text fixture was created under each role's `assets/connection-tests/` prefix, with 90 public bytes and 91 private bytes (**181 synthetic bytes total**, no personal data/secrets). Both random keys and both marker keys were proven absent with HEAD 404 before conditional PUT (`If-None-Match: *`). Markers were created only because they were absent. Payload metadata identifies this task/run; no owner object was overwritten or read.

| Operation | Public fixture | Private fixture |
|---|---|---|
| Pre-upload signed HEAD | 404 | 404 |
| Signed conditional PUT | 200 | 200 |
| Signed GET | 200, exact 90-byte payload match | 200, exact 91-byte payload match |
| Ownership verified before cleanup | Yes, task metadata/length/hash | Yes, task metadata/length/hash |
| ETag-conditional DELETE | 204 | 204 |
| Post-delete signed HEAD | 404 | 404 |

Both `.keep` conditional PUTs returned 200 and subsequent HEADs returned 200 with zero content length and matching task metadata. Those two markers remain intentionally under the owner's organization authorization. No unrelated keys, prefix-wide deletion or bucket configuration was touched.

## 3. CDN and limited denial controls

- Anonymous GET of the **existing, uploaded public fixture** returned **403**. This was a real known-object attempt, not another root/missing-key HEAD. CDN bytes could not be verified: **the CDN test did not pass**.
- Unsigned S3 GET of the owned private fixture returned **400**. Its payload was not disclosed by this request.
- GET of the owned private fixture's key through the configured public CDN returned **403**, without returning its payload. This checks only that route/key, **not every private bucket public/custom-domain path**.
- After S3 cleanup, public CDN GET still returned **403**; this is not proof of cache purge or revocation because successful CDN delivery was never established.
- One extra anonymous diagnostic GET of the owned zero-byte public marker also returned **403**. The supplied public URL is `r2.dev`, has no path prefix, and the response identifies Cloudflare; no recognized challenge/proxy/error-cause signal was established. Raw response/header/body/URL data was not persisted; no cause was invented.

Thus **an empty bucket alone cannot explain the observed known-object denial**. The signed API target exists and accepted the exact payload, but that does not prove the configured CDN belongs to this bucket or has public delivery enabled. Check the **public bucket's** Public Development URL status/association and copy that exact URL. This is not a browser CORS test and no local-IP/port allowlisting, CORS toggle, proxy/TLS bypass, user-agent evasion or automatic public-policy change was attempted.

## 4. Safety, cleanup and evidence

The main run made **22 requests in 12.358 seconds**, plus **one diagnostic read**. Standard TLS verification and redirect refusal were retained; every response was bounded to 8 KiB and requests to 15 seconds. Only authenticated S3 requests received credentials. Synthetic object bodies were checked in memory, never logged. Conditional create, ownership checks and ETag-conditional cleanup protected existing/changed objects; no automatic uncertain-write retry occurred.

Both temporary text fixtures were deleted and S3 absence was verified. **Only two zero-byte asset markers remain.** Python processes exited; no listener, container or worker was created. Original root/API `.env` files remain ignored/untracked and byte-unchanged; no app source, lock, dependency policy, fonts, goldens or native wrapper was modified.

External sanitized evidence: `C:/Users/HP/AppData/Local/Temp/your-own-r2-upload-k3bp2cgr/` — `upload_probe.py`, reused `r2_transport.py`, `result.json`, `upload.log`, `cdn_diagnostic.py`, `cdn-diagnostic.json` and `cdn-diagnostic.log`. The external baseline retains config hashes; result/journal data retains only a random synthetic run ID, statuses, payload hashes and ownership/cleanup flags, never credential/account/bucket/endpoint values. That ID can reconstruct only this run's synthetic keys if recovery is needed. Historical local evidence and all 13 immutable repository snapshots remain intact.

## 5. Remaining acceptance

This proves only point-in-time authenticated upload/read/delete of tiny owned text fixtures. It does not prove the private bucket's complete public-path configuration, least-privilege key isolation, real media type/size/quarantine validation, application authorization, browser CORS, native SDK/storage, cache/revocation/deletion races, signed-URL expiry, retention, backup/restore or release readiness. No application upload endpoint is enabled. Full T06/T07/M01/M02 gates remain open.

Next: verify the public bucket's exact enabled `r2.dev` URL/settings before another scoped CDN check, and verify private public delivery remains disabled before sensitive assets. Do not weaken private access or change CORS/IP rules merely to hide this 403.

## 6. Repository verification

`pnpm check` passed **142 existing root tests** (21 tooling + 14 design/artwork + 88 boundaries + 19 API), lint/types/API build and the **37-source / 131-directive** import scan. Documentation checks passed **96 Markdown / 1,603 local links / four JSON examples** and 29 owned JS/TS/JSON whitespace checks. Diff/preservation/secret checks passed: eight documentation paths only, unchanged original config and application/policy/lock/asset/native/snapshot bytes, **67 requirement IDs / 224 tasks / 20 plans / seven checked tasks**. No Flutter/native/browser or application upload integration test ran. The external real R2 operations above are separate from that 142-test suite; the CDN failure remains explicitly open.
