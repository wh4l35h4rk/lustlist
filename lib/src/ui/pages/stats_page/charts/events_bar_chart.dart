import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/domain/entities/events_amount_data.dart';
import 'package:lustlist/src/ui/pages/stats_page/charts/fixed_axis_bar_chart.dart';
import 'package:lustlist/src/ui/pages/stats_page/charts/scrollable_axis_bar_chart.dart';
import 'package:lustlist/src/ui/widgets/legend_row.dart';


class EventsBarChart extends StatelessWidget {
  final List<EventsAmountData> eventAmountList;
  final Function getBottomTitles;
  final double? gridHorizontalInterval;
  final bool isWeekly;
  final String title;

  const EventsBarChart({
    super.key,
    required this.eventAmountList,
    required this.getBottomTitles,
    required this.isWeekly,
    required this.title,
    this.gridHorizontalInterval,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.barChart,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            StringFormatter.colon(title),
            style: AppStyles.chartTitle(context),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 20,
            children: [
              LegendRow(
                color: AppColors.chart.sexLine(context),
                text: DataStrings.sex,
                notExpanded: true,
              ),
              LegendRow(
                color: AppColors.chart.mstbLine(context),
                text: DataStrings.mstb,
                notExpanded: true,
              )
            ],
          ),
          getBarChartType(context)
        ],
      ),
    );
  }

  Widget getBarChartType(BuildContext context){
    return isWeekly
    ? FixedAxisBarChart(
      eventAmountList: eventAmountList,
      getBottomTitles: getBottomTitles,
      getLeftTitles: (value, meta, context) => getLeftTitles(value, meta, context),
      gridData: gridData,
      borderData: borderData(context),
      barTouchData: barTouchData(context),
      mstbBarsGradient: _mstbBarsGradient(context),
      sexBarsGradient: _sexBarsGradient(context),
      isWeekly: isWeekly,
    ) : ScrollableAxisBarChart(
      eventAmountList: eventAmountList,
      getBottomTitles: getBottomTitles,
      getLeftTitles: (value, meta, context) => getLeftTitles(value, meta, context),
      gridData: gridData,
      borderData: borderData(context),
      barTouchData: barTouchData(context),
      mstbBarsGradient: _mstbBarsGradient(context),
      sexBarsGradient: _sexBarsGradient(context),
      isWeekly: isWeekly,
    );
  }


  FlBorderData borderData(BuildContext context) {
    return FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider(context),
          ),
          left: BorderSide(
            color: AppColors.divider(context),
          ),
        )
    );
  }

  FlGridData get gridData => FlGridData(
    show: true,
    drawHorizontalLine: true,
    drawVerticalLine: false,
    horizontalInterval: gridHorizontalInterval,
  );

  BarTouchData barTouchData(BuildContext context){
    return BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (group) => Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 2,
        getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
            ) {
          return BarTooltipItem(
            rod.toY.round().toString(),
            TextStyle(
              color: AppColors.chart.text(context),
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }


  Widget getLeftTitles(double value, TitleMeta meta, BuildContext context) {
    final style = AppStyles.chartSideTitles(context);

    if (value % 1 != 0) {
      return const SizedBox.shrink();
    }
    String text = value.toInt().toString();

    return SideTitleWidget(
      meta: meta,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }


  LinearGradient _sexBarsGradient(BuildContext context) {
    Color baseColor = AppColors.chart.softBarStart(AppColors.chart.sexLine(context), context);
    Color mainColor = AppColors.chart.sexLine(context);

    return LinearGradient(
      colors: [
        baseColor,
        mainColor,
        mainColor,
        mainColor
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }

  LinearGradient _mstbBarsGradient(BuildContext context) {
    Color baseColor = AppColors.chart.softBarStart(AppColors.chart.mstbLine(context), context);
    Color mainColor = AppColors.chart.mstbLine(context);

    return LinearGradient(
      colors: [
        baseColor,
        mainColor,
        mainColor,
        mainColor
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }
}