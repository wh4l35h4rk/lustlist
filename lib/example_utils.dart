import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart';
import 'package:lustlist/db/events.dart';
import 'package:lustlist/db/event_data.dart';
import 'package:lustlist/db/partners.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lustlist/test_event.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/database.dart';


Future<void> loadEvents(AppDatabase db) async {
  try {
    final data = await getEventSource(db);
    kEvents.addAll(data);
  } catch (e, stack) {
    print('Error in loadEvents: $e');
    print(stack);
  }


  final types = await db.allTypes;
  for (final type in types) {
    iconDataMap[type.id] = getTypeIconData(type.slug);
  }
}


Future<List<Map<String, dynamic>>> insertTestEntries(AppDatabase db) async{
  final sexTypeId = await db.getTypeIdBySlug("sex");
  final mstbTypeId = await db.getTypeIdBySlug("masturbation");
  final medTypeId = await db.getTypeIdBySlug("medical");
  final cuniOptionId = await db.getOptionIdBySlug("cunnilingus");
  final chairOptionId = await db.getOptionIdBySlug("chair");

  final partnerId1 = await db.into(db.partners).insert(
    PartnersCompanion.insert(name: "Wowa", gender: Gender.male)
  );
  final partnerId2 = await db.into(db.partners).insert(
      PartnersCompanion.insert(name: "Sonya", gender: Gender.female)
  );

  final event1Id = await db.into(db.events).insert(
      EventsCompanion.insert(
        typeId: sexTypeId,
        date: DateTime.now(),
        daytime: DayTime.day,
        time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 11, 20)),
      )
  );

  final event2Id = await db.into(db.events).insert(
      EventsCompanion.insert(
        typeId: mstbTypeId,
        date: DateTime.now(),
        daytime: DayTime.morning,
      )
  );

  final event3Id = await db.into(db.events).insert(
      EventsCompanion.insert(
        typeId: medTypeId,
        date: DateTime.now(),
        daytime: DayTime.day,
      )
  );

  final event1DataId = await db.into(db.eventDataTable).insert(
    EventDataTableCompanion.insert(
      eventId: event1Id,
      rating: 4,
      duration: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 1, 20)),
      userOrgasms: Value(1),
    )
  );

  final event2DataId = await db.into(db.eventDataTable).insert(
      EventDataTableCompanion.insert(
        eventId: event2Id,
        rating: 5,
        userOrgasms: Value(2),
      )
  );

  await db.into(db.eventsPartners).insert(
    EventsPartnersCompanion.insert(
      eventId: event1Id,
      partnerId: partnerId1,
      partnerOrgasms: Value(0)
    )
  );

  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
          eventId: event1Id,
          optionId: cuniOptionId,
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event1Id,
        optionId: chairOptionId,
      )
  );

  final entriesList = [{"eventId": event1Id, "dataId": event1DataId, "partnersId": [partnerId1]},
    {"eventId": event2Id, "dataId": event2DataId, "partnersId": []},
    {"eventId": event3Id, "dataId": null, "partnersId": []}];
  print(entriesList);
  return entriesList;
}


Future<Map<DateTime, List<TestEvent>>> getEventSource(AppDatabase db) async {
  final eventsFromDb = await insertTestEntries(db);
  final N = eventsFromDb.length;

  List<Event> eventList = [];
  List<Type> typeList = [];
  List<EventData?> dataList = [];
  List<List<Partner?>> partnersList = [];

  for (var index = 0; index < N; index++){
    final eventId = eventsFromDb[index]["eventId"];
    final dataId = eventsFromDb[index]["dataId"];
    final partnersId = eventsFromDb[index]["partnersId"];

    EventData? data;
    final event = await (db.select(db.events)..where((t) => t.id.equals(eventId))).getSingle();
    final type = await (db.select(db.types)..where((t) => t.id.equals(event.typeId))).getSingle();
    if (dataId != null) {
      data = await (db.select(db.eventDataTable)..where((t) => t.id.equals(dataId))).getSingleOrNull();
    } else {
      data = null;
    }
    final partners = await Future.wait(List.generate(partnersId.length, (ii) async =>
        await (db.select(db.partners)..where((t) => t.id.equals(partnersId[ii]))).getSingleOrNull()
    ));

    eventList.add(event);
    typeList.add(type);
    dataList.add(data);
    partnersList.add(partners);
  }

  final eventMap = {
    for (var item in List.generate(50, (index) => index))
      DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5):
         List.generate(item % 3 + 1, (index) =>
             TestEvent(index, eventList[index % N], typeList[index % N], partnersList[index % N], dataList[index % N])
      ),
  };

  return eventMap;
}


IconData getTypeIconData(String slug)  {
  switch (slug) {
    case "sex":
      return Icons.favorite;
    case "masturbation":
      return Icons.front_hand;
    case "medical":
      return Icons.medical_services;
    default:
      throw FormatException('Invalid type: $slug');
  }
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