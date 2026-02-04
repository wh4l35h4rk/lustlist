import 'package:flutter/material.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';

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

final kToday = DateTime.now();
final kFirstDay = defaultDate;
final kLastDay = DateFormatter.dateOnly(DateTime.now());

const appTitle = "LustList";

final defaultDate = DateTime(1970, 1, 1, 0, 0, 0);
final minBirthday = DateTime(kToday.year - 120, 1, 1, 0, 0, 0);