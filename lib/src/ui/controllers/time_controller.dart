import 'package:flutter/foundation.dart';
import 'package:lustlist/src/core/utils/utils.dart';

class TimeController extends ChangeNotifier{
  DateTime time;

  TimeController({DateTime? time}) : time = time ?? defaultDate;

  void setTime(DateTime newValue) {
    time = newValue;
    notifyListeners();
  }
}