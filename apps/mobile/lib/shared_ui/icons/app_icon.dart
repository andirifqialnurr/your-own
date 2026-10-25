import 'package:flutter/widgets.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_tokens.g.dart';

enum AppSymbol { today, progress, circle, you }

/// Closed, decorative navigation artwork. The adjacent button supplies its
/// localized label/semantics. No arbitrary SVG, remote asset or glyph fallback.
class AppIcon extends StatelessWidget {
  const AppIcon(this.symbol, {super.key});
  final AppSymbol symbol;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: HugeIcon(
      icon: switch (symbol) {
        AppSymbol.today => HugeIcons.strokeRoundedHome01,
        AppSymbol.progress => HugeIcons.strokeRoundedChartHistogram,
        AppSymbol.circle => HugeIcons.strokeRoundedUserGroup,
        AppSymbol.you => HugeIcons.strokeRoundedUserCircle,
      },
      color: DefaultTextStyle.of(context).style.color,
      size: AppTokens.navigationIconSize,
      strokeWidth: 2,
    ),
  );
}
