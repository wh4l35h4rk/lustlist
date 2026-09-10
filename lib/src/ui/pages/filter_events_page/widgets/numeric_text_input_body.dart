import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/ui/controllers/filter_controllers/numeric_text_filter_controller.dart';
import 'package:lustlist/src/ui/widgets/int_text_field_form.dart';

class NumericTextInputBody extends StatelessWidget {
  const NumericTextInputBody({
    super.key,
    required this.controller,
  });

  final NumericTextFilterController controller;

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
            child: SizedBox(
                width: width,
                child: IntTextFieldForm(
                  isEnabled: isEnabled,
                  controller: controller.startController,
                  hint: MiscStrings.equals,
                )
            ),
          );

          Widget rangeModeWidget = LayoutBuilder(
            builder: (context, constraints) {
              final requiredWidth = width * 2 + 45;
              final isHorizontal = constraints.maxWidth >= requiredWidth;

              return Flex(
                direction: isHorizontal ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width,
                    child: IntTextFieldForm(
                      isEnabled: isEnabled,
                      controller: controller.startController,
                      hint: MiscStrings.start,
                    )
                  ),
                  SizedBox(width: isHorizontal ? 15 : 0),
                  SizedBox(
                    width: width,
                    child: IntTextFieldForm(
                      isEnabled: isEnabled,
                      controller: controller.endController,
                      hint: MiscStrings.end,
                    )
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
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: changeModeButton,
              )
            ],
          );
        }
    );
  }
}