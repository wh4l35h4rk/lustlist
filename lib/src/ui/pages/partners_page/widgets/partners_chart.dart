import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/domain/entities/partner_dated.dart';
import 'package:lustlist/src/config/constants/colors.dart';
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
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? AppSizes.titleLarge : AppSizes.textBasic;
      final radius = isTouched ? 80.0 : 65.0;
      final fontColor = MainColors.surface(context);
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final iconSize = AppSizes.iconBasic;
      final iconColor = CategoryTileColors.icon(context);
      final borderWidth = AppSizes.badgeBorderWidth;
      final offset = AppSizes.badgeOffset;

      return switch (i) {
        0 => PieChartSectionData(
            color: ChartColors.female(context),
            value: _getPartnersGenderAmount(widget.partners, Gender.female),
            title: _getPartnersGenderAmount(widget.partners, Gender.female).toInt().toString(),
            radius: radius,
            gradient: LinearGradient(colors: [
              ChartColors.female(context),
              ChartColors.femaleAccent(context)],
            ),
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: fontColor,
              shadows: shadows,
            ),
            badgeWidget: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: ChartColors.female(context),
                      width: borderWidth
                  ),
                  shape: BoxShape.circle,
                  color: MainColors.surface(context),
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
            color: ChartColors.male(context),
            value: _getPartnersGenderAmount(widget.partners, Gender.male),
            title: _getPartnersGenderAmount(widget.partners, Gender.male).toInt().toString(),
            radius: radius,
            gradient: LinearGradient(colors: [
              ChartColors.male(context),
              ChartColors.maleAccent(context)],
            ),
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: fontColor,
              shadows: shadows,
            ),
            badgeWidget: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ChartColors.male(context),
                    width: borderWidth,
                  ),
                  shape: BoxShape.circle,
                  color: MainColors.surface(context),
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
            color: ChartColors.nonbinary(context),
            value: _getPartnersGenderAmount(widget.partners, Gender.nonbinary),
            title: _getPartnersGenderAmount(widget.partners, Gender.nonbinary).toInt().toString(),
            radius: radius,
            gradient: LinearGradient(colors: [
              ChartColors.nonbinary(context),
              ChartColors.nonbinaryAccent(context)],
            ),
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: fontColor,
              shadows: shadows,
            ),
            badgeWidget: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                        color: ChartColors.nonbinary(context),
                      width: borderWidth
                  ),
                  shape: BoxShape.circle,
                  color: MainColors.surface(context),
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
                color: ChartColors.female(context),
                text: Gender.female.label
              ),
            ),
        if (_getPartnersGenderAmount(widget.partners, Gender.male) != 0)
            Padding(
              padding: AppInsets.legendRow,
              child: LegendRow(
                color: ChartColors.male(context),
                text: Gender.male.label,
              ),
            ),
        if (_getPartnersGenderAmount(widget.partners, Gender.nonbinary) != 0)
            Padding(
              padding: AppInsets.legendRow,
              child: LegendRow(
                color: ChartColors.nonbinary(context),
                text: Gender.nonbinary.label
              ),
            )
      ],
    );
  }
}