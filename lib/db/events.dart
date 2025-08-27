import 'package:drift/drift.dart';
import 'package:lustlist/db/types.dart';


class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get typeId => integer().references(Types, #id)();
  IntColumn get dataId => integer().nullable()
                                   .customConstraint('REFERENCES sexual_event_data(id)')();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}