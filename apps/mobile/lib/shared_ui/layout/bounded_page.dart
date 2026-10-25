import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../theme/app_tokens.g.dart';
import 'layout_policy.dart';

/// A scrollable local content column; the shell owns keyboard/safe insets.
class BoundedPage extends StatelessWidget {
  const BoundedPage({
    required this.child,
    required this.storageKey,
    this.maxWidth = AppTokens.readingMax,
    super.key,
  });

  final Widget child;
  final String storageKey;
  final double maxWidth;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final gutter = math.min(
        LayoutScope.maybeOf(context)?.gutter ?? AppTokens.space16,
        constraints.maxWidth / 8,
      );
      return SingleChildScrollView(
        key: PageStorageKey(storageKey),
        padding: EdgeInsets.symmetric(
          horizontal: gutter,
          vertical: AppTokens.space24,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: SizedBox(width: double.infinity, child: child),
          ),
        ),
      );
    },
  );
}
