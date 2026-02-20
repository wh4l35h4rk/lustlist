import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/domain/entities/event_duration.dart';


class DurationText extends StatelessWidget {
  final EventDuration? durationNullable;
  final bool isMain;

  const DurationText({
    super.key,
    required this.durationNullable,
    required this.isMain
  });

  @override
  Widget build(BuildContext context) {
    EventDuration duration = durationNullable == null ? EventDuration(0) : durationNullable!;

    bool hasDays = duration.days != 0;
    bool hasHours = duration.hours != 0;
    bool hasMinutes = duration.minutes != 0;

    bool isNull = !hasDays && !hasHours && !hasMinutes;

    TextStyle numsStyle = TextStyle(
        fontSize: isMain ? 55 : 35,
        color: AppColors.chart.subtitle(context)
    );
    TextStyle subtextStyle = AppStyles.numStatsSubtitle(context);

    return isNull ?
    RichText(
      text: TextSpan(
        text: '--',
        style: numsStyle,
      ),
    ) :
    Wrap(
      alignment: WrapAlignment.center,
      children: [
        if (hasDays) RichText(
          softWrap: false,
          text: TextSpan(
            style: numsStyle,
            children: <TextSpan>[
              TextSpan(
                text: duration.days.toString()),
                TextSpan(
                  text: formatSubtext(MiscStrings.d),
                  style: subtextStyle
              )
            ],
          ),
        ),
        if (hasHours) RichText(
          softWrap: false,
          text: TextSpan(
            style: numsStyle,
            children: <TextSpan>[
              TextSpan(text: duration.hours.toString()),
              TextSpan(
                  text: formatSubtext(MiscStrings.h),
                  style: subtextStyle
              )
            ],
          ),
        ),
        if (hasMinutes) RichText(
          softWrap: false,
          text: TextSpan(
            style: numsStyle,
            children: <TextSpan>[
              TextSpan(text: duration.minutes.toString()),
              TextSpan(
                  text: formatSubtext(MiscStrings.m),
                  style: subtextStyle
              )
            ],
          ),
        ),
      ],
    );
  }

  String formatSubtext(String s) {
    return ' $s   ';
  }
}