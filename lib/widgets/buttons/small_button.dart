import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final Color? bgColor;
  final Color? textbgColor;
  final double radius;
  final double? fontSize;
  final bool isDisabled;
  const SmallButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.bgColor,
    this.textbgColor,
    this.radius = 30,
    this.isDisabled = false,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FilledButton.tonal(
      style: isDisabled
          ? null
          : ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(bgColor ?? colorScheme.primary),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: textbgColor ?? Colors.white,
          fontSize: fontSize ?? 18,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
