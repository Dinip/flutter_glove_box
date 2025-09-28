part of '../golden_builder.dart';

class _BaseScenario extends StatelessWidget {
  const _BaseScenario({
    required this.name,
    required this.widget,
    required this.titleTextStyle,
    this.wrap,
  });

  final WidgetWrapper? wrap;
  final String name;
  final Widget widget;
  final TextStyle titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Text(name, style: titleTextStyle),
          wrap?.call(widget) ?? widget,
        ],
      ),
    );
  }
}
