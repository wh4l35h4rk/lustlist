import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/enums/type.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/widgets/info_row.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/sex_mstb_event/partners_column.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/sex_mstb_event/eventdata_column.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/medical_event/medical_data_tile.dart';


class EventDataTile extends StatelessWidget {
  const EventDataTile({
    super.key,
    required this.event,
  });

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return BasicTile(
      surfaceColor: AppColors.eventData.surface(context),
      margin: AppInsets.headerTile,
      child: buildTileBottom(context),
    );
  }


  Widget buildTileBottom(BuildContext context) {
    EventType type = event.type;
    switch (type) {
      case EventType.sex:
        return Column(
          children: [
            EventDataColumn(event: event),
            Padding(
              padding: AppInsets.dataDivider,
              child: Divider()
            ),
            PartnersColumn(event: event),
          ],
        );
      case EventType.masturbation:
        return Column(
          children: [
            EventDataColumn(event: event),
            Padding(
                padding: AppInsets.dataDivider,
                child: Divider()
            ),
            InfoRow(
              iconData: AppIconData.porn,
              title: StringFormatter.colon(DataStrings.porn),
              child: Text(
                event.data!.didWatchPorn! ? MiscStrings.didWatch : MiscStrings.didNotWatch,
                style: TextStyle(
                  fontSize: AppSizes.textBasic,
                  color: AppColors.eventData.text(context)
                ),
              )
            ),
            InfoRow(
                iconData: AppIconData.toys,
                title: StringFormatter.colon(DataStrings.toys),
                child: Text(
                  event.data!.didUseToys! ? MiscStrings.didUse : MiscStrings.didNotUse,
                  style: TextStyle(
                      fontSize: AppSizes.textBasic,
                      color: AppColors.eventData.text(context)
                  ),
                )
            )
          ]);
      case EventType.medical:
        return MedicalData(event: event);
    }
  }
}
