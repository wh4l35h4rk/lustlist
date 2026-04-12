import 'package:lustlist/src/config/enums/gender.dart';
import 'package:lustlist/src/config/enums/type.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/entities/event_duration.dart';
import 'package:lustlist/src/domain/entities/event_with_options.dart';


class CalendarEvent {
  final int id;
  final Event event;
  final EventType type;
  final Map<Partner, int?>? partnersMap;
  final EventData? data;

  const CalendarEvent(this.id, this.event, this.type, this.partnersMap, this.data);

  List<Partner> getPartners() {
    if (partnersMap != null) {
      return List.generate(partnersMap!.length, (index) => partnersMap!.keys.elementAt(index));
    } else {
      return [];
    }
  }

  List<String> getPartnerNames() {
    if (partnersMap != null) {
      return List.generate(partnersMap!.length, (index) => partnersMap!.keys.elementAt(index).name);
    } else {
      return [];
    }
  }

  List<Gender> getPartnerGenders() {
    if (partnersMap != null) {
      return List.generate(partnersMap!.length, (index) => partnersMap!.keys.elementAt(index).gender);
    } else {
      return [];
    }
  }

  int getEventId() => event.id;
  String getTypeName() => type.name;
  DateTime getDate() => event.date;
  DateTime getTime() => event.time;
  EventDuration? getDuration() => data?.duration != null ? EventDuration(data!.duration!) : null;

  @override
  String toString() {
    return '$partnersMap, $event, $data';
  }

  @override
  bool operator ==(Object other) {
    if (other is CalendarEvent) {
      return getEventId() == other.getEventId();
    } else if (other is CalendarEventWithOptions) {
      return getEventId() == other.calendarEvent.getEventId();
    } else {
      return false;
    }
  }

  @override
  int get hashCode => id.hashCode;
}