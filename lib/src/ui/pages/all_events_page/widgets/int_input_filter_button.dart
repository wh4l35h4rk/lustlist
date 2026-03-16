import 'package:flutter/material.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/ui/controllers/numeric_filter_controller.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/filter_settings_button.dart';
import 'package:lustlist/src/core/widgets/droplist_button.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/int_form.dart';


class IntInputFilterButton extends StatelessWidget {
  const IntInputFilterButton({
    required this.title,
    required this.controller,
    this.canBeDisabled = true,
    super.key,
  });

  final String title;
  final NumericFilterController controller;
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
            _NumericTextForm(
              controller: controller,
            ),
            SizedBox(height: 70,)
          ],
        );
      }
    );
  }
}


class _NumericTextForm extends StatelessWidget {
  const _NumericTextForm({
    required this.controller,
  });

  final NumericFilterController controller;

  @override
  Widget build(BuildContext context) {
    double width = 150;

    return AnimatedBuilder(
      animation: Listenable.merge([
        controller.enabled,
        controller.singleMode,
      ]),
      builder: (context, _) {
        var isEnabled = controller.isEnabled;
        var isSingleMode = controller.singleMode.value;

        ValueListenableBuilder changeModeButton = ValueListenableBuilder(
            valueListenable: controller.singleMode,
            builder: (context, value, child) {
              Icon icon = Icon(
                value ? AppIconData.equals : AppIconData.range,
                size: 15,
                color: AppColors.surface(context),
              );
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.iconButtonSurface(context),
                  child: IconButton(
                    onPressed: () => {
                      controller.toggleMode()
                    },
                    icon: icon,
                  ),
                ),
              );
            }
        );

        Widget singleModeWidget = Center(
          child: SizedBox(
            width: width,
            child: IntForm(
              isEnabled: isEnabled,
              controller: controller.startController,
              hint: MiscStrings.equals,
            )
          ),
        );

        Widget rangeModeWidget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              child: IntForm(
                isEnabled: isEnabled,
                controller: controller.startController,
                hint: MiscStrings.start,
              )
            ),
            SizedBox(width: 15),
            SizedBox(
              width: width,
              child: IntForm(
                isEnabled: isEnabled,
                controller: controller.endController,
                hint: MiscStrings.end,
              )
            ),
          ],
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: isSingleMode ? singleModeWidget : rangeModeWidget
            ),
            changeModeButton
          ],
        );
      }
    );
  }
}