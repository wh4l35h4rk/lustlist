import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/widgets/info_row.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/core/utils/utils.dart';
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
      margin: const EdgeInsets.all(10),
      child: buildTileBottom(context),
    );
  }


  Widget buildTileBottom(BuildContext context) {
    String type = event.type.slug;
    switch (type) {
      case "sex":
        return Column(
          children: [
            EventDataColumn(event: event),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider()
            ),
            PartnersColumn(event: event),
          ],
        );
      case "masturbation":
        return Column(
          children: [
            EventDataColumn(event: event),
            InfoRow(
              iconData: Icons.play_circle,
              title: colon(DataStrings.porn),
              child: Text(
                event.data!.didWatchPorn! ? MiscStrings.didWatch : MiscStrings.didNotWatch,
                style: TextStyle(
                  fontSize: AppSizes.textBasic,
                  color: AppColors.eventData.text(context)
                ),
              )
            )
          ]);
      case "medical":
        return MedicalData(event: event);
      default:
        throw FormatException("Wrong type: $type");
    }
  }
}
