import 'package:drift/drift.dart';
import 'package:lustlist/db/categories.dart';
import 'package:lustlist/db/types.dart';

@DataClassName('CategoryType')
class CategoriesTypes extends Table {
  IntColumn get categoryId => integer().references(Categories, #id)();
  IntColumn get typeId => integer().references(Types, #id)();

  @override
  Set<Column<Object>> get primaryKey => {categoryId, typeId};
}