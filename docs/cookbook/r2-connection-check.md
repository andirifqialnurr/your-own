# M00-T06 — Read-only R2 and public CDN connection check

- **Checked:** 2026-10-26 UTC, starting 06:24:05; repeated at 06:25:40; [two-bucket follow-up](#5-two-bucket-follow-up) at 06:40:24
- **Status:** Signed R2 connection passes; public file delivery unverified; private-storage acceptance and full T06/T07 remain open/unchecked
- **Authority:** [Decision 0016](decisions/0016-framework-auth-and-r2-storage.md), owner's explicit `.env`/R2 and subsequent public-CDN test requests
- **Scope:** Existing owner-provided bucket/configuration only; no application storage/auth integration

## 1. Method and secret boundary

External disposable Python-standard-library probe; no SDK/package installation, Docker or app code. Read the ignored root `.env` into memory without shell evaluation, interpolation, printing or copying values. Use its `STORAGE_PROVIDER`, `R2_ENDPOINT`, `R2_REGION`, `R2_BUCKET`, `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY` and `R2_PUBLIC_BASE_URL` keys. Preserve both root and API `.env` bytes.

Require HTTPS, normal certificate verification, an official account-scoped R2 S3 endpoint, region `auto` and public-routable destination addresses. Sign S3 metadata requests with AWS Signature V4. Public requests carry **no R2 credentials**. Do not follow redirects; requests have 15-second timeouts, listing is limited to one entry/64 KiB and any key stays in memory. Do not persist response bodies, object names, bucket/account identifiers, URLs, authorization headers or secrets. This is a bounded connectivity probe, not a production storage SDK or security audit.

## 2. Actual results

| Request | Initial run | Repeat | Meaning / limit |
|---|---|---|---|
| Signed `HeadBucket` | 200 | 200 | Configured endpoint/bucket accepted authenticated metadata access |
| Signed `ListObjectsV2`, `max-keys=1` | 200 | 200 | Bounded listing permission works; zero objects returned and `IsTruncated=false` at these instants |
| Unsigned S3 bucket HEAD | 400 | 400 | This unsigned request was not accepted; **not proof of private delivery policy** |
| Anonymous public `r2.dev` base HEAD | 403 | 403 | DNS/TLS/HTTP reachable; no successful public response established |
| Anonymous public random absent-object HEAD | Not run | 403 | Additional read-only diagnostic; not a known-object delivery test |
| Anonymous existing-object HEAD | Not run: empty listing | Not run: empty listing | No known object available; no upload was authorized or attempted |

There were **11 requests across the two runs**. Original 403/400 responses are retained, not relabeled as passes. A base URL need not provide a directory listing, so a root 403 alone is inconclusive; the additional absent-object 403 also does not establish successful file delivery or diagnose a cause. Do not assume propagation, a wrong URL, account/bucket mismatch, WAF behavior or correct public configuration without evidence.

**No object body was downloaded and no write/delete/configuration/provisioning request occurred.** Signed read success does not verify object PUT/GET/DELETE, CORS/browser behavior, multipart/limits, expiry/revocation, cache isolation, deletion races, backups or least-privilege credential scope.

## 3. Private/public separation and next proof

The owner reports enabling public CDN access and the configured public URL is on `r2.dev`. No object exists with which to verify its association with the configured S3 bucket. Treat any publicly enabled bucket as unsuitable for private application media until configuration/separation is verified; rejected anonymous access to the S3 API is not protection against another public URL.

- Keep a **private bucket with all public delivery disabled** for personal exports, private cards and restricted evidence. Deliver through current Nest authorization with an approved bounded capability/cache policy; never put R2 credentials in clients.
- Use a **separate public bucket**, only if needed and approved, for deliberately public non-sensitive assets. No creation or public-data migration occurred here. A public URL cannot enforce follower/private-account authorization by itself.
- To prove CDN file delivery, the owner can supply a known non-sensitive object, or separately authorize a tiny synthetic fixture upload and cleanup. Verify the known object without leaking its URL/key; do not infer write permission or upload now.
- Auth now follows Decision 0016's non-Supabase, framework-appropriate integration direction. Exact maintained libraries and the identity/session/store/email/recovery design need review before app implementation; prior toy auth tests are not real auth acceptance.

## 4. Evidence and repository checks

Sanitized local evidence: `C:/Users/HP/AppData/Local/Temp/your-own-r2-b1khpnnn/` — `probe-first.py`, `probe.py`, `result.json`, `result-reviewed.json`, `probe.log`, `probe-reviewed.log`, `endpoint-classification.json` and `baseline.json`. Private config hashes stay only in that external baseline; source and result artifacts contain no credentials/config values. Python processes terminated; no task listener, container or persistent resource was created. The existing owner bucket/public setting and unrelated Docker resources were untouched.

`pnpm check` passed **142 existing root tests** (21 tooling + 14 design/artwork + 88 boundaries + 19 API), lint/types/API build, and the 37-source/131-directive import scan. Documentation checks passed **94 Markdown / 1,576 local links / four JSON examples**; `git diff --check` passed. Preservation checks retain the ignored `.env` bytes, unchanged app sources/locks/policies/assets/native wrappers, 13 historical snapshots and 67 requirement IDs / 224 tasks / 20 plans / seven checked tasks. Only decision/specification/report paths changed; no Flutter/native/real-auth test ran. These connection checks are separate from the root suite and do not close native/CI, full T06/T07, M01 or M02 gates.

## 5. Two-bucket follow-up

After the private/public separation explanation, the owner said **“sudah saya buat silahkan di cek lagi koneksi ke bucket private dan public nya”**. This authorizes read-only checks of both newly supplied targets, not the earlier proposed fixture upload. [Decision 0016's continuation](decisions/0016-framework-auth-and-r2-storage.md#two-bucket-continuation) records the boundary. The original single-target results above remain historical evidence.

The ignored root config now additionally supplies **`R2_ENDPOINT_PUBLIC` and `R2_BUCKET_PUBLIC`**. For this external probe only, use `R2_ENDPOINT` / `R2_BUCKET` for the owner's private role, `R2_ENDPOINT_PUBLIC` / `R2_BUCKET_PUBLIC` for its public role, the shared `R2_ACCESS_KEY_ID` / `R2_SECRET_ACCESS_KEY`, and `R2_PUBLIC_BASE_URL` for anonymous CDN requests. These are actual input names, not an adopted application env contract. Both S3 endpoints are equal and bucket names differ; two distinct bucket targets can be accessed through the same endpoint/credentials.

At **06:40:24 UTC**, eight read-only requests completed in **2.498 seconds**:

| Target | Signed HEAD | Signed list, max one | Listing result | Unsigned S3 HEAD |
|---|---|---|---|---|
| Configured private bucket | 200 | 200 | Zero objects, not truncated | 400 |
| Configured public bucket | 200 | 200 | Zero objects, not truncated | 400 |

Anonymous CDN base HEAD and a random absent-object HEAD both returned **403**. A known-public-object HEAD was **not run** because the public bucket is empty. No private object name is ever used to probe the public CDN. These results establish authenticated metadata access to two distinct configured buckets, not CDN-to-bucket association, successful public file delivery, disabled public paths on the private bucket, object write/read/delete permissions or least-privilege scope. Shared credentials work for these reads; separate least-privilege bucket credentials remain preferable.

No fixture upload, delete, body download, settings/provisioning, SDK install or app integration occurred. TLS verification and redirect refusal remain enabled. Root/API `.env` bytes are unchanged and ignored. Local evidence: `C:/Users/HP/AppData/Local/Temp/your-own-r2-dual-bxkrwpaq/` — `probe.py`, reused `r2_transport.py`, sanitized `result.json`, `probe.log` and private-value-free validation output; config hashes remain external in `baseline.json`. The probe process exited and created no persistent resources. Next file-delivery proof needs a known non-sensitive public object or separate fixture upload/cleanup authorization; private public-path settings still need verification before sensitive media.

Follow-up repository checks: `pnpm check` passed **142 existing root tests**, lint/types/API build and the 37-source/131-directive scan; **94 Markdown / 1,584 links / four JSON examples** passed documentation checks. `git diff --check` and preservation/secret checks passed: six documentation paths only; original config, application/lock/policy/asset/native/snapshot bytes retained; 67 requirement IDs, 224 tasks/20 plans/seven checked tasks unchanged. No Flutter/native or app-storage integration tests ran.
