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

  static TextStyle basicText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.textBasic,
        color: AppColors.text(context)
    );
  }

  static TextStyle addEventBasicText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.textBasic,
        color: AppColors.addEvent.text(context)
    );
  }

  static TextStyle eventDataBasicText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.textBasic,
        color: AppColors.eventData.text(context)
    );
  }

  static ButtonStyle selectableValueButton<T>(BuildContext context, List<T> selectedValues, T value){
    return OutlinedButton.styleFrom(
      backgroundColor: selectedValues.contains(value)
          ? AppColors.filterSurface(context)
          : AppColors.surface(context),
      side: BorderSide(
          width: 1.2,
          color: AppColors.addEvent.border(context)
      ),
    );
  }

  static ButtonStyle filterButton(BuildContext context){
    return OutlinedButton.styleFrom(
      backgroundColor: AppColors.surface(context),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(
          width: 1.2,
          color: AppColors.addEvent.border(context)
      ),
    );
  }

  static ButtonStyle outlinedButton(Color? backgroundColor, BuildContext context){
    return OutlinedButton.styleFrom(
      backgroundColor: backgroundColor,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(
          width: 1.2,
          color: AppColors.addEvent.border(context)
      ),
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

  static TextStyle numStatsSubtitle(BuildContext context) {
    return basicText(context);
  }

  static TextStyle chartTitle(BuildContext context){
    return TextStyle(
      color: AppColors.chart.title(context),
      fontSize: AppSizes.titleLarge,
      fontWeight: FontWeight.bold,
      letterSpacing: AppSizes.chartTitleSpacing,
    );
  }

  static TextStyle chartSideTitles(BuildContext context) {
    return TextStyle(
      color: AppColors.chart.subtitle(context),
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.textBasic,
    );
  }


}