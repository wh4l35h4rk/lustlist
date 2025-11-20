import 'package:flutter/material.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/repository/calendar_event.dart';
import 'package:lustlist/widgets/event_widgets/category_tile.dart';
import 'package:lustlist/widgets/event_widgets/eventdata_tile.dart';
import 'package:lustlist/widgets/event_widgets/notes_tile.dart';
import 'package:lustlist/widgets/event_widgets/sti_tile.dart';

import '../../database.dart';
import 'error_tile.dart';


class MedEventInfo extends StatelessWidget {
  final CalendarEvent event;

  const MedEventInfo({
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        EventDataTile(event: event),
        FutureBuilder(
            future: getCategoryList(database, event.event),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ErrorTile(
                  iconData: Icons.autorenew,
                  title: "Loading...",
                );
              } else if (snapshot.hasError) {
                  return ErrorTile(
                    iconData: Icons.bug_report,
                    title: "Error loading data",
                  );
              } else if (!snapshot.hasData) {
                return ErrorTile(
                  iconData: Icons.close,
                  title: "No data",
                );
              }

              List<String> categoryList = snapshot.data!;
              if (categoryList.contains("sti") && categoryList.contains("obgyn")){
                return Column(
                  children: [
                    StiTile(event: event),
                    CategoryTile(
                      event: event,
                      title: "OB-GYN visit:",
                      categorySlug: "obgyn",
                      iconData: CategoryIcons.uterus,
                      iconSize: 29,
                    ),
                    NotesTile(event: event),
                  ]
                );
              } else if (categoryList.contains("sti")){
                return Column(
                  children: [
                    StiTile(event: event),
                    NotesTile(event: event),
                  ],
                );
              } else if (categoryList.contains("obgyn")){
                return Column(
                  children: [
                    CategoryTile(
                      event: event,
                      title: "OB-GYN visit:",
                      categorySlug: "obgyn",
                      iconData: CategoryIcons.uterus,
                      iconSize: 29,
                    ),
                    NotesTile(event: event),
                  ],
                );
              } else {
                return ErrorTile(
                  iconData: Icons.close,
                  title: "No data",
                );
              }
            }
        ),
        SizedBox(height: 10,)
      ],
    );
  }

  Future<List<String>?> getCategoryList(AppDatabase db, context) async {
    final categorySlugs = await db.getCategorySlugsOfEvent(event.event.id);
    return categorySlugs;
  }
}

