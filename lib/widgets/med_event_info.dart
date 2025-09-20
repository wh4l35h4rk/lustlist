import 'package:flutter/material.dart';
import 'package:lustlist/test_event.dart';
import 'package:lustlist/widgets/eventdata_tile.dart';
import 'package:lustlist/widgets/notes_tile.dart';
import 'package:lustlist/widgets/sti_tile.dart';


class MedEventInfo extends StatelessWidget {
  final TestEvent event;

  const MedEventInfo({
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        EventDataTile(event: event),
        StiTile(event: event),
        NotesTile(event: event),
        SizedBox(height: 10,)
      ],
    );
  }
}


