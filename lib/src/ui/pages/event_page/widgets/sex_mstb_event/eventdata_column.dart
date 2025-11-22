import 'package:flutter/material.dart';
import 'package:lustlist/src/ui/main.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/profile_strings.dart';
import 'package:lustlist/src/core/widgets/info_row.dart';
import 'package:lustlist/src/core/utils/utils.dart';


class EventDataColumn extends StatelessWidget {
  const EventDataColumn({
    super.key, 
    required this.event,
  });

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoRow(
                  iconData: Icons.star,
                  title: colon(DataStrings.rating),
                  child: _getRatingIcons(event, context)
              ),
              InfoRow(
                  iconData: Icons.timelapse,
                  title: colon(DataStrings.duration),
                  child: Text(
                      _getDurationString(event),
                      style: TextStyle(
                        fontSize: AppSizes.textBasic,
                        color: AppColors.eventData.text(context),
                      )
                  )
              ),
              InfoRow(
                  iconData: Icons.auto_awesome,
                  title: colon(DataStrings.duration),
                  child: Text(
                      _getOrgasmsText(event),
                      style: TextStyle(
                        fontSize: AppSizes.textBasic,
                        color: AppColors.eventData.text(context),
                      )
                  )
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                iconDataMap[event.getTypeId()],
                color: AppColors.eventData.leadingIcon(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDurationString(CalendarEvent event) {
    final DateTime? duration = event.data!.duration;
    if (duration != null) {
      int hours = event.data!.duration!.hour;
      int minutes = event.data!.duration!.minute;

      String? hoursString;
      String? minutesString;

      switch (hours) {
        case 0:
          hoursString = null;
        case 1:
          hoursString = "$hours ${ProfileStrings.hour}";
        default:
          hoursString = "$hours ${ProfileStrings.hours}";
      }
      switch (minutes) {
        case 0:
          minutesString = null;
        case 1:
          minutesString = "$minutes ${ProfileStrings.min}";
        default:
          minutesString = "$minutes ${ProfileStrings.mins}";
      }

      if (hoursString == null && minutesString == null) {
        return DataStrings.unknown;
      }

      List<String> list = [?hoursString, ?minutesString];
      return list.join(" ");
    } else {
      return DataStrings.unknown;
    }
  }

  String _getOrgasmsText(CalendarEvent event) {
    final int orgasmsAmount = event.data!.userOrgasms;
    final String amountString = orgasmsAmount.toString();

    final String orgasmsString;
    if (orgasmsAmount == 1) {
      orgasmsString = ProfileStrings.orgasmOne;
    } else {
      orgasmsString = ProfileStrings.orgasmsMany;
    }
    return "$amountString $orgasmsString";
  }

  Row _getRatingIcons(CalendarEvent event, context) {
    final int rating = event.data!.rating;
    return Row(
      children: [
        Row(
            children: [
              for (var index = 0; index < rating; index++)
                Icon(
                    Icons.star,
                    size: AppSizes.iconMedium,
                    color: AppColors.eventData.text(context)
                )
            ]
        ),
        Row(
          children: [
            for (var index = 0; index < 5 - rating; index++)
              Icon(
                  Icons.star_border,
                  size: AppSizes.iconMedium,
                  color: AppColors.eventData.text(context)
              )
          ],
        ),
      ],
    );
  }
}
