import 'package:lustlist/src/domain/entities/calendar_event.dart';

class EventDurationStats {
  double? avgInMinutes;
  CalendarEvent? maxEvent;
  CalendarEvent? minEvent;

  EventDurationStats(this.avgInMinutes, this.minEvent, this.maxEvent);
}