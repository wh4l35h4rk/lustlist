import 'package:flutter/material.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/test_event.dart';
import 'package:lustlist/widgets/event_widgets/notes_tile.dart';
import 'eventdata_tile.dart';
import 'package:lustlist/widgets/event_widgets/category_tile.dart';


class MstbEventInfo extends StatelessWidget {
  final TestEvent event;

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
          title: "Practices:",
          categorySlug: "solo practices",
          iconData: CustomIcons.hand_lizard,
          iconSize: 22,
        ),
        CategoryTile(
            event: event,
            title: "Place:",
            categorySlug: "place",
            iconData: Icons.bed
        ),
        NotesTile(event: event),
        SizedBox(height: 10,)
      ],
    );
  }
}