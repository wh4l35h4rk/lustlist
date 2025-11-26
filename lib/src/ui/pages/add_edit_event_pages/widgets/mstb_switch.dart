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

  const MstbSwitch(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value ? MiscStrings.didWatch : MiscStrings.didNotWatch,
                style: TextStyle(
                    color: AppColors.addEvent.text(context),
                    fontSize: AppSizes.textBasic
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
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