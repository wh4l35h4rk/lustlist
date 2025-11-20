import 'package:drift/drift.dart';


@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
  TextColumn get slug => text().unique().withLength(min: 1, max: 20)();
}