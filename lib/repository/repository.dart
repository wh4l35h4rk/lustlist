import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/test_status.dart';
import 'package:lustlist/utils.dart';
import 'calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/custom_icons.dart';

import '../gender.dart';


class EventRepository {
  final AppDatabase db;
  EventRepository(this.db);

  DateTime normalizeDate(DateTime date) => DateTime(date.year, date.month, date.day);

  int sortTime(DateTime a, DateTime b) {
    final t1 = DateTime(1, 1, 1, a.hour, a.minute);
    final t2 = DateTime(1, 1, 1, b.hour, b.minute);

    if (t1.hour != t2.hour) return t1.hour.compareTo(t2.hour);
    return t1.minute.compareTo(t2.minute);
  }

  int sortDateTime(Event a, Event b) {
    final d1 = DateTime(a.date.year, a.date.month, a.date.day, 0, 0);
    final d2 = DateTime(b.date.year, b.date.month, b.date.day, 0, 0);
    final t1 = DateTime(1, 1, 1, a.time.hour, a.time.minute);
    final t2 = DateTime(1, 1, 1, b.time.hour, b.time.minute);

    if (d1.year == d2.year) {
      if (d1.month == d2.month) {
        if (d1.day == d2.day) {
          if (t1.hour == t2.hour) {
            return t1.minute.compareTo(t2.minute);
          } else {
            return t1.hour.compareTo(t2.hour);
          }
        } else {
          return d1.day.compareTo(d2.day);
        }
      } else {
        return d1.month.compareTo(d2.month);
      }
    } else {
      return d1.year.compareTo(d2.year);
    }
  }

  Future getEventSource() async {
    final allEvents = await db.allEvents;
    List<CalendarEvent> testEventList = [];

    for (var e in allEvents) {
      CalendarEvent event = await dbToCalendarEvent(e);
      testEventList.add(event);
    }
    final eventDates = List.generate(testEventList.length, (index) => normalizeDate(testEventList[index].event.date));

    final eventMap = {
      for (var date in eventDates)
        date : testEventList.where((element) => normalizeDate(element.event.date) == date).toList()
    };
    for (var v in eventMap.values){
      v.sort((a, b) => sortTime(a.event.time, b.event.time));
    }

    return eventMap;
  }


  Future<CalendarEvent> dbToCalendarEvent(Event dbEvent) async {
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
  
  
  Future<int> loadEvent(String slug, DateTime date, DateTime time, String notes) async {
    int typeId = await db.getTypeIdBySlug(slug);
    int eventId = await db.insertEvent(
        EventsCompanion.insert(
          typeId: typeId,
          date: date,
          time: Value(time),
          notes: Value(notes),
        )
    );
    return eventId;
  }

  
  Future<void> loadEventData(int eventId, int rating, DateTime? duration, int orgasmAmount, bool? didWatchPorn,) async {
    DateTime? fixedDuration = (duration != null && duration.hour == 0 && duration.minute == 0) ? null : duration;

    await db.insertEventData(
      EventDataTableCompanion.insert(
        eventId: eventId,
        rating: rating,
        duration: Value(fixedDuration),
        userOrgasms: Value(orgasmAmount),
        didWatchPorn: Value(didWatchPorn),
      ),
    );
  }

  
  Future<void> loadEventPartner(int eventId, int partnerId, int? partnerOrgasms) async {
    await db.insertEventPartner(
        EventsPartnersCompanion.insert(
            eventId: eventId,
            partnerId: partnerId,
            partnerOrgasms: Value(partnerOrgasms!)
        )
    );
  }

  
  Future<void> loadOptions(int eventId, int optionId, TestStatus? stiStatus) async {
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
            eventId: eventId,
            optionId: optionId,
            testStatus: Value(stiStatus)
        )
    );
  }


  Future<void> updateEvent(int eventId, DateTime date, DateTime time, String notes) async {
    var event = await (db.select(db.events)..where((t) => t.id.equals(eventId))).getSingleOrNull();
    if (event == null) {
      if (kDebugMode) {
        print("No event found with id == $eventId");
      }
      return;
    }

    await db.updateEventRaw(
      eventId,
      EventsCompanion(
        date: Value(date),
        time: Value(time),
        notes: Value(notes),
      ),
    );
  }


  Future<void> updateEventData(int eventId, int rating, DateTime? duration, int orgasmAmount, bool? didWatchPorn) async {
    var event = await (db.select(db.events)..where((t) => t.id.equals(eventId))).getSingleOrNull();
    if (event == null) {
      if (kDebugMode) {
        print("No event found with id == $eventId");
      }
      return;
    }

    await db.updateEventDataByEventId(
      eventId,
      EventDataTableCompanion(
          rating: Value(rating),
          duration: Value(duration),
          userOrgasms: Value(orgasmAmount),
          didWatchPorn: Value(didWatchPorn)
      ),
    );
  }

  Future<List<EOption>> getOptionsList(int eventId, String categorySlug) async {
    int categoryId = await db.getCategoryIdBySlug(categorySlug);
    List<EOption> options = await db.getEventOptionsByCategory(eventId, categoryId);
    return options;
  }

  Future<DateTime> getPartnerLastEventDate(int partnerId) async {
    List<Event> events = await db.getEventsByPartnerId(partnerId);
    if (events.isEmpty) return defaultDate;
    events.sort(sortDateTime);
    return events.last.date;
  }

  Future<List<Partner>> getPartnersSorted() async {
    List<Partner> partners = await db.allPartners;

    Map<int, DateTime> dates = {};
    for (Partner p in partners) {
      DateTime date = await getPartnerLastEventDate(p.id);
      dates[p.id] = date;
    }
    if (partners.isNotEmpty){
      partners.sort((a, b) {
        return -1 * dates[a.id]!.compareTo(dates[b.id]!);
      });
    }
    return partners;
  }

  IconData getGenderIconData(Partner partner) {
    final Gender gender = partner.gender;
    switch (gender) {
      case Gender.female:
        return Icons.female;
      case Gender.male:
        return Icons.male;
      case Gender.nonbinary:
        return CustomIcons.genderless;
    }
  }
  

  Future<void> insertMockEntries() async{
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

    final partnerId2 = await db.insertPartner(PartnersCompanion.insert(name: "Sonya", gender: Gender.female));
    final partnerId1 = await db.insertPartner(PartnersCompanion.insert(name: "Wowa", gender: Gender.male));
    final partnerId3 = await db.insertPartner(PartnersCompanion.insert(name: "Alexander II", gender: Gender.male));
    final partnerId4 = await db.insertPartner(PartnersCompanion.insert(name: "Phoenix", gender: Gender.nonbinary));


    final event1Id = await db.insertEvent(
        EventsCompanion.insert(
          typeId: sexTypeId,
          date: DateTime(2025, DateTime.now().month - 1, DateTime.now().day),
          time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 11, 20)),
          notes: Value("The following is a partial list of minor planets, running from minor-planet number 571001 through 572000, inclusive. The primary data for this and other partial lists is based on JPL's Small-Body Orbital Elements and data available from the Minor Planet Center. Critical list information is also provided by the MPC, unless otherwise specified from Lowell Observatory. A detailed description of the table's columns and additional sources are given on the main page including a complete list of every page in this series, and a statistical break-up on the dynamical classification of minor planets."),
        )
    );
    final event2Id = await db.insertEvent(
        EventsCompanion.insert(
            typeId: mstbTypeId,
            date: DateTime(2025, DateTime.now().month, DateTime.now().day),
            time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 10))
        )
    );
    final event3Id = await db.insertEvent(
        EventsCompanion.insert(
          typeId: medTypeId,
          date: DateTime(2025, DateTime.now().month, DateTime.now().day - 1),
          time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0)),
        )
    );
    final event4Id = await db.insertEvent(
        EventsCompanion.insert(
          typeId: sexTypeId,
          date: DateTime(2025, DateTime.now().month - 1, DateTime.now().day - 3),
          time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 30)),
        )
    );
    final event5Id = await db.insertEvent(
        EventsCompanion.insert(
          typeId: medTypeId,
          date: DateTime(2025, DateTime.now().month - 1, DateTime.now().day + 2),
          time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 30)),
        )
    );

    await db.insertEventData(
        EventDataTableCompanion.insert(
          eventId: event1Id,
          rating: 4,
          duration: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 20)),
          userOrgasms: Value(1),
        )
    );
    await db.insertEventData(
        EventDataTableCompanion.insert(
          eventId: event4Id,
          rating: 5,
          duration: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 1, 20)),
          userOrgasms: Value(0),
        )
    );
    await db.insertEventData(
        EventDataTableCompanion.insert(
          eventId: event2Id,
          rating: 5,
          userOrgasms: Value(2),
          didWatchPorn: Value(false),
        )
    );

    await db.insertEventPartner(
        EventsPartnersCompanion.insert(
            eventId: event1Id,
            partnerId: partnerId1,
            partnerOrgasms: Value(0)
        )
    );
    await db.insertEventPartner(
        EventsPartnersCompanion.insert(
            eventId: event4Id,
            partnerId: partnerId1,
            partnerOrgasms: Value(1)
        )
    );
    await db.insertEventPartner(
        EventsPartnersCompanion.insert(
            eventId: event4Id,
            partnerId: partnerId2,
            partnerOrgasms: Value(2)
        )
    );

    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event1Id,
          optionId: cuniOptionId,
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event1Id,
          optionId: chairOptionId,
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event4Id,
          optionId: cuniOptionId,
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event4Id,
          optionId: chairOptionId,
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event3Id,
          optionId: chlamydiaOptionId,
          testStatus: Value(TestStatus.negative),
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event3Id,
          optionId: hpvOptionId,
          testStatus: Value(TestStatus.positive),
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event3Id,
          optionId: herpesOptionId,
          testStatus: Value(TestStatus.waiting),
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event4Id,
          optionId: condomOptionId,
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event4Id,
          optionId: mutualOptionId,
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event4Id,
          optionId: vaginalOptionId,
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event2Id,
          optionId: soloFingeringOptionId,
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event2Id,
          optionId: soloFrottageOptionId,
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event5Id,
          optionId: pregOptionId,
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
            eventId: event5Id,
            optionId: molluscumOptionId,
            testStatus: Value(TestStatus.waiting)
        )
    );
    await db.insertEventOption(
        EventsOptionsCompanion.insert(
          eventId: event5Id,
          optionId: sonoOptionId,
        )
    );
  }
}