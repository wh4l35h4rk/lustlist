import 'package:drift/drift.dart';
import 'package:lustlist/src/database/tables/events.dart';


@DataClassName('EventData')
class EventDataTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get eventId => integer().references(Events, #id, onDelete: KeyAction.cascade)();
  IntColumn get rating => integer().check(rating.isBetweenValues(0, 5))();
  DateTimeColumn get duration => dateTime().nullable()();
  IntColumn get userOrgasms => integer().check(userOrgasms.isBetweenValues(0, 13)).nullable()();
  BoolColumn get didWatchPorn => boolean().nullable()();
}

