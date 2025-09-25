import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens('Auto Width test', (tester) async {
    final builder = GoldenBuilderTable(columns: 2);

    for (int i = 0; i < 4; i++) {
      builder.addScenario(
          'Square Container',
          Container(
            width: 100,
            height: 100,
            color: const Color.fromARGB(255, 36, 51, 66),
          ));
    }

    await tester.pumpWidgetBuilder(builder.build());

    await screenMatchesGolden(
      tester,
      'golden_auto_width',
      autoHeight: true,
      autoWidth: true,
      finder: find.byType(Container).first,
    );
  });
}
