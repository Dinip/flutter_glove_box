part of 'golden_builder.dart';

typedef TableColumnWidthMap = Map<int, TableColumnWidth>;

class GoldenBuilderTable extends GoldenBuilder {
  static TableColumnWidthMap flexibleColumns(int count) {
    return {for (var index in List.generate(count, (index) => index)) index: const FlexColumnWidth(1)};
  }

  static TableColumnWidthMap fixedColumns({required int count, required double columnWidth}) {
    return {for (var index in List.generate(count, (index) => index)) index: FixedColumnWidth(columnWidth)};
  }

  GoldenBuilderTable({
    required this.columns,
    this.rowSpacing = 16.0,
    super.wrap,
    super.bgColor,
    this.columnWidths = const {},
  });

  /// number of columns to distribute the scenarios in
  final int columns;

  /// horizontal spacing between columns
  final double rowSpacing;

  /// column widths for the actual content columns
  /// if a column width is not provided, it will default to IntrinsicColumnWidth
  /// GoldenBuilderTable.flexibleColumns() and GoldenBuilderTable.fixedColumns() are available, as helpers.
  final TableColumnWidthMap columnWidths;

  int get _effectiveRows => (scenarios.length / columns).ceil();

  /// for example:
  /// columns = 2
  /// columnWidths expects the user to provide like {0: FlexColumnWidth(1), 1: FlexColumnWidth(1)}
  /// but in reality, it has 3 columns, because of the spacing column, so the effective
  /// columnWidths will be {0: FlexColumnWidth(1), 1: FixedColumnWidth(rowSpacing), 2: FlexColumnWidth(1)}
  /// if a column width is not provided, it will default to IntrinsicColumnWidth
  /// spacing columns are always FixedColumnWidth(rowSpacing)
  TableColumnWidthMap _effectiveColumnWidths() {
    final widths = <int, TableColumnWidth>{};
    for (int i = 0; i < columns; i++) {
      widths[i * 2] = columnWidths[i] ?? const IntrinsicColumnWidth();
    }
    for (int i = 0; i < columns - 1; i++) {
      widths[i * 2 + 1] = FixedColumnWidth(rowSpacing);
    }
    return widths;
  }

  @override
  Widget _buildInternal() {
    return Table(
      columnWidths: _effectiveColumnWidths(),
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        for (int row = 0; row < _effectiveRows; row++)
          TableRow(
            children: [
              for (int col = 0; col < columns; col++)
                if (row * columns + col < scenarios.length) ...[
                  scenarios[row * columns + col],
                  if (col < columns - 1) const SizedBox.shrink(),
                ] else ...[
                  const SizedBox.shrink(),
                ],
            ],
          ),
      ],
    );
  }
}
