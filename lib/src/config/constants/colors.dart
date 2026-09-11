import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/enums/type.dart';


class ConstColors {
  static Color getBorderColor(CalendarEvent event, BuildContext context) {
    final typeSlug = event.type;
    if ((typeSlug == EventType.sex || typeSlug == EventType.masturbation) && event.data != null) {
      final int rating = event.data!.rating;
      switch (rating) {
        case 1:
          return Colors.red;
        case 2:
          return Colors.orange;
        case 3:
          return Colors.amber;
        case 4:
          return Colors.lime;
        case 5:
          return Colors.green;
        default:
          return context.theme.mainColors.defaultWidget;
      }
    } else {
      return context.theme.mainColors.defaultWidget;
    }
  }
}