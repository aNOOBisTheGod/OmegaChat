import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const PREF_KEY = "int_themes";

  setTheme(int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(PREF_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(PREF_KEY) ?? 0;
  }
}
