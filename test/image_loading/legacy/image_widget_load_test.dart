import 'package:flutter_test/flutter_test.dart';
import 'package:feels_golden/feels_golden.dart';

import '../image_loading_utils.dart';

void main() {
  group(
    'Image Loading Tests - Legacy',
    () {
      testWidgets('should load assets from Image Widgets', (tester) async {
        await GoldenToolkit.runWithConfiguration(
          () async {
            await tester.pumpWidgetBuilder(const ImageWidget());
            await tester.waitForAssets();
            await tester.pump();
            await expectLater(find.byType(ImageWidget).first, matchesGoldenFile('goldens/image_will_show_legacy.png'));
          },
          config: legacyConfiguration,
        );
      });
    },
  );
}
