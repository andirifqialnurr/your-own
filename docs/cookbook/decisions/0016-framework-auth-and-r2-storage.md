# Decision 0016 — Framework-appropriate auth and Cloudflare R2 storage

- **Status:** Owner-directed replacement of Supabase directions; bounded read-only connection checks executed, full M00-T06/T07 still open
- **Approved by:** Project owner, 2026-10-26 UTC
- **Recorded by:** Coding agent
- **Supersedes:** [Decision 0013](0013-provider-and-session-directions.md) INF-03/04 and [Decision 0015](0015-auth-methods-and-local-protocol-spike.md)'s Supabase/provider-managed implementation assumption only; preserve their historical evidence
- **Evidence:** [R2/CDN connection check](../r2-connection-check.md)
- **Later bounded authority:** [Decision 0017](0017-r2-synthetic-upload-and-prefixes.md) separately authorizes synthetic upload/read/cleanup and asset prefixes; the original read-only approval boundaries below remain historical, not blanket upload permission.

## Owner instructions

After asking whether Supabase was in use, the owner said:

> untuk auth bisa menggunakan yang default dari masing-masing pemrograman sih. tapi utnuk file private kita pakai r2 bucket saja. untuk aksesnya bisa anda uji dulu di file .env yang baru saya tambahkan.
>
> silahkan uji dulu koneksinya apakah berhasil. dan jika butuh bucket public bisa mungkin saya buatkan juga

The owner then added:

> oiya saya sudah enable public bucket cdn nya anda bisa sekalian cek koneksi itu juga dulu

The subsequent **“continue”** confirms continuation of these checks, not broader implementation permission.

## Accepted direction and interpretation

- **Do not adopt Supabase Auth or Supabase Storage.** Use Cloudflare **R2** behind the Nest-owned media/storage interface for private files. PostgreSQL/Prisma, one Nest domain authority and separate server-side user-web/admin session directions remain unchanged.
- Auth should use conventional, maintained, framework-appropriate integrations rather than requiring Supabase. Flutter and Next.js are clients of the one backend identity/authorization authority; this is **not** three independent password databases. These frameworks/languages do not supply a complete automatically secure default auth service. Exact Nest auth/session/hash/MFA libraries, protocols, persistence, email delivery and recovery operations require the next bounded review; no library or custom cryptography is selected here.
- Preserve the accepted initial email/password, email verification/recovery and required staff TOTP directions, account-required product scope, current grants/fresh step-up and web/admin realm separation. The prior **provider-managed** implementation assumption is withdrawn, not replaced with an implemented password/reset/TOTP service. Disposable synthetic auth code remains non-production.
- R2 S3 credentials are server-only. An ignored root `.env` is authorized solely as input to this external connection probe; do not copy it to Flutter/web bundles, example files, source control or logs. Do not alter either existing `.env`.
- **Private and public storage must be separated.** If a bucket has public `r2.dev`/custom-domain access, it is not a suitable application private-file bucket. A successful signed S3 request or rejected unsigned S3 request does not prove that a public delivery path is disabled. Signed URLs are bearer capabilities, not instantly revocable app authorization. Sensitive media needs current Nest authorization and approved expiry/cache/deletion/backup policy.

## Authorized execution boundary

Only HTTPS metadata/read checks against the owner's configured R2 bucket and public CDN endpoint: signed HeadBucket, bounded ListObjectsV2 (`max-keys=1`), unsigned negative requests and public HEAD. No credentials to the public endpoint; verify TLS normally, reject redirects rather than forwarding signed headers, use timeouts and bounded responses, do not log endpoints/account/bucket/object identifiers or key values. Existing object metadata may be checked if a key exists, but never download private object contents.

No upload/overwrite/delete, bucket/public-policy/CORS/lifecycle change, provisioning, distribution, SDK/dependency adoption, app auth/upload integration, SMTP/email, deployment or M02 execution is authorized. The owner reports having enabled CDN access; the agent does not enable or provision it. No public fixture upload is inferred from “check connection.”

## Outcome and next action

Signed bucket metadata/listing returned **HTTP 200 twice**; the bounded listing was empty. The configured public `r2.dev` base returned **403**, as did one random absent-object HEAD. TLS/HTTP reachability is established, **successful anonymous file delivery is not**. An existing known non-sensitive object or separately authorized small fixture upload is needed to finish that proof; do not relabel the 403 as a CDN pass or infer its cause.

Keep full T06/T07 unchecked. Next: resolve private/public bucket separation and review a maintained auth/session integration without Supabase. No real auth, upload or private-file authorization capability is enabled by these checks.

## Two-bucket continuation

After the assistant explained two separate private/public buckets, the owner said **“sudah saya buat silahkan di cek lagi koneksi ke bucket private dan public nya”**. Record the owner-reported creation and authorize only read-only metadata checks against both configured targets plus anonymous public-CDN HEAD. This does not accept the earlier fixture-upload proposal or authorize uploads, deletes, public-policy changes, provisioning, credential changes, application integration or M02.

The [follow-up](../r2-connection-check.md#5-two-bucket-follow-up) confirms distinct bucket names at the same S3 endpoint with shared credentials: signed HEAD/list return 200 on both, with empty listings. CDN base/absent-object HEAD remain 403. Configured bucket separation is observed, not proof of disabled public paths on the private bucket, actual CDN association/file delivery or final credential isolation. Preserve original single-target results and keep the full gates open.

## Updated public URL continuation

The owner's **“ohh sorry iya benar saya lupa. saya sudah ikutkan r2 bucket base url nya.”** continues the read-only check with their updated ignored configuration. No fixture upload/delete, CORS/public-policy change, provisioning, credential change or application integration is authorized. The [07:04:05 UTC recheck](../r2-connection-check.md#6-updated-public-url-recheck) retains 200 for both signed bucket HEAD/list checks, empty listings, unsigned S3 400 and CDN base/absent-object 403. A real known-public-object test remains unrun; do not claim a CDN pass, diagnose CORS from a non-browser request or infer full private-policy acceptance.
