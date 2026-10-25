import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:your_own/shared_ui/icons/app_icon.dart';
import 'package:your_own/shared_ui/theme/app_theme.dart';

void main() {
  for (final brightness in Brightness.values) {
    testWidgets(
      'navigation uses only the selected Free Stroke Rounded data in $brightness',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.build(brightness),
            home: const Column(
              children: [
                AppIcon(AppSymbol.today),
                AppIcon(AppSymbol.progress),
                AppIcon(AppSymbol.circle),
                AppIcon(AppSymbol.you),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();
        final icons = tester
            .widgetList<HugeIcon>(find.byType(HugeIcon))
            .toList();
        final expected = [
          HugeIcons.strokeRoundedHome01,
          HugeIcons.strokeRoundedChartHistogram,
          HugeIcons.strokeRoundedUserGroup,
          HugeIcons.strokeRoundedUserCircle,
        ];
        expect(icons, hasLength(4));
        for (var index = 0; index < icons.length; index++) {
          expect(icons[index].icon, same(expected[index]));
          expect(icons[index].strokeWidth, 2);
          expect(icons[index].size, 24);
          expect(
            find.ancestor(
              of: find.byWidget(icons[index]),
              matching: find.byType(ExcludeSemantics),
            ),
            findsWidgets,
          );
        }
        expect(find.byType(Icon), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
