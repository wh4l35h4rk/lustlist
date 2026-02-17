import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';

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
            color: AppColors.categoryTile.surface(context),
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
                      color: AppColors.categoryTile.title(context),
                      fontSize: AppSizes.titleLarge,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.notes,
                    color: AppColors.categoryTile.leadingIcon(context)
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
            color: AppColors.notesBottom(context),
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
            fontSize: AppSizes.textBasic,
          ),
          textAlign: TextAlign.justify
      )]);
    }
  }
}

