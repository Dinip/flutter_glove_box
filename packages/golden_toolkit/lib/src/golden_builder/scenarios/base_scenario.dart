part of '../golden_builder.dart';

class _BaseScenario extends StatelessWidget {
  const _BaseScenario({
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
