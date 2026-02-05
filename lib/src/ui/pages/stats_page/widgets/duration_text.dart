import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
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

    bool hasHours = duration.hour != 0;
    bool hasMinutes = duration.minute != 0;

    TextStyle numsStyle = TextStyle(
        fontSize: isMain ? 55 : 35,
        color: AppColors.chart.subtitle(context)
    );
    TextStyle subtextStyle = TextStyle(
        fontSize: AppSizes.textBasic,
        color: AppColors.text(context)
    );

    TextSpan placeholder = TextSpan(text: '');

    return RichText(
      text: TextSpan(
        style: numsStyle,
        children: <TextSpan>[
          (!hasHours && !hasMinutes) ? TextSpan(text: '--') : placeholder,
          hasHours ? TextSpan(text: duration.hour.toString()) : placeholder,
          hasHours ? TextSpan(
              text: ' ${MiscStrings.h}   ',
              style: subtextStyle
          ) : placeholder,
          hasMinutes ? TextSpan(text: duration.minute.toString()) : placeholder,
          hasMinutes ? TextSpan(
              text: ' ${MiscStrings.m}',
              style: subtextStyle
          ) : placeholder,
        ],
      ),
    );
  }
}