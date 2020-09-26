import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/module_theme/pressistance/theme_preferences_helper.dart';

@provide
class SwapThemeDataService {
  static final PublishSubject<bool> _darkModeSubject = PublishSubject<bool>();
  Stream<bool> get darkModeStream => _darkModeSubject.stream;

  final ThemePreferencesHelper _preferencesHelper;
  SwapThemeDataService(this._preferencesHelper);

  static Color getPrimary() {
    return Color(0xFF2699FB);
  }

  static Color getAccent() {
    return Color(0xFFD31640);
  }

  Future<bool> isDarkMode() async {
    return _preferencesHelper.isDarkMode();
  }

  Future<void> switchDarkMode(bool darkMode) async {
    print('Setting Dark Mode: ' + darkMode.toString());
    if (darkMode) {
      await _preferencesHelper.setDarkMode();
    } else {
      await _preferencesHelper.setDayMode();
    }
    _darkModeSubject.add(darkMode);
  }
}
