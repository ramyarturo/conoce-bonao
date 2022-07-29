import 'package:flutter/material.dart';

const double defaultPadding = 9.5;
const double topPadding = defaultPadding * 6;
const double defaultVerticalSpacing = defaultPadding * 1.6;

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing([this.spacing = defaultVerticalSpacing]) : super(key: null);
  final double spacing;
  @override
  Widget build(BuildContext context) => SizedBox(height: spacing);
}

class ThemeConstants {
  static const toolbarHeight = 60.0;
}
