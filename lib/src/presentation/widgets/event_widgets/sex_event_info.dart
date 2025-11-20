import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/profile_strings.dart';
import 'package:lustlist/src/presentation/widgets/event_widgets/notes_tile.dart';
import '../../../core/utils/utils.dart';
import 'eventdata_tile.dart';
import 'package:lustlist/src/presentation/widgets/event_widgets/category_tile.dart';


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
          title: colon(DataStrings.contraception),
          categorySlug: "contraception",
          iconData: CategoryIcons.condom,
          onNoResultsText: ProfileStrings.none,
        ),
        CategoryTile(
          event: event,
          title: colon(DataStrings.practices),
          categorySlug: "practices",
          iconData: CustomIcons.handLizard,
          iconSize: AppSizes.iconPractices,
        ),
        CategoryTile(
          event: event,
          title: colon(DataStrings.poses),
          categorySlug: "poses",
          iconData: CategoryIcons.sexMove,
          iconSize: AppSizes.iconPoses,
        ),
        CategoryTile(
          event: event,
          title: colon(DataStrings.place),
          categorySlug: "place",
          iconData: Icons.bed
        ),
        NotesTile(event: event),
        SizedBox(height: 20)
      ],
    );
  }
}