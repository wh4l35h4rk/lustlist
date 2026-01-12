import 'package:flutter/material.dart';

IconData getTypeIconData(String slug)  {
  switch (slug) {
    case "sex":
      return Icons.favorite;
    case "masturbation":
      return Icons.front_hand;
    case "medical":
      return Icons.medical_services;
    default:
      throw FormatException('Invalid type: $slug');
  }
}

DateTime toDate(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

final kToday = DateTime.now();
final kFirstDay = defaultDate;
final kLastDay = toDate(DateTime.now());

const appTitle = "LustList";

final defaultDate = DateTime(1970, 1, 1, 0, 0, 0);
final minBirthday = DateTime(kToday.year - 120, 1, 1, 0, 0, 0);