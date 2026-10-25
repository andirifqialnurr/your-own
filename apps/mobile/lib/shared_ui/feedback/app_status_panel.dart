import 'package:flutter/material.dart';

import '../controls/app_button.dart';
import '../icons/app_icon.dart';
import '../surfaces/app_card.dart';
import '../theme/app_tokens.g.dart';

enum AppStatusKind { loading, empty, error, unavailable }

class AppStatusPanel extends StatelessWidget {
  const AppStatusPanel({
    required this.kind,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
    super.key,
  }) : assert((actionLabel == null) == (onAction == null));
  final AppStatusKind kind;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: kind == AppStatusKind.error || kind == AppStatusKind.loading,
    child: AppCard(
      compact: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppIcon(switch (kind) {
                AppStatusKind.loading => AppSymbol.pending,
                AppStatusKind.empty => AppSymbol.read,
                AppStatusKind.error => AppSymbol.error,
                AppStatusKind.unavailable => AppSymbol.info,
              }),
              const SizedBox(width: AppTokens.space8),
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.space8),
          Text(description),
          if (onAction != null) ...[
            const SizedBox(height: AppTokens.space12),
            AppButton(
              label: actionLabel!,
              onPressed: onAction,
              symbol: AppSymbol.retry,
            ),
          ],
        ],
      ),
    ),
  );
}
