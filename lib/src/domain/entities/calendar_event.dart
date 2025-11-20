import 'package:lustlist/src/database/database.dart';


class CalendarEvent {
  final int id;
  final Event event;
  final Type type;
  final Map<Partner, int>? partnersMap;
  final EventData? data;

  const CalendarEvent(this.id, this.event, this.type, this.partnersMap, this.data);

  List<String> getPartnerNames() {
    if (partnersMap != null) {
      return List.generate(partnersMap!.length, (index) => partnersMap!.keys.elementAt(index).name);
    } else {
      return [];
    }
  }

  int getTypeId() => event.typeId;
  String getTypeSlug() => type.slug;
  DateTime getDate() => event.date;
  DateTime? getTime() => event.time;
  DateTime? getDuration() => data?.duration;

  @override
  String toString() {
    return '$partnersMap, $event, $data';
  }
}