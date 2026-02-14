import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/domain/entities/event_duration.dart';
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
            type == 1 ? StringFormatter.duration(
                EventDuration.explicit(0, time.hour, time.minute),
                true
            ) : StringFormatter.time(time),
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