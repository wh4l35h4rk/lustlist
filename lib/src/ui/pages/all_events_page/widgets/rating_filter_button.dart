import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/ui/controllers/selectable_filter_controller.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/list_filter_button.dart';

class RatingFilterButton extends StatelessWidget {
  const RatingFilterButton({
    required this.title,
    required this.controller,
    this.canBeDisabled = true,
    super.key,
  });

  final String title;
  final SelectableFilterController<int> controller;
  final bool canBeDisabled;

  @override
  Widget build(BuildContext context) {
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