import 'package:flutter/material.dart';
import 'package:kanlas_assignment/styles/colors/pallet.dart';

class DescriptionText extends StatelessWidget {
  final String label;
  final Color? color;
  const DescriptionText({
    super.key,
    required this.label,
    this.color,
    this.textAlign = TextAlign.center,
  });
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      label,
      maxLines: 4,
      overflow: TextOverflow.fade,
      softWrap: true,
      textAlign: textAlign,
      style: TextStyle(color: color ?? colorScheme.white),
    );
  }
}
