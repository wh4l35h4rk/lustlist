import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/core/widgets/droplist_button.dart';
import 'package:lustlist/src/ui/controllers/date_filter_controller.dart';
import 'package:lustlist/src/ui/controllers/selectable_filter_controller.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/list_filter_button.dart';

class DateFilterButton extends StatelessWidget {
  const DateFilterButton({
    required this.controller,
    super.key,
  });

  final DateFilterController controller;

  @override
  Widget build(BuildContext context) {
    String title = DataStrings.date;

    return AnimatedBuilder(
        animation: Listenable.merge([
          controller.rangeNotifier
        ]),
        builder: (context, _) {
          bool changesApplied = controller.hasValue;

          return DroplistButton(
            title: title,
            backgroundColor: changesApplied
                ? AppColors.filterSurface(context)
                : AppColors.surface(context),
            onPressed: () {
              _show(context);
            },
          );
        }
    );
  }

  void _show(BuildContext context) async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: kFirstDay,
      lastDate: kLastDay,
      currentDate: DateTime.now(),
      initialDateRange: controller.range,
      saveText: MiscStrings.applyFilter,
      cancelText: MiscStrings.clear,
    );

    controller.set(result);
  }
}