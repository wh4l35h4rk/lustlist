import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/ui/controllers/add_category_controller.dart';

class SwitchController extends ValueNotifier<bool> {
  SwitchController({
    required bool value
  }) : super(value);

  void setValue(bool newValue) {
    value = newValue;
  }
}


class MstbSwitch extends StatelessWidget {
  final AddCategoryController controller;
  final EOption option;

  const MstbSwitch({
    super.key,
    required this.controller,
    required this.option,
  });

  bool isToys(){
    return option.slug == "solo toys";
  }

  @override
  Widget build(BuildContext context) {
    String falseString = isToys() ? MiscStrings.didNotUse : MiscStrings.didNotWatch;
    String trueString = isToys() ? MiscStrings.didUse : MiscStrings.didWatch;

    return ValueListenableBuilder<List<EOption>>(
      valueListenable: controller.selectedOptions,
      builder: (context, selectedOptions, _) {
        final value = selectedOptions.any((e) => e.id == option.id);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(value ? trueString : falseString,
                    softWrap: true,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: AppColors.addEvent.text(context),
                        fontSize: AppSizes.textBasic
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Switch(
                    inactiveThumbColor: AppColors.addEvent.border(context),
                    value: value,
                    onChanged: (bool value) {
                      controller.toggleSelected(option);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}