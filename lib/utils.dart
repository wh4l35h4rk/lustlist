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
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = toDate(DateTime.now());

const appTitle = "LustList";