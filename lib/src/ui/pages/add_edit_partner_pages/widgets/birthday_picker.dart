import 'package:flutter/material.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';
import 'package:lustlist/src/ui/widgets/date_picker.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/core/utils/utils.dart';


class BirthdayPicker extends StatefulWidget {
  const BirthdayPicker({
    super.key,
    required this.controller,
    this.initBirthday
  });
  
  final DateController controller;
  final DateTime? initBirthday;

  @override
  State<BirthdayPicker> createState() => _BirthdayPickerState();
}

class _BirthdayPickerState extends State<BirthdayPicker> {
  late bool value = widget.controller.date != null;
  late DateTime? selectedBirthday = widget.initBirthday;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: SizedBox(
            height: 40,
            child: Switch(
              inactiveThumbColor: AppColors.addEvent.border(context),
              value: value,
              onChanged: (bool value) {
                setState(() {
                  this.value = value;
                  if (value == false) {
                    widget.controller.date = null;
                  }
                });
              },
            ),
          ),
        ),
        SizedBox(width: 3),
        value == true
          ? DatePicker(
            controller: widget.controller,
            minDate: minBirthday,
          )
          : Text(
            MiscStrings.unknown,
            style: TextStyle(
              fontSize: AppSizes.textBasic,
              color: AppColors.addEvent.coloredText(context)
            ),
          )
      ],
    );
  }
}