part of 'golden_builder.dart';

class GoldenBuilderSingle extends GoldenBuilder {
  /// Will output a .png file with a single widget in 'tests/goldens' folder.
  ///
  /// [wrap] (optional) will wrap the scenario's widget in the tree.
  ///
  /// [bgColor] will change the background color of output .png file
  ///
  GoldenBuilderSingle({super.bgColor, super.wrap});

  static _exception() => Exception('GoldenBuilderSingle only supports one scenario. Cannot add more than one.');

  @override
  void addScenario(String name, Widget widget) {
    if (scenarios.length > 1) throw _exception();
    super.addScenario(name, widget);
  }

  @override
  void addScenarioBuilder(String name, Widget Function(BuildContext context) fn) {
    if (scenarios.length > 1) throw _exception();
    super.addScenarioBuilder(name, fn);
  }

  @override
  void addTextScaleScenario(String name, Widget widget, {double textScaleFactor = textScaleFactorMaxSupported}) {
    if (scenarios.length > 1) throw _exception();
    super.addTextScaleScenario(name, widget, textScaleFactor: textScaleFactor);
  }

  @override
  Widget _buildInternal() => scenarios.first;
}
