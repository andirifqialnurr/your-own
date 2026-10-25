import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../shared_ui/icons/app_icon.dart';
import '../../shared_ui/layout/layout_policy.dart';
import '../../shared_ui/theme/app_focus_outline.dart';
import '../../shared_ui/theme/app_theme.dart';
import '../../shared_ui/theme/app_tokens.g.dart';
import '../router/app_destination.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    required this.selectedIndex,
    required this.onSelect,
    required this.child,
    super.key,
  });
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _navigationScroll = ScrollController();

  @override
  void dispose() {
    _navigationScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final labels = [
      for (final destination in AppDestination.values)
        destination.label(strings),
    ];
    final style = Theme.of(context).textTheme.labelMedium!;
    final scaler = MediaQuery.textScalerOf(context);
    var widestLabel = 0.0;
    var labelHeight = 0.0;
    for (final label in labels) {
      final painter = TextPainter(
        text: TextSpan(text: label, style: style),
        textDirection: Directionality.of(context),
        textScaler: scaler,
      )..layout();
      widestLabel = math.max(widestLabel, painter.width);
      labelHeight = math.max(labelHeight, painter.height);
      painter.dispose();
    }
    final railLabelsFit =
        widestLabel <=
        AppTokens.railWidth -
            2 *
                (AppTokens.space4 +
                    AppTokens.focusWidth +
                    AppTokens.focusOffset +
                    AppTokens.borderWidth);
    final bottomHeight =
        math.max(
          AppTokens.minimumTarget,
          math.max(labelHeight, AppTokens.navigationIconSize) +
              2 * AppTokens.space8 +
              2 * AppTokens.borderWidth,
        ) +
        2 * (AppTokens.focusWidth + AppTokens.focusOffset) +
        AppTokens.space8;
    return Scaffold(
      key: const ValueKey('app-shell'),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final policy = LayoutPolicy.resolve(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              railLabelsFit: railLabelsFit,
            );
            final bottom = policy.navigation == NavigationPlacement.bottom;
            return LayoutScope(
              policy: policy,
              // Stable slots: only geometry changes; never reparent the router.
              child: Stack(
                children: [
                  PositionedDirectional(
                    top: 0,
                    start: policy.navigationWidth,
                    end: 0,
                    bottom: bottom ? bottomHeight : 0,
                    child: SizedBox(
                      key: const ValueKey('shell-content'),
                      child: widget.child,
                    ),
                  ),
                  PositionedDirectional(
                    start: 0,
                    bottom: 0,
                    top: bottom ? null : 0,
                    end: bottom ? 0 : null,
                    width: bottom ? null : policy.navigationWidth,
                    height: bottom ? bottomHeight : null,
                    child: _navigation(context, policy, labels, style),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _navigation(
    BuildContext context,
    LayoutPolicy policy,
    List<String> labels,
    TextStyle style,
  ) {
    final strings = AppLocalizations.of(context);
    final bottom = policy.navigation == NavigationPlacement.bottom;
    return Semantics(
      container: true,
      label: strings.primaryNavigation,
      hint: strings.navigationScrollHint,
      child: Material(
        color: AppColors.of(context).canvas,
        child: Scrollbar(
          controller: _navigationScroll,
          thumbVisibility: true,
          child: SingleChildScrollView(
            key: const ValueKey('primary-navigation'),
            controller: _navigationScroll,
            scrollDirection: bottom ? Axis.horizontal : Axis.vertical,
            padding: const EdgeInsets.only(bottom: AppTokens.space8),
            child: Flex(
              direction: bottom ? Axis.horizontal : Axis.vertical,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final destination in AppDestination.values)
                  SizedBox(
                    width: bottom ? null : policy.navigationWidth,
                    child: _NavigationItem(
                      destination: destination,
                      label: labels[destination.index],
                      style: style,
                      placement: policy.navigation,
                      selected: widget.selectedIndex == destination.index,
                      onPressed: () {
                        if (widget.selectedIndex != destination.index) {
                          widget.onSelect(destination.index);
                        }
                      },
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

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.destination,
    required this.label,
    required this.style,
    required this.placement,
    required this.selected,
    required this.onPressed,
  });
  final AppDestination destination;
  final String label;
  final TextStyle style;
  final NavigationPlacement placement;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final icon = AppIcon(destination.symbol);
    final content = switch (placement) {
      NavigationPlacement.rail => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: AppTokens.space4),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
      NavigationPlacement.bottom => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: AppTokens.space8),
          Text(label, softWrap: false),
        ],
      ),
      NavigationPlacement.sidebar => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: AppTokens.space8),
          Flexible(child: Text(label)),
        ],
      ),
    };
    return AppFocusOutline(
      child: MergeSemantics(
        child: Semantics(
          selected: selected,
          inMutuallyExclusiveGroup: true,
          child: OutlinedButton(
            key: ValueKey('nav-${destination.name}'),
            style: AppTheme.outlined(AppColors.of(context), selected: selected)
                .copyWith(
                  textStyle: WidgetStatePropertyAll(style),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(
                      horizontal: AppTokens.space4,
                      vertical: AppTokens.space8,
                    ),
                  ),
                ),
            onPressed: onPressed,
            child: content,
          ),
        ),
      ),
    );
  }
}
