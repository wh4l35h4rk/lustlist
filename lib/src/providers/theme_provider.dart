import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    _loadThemePreference();
  }

  late final _themeKey = "theme";

  late ThemeMode _themeMode = ThemeMode.light;
  late ColorScheme _darkScheme = darkColorScheme;
  late ColorScheme _lightScheme = lightColorScheme;

  ThemeMode get currentThemeMode => _themeMode;
  ColorScheme get darkScheme => _darkScheme;
  ColorScheme get lightScheme => _lightScheme;

  void setThemeMode(ThemeMode value) {
    if (currentThemeMode != value) {
      _themeMode = value;
      saveThemeModeToPreferences(value);
      notifyListeners();
    }
  }
  
  void saveThemeModeToPreferences(ThemeMode value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, currentThemeMode.name);
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final String? themeModeString = prefs.getString(_themeKey);
    if (themeModeString != null) {
      final loadedThemeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == 'ThemeMode.$themeModeString',
        orElse: () => ThemeMode.system,
      );
      setThemeMode(loadedThemeMode);

      print(themeModeString);
    }
  }



  void setDarkScheme(ColorScheme value) {
    _darkScheme = value;
    notifyListeners();
  }

  void setLightScheme(ColorScheme value) {
    _lightScheme = value;
    notifyListeners();
  }
}