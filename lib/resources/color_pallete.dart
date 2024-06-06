import 'package:flutter/material.dart';

const MaterialColor primaryMColor = ColorPalette.primarySwatch;

class ColorPalette {
  static const int _primaryColorValue = 0xFFEE3A43;
  static const Color primaryColor = red;
  static const MaterialColor primarySwatch = MaterialColor(_primaryColorValue, {
    50: red50,
    100: red100,
    200: red200,
    300: red300,
    400: red400,
    500: red,
    600: red600,
    700: red700,
    800: red800,
    900: red900,
  });

  static const Color red50 = Color(0xFFFCD8D9);
  static const Color red100 = Color(0xFFF9BDC0);
  static const Color red200 = Color(0xFFF69CA1);
  static const Color red300 = Color(0xFFF47C82);
  static const Color red400 = Color(0xFFF15B62);
  static const Color red = Color(_primaryColorValue);
  static const Color red600 = Color(0xFFC63038);
  static const Color red700 = Color(0xFF9F272D);
  static const Color red800 = Color(0xFF771D22);
  static const Color red900 = Color(0xFF4F1316);
}
