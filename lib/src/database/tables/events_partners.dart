import 'package:drift/drift.dart';
import 'package:lustlist/src/database/tables/events.dart';
import 'package:lustlist/src/database/tables/partners.dart';

@DataClassName('EventPartner')
class EventsPartners extends Table {
  IntColumn get eventId => integer().references(Events, #id, onDelete: KeyAction.cascade)();
  IntColumn get partnerId => integer().references(Partners, #id, onDelete: KeyAction.cascade)();
  IntColumn get partnerOrgasms => integer().check(partnerOrgasms.isBetweenValues(0, 13)).nullable()();

  @override
  Set<Column<Object>> get primaryKey => {eventId, partnerId};
}