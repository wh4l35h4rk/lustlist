import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';

import 'package:lustlist/src/ui/main.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/category_tile.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/eventdata_tile.dart';
import 'package:lustlist/src/ui/widgets/notes_tile.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/medical_event/sti_tile.dart';


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
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                  return ErrorTile();
              } else if (!snapshot.hasData) {
                return NotesTile(event: event);
              }

              List<String> categoryList = snapshot.data!;
              if (categoryList.contains("sti") && categoryList.contains("obgyn")){
                return Column(
                  children: [
                    StiTile(event: event),
                    CategoryTile(
                      event: event,
                      title: StringFormatter.colon(DataStrings.obgyn),
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
                      title: StringFormatter.colon(DataStrings.obgyn),
                      categorySlug: "obgyn",
                      iconData: CategoryIcons.uterus,
                      iconSize: AppSizes.iconObgyn,
                    ),
                    NotesTile(event: event),
                  ],
                );
              } else {
                return NotesTile(event: event);
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

