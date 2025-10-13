import 'package:flutter/material.dart';
import '../../colors.dart';

class SwitchController {
  bool value = false;

  void setValue(bool newValue) {
    value = newValue;
  }
}

class AppSwitch extends StatefulWidget {
  final SwitchController controller;

  const AppSwitch(
    this.controller,
    {super.key}
  );

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
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
              Text(value ? "Did watch" : "Did not watch",
                style: TextStyle(color: AppColors.addEvent.text(context),
                    fontSize: 14),
              ),
            ],
          ),
        ),
        SizedBox(width: 12,),
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