import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> selectDestination(WidgetTester tester, String name) async {
  final target = find.byKey(ValueKey('nav-$name'));
  await tester.ensureVisible(target);
  await tester.tap(target);
  await tester.pumpAndSettle();
}
