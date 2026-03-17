import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/ui/controllers/filter_controllers/selectable_filter_controller.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/filter_buttons/list_filter_button.dart';

class RatingFilterButton extends StatelessWidget {
  const RatingFilterButton({
    required this.controller,
    this.canBeDisabled = true,
    super.key,
  });

  final SelectableFilterController<int> controller;
  final bool canBeDisabled;

  @override
  Widget build(BuildContext context) {
    String title = DataStrings.rating;

    return ListFilterButton<int>(
      title: title,
      controller: controller,
      canBeDisabled: canBeDisabled,
      valueWidgetBuilder: (int value) {
        return _getRatingIcons(value, context);
      },
    );
  }

  Row _getRatingIcons(int rating, BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            for (var index = 0; index < rating; index++)
              Icon(
                AppIconData.rating,
                size: AppSizes.iconMedium,
                color: AppColors.text(context)
              )
          ]
        ),
        Row(
          children: [
            for (var index = 0; index < 5 - rating; index++)
              Icon(
                AppIconData.ratingEmpty,
                size: AppSizes.iconMedium,
                color: AppColors.text(context)
              )
          ],
        ),
      ],
    );
  }
}