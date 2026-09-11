import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
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
          iconData: AppIconData.contraception,
          onNoResultsText: MiscStrings.none,
        ),
        CategoryTile(
          event: event,
          title: StringFormatter.colon(DataStrings.practices),
          categorySlug: "practices",
          iconData: AppIconData.practices,
          iconSize: context.sizes.iconPractices,
        ),
        CategoryTile(
          event: event,
          title: StringFormatter.colon(DataStrings.poses),
          categorySlug: "poses",
          iconData: AppIconData.poses,
          iconSize: context.sizes.iconPoses,
        ),
        CategoryTile(
          event: event,
          title: StringFormatter.colon(DataStrings.ejaculation),
          categorySlug: "ejaculation",
          iconData: AppIconData.ejaculation,
        ),
        CategoryTile(
          event: event,
          title: StringFormatter.colon(DataStrings.place),
          categorySlug: "place",
          iconData: AppIconData.place
        ),
        CategoryTile(
          event: event,
          title: StringFormatter.colon(DataStrings.complicacies),
          categorySlug: "complicacies",
          iconData: AppIconData.complicacies
        ),
        NotesTile(event: event),
        SizedBox(height: 20)
      ],
    );
  }
}