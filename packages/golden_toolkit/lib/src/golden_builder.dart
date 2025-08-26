/// ***************************************************
/// Copyright 2019-2020 eBay Inc.
///
/// Use of this source code is governed by a BSD-style
/// license that can be found in the LICENSE file or at
/// https://opensource.org/licenses/BSD-3-Clause
/// ***************************************************

import 'package:flutter/widgets.dart';

import 'testing_tools.dart';

/// as of iOS 13.2.3 the max textScaleFactor a user can set is ~3.1176
const double textScaleFactorMaxSupported = 3.2;

/// GoldenBuilder builds column/grid layout for it's children
abstract class GoldenBuilder {
  GoldenBuilder({this.wrap, this.bgColor});

  static column({
    WidgetWrapper? wrap,
    Color? bgColor,
  }) {
    return GoldenBuilderColumn(
      wrap: wrap,
      bgColor: bgColor,
    );
  }

  static grid({
    required int columns,
    required double widthToHeightRatio,
    WidgetWrapper? wrap,
    Color? bgColor,
  }) {
    return GoldenBuilderGrid(
      columns: columns,
      widthToHeightRatio: widthToHeightRatio,
      wrap: wrap,
      bgColor: bgColor,
    );
  }

  static table({
    required int columns,
    double rowSpacing = 16.0,
    WidgetWrapper? wrap,
    Color? bgColor,
  }) {
    return GoldenBuilderTable(
      columns: columns,
      wrap: wrap,
      bgColor: bgColor,
      rowSpacing: rowSpacing,
    );
  }

  /// Can be used to wrap all scenario widgets. Useful if you wish to
  /// provide consistent UI treatment to all of them or need to inject dependencies.
  final WidgetWrapper? wrap;

  ///  background [bgColor] color of output .png file
  final Color? bgColor;

  ///  List of tests [scenarios]  being run within GoldenBuilder
  final List<Widget> scenarios = [];

  ///  [addTextScaleScenario]  will add a test to GoldenBuilder where u can provide custom font size
  void addTextScaleScenario(
    String name,
    Widget widget, {
    double textScaleFactor = textScaleFactorMaxSupported,
  }) {
    addScenario(
        '$name ${textScaleFactor}x',
        _TextScaleFactor(
          textScaleFactor: textScaleFactor,
          child: widget,
        ));
  }

  ///  [addScenario] will add a test GoldenBuilder
  void addScenario(String name, Widget widget) {
    scenarios.add(_Scenario(
      name: name,
      widget: widget,
      wrap: wrap,
    ));
  }

  ///  [addScenarioBuilder] will add a test with BuildContext GoldenBuilder
  /// use as:
  /// ..addScenarioBuilder(
  ///   'Test with context',
  ///   (context) {
  ///     var color = Theme.of(context).colorScheme.primary;
  ///     return Container(color: color);
  ///   },
  /// )
  void addScenarioBuilder(String name, Widget Function(BuildContext context) fn) {
    addScenario(
      name,
      Builder(builder: fn),
    );
  }

  Widget _buildInternal();

  ///  [build] will build a list of [scenarios]  with a given layout
  Widget build() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: bgColor ?? const Color(0xFFEEEEEE),
        child: _buildInternal(),
      ),
    );
  }
}

class _Scenario extends StatelessWidget {
  const _Scenario({
    Key? key,
    required this.name,
    required this.widget,
    this.wrap,
  }) : super(key: key);

  final WidgetWrapper? wrap;
  final String name;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 4),
          wrap?.call(widget) ?? widget,
        ],
      ),
    );
  }
}

class GoldenBuilderTable extends GoldenBuilder {
  GoldenBuilderTable({
    required this.columns,
    this.rowSpacing = 16.0,
    super.wrap,
    super.bgColor,
  });

  /// number of columns [columns] in a grid
  final int columns;
  final double rowSpacing;

  int get _effectiveRows => (scenarios.length / columns).ceil();

  @override
  Widget _buildInternal() {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        for (int i = 0; i < _effectiveRows; i++)
          TableRow(
            children: [
              for (int j = 0; j < columns; j++)
                if (i * columns + j < scenarios.length) ...[
                  scenarios[i * columns + j],
                  if (j < columns - 1) SizedBox(width: rowSpacing),
                ] else
                  const SizedBox.shrink(),
            ],
          ),
      ],
    );
  }
}

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

class _TextScaleFactor extends StatelessWidget {
  const _TextScaleFactor({
    required this.textScaleFactor,
    required this.child,
  });

  final Widget child;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: textScaleFactor),
      child: child,
    );
  }
}
