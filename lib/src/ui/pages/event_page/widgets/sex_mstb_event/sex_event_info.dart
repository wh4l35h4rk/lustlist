import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/ui/widgets/notes_tile.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/eventdata_tile.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/category_tile.dart';


class SexEventInfo extends StatelessWidget {
  final CalendarEvent event;

  const SexEventInfo({
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
          title: StringFormatter.colon(DataStrings.contraception),
          categorySlug: "contraception",
          iconData: CategoryIcons.condom,
          onNoResultsText: MiscStrings.none,
        ),
        CategoryTile(
          event: event,
          title: StringFormatter.colon(DataStrings.practices),
          categorySlug: "practices",
          iconData: CustomIcons.handLizard,
          iconSize: AppSizes.iconPractices,
        ),
        CategoryTile(
          event: event,
          title: StringFormatter.colon(DataStrings.poses),
          categorySlug: "poses",
          iconData: CategoryIcons.sexMove,
          iconSize: AppSizes.iconPoses,
        ),
        CategoryTile(
          event: event,
          title: StringFormatter.colon(DataStrings.ejaculation),
          categorySlug: "ejaculation",
          iconData: Icons.water_drop_outlined,
        ),
        CategoryTile(
          event: event,
          title: StringFormatter.colon(DataStrings.place),
          categorySlug: "place",
          iconData: Icons.bed
        ),
        NotesTile(event: event),
        SizedBox(height: 20)
      ],
    );
  }
}