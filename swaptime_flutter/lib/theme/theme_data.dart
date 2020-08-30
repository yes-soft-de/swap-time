import 'package:flutter/material.dart';

class SwapThemeData {
  ThemeData _themeData;

  SwapThemeData();

  static Color getPrimary() {
    return Color(0xFF2699FB);
  }

  static Color getAccent() {
    return Color(0xFFD31640);
  }

  static bool isDarkMode() {
    return false;
  }
}
