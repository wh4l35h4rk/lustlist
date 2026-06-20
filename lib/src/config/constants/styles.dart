import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';

class AppStyles{
  static TextStyle noDataText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.textBasic,
        fontStyle: FontStyle.italic,
        color: MainColors.defaultTile(context)
    );
  }

  static TextStyle basicText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.textBasic,
        color: MainColors.text(context)
    );
  }

  static TextStyle addEventBasicText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.textBasic,
        color: AddEventColors.text(context)
    );
  }

  static TextStyle eventDataBasicText(BuildContext context) {
    return TextStyle(
        fontSize: AppSizes.textBasic,
        color: EventDataColors.text(context)
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
          ? MainColors.filterSurface(context)
          : MainColors.surface(context),
      side: BorderSide(
          width: 1.2,
          color: AddEventColors.border(context)
      ),
    );
  }

  static ButtonStyle filterButton(BuildContext context){
    return OutlinedButton.styleFrom(
      backgroundColor: MainColors.surface(context),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(
          width: 1.2,
          color: AddEventColors.border(context)
      ),
    );
  }

  static ButtonStyle outlinedButton(Color? backgroundColor, BuildContext context){
    return OutlinedButton.styleFrom(
      backgroundColor: backgroundColor,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(
          width: 1.2,
          color: AddEventColors.border(context)
      ),
    );
  }


  static TextStyle numStatsTitle(BuildContext context){
    return TextStyle(
      color: ChartColors.title(context),
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
      color: ChartColors.title(context),
      fontSize: AppSizes.titleLarge,
      fontWeight: FontWeight.bold,
      letterSpacing: AppSizes.chartTitleSpacing,
    );
  }

  static TextStyle chartSideTitles(BuildContext context) {
    return TextStyle(
      color: ChartColors.subtitle(context),
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.textBasic,
    );
  }


}