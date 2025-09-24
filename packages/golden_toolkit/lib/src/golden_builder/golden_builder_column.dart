part of 'golden_builder.dart';

class GoldenBuilderColumn extends GoldenBuilder {
  /// Will output a .png file with a column layout in 'tests/goldens' folder.
  ///
  /// [wrap] (optional) will wrap the scenario's widget in the tree.
  ///
  /// [bgColor] will change the background color of output .png file
  ///
  GoldenBuilderColumn({super.bgColor, super.wrap, this.crossAxisAlignment = CrossAxisAlignment.center});

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget _buildInternal() {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: scenarios,
    );
  }
}
