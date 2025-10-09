import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../colors.dart';
import '../../example_utils.dart';

class DateController {
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);

  void setDate(DateTime newValue) {
    date = newValue;
  }
}


class DatePicker extends StatefulWidget {
  final DateController controller;

  const DatePicker({
    super.key,
    required this.controller,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime get date => widget.controller.date;

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
              initialDateTime: date,
              mode: CupertinoDatePickerMode.date,
              minimumDate: kFirstDay,
              maximumDate: kLastDay,
              onDateTimeChanged: (DateTime newValue) {
                setState(() => widget.controller.setDate(newValue));
              },
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            DateFormat.yMMMMd().format(date),
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