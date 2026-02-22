import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/misc.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/domain/entities/events_amount_data.dart';


class FixedAxisBarChart extends StatelessWidget {
  final List<EventsAmountData> eventAmountList;
  final Function getBottomTitles;
  final Widget Function(double, TitleMeta, BuildContext) getLeftTitles;
  final Gradient? sexBarsGradient;
  final Gradient? mstbBarsGradient;
  final FlGridData gridData;
  final FlBorderData borderData;
  final BarTouchData barTouchData;
  final bool isWeekly;

  const FixedAxisBarChart({
    super.key,
    required this.eventAmountList,
    required this.getBottomTitles,
    required this.getLeftTitles,
    required this.gridData, 
    required this.borderData, 
    required this.barTouchData,
    required this.sexBarsGradient, 
    required this.mstbBarsGradient,
    required this.isWeekly,
  });

  @override
  Widget build(BuildContext context) {
    List<double> listValues = [];
    for (var d in eventAmountList){
      listValues.add(d.sexValue);
      listValues.add(d.mstbValue);
    }
    listValues.sort();
    var maxValue = listValues.last;

    return AspectRatio(
      aspectRatio: 1.45,
      child: BarChart(
        BarChartData(
          barGroups: barGroups(context),
          barTouchData: barTouchData,
          titlesData: titlesData(context),
          borderData: borderData,
          gridData: gridData,
          alignment: BarChartAlignment.spaceEvenly,
          rotationQuarterTurns: 0,
          maxY: maxValue + 0.1
        ),
        duration: Duration(milliseconds: chartDuration),
        curve: Curves.linear,
      )
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

  List<BarChartGroupData> barGroups(BuildContext context){
    return List<BarChartGroupData>.generate(
        eventAmountList.length,
            (i) => BarChartGroupData(
          x: isWeekly? i : eventAmountList[i].dateInMs.toInt(),
          barsSpace: 4,
          barRods: [
            BarChartRodData(
                toY: eventAmountList[i].sexValue.toDouble(),
                width: AppSizes.narrowBarWidth,
                gradient: sexBarsGradient,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))
            ),
            BarChartRodData(
                toY: eventAmountList[i].mstbValue.toDouble(),
                width: AppSizes.narrowBarWidth,
                gradient: mstbBarsGradient,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))
            )
          ],
          showingTooltipIndicators: [],
        )
    );
  }
}