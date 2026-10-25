import 'package:flutter/material.dart';

import 'app_tokens.g.dart';

/// Stable geometry: a 3-unit focus ring separated by a 2-unit surface gap.
class AppFocusOutline extends StatefulWidget {
  const AppFocusOutline({required this.child, super.key});

  final Widget child;

  @override
  State<AppFocusOutline> createState() => _AppFocusOutlineState();
}

class _AppFocusOutlineState extends State<AppFocusOutline> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Focus(
      canRequestFocus: false,
      skipTraversal: true,
      onFocusChange: (focused) => setState(() => _focused = focused),
      child: Container(
        padding: const EdgeInsets.all(AppTokens.focusOffset),
        decoration: BoxDecoration(
          // The focus gap inherits its actual parent surface (including cards).
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(
            AppTokens.radiusControl +
                AppTokens.focusWidth +
                AppTokens.focusOffset,
          ),
          border: Border.all(
            color: _focused ? colors.focus : Colors.transparent,
            width: AppTokens.focusWidth,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
