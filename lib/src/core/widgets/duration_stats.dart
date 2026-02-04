import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/chart_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/domain/entities/event_duration.dart';
import 'package:lustlist/src/ui/pages/event_page/eventpage.dart';


class DurationStats extends StatelessWidget{
  final double? avgInMinutes;
  final CalendarEvent? maxEvent;
  final CalendarEvent? minEvent;

  const DurationStats({
    required this.avgInMinutes,
    required this.maxEvent,
    required this.minEvent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    EventDuration? avg = avgInMinutes != null ? EventDuration(avgInMinutes!.toInt()) : null;
    EventDuration? min = minEvent?.getDuration();
    EventDuration? max = maxEvent?.getDuration();

    double iconPadding = 12;
    TextStyle titleStyle = TextStyle(
      color: AppColors.chart.title(context),
      fontSize: AppSizes.titleSmall,
      letterSpacing: AppSizes.chartTitleSpacing,
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: AppInsets.stats,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Icon(
                    CupertinoIcons.clock,
                    color: AppColors.chart.bgIcon(context),
                    size: 180,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      StringFormatter.colon(ChartStrings.avgSexDuration),
                      textAlign: TextAlign.center,
                      style: titleStyle
                    ),
                    DurationText(durationNullable: avg, isMain: true)
                  ],
                ),
              ]
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringFormatter.colon(ChartStrings.minSexDuration),
                  textAlign: TextAlign.center,
                  style: titleStyle
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    minEvent != null ? SizedBox(width: AppSizes.iconSmall + iconPadding) : SizedBox.shrink(),
                    DurationText(durationNullable: min, isMain: false,),
                    minEvent != null
                        ? InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventPage(event: minEvent!),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: iconPadding),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: AppSizes.iconSmall,
                          ),
                        )
                    ) : SizedBox.shrink(),
                ],),
                SizedBox(height: 20),
                Text(
                  StringFormatter.colon(ChartStrings.maxSexDuration),
                  textAlign: TextAlign.center,
                  style: titleStyle
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    maxEvent != null ? SizedBox(width: AppSizes.iconSmall + iconPadding) : SizedBox.shrink(),
                    DurationText(durationNullable: max, isMain: false,),
                    maxEvent != null
                        ? InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventPage(event: maxEvent!),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: iconPadding),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: AppSizes.iconSmall,
                          ),
                        )
                    ) : SizedBox.shrink(),
                  ],),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


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