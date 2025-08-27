/// ***************************************************
/// Copyright 2019-2020 eBay Inc.
///
/// Use of this source code is governed by a BSD-style
/// license that can be found in the LICENSE file or at
/// https://opensource.org/licenses/BSD-3-Clause
/// ***************************************************

import 'package:flutter/widgets.dart';
import '../testing_tools.dart';

part 'scenarios/base_scenario.dart';
part 'scenarios/scale_factor_scenario.dart';
part 'golden_builder_column.dart';
part 'golden_builder_grid.dart';
part 'golden_builder_single.dart';
part 'golden_builder_table.dart';

/// as of iOS 13.2.3 the max textScaleFactor a user can set is ~3.1176
const double textScaleFactorMaxSupported = 3.2;

/// GoldenBuilder builds column/grid layout for it's children
abstract class GoldenBuilder {
  GoldenBuilder({this.wrap, this.bgColor = const Color(0xFFEEEEEE)});

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
    addScenario('$name ${textScaleFactor}x', _TextScaleFactorScenario(textScaleFactor: textScaleFactor, child: widget));
  }

  ///  [addScenario] will add a test GoldenBuilder
  void addScenario(String name, Widget widget) {
    scenarios.add(_BaseScenario(
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
        color: bgColor,
        child: _buildInternal(),
      ),
    );
  }
}
