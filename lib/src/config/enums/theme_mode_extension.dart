import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';


extension ThemeModeExtension on ThemeMode {

  String get label {
    switch (this) {
      case ThemeMode.system:
        return "System";
      case ThemeMode.light:
        return "Light";
      case ThemeMode.dark:
        return "Dark";
    }
  }

  IconData get iconData {
    switch (this) {
      case ThemeMode.system:
        return AppIconData.systemTheme;
      case ThemeMode.light:
        return AppIconData.lightTheme;
      case ThemeMode.dark:
        return AppIconData.darkTheme;
    }
  }

  List<ThemeMode> get entries => [ThemeMode.light, ThemeMode.dark, ThemeMode.system];
}
