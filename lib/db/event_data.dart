import 'package:drift/drift.dart';


enum DayTime {
  morning,
  day,
  evening,
  night
}

@DataClassName('EventData')
class EventDataTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get rating => integer().check(rating.isBetweenValues(1, 5))();
  TextColumn get daytime => textEnum<DayTime>()();
  DateTimeColumn get time => dateTime().nullable()();
  IntColumn get duration => integer().nullable()();
  IntColumn get userOrgasms => integer().customConstraint('NOT NULL DEFAULT 1 CHECK(user_orgasms BETWEEN 0 AND 25)')();
}

