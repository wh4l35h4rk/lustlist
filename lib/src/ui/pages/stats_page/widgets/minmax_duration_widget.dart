import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/domain/entities/event_duration.dart';
import 'package:lustlist/src/ui/pages/event_page/eventpage.dart';
import 'package:lustlist/src/ui/pages/stats_page/widgets/duration_text.dart';


class MinMaxDurationColumn extends StatelessWidget {
  const MinMaxDurationColumn({
    super.key,
    required this.event,
    required this.title,
    this.value,
    this.iconData,
  });

  final CalendarEvent? event;
  final String title;
  final EventDuration? value;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    bool valueNotEvent = event == null && value != null;

    EventDuration? eventDuration = !valueNotEvent ? event?.getDuration() : value;

    bool eventHasDuration =
        event?.data?.duration != null &&
        event!.data!.duration != 0;

    double iconPadding = 12;
    TextStyle titleStyle = AppStyles.numStatsTitle(context);

    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        if (iconData != null) Icon(
          iconData,
          color: AppColors.chart.bgIcon(context),
          size: 120
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
            !valueNotEvent && eventHasDuration ?
            InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventPage(event: event!),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: AppSizes.iconSmall + iconPadding),
                  DurationText(durationNullable: eventDuration, isMain: false,),
                  Padding(
                    padding: EdgeInsets.only(left: iconPadding),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: AppSizes.iconSmall,
                    ),
                  ),
                ],
              ),
            ) : DurationText(durationNullable: eventDuration, isMain: false,),
          ],
        ),
      ],
    );
  }
}