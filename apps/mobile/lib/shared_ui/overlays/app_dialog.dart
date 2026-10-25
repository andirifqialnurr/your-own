import 'package:flutter/material.dart';

import '../controls/app_button.dart';
import '../theme/app_tokens.g.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.title,
    required this.child,
    required this.actions,
    super.key,
  });
  final String title;
  final Widget child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final compact =
        media.size.width - media.padding.horizontal < AppTokens.windowMedium ||
        media.size.height - media.viewInsets.vertical - media.padding.vertical <
            AppTokens.shortHeight;
    return Dialog(
      insetPadding: compact
          ? EdgeInsets.zero
          : const EdgeInsets.all(AppTokens.space24),
      insetAnimationDuration: Duration.zero,
      constraints: BoxConstraints(
        minWidth: 0,
        maxWidth: compact ? double.infinity : AppTokens.formMax,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(compact ? 0 : AppTokens.radiusCard),
        side: BorderSide(color: AppColors.of(context).controlBorder),
      ),
      // Keep this tree stable across resize, including arbitrary child drafts.
      child: SizedBox(
        width: double.infinity,
        height: compact ? double.infinity : null,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTokens.space24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Semantics(
                  namesRoute: true,
                  header: true,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: AppTokens.space16),
                child,
                const SizedBox(height: AppTokens.space24),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Wrap(
                    spacing: AppTokens.space8,
                    runSpacing: AppTokens.space8,
                    children: actions,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Confirmation returns intent only. The caller owns authorization/mutation.
Future<bool> showAppConfirmation({
  required BuildContext context,
  required String title,
  required String description,
  required String cancelLabel,
  required String confirmLabel,
}) async {
  final previousFocus = FocusManager.instance.primaryFocus;
  try {
    return await showDialog<bool>(
          context: context,
          barrierColor: Theme.of(context).colorScheme.scrim,
          animationStyle: AnimationStyle.noAnimation,
          traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
          builder: (context) => AppDialog(
            title: title,
            actions: [
              AppButton(
                label: cancelLabel,
                autofocus: true,
                kind: AppButtonKind.ghost,
                onPressed: () => Navigator.of(context).pop(false),
              ),
              AppButton(
                label: confirmLabel,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
            child: Text(description),
          ),
        ) ??
        false;
  } finally {
    if (previousFocus?.context?.mounted == true &&
        previousFocus!.canRequestFocus) {
      previousFocus.requestFocus();
    }
  }
}
