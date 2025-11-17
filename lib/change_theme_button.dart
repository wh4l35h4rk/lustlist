import 'package:flutter/material.dart';
import 'package:lustlist/theme_provider.dart';
import 'package:provider/provider.dart';
import 'colors.dart';

class ChangeThemeButton extends StatefulWidget{
  const ChangeThemeButton({super.key});

  @override
  State<ChangeThemeButton> createState() => _ChangeThemeButtonState();
}

class _ChangeThemeButtonState extends State<ChangeThemeButton> {
  bool isLight = true;
  late final themeProvider = context.read<ThemeProvider>();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (isLight) {
            themeProvider.setThemeMode(ThemeMode.dark);
            setState(() {
              isLight = false;
            });
          } else {
            themeProvider.setThemeMode(ThemeMode.light);
            setState(() {
              isLight = true;
            });
          }
        },
        icon: Icon(isLight ? Icons.dark_mode : Icons.light_mode),
        color: AppColors.surface(context)
    );
  }
}