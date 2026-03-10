import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/ui/controllers/filter_controller.dart';


class SelectableValueButton<T> extends StatelessWidget {
  const SelectableValueButton({
    required this.controller,
    required this.value,
    required this.title,
    super.key,
  });

  final T value;
  final FilterController<T> controller;
  final String title;


  @override
  Widget build(BuildContext context) {
    final selectedValues = controller.values;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: () => {
          controller.toggle(value)
        },
        style: AppStyles.selectableValueButton(context, selectedValues, value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(selectedValues.contains(value) ? AppIconData.selected : AppIconData.notSelected),
            ),
            Text(
              title,
              textAlign: TextAlign.left,
              style: AppStyles.addEventBasicText(context)
            ),
          ],
        ),
      ),
    );
  }
}
