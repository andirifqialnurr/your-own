# Decision 0017 — Synthetic R2 upload test and asset prefixes

- **Status:** Bounded upload/read/cleanup executed on both buckets; CDN known-file GET denied, full T06 still unchecked
- **Approved by:** Project owner, 2026-10-26 UTC
- **Recorded by:** Coding agent
- **Related:** [Decision 0016](0016-framework-auth-and-r2-storage.md), [prior read-only evidence](../r2-connection-check.md)

## Owner instruction

After repeated metadata-only checks and the request for a known public file, the owner said:

> silahkan anda menguji unggahannya saja. anda bisa buat folder untuk menata file-file aset untuk public dan privatenya.

This explicitly extends the earlier read-only scope to a small synthetic upload test in the configured public/private buckets and asset-prefix organization. It does not authorize arbitrary personal-data upload, enabling public delivery on private storage, provider provisioning or application implementation.

## Bounded execution

- Use the existing ignored root `.env` without printing/copying/changing credentials. Preserve the API `.env`, app/lock/policy/asset/native files and historical evidence. No dependency/SDK installation, Docker, app upload route or M02.
- Use verified HTTPS/no redirects and existing standard-library SigV4 transport only in the external disposable probe. Validate configured official S3 endpoints and separate bucket targets; never send credentials to CDN URLs.
- Upload one non-sensitive text fixture per bucket, under `public/assets/connection-tests/<random-run-id>.txt` and `private/assets/connection-tests/<random-run-id>.txt`. Total payload below 8 KiB; no user/account identifiers or real data. Do not read or overwrite existing owner objects. Use random keys, conditional creation and task ownership metadata; do not blindly retry an uncertain write.
- R2 folders are object-key prefixes, not filesystem access boundaries. A zero-byte `public/assets/.keep` / `private/assets/.keep` may be created if absent to retain the owner's requested visible organization. Keep only successfully established markers; never replace a pre-existing marker. Prefixes/markers are organizational only, not a product schema or privacy control.
- Read back only owned synthetic fixtures through authenticated R2 and compare exact bytes. Test anonymous public CDN delivery of the public fixture, and limited denial controls for synthetic private access without claiming that every possible private public/custom-domain path has been audited.
- Clean up only this run's owned text fixtures in `finally`, including an uncertain PUT that can be positively identified by task metadata. Check metadata/ETag before deleting; never use bucket/prefix-wide deletion. Verify fixture absence through S3 and report CDN/cache behavior separately. If cleanup cannot be verified, report remaining synthetic objects rather than hiding the failure. New successful `.keep` markers may remain, as authorized organization.
- Bound each request to 15 seconds, each response to 8 KiB, and the run to approximately five minutes / 40 requests. No multipart, policy/CORS/lifecycle/cache-purge change, bucket/key creation, private public enablement, external mail, app authentication integration or deployment.
- Persist only sanitized statuses/hashes/ownership/cleanup results. A random run ID can be kept externally for reconstructing this run's synthetic keys if recovery is needed; no endpoint/account/bucket values or auth headers in logs/source control. Separately commit/push the reviewed decision/evidence under the existing owner instruction.

## Acceptance boundary

A successful synthetic PUT/GET/DELETE is a point-in-time integration result, not approval of production media validation, authorization, cache/revocation/deletion races, credential isolation, private public-path settings, backup/restore, browser CORS, native behavior or full T06/M02. Preserve prior 403 and empty-list results as their original checkpoints. The result and next action must be recorded after execution, without treating a CDN 403 as a successful public-file test.

## Execution checkpoint

The [07:18:28 UTC report](../r2-upload-check.md) records real conditional PUT 200 / exact GET 200 / ETag-conditional DELETE 204 / post-delete HEAD 404 for **both** tiny text fixtures (181 total bytes). Two newly created zero-byte `public/assets/.keep` / `private/assets/.keep` markers remain as authorized organization. CDN GET of the existing public fixture still returned **403**, so an empty bucket is not sufficient explanation and public-file delivery remains unverified. Limited private denial controls passed only for the tested routes; no complete private-path audit is implied. Twenty-two main requests plus one diagnostic read; no config/policy/TLS bypass, owner data change, SDK/app integration or full gate advancement. All original read-only checkpoints are preserved.
