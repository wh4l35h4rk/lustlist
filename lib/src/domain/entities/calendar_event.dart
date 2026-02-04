import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/entities/event_duration.dart';


class CalendarEvent {
  final int id;
  final Event event;
  final Type type;
  final Map<Partner, int?>? partnersMap;
  final EventData? data;

  const CalendarEvent(this.id, this.event, this.type, this.partnersMap, this.data);

  List<String> getPartnerNames() {
    if (partnersMap != null) {
      return List.generate(partnersMap!.length, (index) => partnersMap!.keys.elementAt(index).name);
    } else {
      return [];
    }
  }

  int getEventId() => event.id;
  int getTypeId() => event.typeId;
  String getTypeSlug() => type.slug;
  DateTime getDate() => event.date;
  DateTime getTime() => event.time;
  EventDuration? getDuration() => data?.duration != null ? EventDuration(data!.duration!) : null;

  @override
  String toString() {
    return '$partnersMap, $event, $data';
  }
}