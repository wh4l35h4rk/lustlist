import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/misc.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/strings/chart_strings.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/ui/pages/stats_page/widgets/checkmark_legend_row.dart';
import 'package:lustlist/src/ui/pages/stats_page/widgets/line_legend.dart';


class LineChartYearly extends StatefulWidget {
  const LineChartYearly({
    super.key,
    required this.spots,
  });

  final List<List<FlSpot>> spots;

  @override
  State<StatefulWidget> createState() => LineChartYearlyState();
}

class LineChartYearlyState extends State<LineChartYearly> {
  late List<FlSpot> sexSpots = widget.spots[0];
  late List<FlSpot> mstbSpots = widget.spots[1];

  bool _showSex = true;
  bool _showMstb = true;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color sexLineColor = AppColors.chart.sexLine(context);
    Color mstbLineColor = AppColors.chart.mstbLine(context);

    return AspectRatio(
      aspectRatio: 1.15,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: AppInsets.chartTitle,
                child: Column(
                  children: [
                    Text(
                      StringFormatter.colon(ChartStrings.lastYearChart),
                      style: AppStyles.chartTitle(context),
                      textAlign: TextAlign.center,
                    ),
                    CheckmarkLegendRow(
                      title: DataStrings.sex,
                      iconData: _showSex ?
                        Icons.check_box_outlined :
                        Icons.check_box_outline_blank_outlined,
                      onTap: () {
                        setState(() {
                          _showSex = !_showSex;
                          if (!_showMstb) {
                            _showMstb = true;
                          }
                        });
                      },
                      marker: LineLegend(color: sexLineColor, hasDots: true),
                    ),
                    CheckmarkLegendRow(
                      title: DataStrings.mstb,
                      iconData: _showMstb ?
                        Icons.check_box_outlined :
                        Icons.check_box_outline_blank_outlined,
                      onTap: () {
                        setState(() {
                          _showMstb = !_showMstb;
                          if (!_showSex) {
                            _showSex = true;
                          }
                        });
                      },
                      marker: LineLegend(color: mstbLineColor, hasDots: true),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: AppInsets.lineChart,
                  child: _LineChart(
                    showSex: _showSex,
                    showMstb: _showMstb,
                    sexSpots: sexSpots,
                    mstbSpots: mstbSpots,
                    sexLineColor: sexLineColor,
                    mstbLineColor: mstbLineColor,
                    surfaceColor: AppColors.chart.tooltipSurface(context),
                    borderColor: AppColors.primary(context),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class _LineChart extends StatelessWidget {
  const _LineChart({
    required this.showSex,
    required this.showMstb,
    required this.sexSpots,
    required this.mstbSpots,
    required this.sexLineColor,
    required this.mstbLineColor,
    required this.surfaceColor,
    required this.borderColor,
  });

  final List<FlSpot> sexSpots;
  final List<FlSpot> mstbSpots;
  final Color sexLineColor;
  final Color mstbLineColor;
  final Color surfaceColor;
  final Color borderColor;

  final bool showSex;
  final bool showMstb;


  @override
  Widget build(BuildContext context) {
    return LineChart(
      data,
      duration: const Duration(milliseconds: chartDuration),
      curve: Curves.linear,
    );
  }


  // general chart data
  LineChartData get data => LineChartData(
    lineTouchData: lineTouchData,
    gridData: gridData,
    titlesData: titlesData,
    borderData: borderData,
    lineBarsData: lineBarsData,
  );


  // on-touch properties
  LineTouchData get lineTouchData => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBorder: BorderSide(
          width: AppSizes.tooltipBorder,
          color: borderColor.withValues(alpha: 0.7)
      ),
      getTooltipColor: (touchedSpot) =>
          surfaceColor.withValues(alpha: 0.7),
      getTooltipItems: (List<LineBarSpot> spots) {
        return spots.asMap().entries.map((entry) {
          final index = entry.key;
          final flSpot = entry.value;

          DateTime date = DateTime.fromMillisecondsSinceEpoch(flSpot.x.toInt());
          String month = DateFormatter.month(date.month);

          return LineTooltipItem(
            index == 0 ? StringFormatter.endl(month) : MiscStrings.emptyString,
            TextStyle(
              color: borderColor,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: flSpot.y.toInt().toString(),
                style: TextStyle(
                  color: flSpot.bar.color,
                ),
              ),
            ],
            textAlign: TextAlign.center,
          );
        }).toList();
      },
    ),
  );


  // general axis titles data
  FlTitlesData get titlesData => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );


  // left chart titles, Y-axis
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
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

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: AppSizes.chartSideTitlesSpace,
  );


  // bottom chart titles, X-axis
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.titleSmall,
    );
    DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    String text = DateFormatter.month(date.month);

    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: Text(text, style: style),
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: AppSizes.chartBottomTitlesSpace,
    interval: monthInMs * 5,
    getTitlesWidget: bottomTitleWidgets,
  );


  // chart grid
  FlGridData get gridData => FlGridData(
    show: true,
    drawHorizontalLine: true,
    drawVerticalLine: true,
    verticalInterval: monthInMs * 2,
    horizontalInterval: 1,
  );

  // bottom border of chart
  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom: BorderSide(
          color: Colors.black.withValues(alpha: 0.2), width: AppSizes.chartBorder),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );


  // lines data
  List<LineChartBarData> get lineBarsData {
    if (showMstb && showSex) {
      return [
        mstbLineChartBarData,
        sexLineChartBarData,
      ];
    } else if (!showMstb) {
      return [
        sexLineChartBarData,
      ];
    } else if (!showSex) {
      return [
        mstbLineChartBarData,
      ];
    } else {
      return [];
    }
  }

  LineChartBarData get sexLineChartBarData => LineChartBarData(
    isCurved: true,
    preventCurveOverShooting: true,
    color: sexLineColor,
    barWidth: AppSizes.chartLineWidth,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: true),
    belowBarData: BarAreaData(show: false),
    spots: sexSpots,
  );

  LineChartBarData get mstbLineChartBarData => LineChartBarData(
    isCurved: true,
    preventCurveOverShooting: true,
    color: mstbLineColor,
    barWidth: AppSizes.chartLineWidth,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: true),
    belowBarData: BarAreaData(show: false),
    spots: mstbSpots,
  );
}