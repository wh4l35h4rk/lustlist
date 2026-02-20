import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';

class SwitchController extends ValueNotifier<bool> {
  SwitchController({
    required bool value
  }) : super(value);

  void setValue(bool newValue) {
    value = newValue;
  }
}


class MstbSwitch extends StatefulWidget {
  final SwitchController controller;
  final bool isToys;

  const MstbSwitch(
    this.isToys,
    this.controller,
    {super.key}
  );

  @override
  State<MstbSwitch> createState() => _MstbSwitchState();
}

class _MstbSwitchState extends State<MstbSwitch> {
  late bool value = widget.controller.value;

  @override
  Widget build(BuildContext context) {
    String falseString = widget.isToys ? MiscStrings.didNotUse : MiscStrings.didNotWatch;
    String trueString = widget.isToys ? MiscStrings.didUse : MiscStrings.didWatch;

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
                  setState(() {
                    this.value = value;
                    widget.controller.setValue(value);
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}