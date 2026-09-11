import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/widgets/info_row.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/providers/scale_provider.dart';


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
                iconData: AppIconData.rating,
                title: StringFormatter.colon(DataStrings.rating),
                child: _getRatingIcons(event, context)
              ),
              InfoRow(
                iconData: AppIconData.duration,
                title: StringFormatter.colon(DataStrings.duration),
                child: Text(
                  StringFormatter.duration(event.getDuration(), true),
                  style: TextStyle(
                    fontSize: context.sizes.textBasic,
                    color: context.theme.eventDataColors.text,
                  )
                )
              ),
              InfoRow(
                iconData: AppIconData.orgasms,
                title: StringFormatter.colon(DataStrings.myOrgasms),
                child: Text(
                  StringFormatter.orgasmsAmount(event.data!.userOrgasms, true),
                  style: TextStyle(
                    fontSize: context.sizes.textBasic,
                    color: context.theme.eventDataColors.text,
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
                event.type.iconData,
                size: context.sizes.iconBasic,
                color: context.theme.eventDataColors.leadingIcon,
              ),
            ],
          ),
        ],
      ),
    );
  }


  Row _getRatingIcons(CalendarEvent event, BuildContext context) {
    final int rating = event.data!.rating;
    return Row(
      children: [
        Row(
          children: [
            for (var index = 0; index < rating; index++)
              Icon(
                AppIconData.rating,
                size: context.sizes.iconMedium,
                color: context.theme.eventDataColors.text
              )
          ]
        ),
        Row(
          children: [
            for (var index = 0; index < 5 - rating; index++)
              Icon(
                AppIconData.ratingEmpty,
                size: context.sizes.iconMedium,
                color: context.theme.eventDataColors.text
              )
          ],
        ),
      ],
    );
  }
}
