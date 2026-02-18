import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/misc.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/strings/chart_strings.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/domain/entities/option_rank.dart';

class TopOptionsChart extends StatelessWidget {
  final List<OptionRank> optionsList;
  final String title;
  final Color? barAccentColor;

  const TopOptionsChart({
    super.key,
    required this.optionsList,
    required this.title,
    this.barAccentColor
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
          SizedBox(height: 5),
          optionsList.isEmpty
          ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              ChartStrings.noOptions,
              style: AppStyles.noDataText(context),
            ),
          )
          : AspectRatio(
            aspectRatio: calculateRatio(),
            child: _BarChart(
              optionsList: optionsList,
              barAccentColor: barAccentColor,
            ),
          ),
        ],
      ),
    );
  }

  double calculateRatio(){
    int length = optionsList.length;
    return pow(0.55, length - 3.45) + 1.3;
  }
}


class _BarChart extends StatelessWidget {
  final List<OptionRank> optionsList;
  final Color? barAccentColor;

  const _BarChart({
    required this.optionsList,
    this.barAccentColor
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: barGroups(context),
        barTouchData: barTouchData(context),
        titlesData: titlesData(context),
        borderData: borderData(context),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceEvenly,
        rotationQuarterTurns: 1
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
  
  Widget getTitles(double value, TitleMeta meta, BuildContext context) {
    final style = TextStyle(
      color: AppColors.chart.subtitle(context),
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.textBasic,
    );
    String text = optionsList[value.round()].displayedName;
    return SideTitleWidget(
      meta: meta,
      space: 12,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.right,
        softWrap: true,
      ),
    );
  }

  FlTitlesData titlesData(BuildContext context) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 110,
          getTitlesWidget: (value, meta) => getTitles(value, meta, context),
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
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
        border: Border(bottom: BorderSide(
          color: AppColors.divider(context),
        ))
    );
  }

  // chart bars
  LinearGradient _barsGradient(BuildContext context) {
    return LinearGradient(
    colors: [
      AppColors.chart.barStart(barAccentColor ?? AppColors.primary(context), context),
      AppColors.chart.barEnd(barAccentColor ?? AppColors.primary(context), context),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  }

  List<BarChartGroupData> barGroups(BuildContext context){
    return List<BarChartGroupData>.generate(
    optionsList.length,
      (i) => BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: optionsList[i].value.toDouble(),
            width: AppSizes.barWidth,
            gradient: _barsGradient(context),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12))
          )
        ],
        showingTooltipIndicators: [0],
      )
  );
  }
}