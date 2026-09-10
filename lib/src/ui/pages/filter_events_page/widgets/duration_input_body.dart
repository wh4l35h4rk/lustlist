import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/ui/controllers/filter_controllers/numeric_duration_filter_controller.dart';
import 'package:lustlist/src/ui/pages/filter_events_page/widgets/duration_picker.dart';

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
                  color: context.theme.mainColors.surface,
                );
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: context.theme.mainColors.iconButton,
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
            key: const ValueKey(0),
            child: DurationPicker(
              label: MiscStrings.equals,
              controller: controller.startController,
              enabled: isEnabled,
            ),
          );

          Widget rangeModeWidget = LayoutBuilder(
            builder: (context, constraints) {
              double width = 150;
              final requiredWidth = width * 2 + 45;
              final isHorizontal = constraints.maxWidth >= requiredWidth;

              return Flex(
                key: const ValueKey(1),
                direction: isHorizontal ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DurationPicker(
                    label: MiscStrings.start,
                    controller: controller.startController,
                    enabled: isEnabled,
                  ),
                  SizedBox(width: isHorizontal ? 15 : 0),
                  DurationPicker(
                    label: MiscStrings.end,
                    controller: controller.endController,
                    enabled: isEnabled,
                  ),
                ],
              );
            },
          );

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: isSingleMode ? singleModeWidget : rangeModeWidget,
                ),
              ),
              changeModeButton
            ],
          );
        }
    );
  }
}