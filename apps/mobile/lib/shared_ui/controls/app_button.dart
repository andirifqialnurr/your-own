import 'package:flutter/material.dart';

import '../icons/app_icon.dart';
import '../theme/app_focus_outline.dart';
import '../theme/app_theme.dart';
import '../theme/app_tokens.g.dart';

enum AppButtonKind { primary, secondary, ghost }

/// Controlled presentation. The action owner must synchronously guard async
/// submission, handle outcomes and retain operation identity; busy UI is not
/// request idempotency. Labels are supplied by localized callers.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.kind = AppButtonKind.secondary,
    this.symbol,
    this.busy = false,
    this.busyLabel,
    this.selected,
    this.focusNode,
    this.autofocus = false,
    this.statesController,
    super.key,
  }) : assert(!busy || busyLabel != null),
       assert(selected == null || kind == AppButtonKind.secondary);
  final String label;
  final VoidCallback? onPressed;
  final AppButtonKind kind;
  final AppSymbol? symbol;
  final bool busy;
  final String? busyLabel;
  final bool? selected;
  final FocusNode? focusNode;
  final bool autofocus;
  final WidgetStatesController? statesController;

  @override
  Widget build(BuildContext context) {
    final icon = busy ? AppSymbol.pending : symbol;
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          AppIcon(icon),
          const SizedBox(width: AppTokens.space8),
        ],
        Flexible(
          child: Text(busy ? busyLabel! : label, textAlign: TextAlign.center),
        ),
      ],
    );
    final action = busy ? null : onPressed;
    final button = switch (kind) {
      AppButtonKind.primary => FilledButton(
        onPressed: action,
        focusNode: focusNode,
        autofocus: autofocus,
        statesController: statesController,
        child: content,
      ),
      AppButtonKind.secondary => OutlinedButton(
        onPressed: action,
        focusNode: focusNode,
        autofocus: autofocus,
        statesController: statesController,
        style: AppTheme.outlined(
          AppColors.of(context),
          selected: selected ?? false,
        ),
        child: content,
      ),
      AppButtonKind.ghost => TextButton(
        onPressed: action,
        focusNode: focusNode,
        autofocus: autofocus,
        statesController: statesController,
        child: content,
      ),
    };
    return AppFocusOutline(
      child: MergeSemantics(
        child: Semantics(
          liveRegion: busy,
          selected: selected,
          inMutuallyExclusiveGroup: selected != null,
          child: button,
        ),
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.label,
    required this.symbol,
    required this.onPressed,
    super.key,
  });
  final String label;
  final AppSymbol symbol;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: label,
    excludeFromSemantics: true,
    child: AppFocusOutline(
      child: MergeSemantics(
        child: Semantics(
          label: label,
          child: OutlinedButton(onPressed: onPressed, child: AppIcon(symbol)),
        ),
      ),
    ),
  );
}
