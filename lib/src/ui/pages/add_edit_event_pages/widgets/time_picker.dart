import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/ui/controllers/time_controller.dart';
import 'package:lustlist/src/config/constants/colors.dart';


class TimePicker extends StatefulWidget {
  final int type;
  final TimeController controller;

  const TimePicker({
    super.key,
    required this.type, 
    required this.controller,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  DateTime get time => widget.controller.time;
  int get type => widget.type;

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
      return "0 ${MiscStrings.mins}";
    }

    String? hoursString;
    String? minutesString;

    switch (hours) {
      case 0:
        hoursString = null;
      case 1:
        hoursString = "$hours ${MiscStrings.hour}";
      default:
        hoursString = "$hours ${MiscStrings.hours}";
    }
    switch (minutes) {
      case 0:
        minutesString = null;
      case 1:
        minutesString = "$minutes ${MiscStrings.min}";
      default:
        minutesString = "$minutes ${MiscStrings.mins}";
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
              onDateTimeChanged: (DateTime newValue) {
                setState(() => widget.controller.setTime(newValue));
              },
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            type == 1 ? _getDurationString() : _getTimeString(),
            style: TextStyle(
                fontSize: AppSizes.textBasic,
                color: AppColors.addEvent.coloredText(context)
            ),
          ),
        ),
      ),
    );
  }
}