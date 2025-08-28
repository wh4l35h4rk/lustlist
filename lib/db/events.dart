import 'package:drift/drift.dart';
import 'package:lustlist/db/types.dart';
import 'package:lustlist/db/event_data.dart';


class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get typeId => integer().references(Types, #id)();
  IntColumn get dataId => integer().nullable()
                                   .customConstraint('REFERENCES event_data_table(id)')();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}