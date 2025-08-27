import 'package:drift/drift.dart';
import 'package:lustlist/db/categories.dart';


class EOptions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique().withLength(min: 1, max: 20)();
  IntColumn get categoryId => integer().references(Categories, #id)();
  BoolColumn get isVisible => boolean().withDefault(const Constant(true))();
  BoolColumn get isBasic => boolean().withDefault(const Constant(false))();
}