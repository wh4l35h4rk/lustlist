import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/ui/controllers/filter_controllers/selectable_filter_controller.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/filter_buttons/list_filter_button.dart';

class OptionsFilterButton<T> extends StatelessWidget {
  const OptionsFilterButton({
    required this.title,
    required this.controller,
    required this.nameBuilder,
    this.canBeDisabled = true,
    super.key,
  });

  final String title;
  final SelectableFilterController<T> controller;
  final String Function(T value) nameBuilder;
  final bool canBeDisabled;

  @override
  Widget build(BuildContext context) {
    return ListFilterButton(
      title: title,
      controller: controller,
      canBeDisabled: canBeDisabled,
      valueWidgetBuilder: (T value) {
        return Text(
          nameBuilder(value),
          style: AppStyles.basicText(context),
        );
      },
    );
  }
}