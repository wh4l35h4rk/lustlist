import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/widgets/info_row.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';


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
                        fontSize: AppSizes.textBasic,
                        color: AppColors.eventData.text(context),
                      )
                  )
              ),
              InfoRow(
                  iconData: AppIconData.orgasms,
                  title: StringFormatter.colon(DataStrings.myOrgasms),
                  child: Text(
                      StringFormatter.orgasmsAmount(event.data!.userOrgasms, true),
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
                event.type.iconData,
                color: AppColors.eventData.leadingIcon(context),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Row _getRatingIcons(CalendarEvent event, context) {
    final int rating = event.data!.rating;
    return Row(
      children: [
        Row(
          children: [
            for (var index = 0; index < rating; index++)
              Icon(
                AppIconData.rating,
                size: AppSizes.iconMedium,
                color: AppColors.eventData.text(context)
              )
          ]
        ),
        Row(
          children: [
            for (var index = 0; index < 5 - rating; index++)
              Icon(
                AppIconData.ratingEmpty,
                size: AppSizes.iconMedium,
                color: AppColors.eventData.text(context)
              )
          ],
        ),
      ],
    );
  }
}
