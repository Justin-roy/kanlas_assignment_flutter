import 'package:flutter/material.dart';
import 'package:kanlas_assignment/styles/colors/pallet.dart';

class BoldHeaderText extends StatelessWidget {
  const BoldHeaderText({
    super.key,
    required this.label,
    this.fontSize = 32,
    this.textStyle,
    this.textAlign,
  });
  final String label;
  final double? fontSize;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      label,
      style: textStyle ??
          textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: colorScheme.white,
          ),
      textAlign: textAlign,
    );
  }
}
