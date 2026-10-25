# Bundled DM Sans

The normal variable font is an **unmodified upstream TTF**, locally named `DMSans-Variable.ttf`. It is not downloaded at application runtime. Optical-size range: 9–40; weight range: 100–1000. No italic or other font family is included.

- Original project: [googlefonts/dm-fonts](https://github.com/googlefonts/dm-fonts/tree/d0520ba03bd780f5dccb3024854463d44f699b78/Sans), commit `d0520ba03bd780f5dccb3024854463d44f699b78`.
- Google Fonts mirror: [ofl/dmsans](https://github.com/google/fonts/tree/5b35b7208dd4100571326fdf37f030b32a524232/ofl/dmsans), commit `5b35b7208dd4100571326fdf37f030b32a524232`.
- The source and mirror TTF/license bytes matched independently when reviewed on 2026-10-24 UTC. [provenance.json](provenance.json) records paths, lengths and SHA-256 hashes.
- Copyright **2014 The DM Sans Project Authors (https://github.com/googlefonts/dm-fonts)**. Designer metadata: Colophon Foundry.
- Full [SIL Open Font License 1.1](OFL.txt) is retained byte-for-byte, including its original line endings. Keep its copyright and complete terms with redistributed copies; do not sell the font by itself, relicense it, or imply author endorsement. Modification/reserved-name conditions remain applicable to future changes.

`pubspec.yaml` bundles the font and notice. The app registers the notice and exposes it through **DM Sans license**. From the repository root, `pnpm check:assets` verifies the reviewed bytes. Native rendering, archive contents and final distribution compliance still require the affected platform checks.

The upstream notice intentionally retains its original trailing space on line 21. A staged Git whitespace check reports that line; check owned sources separately and verify this notice by its reviewed byte hash instead of rewriting third-party license bytes.
