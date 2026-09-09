import 'package:flutter/material.dart';

class DateFilterController{
  final ValueNotifier<DateTimeRange?> rangeNotifier = ValueNotifier(null);

  DateFilterController();

  DateTimeRange? get range => rangeNotifier.value;
  bool get isEnabled => range != null;

  void set(DateTimeRange? newValue) {
    rangeNotifier.value = newValue;
  }

  void disable() {
    set(null);
  }
}