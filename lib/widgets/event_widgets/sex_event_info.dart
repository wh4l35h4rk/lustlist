import 'package:flutter/material.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/calendar_event.dart';
import 'package:lustlist/widgets/event_widgets/notes_tile.dart';
import 'eventdata_tile.dart';
import 'package:lustlist/widgets/event_widgets/category_tile.dart';


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
          title: "Contraception:",
          categorySlug: "contraception",
          iconData: CategoryIcons.condom,
          onNoResultsText: "None",
        ),
        CategoryTile(
          event: event,
          title: "Practices:",
          categorySlug: "practices",
          iconData: CustomIcons.handLizard,
          iconSize: 22,
        ),
        CategoryTile(
          event: event,
          title: "Poses:",
          categorySlug: "poses",
          iconData: CategoryIcons.sexMove,
          iconSize: 27,
        ),
        CategoryTile(
          event: event,
          title: "Place:",
          categorySlug: "place",
          iconData: Icons.bed
        ),
        NotesTile(event: event),
        SizedBox(height: 20,)
      ],
    );
  }
}