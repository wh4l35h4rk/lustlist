import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';


class PercentageStatsColumn extends StatelessWidget {
  const PercentageStatsColumn({
    super.key,
    required this.valueTarget,
    required this.valueTotal,
    required this.title,
    required this.bgIconData,
    this.bgIconSize,
  });

  final int? valueTarget;
  final int? valueTotal;
  final String title;
  final IconData bgIconData;
  final double? bgIconSize;

  @override
  Widget build(BuildContext context) {
    TextStyle numsStyle = TextStyle(
        fontSize: 35,
        color: AppColors.chart.subtitle(context)
    );
    TextStyle titleStyle = AppStyles.numStatsTitle(context);
    TextStyle basicStyle = AppStyles.numStatsSubtitle(context);

    return Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            bgIconData,
            color: AppColors.chart.bgIcon(context),
            size: bgIconSize ?? 120,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringFormatter.colon(title),
                textAlign: TextAlign.center,
                style: titleStyle
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  StringFormatter.percentage(
                    _getPercentage(
                      valueTarget ?? 0,
                      valueTotal ?? 0
                    )
                  ),
                  style: numsStyle,
                  softWrap: true,
                ),
              ),
              Text(
                StringFormatter.eventRatio(valueTarget ?? 0, valueTotal ?? 0),
                textAlign: TextAlign.center,
                style: basicStyle
              ),
            ],
          ),
        ]
    );
  }

  int _getPercentage(int targetValue, int sumAll) {
    if (sumAll == 0) {
      return 0;
    }
    double percentage = targetValue / sumAll * 100;
    return percentage.round();
  }
}
