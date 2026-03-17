import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/ui/controllers/filter_controllers/numeric_text_filter_controller.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/int_form.dart';

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