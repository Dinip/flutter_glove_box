import 'package:flutter/material.dart';

class GoldenTextStyle {
  const GoldenTextStyle({this.fontSize = 18, this.color});

  final double fontSize;
  final Color? color;

  TextStyle get textStyle => TextStyle(fontSize: fontSize, color: color);
}
