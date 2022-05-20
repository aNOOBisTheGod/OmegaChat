import 'package:flutter/material.dart';
import '../themes/themeprovider.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  int _themeIndex = 0;
  ThemePreferences? _preferences;
  bool get isDark => _isDark;
  int get themeIndex => _themeIndex;

  ThemeModel() {
    _themeIndex = 0;
    _preferences = ThemePreferences();
    getPreferences();
  }
//Switching themes in the flutter apps - Flutterant
  set themeIndex(int value) {
    _themeIndex = value;
    _preferences!.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences!.getTheme();
    notifyListeners();
  }
}
