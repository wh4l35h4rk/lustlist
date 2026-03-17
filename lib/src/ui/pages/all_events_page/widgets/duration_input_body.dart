import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/ui/controllers/numeric_duration_filter_controller.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/duration_picker.dart';

class DurationInputBody extends StatelessWidget {
  const DurationInputBody({
    super.key,
    required this.controller,
  });

  final NumericDurationFilterController controller;

  @override
  Widget build(BuildContext context) {
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
            child: DurationPicker(
              label: MiscStrings.equals,
              controller: controller.startController,
              enabled: isEnabled,
            ),
          );

          Widget rangeModeWidget = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DurationPicker(
                label: MiscStrings.start,
                controller: controller.startController,
                enabled: isEnabled,
              ),
              SizedBox(width: 15),
              DurationPicker(
                label: MiscStrings.end,
                controller: controller.endController,
                enabled: isEnabled,
              ),
            ],
          );

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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