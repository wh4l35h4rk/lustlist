import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/providers/scale_provider.dart';


class NotesTile extends StatelessWidget {
  const NotesTile({
    super.key,
    this.event,
    this.partner
  });

  final CalendarEvent? event;
  final Partner? partner;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 18.0,
            right: 18.0,
            top: 18.0,
            bottom: 12,
          ),
          margin: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 5
          ),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: context.theme.categoryTileColors.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringFormatter.colon(DataStrings.notes),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: context.theme.categoryTileColors.title,
                      fontSize: context.sizes.titleLarge,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    AppIconData.notes,
                    size: context.sizes.iconBasic,
                    color: context.theme.categoryTileColors.leadingIcon
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(18.0),
          margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 5
          ),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: context.theme.mainColors.notes,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          child: _getNotes(context),
        ),
      ],
    );
  }

  Widget _getNotes(BuildContext context) {
    String? notes;
    if (event != null) {
      notes = event!.event.notes;
    } else if (partner != null) {
      notes = partner!.notes;
    }

    if (notes == null || notes.isEmpty || notes == "") {
      return Text(
        MiscStrings.noNotes,
        style: AppStyles.noDataText(context)
      );
    } else {
      return Wrap(children: [
        Text(
          notes,
          style: TextStyle(
            fontSize: context.sizes.textBasic,
          ),
          textAlign: TextAlign.justify
      )]);
    }
  }
}

