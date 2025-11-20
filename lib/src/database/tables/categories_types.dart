import 'package:drift/drift.dart';
import 'package:lustlist/src/database/tables/categories.dart';
import 'package:lustlist/src/database/tables/types.dart';

@DataClassName('CategoryType')
class CategoriesTypes extends Table {
  IntColumn get categoryId => integer().references(Categories, #id)();
  IntColumn get typeId => integer().references(Types, #id)();

  @override
  Set<Column<Object>> get primaryKey => {categoryId, typeId};
}