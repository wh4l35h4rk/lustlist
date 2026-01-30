import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/misc.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/domain/repository.dart';


class LineChartYearly extends StatefulWidget {
  const LineChartYearly({super.key});

  @override
  State<StatefulWidget> createState() => LineChartYearlyState();
}

class LineChartYearlyState extends State<LineChartYearly> {
  // late Future<Map<String, List<FlSpot>>> spotLists;
  List<FlSpot>? sexSpots;
  List<FlSpot>? mstbSpots;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final repo = EventRepository(database);
    DateTime period = DateTime(1, 0, 0);
    sexSpots = await repo.getSpotsListByMonth("sex", period);
    mstbSpots = await repo.getSpotsListByMonth("masturbation", period);
    setState(() {});
    print(sexSpots);
  }

  @override
  Widget build(BuildContext context) {
    if (sexSpots == null) {
      return const CircularProgressIndicator();
    }

    return AspectRatio(
      aspectRatio: 1.1,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 37
                ),
                child: Text(
                  'Sex & masturbation in last year',
                  style: TextStyle(
                    color: AppColors.title(context),
                    fontSize: AppSizes.titleLarge,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(
                    sexSpots: sexSpots!,
                    mstbSpots: mstbSpots!,
                    sexLineColor: AppColors.chart.sexLine(context),
                    mstbLineColor: AppColors.chart.mstbLine(context),
                    surfaceColor: AppColors.bnb(context),
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


  @override
  Widget build(BuildContext context) {
    return LineChart(
      data,
      duration: const Duration(milliseconds: chartDuration),
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
          surfaceColor.withValues(alpha: 0.5),
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
    reservedSize: 40,
  );


  // bottom chart titles, X-axis
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.titleSmall,
    );
    DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    print(date);
    String text = DateFormatter.month(date.month);

    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: Text(text, style: style),
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 30,
    interval: monthInMs * 3,
    getTitlesWidget: bottomTitleWidgets,
  );


  // chart grid
  FlGridData get gridData => FlGridData(
    show: true,
    drawHorizontalLine: true,
    drawVerticalLine: true
  );

  // bottom border of chart
  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom: BorderSide(
          color: Colors.black.withValues(alpha: 0.2), width: 3),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );


  // lines data
  List<LineChartBarData> get lineBarsData => [
    mstbLineChartBarData,
    sexLineChartBarData,
  ];

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