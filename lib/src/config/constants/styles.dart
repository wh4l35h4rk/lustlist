import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/sizes.dart';


class AppStyles{
  static TextStyle noDataText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.textBasic,
        fontStyle: FontStyle.italic,
        color: context.theme.mainColors.defaultWidget
    );
  }

  static TextStyle basicText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.textBasic,
        color: context.theme.mainColors.text
    );
  }

  static TextStyle addEventBasicText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.textBasic,
        color: context.theme.addEventColors.text
    );
  }

  static TextStyle eventDataBasicText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.textBasic,
        color: context.theme.eventDataColors.text
    );
  }

  static TextStyle largeTitleText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.titleLarge,
        fontWeight: FontWeight.bold
    );
  }

  static ButtonStyle selectableValueButton<T>(BuildContext context, List<T> selectedValues, T value){
    return OutlinedButton.styleFrom(
      backgroundColor: selectedValues.contains(value)
          ? context.theme.mainColors.filterSurface
          : context.theme.mainColors.surface,
      side: BorderSide(
          width: 1.2,
          color: context.theme.addEventColors.border
      ),
    );
  }

  static ButtonStyle filterButton(BuildContext context){
    return OutlinedButton.styleFrom(
      backgroundColor: context.theme.mainColors.surface,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(
          width: 1.2,
          color: context.theme.addEventColors.border
      ),
    );
  }

  static ButtonStyle outlinedButton(Color? backgroundColor, BuildContext context){
    return OutlinedButton.styleFrom(
      backgroundColor: backgroundColor,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(
          width: 1.2,
          color: context.theme.addEventColors.border
      ),
    );
  }


  static TextStyle numStatsTitle(BuildContext context){
    return TextStyle(
      color: context.theme.chartColors.title,
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
      color: context.theme.chartColors.title,
      fontSize: AppSizes.titleLarge,
      fontWeight: FontWeight.bold,
      letterSpacing: AppSizes.chartTitleSpacing,
    );
  }

  static TextStyle chartSideTitles(BuildContext context) {
    return TextStyle(
      color: context.theme.chartColors.subtitle,
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.textBasic,
    );
  }


}