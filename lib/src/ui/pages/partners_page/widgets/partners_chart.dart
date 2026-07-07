import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/domain/entities/partner_dated.dart';
import 'package:lustlist/src/ui/widgets/legend_row.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lustlist/src/config/enums/gender.dart';


class PartnersChart extends StatefulWidget {
  final List<PartnerWithDate> partners;

  const PartnersChart({
    required this.partners,
    super.key,
  });

  @override
  State<PartnersChart> createState() => _PartnersChartState();
}

class _PartnersChartState extends State<PartnersChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: AppSizes.roundChartSize,
          width: AppSizes.roundChartSize,
          child: PieChart(
            PieChartData(
              sections: showingSections(),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              startDegreeOffset: 10,
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null ||
                        touchedIndex != -1) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
            ),
            duration: Duration(milliseconds: 400),
            curve: Curves.linear,
          ),
        ),
        Expanded(child: chartLegend()),
      ],
    );
  }

  double _getPartnersGenderAmount(List<PartnerWithDate> partners, Gender gender) {
    int count = partners.where((p) => p.partner.gender == gender).length;
    return count.toDouble();
  }

  List<PieChartSectionData> showingSections() {
    final chart = context.theme.chartColors;

    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? AppSizes.titleLarge : AppSizes.textBasic;
      final radius = isTouched ? 80.0 : 65.0;
      final fontColor = context.theme.mainColors.surface;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final iconSize = AppSizes.iconBasic;
      final iconColor = context.theme.categoryTileColors.icon;
      final borderWidth = AppSizes.badgeBorderWidth;
      final offset = AppSizes.badgeOffset;

      return switch (i) {
        0 => PieChartSectionData(
            color: context.theme.chartColors.female,
            value: _getPartnersGenderAmount(widget.partners, Gender.female),
            title: _getPartnersGenderAmount(widget.partners, Gender.female).toInt().toString(),
            radius: radius,
            gradient: LinearGradient(colors: [
              chart.female,
              chart.colorAccent(chart.female)
            ]),
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: fontColor,
              shadows: shadows,
            ),
            badgeWidget: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: chart.female,
                  width: borderWidth
                ),
                shape: BoxShape.circle,
                color: context.theme.mainColors.surface,
              ),
              child: Padding(
                padding: AppInsets.chartIcon,
                child: Icon(
                  Gender.female.iconData,
                  size: iconSize,
                  color: iconColor
                ),
              )
            ),
            badgePositionPercentageOffset: offset
        ),
        1 => PieChartSectionData(
            color: chart.male,
            value: _getPartnersGenderAmount(widget.partners, Gender.male),
            title: _getPartnersGenderAmount(widget.partners, Gender.male).toInt().toString(),
            radius: radius,
            gradient: LinearGradient(colors: [
              chart.male,
              chart.colorAccent(chart.male)
            ]),
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: fontColor,
              shadows: shadows,
            ),
            badgeWidget: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: chart.male,
                    width: borderWidth,
                  ),
                  shape: BoxShape.circle,
                  color: context.theme.mainColors.surface,
                ),
                child: Padding(
                  padding: AppInsets.chartIcon,
                  child: Icon(
                      Gender.male.iconData,
                      size: iconSize,
                      color: iconColor
                  ),
                )
            ),
            badgePositionPercentageOffset: offset
        ),
        2 => PieChartSectionData(
            color: chart.nonbinary,
            value: _getPartnersGenderAmount(widget.partners, Gender.nonbinary),
            title: _getPartnersGenderAmount(widget.partners, Gender.nonbinary).toInt().toString(),
            radius: radius,
            gradient: LinearGradient(colors: [
              chart.nonbinary,
              chart.colorAccent(chart.nonbinary)
            ]),
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: fontColor,
              shadows: shadows,
            ),
            badgeWidget: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: chart.nonbinary,
                  width: borderWidth
                ),
                shape: BoxShape.circle,
                color: context.theme.mainColors.surface,
              ),
              child: Padding(
                padding: AppInsets.chartIcon,
                child: Icon(
                  Gender.nonbinary.iconData,
                  size: iconSize,
                  color: iconColor
                ),
              )
            ),
            badgePositionPercentageOffset: offset
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
        if (_getPartnersGenderAmount(widget.partners, Gender.female) != 0)
            Padding(
              padding: AppInsets.legendRow,
              child: LegendRow(
                color: context.theme.chartColors.female,
                text: Gender.female.label
              ),
            ),
        if (_getPartnersGenderAmount(widget.partners, Gender.male) != 0)
            Padding(
              padding: AppInsets.legendRow,
              child: LegendRow(
                color: context.theme.chartColors.male,
                text: Gender.male.label,
              ),
            ),
        if (_getPartnersGenderAmount(widget.partners, Gender.nonbinary) != 0)
            Padding(
              padding: AppInsets.legendRow,
              child: LegendRow(
                color: context.theme.chartColors.nonbinary,
                text: Gender.nonbinary.label
              ),
            )
      ],
    );
  }
}