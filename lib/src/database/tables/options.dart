import 'package:drift/drift.dart';
import 'package:lustlist/src/database/tables/categories.dart';


class EOptions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 40)();
  TextColumn get slug => text().unique().withLength(min: 1, max: 40)();
  IntColumn get categoryId => integer().references(Categories, #id)();
  BoolColumn get isVisible => boolean().withDefault(const Constant(true))();
  BoolColumn get isBasic => boolean().withDefault(const Constant(true))();
}