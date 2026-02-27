import 'package:drift/drift.dart';
import 'package:lustlist/src/database/tables/categories.dart';
import 'package:lustlist/src/config/enums/type.dart';

@DataClassName('CategoryType')
class CategoriesTypes extends Table {
  IntColumn get categoryId => integer().references(Categories, #id)();
  IntColumn get type => intEnum<EventType>()();

  @override
  Set<Column<Object>> get primaryKey => {categoryId, type};
}