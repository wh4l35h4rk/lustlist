import 'package:drift/drift.dart';
import 'package:lustlist/db/events.dart';


@DataClassName('EventData')
class EventDataTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get eventId => integer().references(Events, #id)();
  IntColumn get rating => integer().check(rating.isBetweenValues(0, 5))();
  DateTimeColumn get duration => dateTime().nullable()();
  IntColumn get userOrgasms => integer().customConstraint('NOT NULL DEFAULT 1 CHECK(user_orgasms BETWEEN 0 AND 25)')();
  BoolColumn get didWatchPorn => boolean().nullable()();
}

