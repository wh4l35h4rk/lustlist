import 'package:flutter/material.dart';
import 'package:drift/drift.dart';
import 'package:lustlist/db/partners.dart';
import 'package:lustlist/calendar_event.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/test_status.dart';


DateTime normalizeDate(DateTime date) => DateTime(date.year, date.month, date.day);


Future getEventSource(AppDatabase db) async {
  final allEvents = await db.allEvents;
  List<CalendarEvent> testEventList = [];

  for (var e in allEvents) {
    CalendarEvent event = await dbToCalendarEvent(db, e);
    testEventList.add(event);
  }
  final eventDates = List.generate(testEventList.length, (index) => normalizeDate(testEventList[index].event.date));

  final eventMap = {
    for (var date in eventDates)
      date : testEventList.where((element) => normalizeDate(element.event.date) == date).toList()
  };
  return eventMap;
}

//TODO: change partner orgasms list to map
Future<CalendarEvent> dbToCalendarEvent(AppDatabase db, Event dbEvent) async {
  int eventId = dbEvent.id;
  Type type = await db.getTypeByEventId(dbEvent);
  List<Partner> partners = await db.getPartnersByEventId(eventId);
  List<int> partnerOrgasms = await db.getPartnerOrgasmsListByPartnersList(eventId, partners);
  Map<Partner, int> partnersMap = Map.fromEntries(List.generate(partners.length, (index) =>
    MapEntry(partners[index], partnerOrgasms[index])
  ));
  EventData? data = await db.getDataByEventId(eventId);

  CalendarEvent calendarEvent = CalendarEvent(eventId, dbEvent, type, partnersMap, data);
  return calendarEvent;
}


Future<void> insertMockEntries(AppDatabase db) async{
  final sexTypeId = await db.getTypeIdBySlug("sex");
  final mstbTypeId = await db.getTypeIdBySlug("masturbation");
  final medTypeId = await db.getTypeIdBySlug("medical");
  final cuniOptionId = await db.getOptionIdBySlug("cunnilingus");
  final chairOptionId = await db.getOptionIdBySlug("chair");
  final chlamydiaOptionId = await db.getOptionIdBySlug("chlamydia");
  final hpvOptionId = await db.getOptionIdBySlug("hpv");
  final herpesOptionId = await db.getOptionIdBySlug("herpes");
  final condomOptionId = await db.getOptionIdBySlug("condom");
  final mutualOptionId = await db.getOptionIdBySlug("mutual masturbation");
  final vaginalOptionId = await db.getOptionIdBySlug("vaginal");
  final soloFingeringOptionId = await db.getOptionIdBySlug("solo fingering");
  final soloFrottageOptionId = await db.getOptionIdBySlug("solo frottage");
  final pregOptionId = await db.getOptionIdBySlug("pregnancy test");
  final sonoOptionId = await db.getOptionIdBySlug("ultrasonography");
  final molluscumOptionId = await db.getOptionIdBySlug("molluscum contagiosum");

  final partnerId2 = await db.into(db.partners).insert(
      PartnersCompanion.insert(name: "Sonya", gender: Gender.female)
  );

  final partnerId1 = await db.into(db.partners).insert(
    PartnersCompanion.insert(name: "Wowa", gender: Gender.male,
        lastEventDate: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 11, 20))
    )
  );

  final partnerId3 = await db.into(db.partners).insert(PartnersCompanion.insert(name: "Alexander II", gender: Gender.male));
  final partnerId4 = await db.into(db.partners).insert(PartnersCompanion.insert(name: "Phoenix", gender: Gender.nonbinary));


  final event1Id = await db.into(db.events).insert(
      EventsCompanion.insert(
        typeId: sexTypeId,
        date: DateTime(2025, DateTime.now().month - 1, DateTime.now().day),
        time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 11, 20)),
        notes: Value("The following is a partial list of minor planets, running from minor-planet number 571001 through 572000, inclusive. The primary data for this and other partial lists is based on JPL's Small-Body Orbital Elements and data available from the Minor Planet Center. Critical list information is also provided by the MPC, unless otherwise specified from Lowell Observatory. A detailed description of the table's columns and additional sources are given on the main page including a complete list of every page in this series, and a statistical break-up on the dynamical classification of minor planets."),
      )
  );
  final event2Id = await db.into(db.events).insert(
      EventsCompanion.insert(
        typeId: mstbTypeId,
        date: DateTime(2025, DateTime.now().month, DateTime.now().day),
        time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 10))
      )
  );
  final event3Id = await db.into(db.events).insert(
      EventsCompanion.insert(
        typeId: medTypeId,
        date: DateTime(2025, DateTime.now().month, DateTime.now().day - 1),
        time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 1)),
      )
  );
  final event4Id = await db.into(db.events).insert(
      EventsCompanion.insert(
        typeId: sexTypeId,
        date: DateTime(2025, DateTime.now().month - 1, DateTime.now().day - 3),
        time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 31)),
      )
  );
  final event5Id = await db.into(db.events).insert(
      EventsCompanion.insert(
        typeId: medTypeId,
        date: DateTime(2025, DateTime.now().month - 1, DateTime.now().day + 2),
        time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 31)),
      )
  );

  await db.into(db.eventDataTable).insert(
    EventDataTableCompanion.insert(
      eventId: event1Id,
      rating: 4,
      duration: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 20)),
      userOrgasms: Value(1),
    )
  );
  await db.into(db.eventDataTable).insert(
      EventDataTableCompanion.insert(
        eventId: event4Id,
        rating: 5,
        duration: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 1, 20)),
        userOrgasms: Value(0),
      )
  );
  await db.into(db.eventDataTable).insert(
      EventDataTableCompanion.insert(
        eventId: event2Id,
        rating: 5,
        userOrgasms: Value(2),
        didWatchPorn: Value(false),
      )
  );

  await db.into(db.eventsPartners).insert(
    EventsPartnersCompanion.insert(
      eventId: event1Id,
      partnerId: partnerId1,
      partnerOrgasms: Value(0)
    )
  );
  await db.into(db.eventsPartners).insert(
      EventsPartnersCompanion.insert(
          eventId: event4Id,
          partnerId: partnerId1,
          partnerOrgasms: Value(1)
      )
  );
  await db.into(db.eventsPartners).insert(
      EventsPartnersCompanion.insert(
          eventId: event4Id,
          partnerId: partnerId2,
          partnerOrgasms: Value(2)
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
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event4Id,
        optionId: cuniOptionId,
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event4Id,
        optionId: chairOptionId,
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event3Id,
        optionId: chlamydiaOptionId,
        testStatus: Value(TestStatus.negative),
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event3Id,
        optionId: hpvOptionId,
        testStatus: Value(TestStatus.positive),
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event3Id,
        optionId: herpesOptionId,
        testStatus: Value(TestStatus.waiting),
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event4Id,
        optionId: condomOptionId,
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event4Id,
        optionId: mutualOptionId,
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event4Id,
        optionId: vaginalOptionId,
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event2Id,
        optionId: soloFingeringOptionId,
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event2Id,
        optionId: soloFrottageOptionId,
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event5Id,
        optionId: pregOptionId,
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event5Id,
        optionId: molluscumOptionId,
        testStatus: Value(TestStatus.waiting)
      )
  );
  await db.into(db.eventsOptions).insert(
      EventsOptionsCompanion.insert(
        eventId: event5Id,
        optionId: sonoOptionId,
      )
  );
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

DateTime toDate(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = toDate(DateTime.now());

const appTitle = "LustList";