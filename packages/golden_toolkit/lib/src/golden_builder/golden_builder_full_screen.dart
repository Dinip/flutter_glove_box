part of 'golden_builder.dart';

class GoldenBuilderFullScreen extends GoldenBuilder {
  /// Will output a .png file with a single widget in 'tests/goldens' folder.
  ///
  /// Takes only a single scenario, similar to [GoldenBuilderSingle], but the widget will be rendered in full screen
  /// instead of being wrapped in the [_BaseScenario], with paddings and a title.
  /// This is useful for testing widgets that are meant to take up the entire screen or full pages.
  ///
  /// [wrap] (optional) will wrap the scenario's widget in the tree.
  ///
  /// [bgColor] will change the background color of output .png file
  ///
  GoldenBuilderFullScreen({super.bgColor, super.wrap, super.titleTextStyle});

  static _exception() => Exception('GoldenBuilderFullScreen only supports one scenario. Cannot add more than one.');

  @override
  void addScenario(String name, Widget widget) {
    if (scenarios.length > 1) throw _exception();
    scenarios.add(widget);
  }

  @override
  void addScenarioBuilder(String name, Widget Function(BuildContext context) fn) {
    if (scenarios.length > 1) throw _exception();
    scenarios.add(Builder(builder: fn));
  }

  @override
  void addTextScaleScenario(String name, Widget widget, {double textScaleFactor = textScaleFactorMaxSupported}) {
    if (scenarios.length > 1) throw _exception();
    scenarios.add(_TextScaleFactorScenario(textScaleFactor: textScaleFactor, child: widget));
  }

  @override
  Widget _buildInternal() => scenarios.first;

  @override
  Widget build() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        color: bgColor ?? const Color(0xFFEEEEEE),
        child: _buildInternal(),
      ),
    );
  }
}
