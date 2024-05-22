import 'package:flutter/material.dart';
import '../colors/pallet.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Pallet.primary,
  primarySwatch: Pallet.appColor,
  brightness: Brightness.dark,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
    ),
  ),
  fontFamily: 'Manrope',
  appBarTheme: _darkAppBarTheme,
);
AppBarTheme _darkAppBarTheme = ThemeData.dark()
    .appBarTheme
    .copyWith(elevation: 0, foregroundColor: Colors.white);
