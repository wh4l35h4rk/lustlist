import 'package:drift/drift.dart';
import 'package:lustlist/db/types.dart';

extension DayTimeLabel on DayTime {
  String get label {
    switch (this) {
      case DayTime.morning:
        return "Morning";
      case DayTime.day:
        return "Day";
      case DayTime.evening:
        return "Evening";
      case DayTime.night:
        return "Night";
    }
  }
}

enum DayTime {
  morning,
  day,
  evening,
  night
}

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get typeId => integer().references(Types, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get daytime => textEnum<DayTime>()();
  DateTimeColumn get time => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}