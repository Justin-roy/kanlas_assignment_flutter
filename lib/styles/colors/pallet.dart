import 'package:flutter/material.dart';

extension Pallet on ColorScheme {
  static MaterialColor appColor = MaterialColor(
    primary.value,
    <int, Color>{
      50: primary.withOpacity(0.05),
      100: primary.withOpacity(0.1),
      200: primary.withOpacity(0.2),
      300: primary.withOpacity(0.3),
      400: primary.withOpacity(0.4),
      500: primary.withOpacity(0.5),
      600: primary.withOpacity(0.6),
      700: primary.withOpacity(0.7),
      800: primary.withOpacity(0.8),
      900: primary.withOpacity(0.9),
    },
  );
  static const Color primary = Color(0xff5468ff);
  static const Color orange = Color.fromARGB(255, 250, 84, 59);
  static const Color purple = Color(0XFF4E0288);
  static const Color red = Colors.red;
  static const Color green = Colors.green;

  Color get grey =>
      brightness == Brightness.dark ? const Color(0XFF545c5e) : Colors.white;

  Color get white =>
      brightness == Brightness.dark ? Colors.white : Colors.black;
  Color get cWhite =>
      brightness == Brightness.dark ? Colors.black : Colors.white;
  Color get black => Colors.black;
  Color get notificationBg => brightness == Brightness.dark
      ? Colors.grey.shade700
      : Colors.grey.shade200;
}
