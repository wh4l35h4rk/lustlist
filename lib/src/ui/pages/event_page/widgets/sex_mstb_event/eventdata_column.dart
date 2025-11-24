import 'package:flutter/material.dart';
import 'package:lustlist/src/ui/main.dart';
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
                  iconData: Icons.star,
                  title: StringFormatter.colon(DataStrings.rating),
                  child: _getRatingIcons(event, context)
              ),
              InfoRow(
                  iconData: Icons.timelapse,
                  title: StringFormatter.colon(DataStrings.duration),
                  child: Text(
                      StringFormatter.duration(event.data!.duration),
                      style: TextStyle(
                        fontSize: AppSizes.textBasic,
                        color: AppColors.eventData.text(context),
                      )
                  )
              ),
              InfoRow(
                  iconData: Icons.auto_awesome,
                  title: StringFormatter.colon(DataStrings.myOrgasms),
                  child: Text(
                      StringFormatter.orgasmsAmount(event.data!.userOrgasms),
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
