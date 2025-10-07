import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../colors.dart';



class TimePicker extends StatefulWidget {
  final int type;

  const TimePicker({
    super.key,
    required this.type,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  DateTime time = DateTime(2016, 5, 10, 0, 0);
  late final int type = widget.type;

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: AppColors.addEvent.pickerSurface(context),
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  String _getDurationString() {
    int hours = time.hour;
    int minutes = time.minute;

    if (hours == 0 && minutes == 0) {
      return "0 minutes";
    }

    String? hoursString;
    String? minutesString;

    switch (hours) {
      case 0:
        hoursString = null;
      case 1:
        hoursString = "$hours hour";
      default:
        hoursString = "$hours hours";
    }
    switch (minutes) {
      case 0:
        minutesString = null;
      case 1:
        minutesString = "$minutes minute";
      default:
        minutesString = "$minutes minutes";
    }

    List<String> list = [?hoursString, ?minutesString];
    return list.join(" ");
  }

  String _getTimeString(){
    String hoursString = time.hour.toString();
    String minutesSting = time.minute.toString();

    if (time.hour < 10) {
      hoursString = '0$hoursString';
    }
    if (time.minute < 10) {
      minutesSting = '0$minutesSting';
    }

    return '$hoursString:$minutesSting';
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColors.addEvent.border(context))
          )
      ),
      child: SizedBox(
        height: 24,
        child: CupertinoButton(
          onPressed: () => _showDialog(
            CupertinoDatePicker(
              initialDateTime: time,
              minuteInterval: 5,
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newTime) {
                setState(() => time = newTime);
              },
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            type == 1 ? _getDurationString() : _getTimeString(),
            style: TextStyle(
                fontSize: 14.0,
                color: AppColors.addEvent.coloredText(context)
            ),
          ),
        ),
      ),
    );
  }
}