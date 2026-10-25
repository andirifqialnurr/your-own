# Shared UI visual baselines

Owned synthetic fixtures, generated on Windows with Flutter **3.38.9 / Dart 3.10.8**, the bundled DM Sans font and the pinned Hugeicons renderer. No personal records or reference-app screenshots are included.

- `catalog_{actions,fields,feedback,icons}_{light,dark}.png`: 900×1400, DPR 1, 100% text. Separate widget tests cover 200% text and compact/short/tablet windows.
- `dialog_{light,dark}.png`: isolated dialog overlay layer at 900×800. Pixels outside the dialog are transparent, not a proposed black application canvas.
- The helper awaits the actual SVG loader futures; it does not capture empty placeholders or use a guessed sleep.

From `apps/mobile`:

```bash
flutter test --no-pub test/catalog_golden_test.dart
```

Only after an intentional visual change, regenerate with `--update-goldens`, inspect every changed image, and repeat without that flag. Do not auto-accept diffs, relax the comparator or overwrite these with another platform's rendering without review. These are host baselines, not Android/iOS screenshots, accessibility certification or owner design acceptance.

Artwork: **Hugeicons Free Stroke Rounded 1.2.0**, Copyright (c) 2024 Halal Labs, MIT. Retain the complete [supplied license](HUGEICONS-LICENSE.txt) with these redistributed fixtures. Font: [DM Sans provenance and OFL](../../assets/fonts/README.md). The PNGs contain rendered output, not a new icon/font family. Final app artifact notices and other-platform/poster usage remain separately reviewed.

[Implementation and test evidence](../../../../docs/cookbook/mobile-shared-ui.md).
