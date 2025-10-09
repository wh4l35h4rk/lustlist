import 'package:flutter/material.dart';
import '../../colors.dart';
import 'notes_form.dart';


class NotesTileController {
  final TextEditingController notesController = TextEditingController();
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
                    "Notes:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColors.addEvent.title(context),
                      fontSize: 18,
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
              child: NotesForm(controller: widget.controller.notesController,
            )
          )
        ),
      ],
    );
  }
}

