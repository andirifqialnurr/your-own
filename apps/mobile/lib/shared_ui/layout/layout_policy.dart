import 'package:flutter/widgets.dart';

import '../theme/app_tokens.g.dart';

enum WindowClass { small, medium, large, largest }

enum NavigationPlacement { bottom, rail, sidebar }

/// Inputs are usable constraints AFTER safe areas and keyboard avoidance,
/// BEFORE navigation/gutters. No device names, orientations or physical pixels.
@immutable
class LayoutPolicy {
  const LayoutPolicy._(this.windowClass, this.navigation, this.gutter);

  factory LayoutPolicy.resolve({
    required double width,
    required double height,
    required bool railLabelsFit,
  }) {
    final windowClass = switch (width) {
      < AppTokens.windowMedium => WindowClass.small,
      < AppTokens.windowLarge => WindowClass.medium,
      < AppTokens.windowLargest => WindowClass.large,
      _ => WindowClass.largest,
    };
    final navigation =
        height < AppTokens.shortHeight || windowClass == WindowClass.small
        ? NavigationPlacement.bottom
        : windowClass == WindowClass.largest
        ? NavigationPlacement.sidebar
        : railLabelsFit
        ? NavigationPlacement.rail
        : NavigationPlacement.bottom;
    final gutter = switch (windowClass) {
      WindowClass.small => AppTokens.space16,
      WindowClass.medium => AppTokens.space24,
      WindowClass.large => AppTokens.space32,
      WindowClass.largest => AppTokens.space40,
    };
    return LayoutPolicy._(windowClass, navigation, gutter);
  }

  final WindowClass windowClass;
  final NavigationPlacement navigation;
  final double gutter;

  double get navigationWidth => switch (navigation) {
    NavigationPlacement.bottom => 0,
    NavigationPlacement.rail => AppTokens.railWidth,
    NavigationPlacement.sidebar => AppTokens.sidebarWidth,
  };
}

class LayoutScope extends InheritedWidget {
  const LayoutScope({required this.policy, required super.child, super.key});
  final LayoutPolicy policy;

  static LayoutPolicy? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LayoutScope>()?.policy;

  @override
  bool updateShouldNotify(LayoutScope oldWidget) =>
      policy.windowClass != oldWidget.policy.windowClass ||
      policy.navigation != oldWidget.policy.navigation ||
      policy.gutter != oldWidget.policy.gutter;
}
