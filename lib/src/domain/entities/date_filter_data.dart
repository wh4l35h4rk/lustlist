import 'package:flutter/material.dart';

class DateFilterData {
  final bool isEnabled;
  final DateTimeRange? value;

  const DateFilterData({
    required this.isEnabled,
    required this.value,
  });

  @override
  String toString() {
    return "DateFilterData(isEnabled: $isEnabled, value: $value";
  }
}