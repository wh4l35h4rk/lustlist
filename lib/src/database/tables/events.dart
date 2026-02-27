import 'package:drift/drift.dart';
import 'package:lustlist/src/config/enums/type.dart';


class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get type => intEnum<EventType>()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get time => dateTime().withDefault(Constant(DateTime(2006, 01, 01, 12, 0, 0)))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}