import 'package:flutter/material.dart';
import '../colors/pallet.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Pallet.primary,
  brightness: Brightness.light,
  primarySwatch: Pallet.appColor,
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
  appBarTheme: _lightAppBarTheme,
);

AppBarTheme _lightAppBarTheme = ThemeData.light()
    .appBarTheme
    .copyWith(elevation: 0, foregroundColor: Colors.black);
