import 'package:flutter/material.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/ui/controllers/filter_controllers/numeric_filter_controller_base.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/filter_buttons/filter_settings_button.dart';
import 'package:lustlist/src/core/widgets/droplist_button.dart';


class NumericFilterButton extends StatelessWidget {
  const NumericFilterButton({
    required this.title,
    required this.controller,
    required this.child,
    this.canBeDisabled = true,
    super.key,
  });

  final String title;
  final NumericFilterControllerBase controller;
  final Widget child;
  final bool canBeDisabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        controller.enabled,
        controller.startNotifier,
        controller.endNotifier
      ]),
      builder: (context, _) {
        bool changesApplied = canBeDisabled
          ? controller.isEnabled
          : !controller.hasValues;

        return DroplistButton(
          title: title,
          backgroundColor: changesApplied
              ? AppColors.filterSurface(context)
              : AppColors.surface(context),
          onPressed: () {
            buildBottomSheet(context);
          },
        );
      }
    );
  }

  Future<dynamic> buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: AppColors.surface(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 8
                          ),
                          child: Text(
                            StringFormatter.colon(title),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppSizes.titleLarge,
                                color: AppColors.title(context)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (canBeDisabled) ValueListenableBuilder(
                          valueListenable: controller.enabled,
                          builder: (context, value, child) {
                            return FilterSettingsButton(
                              title: ButtonStrings.filter,
                              onPressed: () => {
                                controller.toggleEnabled()
                              },
                              backgroundColor: controller.isEnabled
                                  ? AppColors.filterButton(context)
                                  : AppColors.surface(context),
                              icon: Icon(controller.isEnabled
                                  ? AppIconData.selected
                                  : AppIconData.notSelected
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            child,
            SizedBox(height: 70,)
          ],
        );
      }
    );
  }
}