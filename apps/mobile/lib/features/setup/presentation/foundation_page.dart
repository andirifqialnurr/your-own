import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../shared_ui/layout/bounded_page.dart';
import '../../../shared_ui/theme/app_focus_outline.dart';
import '../../../shared_ui/theme/app_tokens.g.dart';

/// Honest development placeholders, not enabled tracking/social features.
class FoundationPage extends StatelessWidget {
  const FoundationPage({
    required this.title,
    required this.description,
    required this.storageKey,
    required this.onOpenAppearance,
    this.storageError = false,
    this.onOpenMessages,
    this.onBack,
    super.key,
  });
  final String title;
  final String description;
  final String storageKey;
  final bool storageError;
  final VoidCallback onOpenAppearance;
  final VoidCallback? onOpenMessages;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    return BoundedPage(
      storageKey: storageKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strings.appName, style: text.labelLarge),
          const SizedBox(height: AppTokens.space16),
          Semantics(
            header: true,
            child: Text(title, style: text.headlineMedium),
          ),
          const SizedBox(height: AppTokens.space16),
          if (onBack != null) ...[
            AppFocusOutline(
              child: TextButton(onPressed: onBack, child: Text(strings.back)),
            ),
            const SizedBox(height: AppTokens.space16),
          ],
          if (onOpenMessages != null) ...[
            AppFocusOutline(
              child: TextButton(
                onPressed: onOpenMessages,
                child: Text(strings.messagesEntry),
              ),
            ),
            const SizedBox(height: AppTokens.space16),
          ],
          Text(description, style: text.bodyLarge),
          const SizedBox(height: AppTokens.space24),
          Text(strings.setupNotice, style: text.bodyMedium),
          if (storageError) ...[
            const SizedBox(height: AppTokens.space16),
            Semantics(
              liveRegion: true,
              child: Text(strings.appearanceStorageError),
            ),
          ],
          const SizedBox(height: AppTokens.space24),
          AppFocusOutline(
            child: TextButton(
              onPressed: onOpenAppearance,
              child: Text(strings.appearanceTitle),
            ),
          ),
        ],
      ),
    );
  }
}
