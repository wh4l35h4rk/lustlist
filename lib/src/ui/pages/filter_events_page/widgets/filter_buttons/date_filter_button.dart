import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/core/widgets/droplist_button.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
import 'package:lustlist/src/ui/controllers/filter_controllers/date_filter_controller.dart';
import 'package:provider/provider.dart';

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
          bool changesApplied = controller.isEnabled;

          return DroplistButton(
            title: title,
            backgroundColor: changesApplied
                ? context.theme.mainColors.filterSurface
                : context.theme.mainColors.surface,
            onPressed: () {
              _show(context);
            },
          );
        }
    );
  }

  void _show(BuildContext context) async {
    final scale = context.read<ScaleProvider>();

    final result = await showDateRangePicker(
      context: context,
      firstDate: kFirstDay,
      lastDate: kLastDay,
      currentDate: DateTime.now(),
      initialDateRange: controller.range,
      saveText: MiscStrings.applyFilter,
      cancelText: MiscStrings.clear,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(scale.value),
          ),
          child: child!,
        );
      },
    );
    controller.set(result);
  }
}