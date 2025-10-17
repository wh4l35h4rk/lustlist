import 'package:drift/drift.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/test_status.dart';


Future<int> loadEvent(AppDatabase db, String slug, DateTime date, DateTime time, String notes) async {
  int typeId = await db.getTypeIdBySlug(slug);
  int eventId = await db.into(db.events).insert(
      EventsCompanion.insert(
        typeId: typeId,
        date: date,
        time: Value(time),
        notes: Value(notes),
      )
  );
  return eventId;
}


Future<void> loadEventData(AppDatabase db, Future<int> id, int rating, DateTime? duration, int orgasmAmount, bool? didWatchPorn) async {
  if (duration != null && duration.hour == 0 && duration.minute == 0) {
    duration = null;
  }
  await db.into(db.eventDataTable).insert(
      EventDataTableCompanion.insert(
        eventId: await id,
        rating: rating,
        duration: Value(duration),
        userOrgasms: Value(orgasmAmount),
        didWatchPorn: Value(didWatchPorn),
      )
  );
}


Future<void> loadEventPartner(AppDatabase db, Future<int> eventId, int partnerId, int? partnerOrgasms) async {
  await db.into(db.eventsPartners).insert(
      EventsPartnersCompanion.insert(
          eventId: await eventId,
          partnerId: partnerId,
          partnerOrgasms: Value(partnerOrgasms!)
      )
  );

  Event event = await db.getEventById(await eventId);
  await (db.update(db.partners)..where((t) => t.id.equals(partnerId))).write(
    PartnersCompanion(lastEventDate: Value(event.date)),
  );
}


Future<void> loadOptions(AppDatabase db, Future<int> eventId, int optionId, TestStatus? stiStatus) async {
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: await eventId,
        optionId: optionId,
        testStatus: Value(stiStatus)
      )
  );
}