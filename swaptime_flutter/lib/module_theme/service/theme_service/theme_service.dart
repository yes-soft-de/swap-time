import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SwapThemeDataService {
  static final PublishSubject<bool> _darkModeSubject = PublishSubject<bool>();
  Stream<bool> get darkModeStream => _darkModeSubject.stream;

  static bool darkModeEnabled = false;
  SwapThemeDataService();

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
