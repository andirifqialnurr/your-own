import 'package:flutter_test/flutter_test.dart';
import 'package:your_own/shared_ui/layout/layout_policy.dart';

void main() {
  for (final (width, expected) in <(double, WindowClass)>[
    (280, WindowClass.small),
    (599, WindowClass.small),
    (600, WindowClass.medium),
    (839, WindowClass.medium),
    (840, WindowClass.large),
    (1199, WindowClass.large),
    (1200, WindowClass.largest),
    (2560, WindowClass.largest),
  ]) {
    test('usable width $width maps to $expected', () {
      expect(
        LayoutPolicy.resolve(
          width: width,
          height: 800,
          railLabelsFit: true,
        ).windowClass,
        expected,
      );
    });
  }
  test(
    '479/480 interactive height changes navigation without changing class',
    () {
      final short = LayoutPolicy.resolve(
        width: 1024,
        height: 479,
        railLabelsFit: true,
      );
      final tall = LayoutPolicy.resolve(
        width: 1024,
        height: 480,
        railLabelsFit: true,
      );
      expect(short.windowClass, tall.windowClass);
      expect(short.navigation, NavigationPlacement.bottom);
      expect(tall.navigation, NavigationPlacement.rail);
    },
  );
  test(
    'large text/long labels opt out of a cramped rail, not text scaling',
    () {
      for (final width in [600.0, 840.0, 1199.0]) {
        expect(
          LayoutPolicy.resolve(
            width: width,
            height: 800,
            railLabelsFit: false,
          ).navigation,
          NavigationPlacement.bottom,
        );
      }
      expect(
        LayoutPolicy.resolve(
          width: 1200,
          height: 800,
          railLabelsFit: false,
        ).navigation,
        NavigationPlacement.sidebar,
      );
    },
  );
}
