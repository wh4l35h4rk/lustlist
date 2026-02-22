import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/misc.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/domain/entities/events_amount_data.dart';


class ScrollableAxisBarChart extends StatefulWidget {
  final List<EventsAmountData> eventAmountList;
  final Function getBottomTitles;
  final Widget Function(double, TitleMeta, BuildContext) getLeftTitles;
  final Gradient? sexBarsGradient;
  final Gradient? mstbBarsGradient;
  final FlGridData gridData;
  final FlBorderData borderData;
  final BarTouchData barTouchData;
  final bool isWeekly;

  const ScrollableAxisBarChart({
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
  State<ScrollableAxisBarChart> createState() => _ScrollableAxisBarChartState();
}

class _ScrollableAxisBarChartState extends State<ScrollableAxisBarChart> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double reservedSpace = widget.eventAmountList.length * 60;

    List<double> listValues = [];
    for (var d in widget.eventAmountList){
      listValues.add(d.sexValue);
      listValues.add(d.mstbValue);
    }
    listValues.sort();
    var maxValue = listValues.last;

    return Row(
      children: [
        SizedBox(
          width: 30,
          height: 255,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: BarChart(
              BarChartData(
                barGroups: null,
                barTouchData: null,
                titlesData: fixedTitlesData(context),
                borderData: widget.borderData,
                gridData: widget.gridData,
                alignment: BarChartAlignment.spaceEvenly,
                rotationQuarterTurns: 0,
                maxY: maxValue + 0.1
              ),
              duration: Duration(milliseconds: chartDuration),
              curve: Curves.linear,
            ),
          )
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final viewportWidth = constraints.maxWidth;
              final chartWidth = max(viewportWidth, reservedSpace);

              return SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: chartWidth,
                  height: 255,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: BarChart(
                      BarChartData(
                        barGroups: barGroups(context),
                        barTouchData: widget.barTouchData,
                        titlesData: scrollableTitlesData(context),
                        borderData: widget.borderData,
                        gridData: widget.gridData,
                        alignment: BarChartAlignment.spaceEvenly,
                        rotationQuarterTurns: 0,
                        maxY: maxValue + 0.1,
                      ),
                      duration: Duration(milliseconds: chartDuration),
                      curve: Curves.linear,
                    ),
                  )
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  FlTitlesData fixedTitlesData(BuildContext context) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 29,
            getTitlesWidget: (value, meta) => SizedBox.shrink()
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: (value, meta) => widget.getLeftTitles(value, meta, context),
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

  FlTitlesData scrollableTitlesData(BuildContext context) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (value, meta) => widget.getBottomTitles(value, meta, context),
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            getTitlesWidget: (value, meta) => SizedBox.shrink()
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
        widget.eventAmountList.length,
            (i) => BarChartGroupData(
          x: widget.isWeekly? i : widget.eventAmountList[i].dateInMs.toInt(),
          barsSpace: 6,
          barRods: [
            BarChartRodData(
                toY: widget.eventAmountList[i].sexValue.toDouble(),
                width: AppSizes.mediumBarWidth,
                gradient: widget.sexBarsGradient,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))
            ),
            BarChartRodData(
                toY: widget.eventAmountList[i].mstbValue.toDouble(),
                width: AppSizes.mediumBarWidth,
                gradient: widget.mstbBarsGradient,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))
            )
          ],
          showingTooltipIndicators: [0, 1],
        )
    );
  }
}