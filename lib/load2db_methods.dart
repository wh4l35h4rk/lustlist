import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
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


Future<void> loadEventData(AppDatabase db, int id, int rating, DateTime? duration, int orgasmAmount, bool? didWatchPorn) async {
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


Future<void> loadEventPartner(AppDatabase db, int eventId, int partnerId, int? partnerOrgasms) async {
  await db.into(db.eventsPartners).insert(
      EventsPartnersCompanion.insert(
          eventId: eventId,
          partnerId: partnerId,
          partnerOrgasms: Value(partnerOrgasms!)
      )
  );

  Event event = await db.getEventById(eventId);
  await (db.update(db.partners)..where((t) => t.id.equals(partnerId))).write(
    PartnersCompanion(lastEventDate: Value(event.date)),
  );
}


Future<void> loadOptions(AppDatabase db, int eventId, int optionId, TestStatus? stiStatus) async {
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: eventId,
        optionId: optionId,
        testStatus: Value(stiStatus)
      )
  );
}


Future<void> updateEvent(AppDatabase db, int eventId, DateTime date, DateTime time, String notes) async {
  var event = await (db.select(db.events)..where((t) => t.id.equals(eventId))).getSingleOrNull();
  if (event == null) {
    print("No event found with id $eventId");
    return;
  }

  await (db.update(db.events)
    ..where((t) => t.id.equals(eventId)))
      .write(
    EventsCompanion(
      date: Value(date),
      time: Value(time),
      notes: Value(notes),
    ),
  );
}

Future<void> updateEventData(
    AppDatabase db, int eventId,
    int rating, DateTime? duration, int orgasmAmount, bool? didWatchPorn
) async {
  var event = await (db.select(db.events)..where((t) => t.id.equals(eventId))).getSingleOrNull();
  if (event == null) {
    if (kDebugMode) {
      print("No event found with id == $eventId");
    }
    return;
  }

  await (db.update(db.eventDataTable)
    ..where((t) => t.eventId.equals(eventId)))
      .write(
    EventDataTableCompanion(
      rating: Value(rating),
      duration: Value(duration),
      userOrgasms: Value(orgasmAmount),
      didWatchPorn: Value(didWatchPorn)
    ),
  );
}


Future<void> deleteEventPartners(AppDatabase db, int eventId) async {
  await (db.delete(db.eventsPartners)..where((t) => t.eventId.equals(eventId))).go();
}

Future<void> deleteEventOptions(AppDatabase db, int eventId) async {
  await (db.delete(db.eventsOptions)..where((t) => t.eventId.equals(eventId))).go();
}