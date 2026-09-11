import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';
import 'package:lustlist/src/core/utils/utils.dart';


class DatePicker extends StatefulWidget {
  final DateController controller;
  final DateTime? minDate;

  const DatePicker({
    super.key,
    required this.controller,
    this.minDate
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime get date => widget.controller.date ?? DateFormatter.dateOnly(defaultDate);

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: context.theme.addEventColors.pickerSurface,
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: context.theme.addEventColors.border)
          )
      ),
      child: SizedBox(
        height: 24,
        child: CupertinoButton(
          onPressed: () => _showDialog(
            CupertinoDatePicker(
              initialDateTime: date,
              mode: CupertinoDatePickerMode.date,
              minimumDate: widget.minDate ?? kFirstDay,
              maximumDate: kLastDay,
              onDateTimeChanged: (DateTime newValue) {
                setState(() => widget.controller.setDate(newValue));
              },
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            DateFormatter.dateWithDay(date),
            style: TextStyle(
                fontSize: context.sizes.textBasic,
                color: context.theme.addEventColors.coloredText
            ),
          ),
        ),
      ),
    );
  }
}