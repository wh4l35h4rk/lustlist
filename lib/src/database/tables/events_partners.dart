import 'package:drift/drift.dart';
import 'package:lustlist/src/database/tables/events.dart';
import 'package:lustlist/src/database/tables/partners.dart';

@DataClassName('EventPartner')
class EventsPartners extends Table {
  IntColumn get eventId => integer().references(Events, #id, onDelete: KeyAction.cascade)();
  IntColumn get partnerId => integer().references(Partners, #id, onDelete: KeyAction.cascade)();
  IntColumn get partnerOrgasms => integer().customConstraint('NOT NULL DEFAULT 1 CHECK(partner_orgasms BETWEEN 0 AND 25)')();

  @override
  Set<Column<Object>> get primaryKey => {eventId, partnerId};
}