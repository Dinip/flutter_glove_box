part of '../golden_builder.dart';

class _TextScaleFactorScenario extends StatelessWidget {
  const _TextScaleFactorScenario({
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
