import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/domain/entities/event_duration.dart';
import 'package:lustlist/src/ui/pages/stats_page/widgets/duration_text.dart';


class AvgDurationColumn extends StatelessWidget {
  const AvgDurationColumn({
    super.key,
    required this.avgInMinutes,
    required this.title,
    required this.bgIconData,
    this.bgIconSize,
  });

  final double? avgInMinutes;
  final String title;
  final IconData bgIconData;
  final double? bgIconSize;

  @override
  Widget build(BuildContext context) {
    EventDuration? avg = avgInMinutes != null ? EventDuration(
        avgInMinutes!.toInt()) : null;
    TextStyle titleStyle = AppStyles.numStatsTitle(context);

    return Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            bgIconData,
            color: AppColors.chart.bgIcon(context),
            size: bgIconSize ?? 180,
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
              DurationText(durationNullable: avg, isMain: true)
            ],
          ),
        ]
    );
  }
}