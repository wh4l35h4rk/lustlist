import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/ui/theme_provider.dart';
import 'package:provider/provider.dart';


class ChangeThemeButton extends StatefulWidget{
  const ChangeThemeButton({super.key});

  @override
  State<ChangeThemeButton> createState() => _ChangeThemeButtonState();
}

class _ChangeThemeButtonState extends State<ChangeThemeButton> {
  late final themeProvider = context.read<ThemeProvider>();
  late bool isLight = themeProvider.themeMode == ThemeMode.light;

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
        icon: Icon(isLight ? AppIconData.darkTheme : AppIconData.lightTheme),
        color: context.theme.mainColors.surface
    );
  }
}