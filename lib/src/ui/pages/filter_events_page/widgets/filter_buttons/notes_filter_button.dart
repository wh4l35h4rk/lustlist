import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/enums/bool_filter.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
import 'package:lustlist/src/ui/controllers/filter_controllers/bool_notes_controller.dart';


class NotesFilterButton<T> extends StatelessWidget {
  const NotesFilterButton({
    required this.controller,
    super.key,
  });

  final BoolNotesController controller;

  @override
  Widget build(BuildContext context) {
    final String title = DataStrings.notes;

    return AnimatedSize(
      duration: Duration(milliseconds: 250),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          controller.modeNotifier,
        ]),
        builder: (BuildContext context, Widget? child) {
          BoolFilter value = controller.mode;
          bool changesApplied = value != BoolFilter.notSet;
          return OutlinedButton(
              style: AppStyles.outlinedButton(
                  changesApplied
                    ? context.theme.mainColors.filterSurface
                    : context.theme.mainColors.surface,
                  context
              ),
              onPressed: _switchMode,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  if (changesApplied) Icon(value.iconData, size: context.sizes.iconBasic),
                  Text(title, style: TextStyle(fontSize: context.sizes.textBasic)),
                ],
              )
          );
        },
      ),
    );
  }

  void _switchMode(){
    BoolFilter value = controller.mode;
    switch (value) {
      case BoolFilter.notSet:
        controller.set(BoolFilter.hasValue);
      case BoolFilter.hasValue:
        controller.set(BoolFilter.noValue);
      case BoolFilter.noValue:
        controller.set(BoolFilter.notSet);
    }
  }
}
