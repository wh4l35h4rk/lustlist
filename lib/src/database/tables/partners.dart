import 'package:drift/drift.dart';
import 'package:lustlist/src/config/enums/gender.dart';


class Partners extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 32)();
  IntColumn get gender => intEnum<Gender>()();
  DateTimeColumn get birthday => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get notes => text().nullable()();
}