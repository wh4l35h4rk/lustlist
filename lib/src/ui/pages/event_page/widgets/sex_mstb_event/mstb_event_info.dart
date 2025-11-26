import 'package:flutter/material.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/ui/widgets/notes_tile.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/eventdata_tile.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/category_tile.dart';


class MstbEventInfo extends StatelessWidget {
  final CalendarEvent event;

  const MstbEventInfo({
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        EventDataTile(event: event),
        CategoryTile(
          event: event,
          title: StringFormatter.colon(DataStrings.practices),
          categorySlug: "solo practices",
          iconData: CustomIcons.handLizard,
          iconSize: AppSizes.iconPractices,
        ),
        CategoryTile(
            event: event,
            title: StringFormatter.colon(DataStrings.place),
            categorySlug: "place",
            iconData: Icons.bed
        ),
        NotesTile(event: event),
        SizedBox(height: 10)
      ],
    );
  }
}