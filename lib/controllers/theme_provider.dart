import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.pink,
);

final darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.deepPurpleAccent,
);


class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode = ThemeMode.light;
  late ColorScheme _darkScheme = darkColorScheme;
  late ColorScheme _lightScheme = lightColorScheme;

  ThemeMode get themeMode => _themeMode;
  ColorScheme get darkScheme => _darkScheme;
  ColorScheme get lightScheme => _lightScheme;

  void setThemeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
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