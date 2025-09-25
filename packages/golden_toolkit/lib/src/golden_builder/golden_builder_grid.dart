part of 'golden_builder.dart';

class GoldenBuilderGrid extends GoldenBuilder {
  /// Will output a *.png file with a grid layout in 'tests/goldens' folder.
  ///
  /// You need to specify how many columns [columns] and widthToHeight ratio [widthToHeightRatio]
  ///
  /// [widthToHeightRatio] can range from 0.0 to 1.0
  ///
  /// [wrap] (optional) will wrap the scenario's widget in the tree.
  ///
  /// [bgColor] will change the background color of output .png file
  GoldenBuilderGrid({
    required this.columns,
    required this.widthToHeightRatio,
    super.wrap,
    super.bgColor,
    super.titleTextStyle,
  });

  /// number of columns [columns] in a grid
  final int columns;

  ///  [widthToHeightRatio]  grid layout
  final double widthToHeightRatio;

  @override
  Widget _buildInternal() {
    return GridView.count(
      childAspectRatio: widthToHeightRatio,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      crossAxisCount: columns,
      children: scenarios,
    );
  }
}
