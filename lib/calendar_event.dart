import 'package:lustlist/database.dart';


class CalendarEvent {
  final int id;
  final Event event;
  final Type type;
  final List<Partner?>? partners;
  final List<int>? partnerOrgasms;
  final EventData? data;

  const CalendarEvent(this.id, this.event, this.type, this.partners, this.partnerOrgasms, this.data);

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
  DateTime? getTime() => event.time;
  DateTime? getDuration() => data?.duration;

  @override
  String toString() {
    return '$partners, $event, $data';
  }
}