import 'package:flutter/material.dart';

import '../theme/app_tokens.g.dart';
import 'app_button.dart';

/// Plain-text primitive, not a Money/password parser or persistence owner.
class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    required this.controller,
    this.helper,
    this.error,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
    this.maxLines = 1,
    super.key,
  });
  final String label;
  final TextEditingController controller;
  final String? helper;
  final String? error;
  final bool enabled;
  final bool readOnly;
  final FocusNode? focusNode;
  final int maxLines;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // External label wraps without the floating label's single-line clipping.
      ExcludeSemantics(
        child: Text(label, style: Theme.of(context).textTheme.labelLarge),
      ),
      const SizedBox(height: AppTokens.space8),
      Semantics(
        label: label,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          readOnly: readOnly,
          maxLines: maxLines,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: enabled
                ? AppColors.of(context).textPrimary
                : AppColors.of(context).onDisabled,
          ),
          autocorrect: false,
          enableSuggestions: false,
          enableIMEPersonalizedLearning: false,
          spellCheckConfiguration: const SpellCheckConfiguration.disabled(),
          decoration: InputDecoration(
            fillColor: enabled
                ? AppColors.of(context).surface
                : AppColors.of(context).disabled,
            helper: helper == null ? null : Text(helper!),
            error: error == null
                ? null
                : Semantics(liveRegion: true, child: Text(error!)),
          ),
          contextMenuBuilder: (context, state) => _FieldToolbar(state: state),
        ),
      ),
    ],
  );
}

/// Keep explicit clipboard/selection actions, without SDK overflow/back glyphs
/// or search/share actions that could send field text to another application.
class _FieldToolbar extends StatelessWidget {
  const _FieldToolbar({required this.state});
  final EditableTextState state;

  @override
  Widget build(BuildContext context) {
    final anchors = state.contextMenuAnchors;
    return CustomSingleChildLayout(
      delegate: TextSelectionToolbarLayoutDelegate(
        anchorAbove: anchors.primaryAnchor,
        anchorBelow: anchors.secondaryAnchor ?? anchors.primaryAnchor,
      ),
      child: Material(
        color: AppColors.of(context).raised,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusControl),
          side: BorderSide(color: AppColors.of(context).controlBorder),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final item in state.contextMenuButtonItems)
                if (const {
                  ContextMenuButtonType.cut,
                  ContextMenuButtonType.copy,
                  ContextMenuButtonType.paste,
                  ContextMenuButtonType.selectAll,
                }.contains(item.type))
                  AppButton(
                    kind: AppButtonKind.ghost,
                    label: AdaptiveTextSelectionToolbar.getButtonLabel(
                      context,
                      item,
                    ),
                    onPressed: item.onPressed,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
