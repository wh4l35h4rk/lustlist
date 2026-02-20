import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/misc.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/strings/chart_strings.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/domain/entities/events_bar_rod.dart';
import 'package:lustlist/src/ui/widgets/legend_row.dart';


class LastWeekBarChart extends StatelessWidget {
  final List<EventsAmountRodData> sexAmountList;
  final List<EventsAmountRodData> mstbAmountList;

  const LastWeekBarChart({
    super.key,
    required this.sexAmountList,
    required this.mstbAmountList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.barChart,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            StringFormatter.colon(ChartStrings.lastWeekChart),
            style: AppStyles.chartTitle(context),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 20,
            children: [
              LegendRow(
                color: AppColors.chart.vividBarEnd(AppColors.chart.sexBarAccent(context), context),
                text: DataStrings.sex,
                notExpanded: true,
              ),
              LegendRow(
                color: AppColors.chart.vividBarEnd(AppColors.chart.mstbBarAccent(), context),
                text: DataStrings.mstb,
                notExpanded: true,
              )
            ],
          ),
          AspectRatio(
            aspectRatio: 1.45,
            child: _BarChart(
              sexAmountList: sexAmountList,
              mstbAmountList: mstbAmountList,
            ),
          ),
        ],
      ),
    );
  }
}


class _BarChart extends StatelessWidget {
  final List<EventsAmountRodData> sexAmountList;
  final List<EventsAmountRodData> mstbAmountList;

  const _BarChart({
    required this.sexAmountList,
    required this.mstbAmountList,
  });

  @override
  Widget build(BuildContext context) {
    List<double> listValues = [];
    for (var d in sexAmountList){
      listValues.add(d.value);
    }
    for (var d in mstbAmountList){
      listValues.add(d.value);
    }
    listValues.sort();
    var maxValue = listValues.last;

    return BarChart(
      BarChartData(
        barGroups: barGroups(context),
        barTouchData: barTouchData(context),
        titlesData: titlesData(context),
        borderData: borderData(context),
        gridData: gridData,
        alignment: BarChartAlignment.spaceEvenly,
        rotationQuarterTurns: 0,
        maxY: maxValue + 0.1
      ),
      duration: Duration(milliseconds: chartDuration),
      curve: Curves.linear,
    );
  }

  BarTouchData barTouchData(BuildContext context){
    return BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (group) => Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 6,
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

  Widget getBottomTitles(double value, TitleMeta meta, BuildContext context) {
    final style = TextStyle(
      color: AppColors.chart.subtitle(context),
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.textBasic,
    );

    final DateTime date = DateTime.now().subtract(Duration(days: 6 - value.toInt()));

    final String text = DateFormatter.weekday(date);

    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.right,
        softWrap: true,
      ),
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta, BuildContext context) {
    if (value % 1 != 0) {
      return const SizedBox.shrink();
    }

    final style = TextStyle(
      color: AppColors.chart.subtitle(context),
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.textBasic,
    );

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

  FlTitlesData titlesData(BuildContext context) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (value, meta) => getBottomTitles(value, meta, context),
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: (value, meta) => getLeftTitles(value, meta, context),
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }


  // chart border
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
    horizontalInterval: 1,
  );

  // chart bars
  LinearGradient _sexBarsGradient(BuildContext context) {
    Color baseColor = AppColors.chart.vividBarStart(AppColors.chart.mstbBarStart(), context);
    Color mainColor = AppColors.chart.vividBarEnd(AppColors.chart.sexBarAccent(context), context);

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
    Color baseColor = AppColors.chart.vividBarStart(AppColors.chart.mstbBarStart(), context);
    Color mainColor = AppColors.chart.vividBarEnd(AppColors.chart.mstbBarAccent(), context);

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

  List<BarChartGroupData> barGroups(BuildContext context){
    return List<BarChartGroupData>.generate(
        7, (i) => BarChartGroupData(
          x: i,
          barsSpace: 4,
          barRods: [
            BarChartRodData(
                toY: sexAmountList[i].value.toDouble(),
                width: AppSizes.narrowBarWidth,
                gradient: _sexBarsGradient(context),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))
            ),
            BarChartRodData(
                toY: mstbAmountList[i].value.toDouble(),
                width: AppSizes.narrowBarWidth,
                gradient: _mstbBarsGradient(context),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))
            )
          ],
          showingTooltipIndicators: [],
        )
    );
  }
}