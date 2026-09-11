import 'package:lustlist/src/config/constants/sizes.dart';

class AppScales {
  final double factor;

  AppScales({
    this.factor = 1
  });

  double get alertBody => AppSizes.alertBody * factor;
  double get alertButtonText => AppSizes.alertButtonText * factor;
  double get alertButtonRadius => AppSizes.alertButtonRadius * factor;

  double get appbarLarge => AppSizes.appbarLarge * factor;
  double get appbarAnimated => AppSizes.appbarAnimated * factor;
  double get appbarBasic => AppSizes.appbarBasic * factor;

  double get titleLarge => AppSizes.titleLarge * factor;
  double get titleSmall => AppSizes.titleSmall * factor;
  double get textBasic => AppSizes.textBasic * factor;
  double get textSmall => AppSizes.textSmall * factor;
  double get textCalendar => AppSizes.textCalendar * factor;

  double get eventCounter => AppSizes.eventCounter * factor;

  double get iconHelper => AppSizes.iconHelper * factor;
  double get iconBasic => AppSizes.iconBasic * factor;
  double get iconAdd => AppSizes.iconAdd * factor;
  double get iconMedium => AppSizes.iconMedium * factor;
  double get iconSmall => AppSizes.iconSmall * factor;
  double get iconCalendarEvent => AppSizes.iconCalendarEvent * factor;

  double get iconViruses => AppSizes.iconViruses * factor;
  double get iconPractices => AppSizes.iconPractices * factor;
  double get iconPoses => AppSizes.iconPoses * factor;
  double get iconObgyn => AppSizes.iconObgyn * factor;

  double get iconNoninaryBasic => AppSizes.iconNonbinaryBasic * factor;
  double get iconNoninaryMedium => AppSizes.iconNonbinaryMedium * factor;

  double get iconMinMax => AppSizes.iconMinMax * factor;
  double get statsIconPadding => AppSizes.statsIconPadding * factor;

  double get roundChartSize => AppSizes.roundChartSize * factor;
  double get badgeOffset => AppSizes.badgeOffset * factor;
  double get badgeBorderWidth => AppSizes.badgeBorderWidth * factor;

  double get chartTitleSpacing => AppSizes.chartTitleSpacing * factor;
  double get chartLineWidth => AppSizes.chartLineWidth * factor;
  double get chartSideTitlesSpace => AppSizes.chartSideTitlesSpace * factor;
  double get tooltipBorder => AppSizes.tooltipBorder * factor;
  double get chartBorder => AppSizes.chartBorder * factor;

  double get dividerMinimal => AppSizes.dividerMinimal * factor;
  double get calendarWeekdaysHeight => AppSizes.calendarWeekdaysHeight * factor;

  double get listTileBorderRadius => AppSizes.listTileBorderRadius * factor;
  double get containerTileRadius => AppSizes.containerTileRadius * factor;

  double get numStatsLarge => AppSizes.numStatsLarge * factor;
  double get numStatsMedium => AppSizes.numStatsMedium * factor;

  double get defaultBarWidth => AppSizes.defaultBarWidth * factor;
  double get mediumBarWidth => AppSizes.mediumBarWidth * factor;
  double get narrowBarWidth => AppSizes.narrowBarWidth * factor;

  double get avatarRadiusSmall => AppSizes.avatarRadiusSmall * factor;
  double get avatarSize => AppSizes.avatarSize * factor;

  double get bnbLabelSelected => AppSizes.bnbLabelSelected * factor;
  double get bnbLabel => AppSizes.bnbLabel * factor;
}