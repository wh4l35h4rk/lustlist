import 'package:flutter/material.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'text_form.dart';


class NotesTileController {
  final TextEditingController notesController;

  NotesTileController({String? notes}) : notesController = TextEditingController(text: notes);
}


class AddNotesTile extends StatefulWidget {
  final NotesTileController controller;

  const AddNotesTile({
    super.key,
    required this.controller
  });

  @override
  State<AddNotesTile> createState() => _AddNotesTileState();
}

class _AddNotesTileState extends State<AddNotesTile> {
  final _formKey = GlobalKey<FormState>();
  final maxLength = 500;

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
            color: AppColors.addEvent.surface(context),
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
                      color: AppColors.addEvent.title(context),
                      fontSize: AppSizes.titleLarge,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.notes,
                    color: AppColors.addEvent.leadingIcon(context)
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
            color: colorBlend(
              AppColors.addEvent.surface(context),
              AppColors.surface(context),
              0.5
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: TextForm(
                controller: widget.controller.notesController,
                maxLength: maxLength,
                hint: MiscStrings.notesHint,
                validator: (value) => _notesValidate(value)
              )
          )
        ),
      ],
    );
  }


  String? _notesValidate(String? value) {
    if (value != null && value.length > maxLength) {
      return AlertStrings.noteTooLong;
    }
    return null;
  }
}

