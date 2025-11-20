import 'package:drift/drift.dart';


class Types extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique().withLength(min: 1, max: 20)();
  TextColumn get slug => text().unique().withLength(min: 1, max: 20)();
}