import 'package:flutter/material.dart';

import '../../../core/domain/appearance_preference.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared_ui/theme/app_focus_outline.dart';
import '../../../shared_ui/theme/app_theme.dart';
import '../../../shared_ui/theme/app_tokens.g.dart';
import '../../../shared_ui/theme/font_license_dialog.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({
    required this.preference,
    required this.saving,
    required this.storageError,
    required this.onPreferenceChanged,
    required this.onRetry,
    super.key,
  });

  final AppearancePreference preference;
  final bool saving;
  final bool storageError;
  final ValueChanged<AppearancePreference> onPreferenceChanged;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final colors = AppColors.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            key: const PageStorageKey('setup-scroll'),
            padding: const EdgeInsets.all(AppTokens.space24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppTokens.formMax),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(strings.appName, style: text.labelLarge),
                  const SizedBox(height: AppTokens.space16),
                  Text(strings.setupTitle, style: text.headlineMedium),
                  const SizedBox(height: AppTokens.space16),
                  Text(strings.setupDescription, style: text.bodyLarge),
                  const SizedBox(height: AppTokens.space24),
                  Text(
                    strings.setupNotice,
                    style: text.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTokens.space32),
                  Semantics(
                    header: true,
                    child: Text(
                      strings.appearanceTitle,
                      style: text.titleMedium,
                    ),
                  ),
                  const SizedBox(height: AppTokens.space8),
                  Text(
                    strings.appearanceDescription,
                    style: text.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTokens.space12),
                  Wrap(
                    spacing: AppTokens.space8,
                    runSpacing: AppTokens.space8,
                    children: [
                      for (final choice in AppearancePreference.values)
                        AppFocusOutline(
                          child: MergeSemantics(
                            child: Semantics(
                              selected: preference == choice,
                              inMutuallyExclusiveGroup: true,
                              child: OutlinedButton(
                                key: ValueKey('appearance-${choice.name}'),
                                style: AppTheme.outlined(
                                  colors,
                                  selected: preference == choice,
                                ),
                                onPressed: () => onPreferenceChanged(choice),
                                child: Text(switch (choice) {
                                  AppearancePreference.system =>
                                    strings.appearanceSystem,
                                  AppearancePreference.light =>
                                    strings.appearanceLight,
                                  AppearancePreference.dark =>
                                    strings.appearanceDark,
                                }),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (saving || storageError) ...[
                    const SizedBox(height: AppTokens.space12),
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        storageError
                            ? strings.appearanceStorageError
                            : strings.appearanceSaving,
                        style: text.bodyMedium,
                      ),
                    ),
                    if (storageError)
                      AppFocusOutline(
                        child: TextButton(
                          onPressed: onRetry,
                          child: Text(strings.retry),
                        ),
                      ),
                  ],
                  const SizedBox(height: AppTokens.space24),
                  AppFocusOutline(
                    child: TextButton(
                      onPressed: () => showDialog<void>(
                        context: context,
                        builder: (context) => const FontLicenseDialog(),
                      ),
                      child: Text(strings.fontLicense),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
