import 'package:lustlist/src/core/utils/utils.dart';

class TimeController {
  DateTime time;

  TimeController({DateTime? time}) : time = time ?? defaultDate;

  void setTime(DateTime newValue) {
    time = newValue;
  }
}