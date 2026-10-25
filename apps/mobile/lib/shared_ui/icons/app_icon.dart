import 'package:flutter/widgets.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_tokens.g.dart';

enum AppSymbol {
  today,
  progress,
  circle,
  you,
  focus,
  read,
  intake,
  money,
  back,
  next,
  close,
  menu,
  add,
  edit,
  delete,
  visible,
  hidden,
  retry,
  check,
  info,
  warning,
  error,
  search,
  settings,
  messages,
  share,
  save,
  pending,
}

/// Closed decorative artwork. A containing control or adjacent text supplies
/// localized semantics. Only directional navigation mirrors in RTL. No raw SVG,
/// remote asset, Pro pack or glyph fallback.
class AppIcon extends StatelessWidget {
  const AppIcon(this.symbol, {super.key});
  final AppSymbol symbol;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Transform.flip(
      flipX:
          (symbol == AppSymbol.back || symbol == AppSymbol.next) &&
          Directionality.of(context) == TextDirection.rtl,
      child: HugeIcon(
        icon: switch (symbol) {
          AppSymbol.today => HugeIcons.strokeRoundedHome01,
          AppSymbol.progress => HugeIcons.strokeRoundedChartHistogram,
          AppSymbol.circle => HugeIcons.strokeRoundedUserGroup,
          AppSymbol.you => HugeIcons.strokeRoundedUserCircle,
          AppSymbol.focus => HugeIcons.strokeRoundedTimer01,
          AppSymbol.read => HugeIcons.strokeRoundedBookOpen01,
          AppSymbol.intake => HugeIcons.strokeRoundedDroplet,
          AppSymbol.money => HugeIcons.strokeRoundedWallet01,
          AppSymbol.back => HugeIcons.strokeRoundedArrowLeft01,
          AppSymbol.next => HugeIcons.strokeRoundedArrowRight01,
          AppSymbol.close => HugeIcons.strokeRoundedCancel01,
          AppSymbol.menu => HugeIcons.strokeRoundedMenu01,
          AppSymbol.add => HugeIcons.strokeRoundedAdd01,
          AppSymbol.edit => HugeIcons.strokeRoundedPencilEdit01,
          AppSymbol.delete => HugeIcons.strokeRoundedDelete02,
          AppSymbol.visible => HugeIcons.strokeRoundedView,
          AppSymbol.hidden => HugeIcons.strokeRoundedViewOff,
          AppSymbol.retry => HugeIcons.strokeRoundedRefresh,
          AppSymbol.check => HugeIcons.strokeRoundedTick02,
          AppSymbol.info => HugeIcons.strokeRoundedInformationCircle,
          AppSymbol.warning => HugeIcons.strokeRoundedAlert02,
          AppSymbol.error => HugeIcons.strokeRoundedAlertCircle,
          AppSymbol.search => HugeIcons.strokeRoundedSearch01,
          AppSymbol.settings => HugeIcons.strokeRoundedSettings01,
          AppSymbol.messages => HugeIcons.strokeRoundedMessage01,
          AppSymbol.share => HugeIcons.strokeRoundedShare01,
          AppSymbol.save => HugeIcons.strokeRoundedFloppyDisk,
          AppSymbol.pending => HugeIcons.strokeRoundedHourglass,
        },
        color:
            DefaultTextStyle.of(context).style.color ??
            AppColors.of(context).icon,
        size: AppTokens.navigationIconSize,
        strokeWidth: 2,
      ),
    ),
  );
}
