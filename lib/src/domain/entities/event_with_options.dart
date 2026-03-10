import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';


class CalendarEventWithOptions {
  final CalendarEvent calendarEvent;
  final List<EOption> options;

  const CalendarEventWithOptions(this.calendarEvent, this.options);

  @override
  String toString() {
    return '$calendarEvent, $options';
  }
}