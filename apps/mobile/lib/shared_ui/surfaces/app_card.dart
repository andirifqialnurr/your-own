import 'package:flutter/material.dart';

import '../theme/app_tokens.g.dart';

/// Static surface: no tap/hover behavior or synthetic button semantics.
class AppCard extends StatelessWidget {
  const AppCard({required this.child, this.compact = false, super.key});
  final Widget child;
  final bool compact;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        compact ? AppTokens.radiusCompactCard : AppTokens.radiusCard,
      ),
      side: BorderSide(color: AppColors.of(context).border),
    ),
    child: Padding(
      padding: EdgeInsets.all(compact ? AppTokens.space16 : AppTokens.space24),
      child: child,
    ),
  );
}
