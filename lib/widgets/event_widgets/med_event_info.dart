import 'package:flutter/material.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/test_event.dart';
import 'package:lustlist/widgets/event_widgets/category_tile.dart';
import 'package:lustlist/widgets/event_widgets/eventdata_tile.dart';
import 'package:lustlist/widgets/event_widgets/notes_tile.dart';
import 'package:lustlist/widgets/event_widgets/sti_tile.dart';

import '../../database.dart';


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
        FutureBuilder(
            future: getCategoryList(database, event.event),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...", style: TextStyle(color: Theme
                    .of(context)
                    .colorScheme
                    .onSurface),);
              } else if (snapshot.hasError) {
                return Text("Error loading data", style: TextStyle(color: Theme
                    .of(context)
                    .colorScheme
                    .onSurface),);
              } else if (!snapshot.hasData) {
                return Text(
                  "No data",
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
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
                  ]
                );
              } else if (categoryList.contains("sti")){
                return StiTile(event: event);
              } else if (categoryList.contains("obgyn")){
                return CategoryTile(
                  event: event,
                  title: "OB-GYN visit:",
                  categorySlug: "obgyn",
                  iconData: CategoryIcons.uterus,
                  iconSize: 29,
                );
              } else {
                return Text(
                  "No data",
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                );
              }
            }
        ),
        NotesTile(event: event),
        SizedBox(height: 10,)
      ],
    );
  }

  Future<List<String>?> getCategoryList(AppDatabase db, context) async {
    final categorySlugs = await db.getCategorySlugsOfEvent(event.event.id);
    return categorySlugs;
  }
}

