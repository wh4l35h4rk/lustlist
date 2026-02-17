import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';

class AppStyles{
  static TextStyle noDataText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.textBasic,
        fontStyle: FontStyle.italic,
        color: AppColors.defaultTile(context)
    );
  }

  static TextStyle numStatsTitle(BuildContext context){
    return TextStyle(
      color: AppColors.chart.title(context),
      fontSize: AppSizes.titleSmall,
      letterSpacing: AppSizes.chartTitleSpacing,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle chartTitle(BuildContext context){
    return TextStyle(
      color: AppColors.chart.title(context),
      fontSize: AppSizes.titleLarge,
      fontWeight: FontWeight.bold,
      letterSpacing: AppSizes.chartTitleSpacing,
    );
  }
}