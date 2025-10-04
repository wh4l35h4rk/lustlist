import 'package:drift/drift.dart';
import 'package:lustlist/db/types.dart';


class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get typeId => integer().references(Types, #id)();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get time => dateTime().withDefault(Constant(DateTime(2006, 01, 01, 12, 0, 0)))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}