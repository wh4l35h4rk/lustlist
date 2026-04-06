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
          backgroundColor: AppColors.appBar.surface(context),
          centerTitle: true,
          foregroundColor: AppColors.appBar.text(context),
        ),
      ),
      child: LicensePage()
    );
  }
}