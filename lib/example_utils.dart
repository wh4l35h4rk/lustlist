import 'dart:collection';
import 'package:drift/drift.dart';
import 'package:lustlist/db/event_data.dart';
import 'package:lustlist/db/partners.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lustlist/db/test_event.dart';
import 'package:lustlist/database.dart';


Future<void> loadEvents(AppDatabase db) async {
  final data = await getEventSource(db);
  kEvents.addAll(data);
}


Future<List<Map<String, dynamic>>> insertTestEntries(AppDatabase db) async{
  final sexTypeId = await db.getTypeIdBySlug("sex");
  final mstbTypeId = await db.getTypeIdBySlug("masturbation");
  final cuniOptionId = await db.getOptionIdBySlug("cunnilingus");
  final chairOptionId = await db.getOptionIdBySlug("chair");

  final partnerId1 = await db.into(db.partners).insert(
    PartnersCompanion.insert(name: "Wowa", gender: Gender.male)
  );
  final partnerId2 = await db.into(db.partners).insert(
      PartnersCompanion.insert(name: "Sonya", gender: Gender.female)
  );

  final eventDataId = await db.into(db.eventDataTable).insert(
    EventDataTableCompanion.insert(
      rating: 4,
      daytime: DayTime.day,
      duration: Value(20),
      userOrgasms: Value(1),
    )
  );

  final eventId = await db.into(db.events).insert(
    EventsCompanion.insert(
      typeId: sexTypeId,
      dataId: Value(eventDataId),
    )
  );

  await db.into(db.eventsPartners).insert(
    EventsPartnersCompanion.insert(
      eventId: eventId,
      partnerId: partnerId1,
      partnerOrgasms: Value(0)
    )
  );

  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
          eventId: eventId,
          optionId: cuniOptionId,
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: eventId,
        optionId: chairOptionId,
      )
  );

  final entriesList = [{"eventId": eventId, "dataId": eventDataId, "partnersId": [partnerId1]}];
  return entriesList;
}


Future<Map<DateTime, List<TestEvent>>> getEventSource(AppDatabase db) async {
  final eventsFromDb = await insertTestEntries(db);
  var eventList = [];
  var dataList = [];
  var partnersList = [];

  for (var index = 0; index < eventsFromDb.length; index++){
    final eventId = eventsFromDb[index]["eventId"];
    final dataId = eventsFromDb[index]["dataId"];
    final partnersId = eventsFromDb[index]["partnersId"];

    final event = await (db.select(db.events)..where((t) => t.id.equals(eventId))).getSingle();
    final data = await (db.select(db.eventDataTable)..where((t) => t.id.equals(dataId))).getSingleOrNull();
    final partners = await Future.wait(List.generate(partnersId.length, (ii) async =>
        await (db.select(db.partners)..where((t) => t.id.equals(partnersId[ii]))).getSingle()
    ));

    eventList.add(event);
    dataList.add(data);
    partnersList.add(partners);
  }

  final eventMap = {
    for (var item in List.generate(50, (index) => index))
      DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5):
         List.generate(item % 3 + 1, (index) =>
             TestEvent(index,
                 eventList[index % eventsFromDb.length].toString() +
                 dataList[index % eventsFromDb.length].toString() +
                 partnersList[index % eventsFromDb.length].toString()
            ),
      ),
  };

  return eventMap;
}

LinkedHashMap<DateTime, List<TestEvent>> kEvents = LinkedHashMap(
  equals: isSameDay,
  hashCode: getHashCode,
);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}


List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}


final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);