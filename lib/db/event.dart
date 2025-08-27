import 'dart:collection';


class Event {
  final int id;
  final String notes;

  const Event(this.id, this.notes);

  @override
  String toString() => notes;

}