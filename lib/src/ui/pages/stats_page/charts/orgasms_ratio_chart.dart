import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/chart_strings.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
import 'package:lustlist/src/providers/theme_provider.dart';
import 'package:lustlist/src/ui/widgets/legend_row.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';


class OrgasmsRatioChart extends StatefulWidget {
  final int userAmount;
  final int partnersAmount;

  const OrgasmsRatioChart({
    super.key, required this.userAmount, required this.partnersAmount,
  });

  @override
  State<OrgasmsRatioChart> createState() => _OrgasmsRatioChartState();
}

class _OrgasmsRatioChartState extends State<OrgasmsRatioChart> {
  late final themeProvider = context.read<ThemeProvider>();
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<ThemeProvider>().currentThemeMode == ThemeMode.light;
    bool haveData = widget.userAmount != 0 && widget.partnersAmount != 0;

    return Padding(
      padding: AppInsets.pieChartWithTitle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 13,
        children: [
          Text(
            StringFormatter.colon(ChartStrings.orgasmRatio),
            style: AppStyles.chartTitle(context),
            textAlign: TextAlign.center,
          ),
          haveData
          ? Row(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: AppSizes.roundChartSize,
                width: AppSizes.roundChartSize,
                child: Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    if (touchedIndex != -1)
                      Text(
                        sectionPercentage(isLight),
                        style: TextStyle(
                          fontSize: context.sizes.titleSmall
                        ),
                      ),
                    PieChart(
                      PieChartData(
                        sections: showingSections(isLight),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 0,
                        startDegreeOffset: 0,
                        pieTouchData: PieTouchData(
                          touchCallback: (event, response) {
                            if (event is! FlTapUpEvent) return;

                            setState(() {
                              final touchedSection = response?.touchedSection?.touchedSectionIndex;

                              if (touchedSection == null || touchedIndex == touchedSection) {
                                touchedIndex = -1;
                              } else {
                                touchedIndex = touchedSection;
                              }
                            });
                          },
                        ),
                      ),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.linear,
                    ),
                  ],
                ),
              ),
              Expanded(child: chartLegend()),
            ],
          )
          : Text(
            ChartStrings.noOrgasms,
            style: AppStyles.noDataText(context),
          ),
        ],
      ),
    );
  }


  List<PieChartSectionData> showingSections(bool isThemeLight) {
    final chart = context.theme.chartColors;
    final user = chart.user;
    final partners = chart.partners;


    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? context.sizes.titleLarge : context.sizes.textBasic;
      final radius = isTouched ? 65.0 : 55.0;
      final fontColor = isThemeLight ? context.theme.mainColors.surface : context.theme.mainColors.text;
      final shadows = [Shadow(color: Colors.black, blurRadius: 3)];

      return switch (i) {
        0 => PieChartSectionData(
            color: chart.female,
            value: widget.userAmount.toDouble(),
            title: widget.userAmount.toString(),
            radius: radius,
            gradient: LinearGradient(colors: [
              user,
              chart.colorAccent(user)
            ]),
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: fontColor,
              shadows: shadows,
            ),
        ),
        1 => PieChartSectionData(
            color: chart.male,
            value: widget.partnersAmount.toDouble(),
            title: widget.partnersAmount.toString(),
            radius: radius,
            gradient: LinearGradient(colors: [
              partners,
              chart.colorAccent(partners)
            ]),
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: fontColor,
              shadows: shadows,
            ),
        ),
        _ => throw StateError('Invalid'),
      };
    });
  }

  Column chartLegend() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: AppInsets.legendRow,
          child: LegendRow(
            color: context.theme.chartColors.user,
            text: ChartStrings.userOrgasms
          ),
        ),
        Padding(
          padding: AppInsets.legendRow,
          child: LegendRow(
            color: context.theme.chartColors.partners,
            text: ChartStrings.partnersOrgasms
          ),
        )
      ],
    );
  }
  
  String sectionPercentage(bool isThemeLight) {
    double touchedValue = showingSections(isThemeLight)[touchedIndex].value;
    
    double valuesSum = 0;
    for (var s in showingSections(isThemeLight)) {
      valuesSum += s.value;
    }
    
    double percentage = touchedValue / valuesSum * 100;
    return StringFormatter.percentage(percentage.round());
  }
}