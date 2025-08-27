part of 'golden_builder.dart';
class GoldenBuilderColumn extends GoldenBuilder {
  /// Will output a .png file with a column layout in 'tests/goldens' folder.
  ///
  /// [wrap] (optional) will wrap the scenario's widget in the tree.
  ///
  /// [bgColor] will change the background color of output .png file
  ///
  GoldenBuilderColumn({super.bgColor, super.wrap});

  @override
  Widget _buildInternal() => Column(mainAxisSize: MainAxisSize.min, children: scenarios);
}
