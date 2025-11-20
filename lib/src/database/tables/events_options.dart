import 'package:drift/drift.dart';
import 'package:lustlist/src/database/tables/events.dart';
import 'package:lustlist/src/database/tables/options.dart';
import 'package:lustlist/src/config/enums/test_status.dart';


@DataClassName('EventOption')
class EventsOptions extends Table {
  IntColumn get eventId => integer().references(Events, #id, onDelete: KeyAction.cascade)();
  IntColumn get optionId => integer().references(EOptions, #id)();
  TextColumn get testStatus => textEnum<TestStatus>().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {eventId, optionId};
}