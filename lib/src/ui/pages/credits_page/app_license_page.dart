import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';

class AppLicensePage extends StatelessWidget {
  const AppLicensePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: AppBarColors.surface(context),
          centerTitle: true,
          foregroundColor: AppBarColors.text(context),
        ),
      ),
      child: LicensePage()
    );
  }
}