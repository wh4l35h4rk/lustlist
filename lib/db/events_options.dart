import 'package:drift/drift.dart';
import 'package:lustlist/db/events.dart';
import 'package:lustlist/db/options.dart';

@DataClassName('EventOption')
class EventsOptions extends Table {
  IntColumn get eventId => integer().references(Events, #id)();
  IntColumn get optionId => integer().references(EOptions, #id)();

  @override
  Set<Column<Object>> get primaryKey => {eventId, optionId};
}