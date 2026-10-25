import '../../l10n/generated/app_localizations.dart';
import '../../shared_ui/icons/app_icon.dart';

enum AppDestination {
  today('/today', AppSymbol.today),
  progress('/progress', AppSymbol.progress),
  circle('/circle', AppSymbol.circle),
  you('/you', AppSymbol.you);

  const AppDestination(this.path, this.symbol);
  final String path;
  final AppSymbol symbol;

  String label(AppLocalizations strings) => switch (this) {
    today => strings.navToday,
    progress => strings.navProgress,
    circle => strings.navCircle,
    you => strings.navYou,
  };
}
