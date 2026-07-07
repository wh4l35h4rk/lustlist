import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';

class AppLicensePage extends StatelessWidget {
  const AppLicensePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: context.theme.appBarColors.surface,
          centerTitle: true,
          foregroundColor: context.theme.appBarColors.text,
        ),
      ),
      child: LicensePage()
    );
  }
}