import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/styles.dart';
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
  });

  final CalendarEvent? event;
  final String title;

  @override
  Widget build(BuildContext context) {
    EventDuration? min = event?.getDuration();

    bool haveDuration =
        event?.data?.duration != null &&
            event!.data!.duration != 0;

    double iconPadding = 12;
    TextStyle titleStyle = AppStyles.numStatsTitle(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            StringFormatter.colon(title),
            textAlign: TextAlign.center,
            style: titleStyle
        ),
        haveDuration ?
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
              DurationText(durationNullable: min, isMain: false,),
              Padding(
                padding: EdgeInsets.only(left: iconPadding),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: AppSizes.iconSmall,
                ),
              ),
            ],
          ),
        ) : DurationText(durationNullable: min, isMain: false,),
      ],
    );
  }
}