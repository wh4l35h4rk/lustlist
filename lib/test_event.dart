import 'package:lustlist/database.dart';
import 'package:lustlist/db/events.dart';


class TestEvent {
  final int id;
  final Event event;
  final Type type;
  final List<Partner?>? partners;
  final EventData? data;

  const TestEvent(this.id, this.event, this.type, this.partners, this.data);

  List<String> getPartnerNames() {
    if (partners != null) {
      return List.generate(partners!.length, (index) => partners![index]!.name);
    } else {
      return [];
    }
  }

  int getTypeId() => event.typeId;
  String getTypeSlug() => type.slug;
  DateTime getDate() => event.date;
  DayTime? getDayTime() => event.daytime;
  DateTime? getTime() => event.time;
  DateTime? getDuration() => data?.duration;

  @override
  String toString() {
    return '$partners, $event, $data';
  }
}