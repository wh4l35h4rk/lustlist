import 'dart:math';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:lustlist/src/config/constants/misc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lustlist/src/config/enums/aggro_type.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/enums/test_status.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/domain/entities/event_duration.dart';
import 'package:lustlist/src/domain/entities/option_rank.dart';
import 'entities/calendar_event.dart';
import 'package:lustlist/src/config/enums/gender.dart';


class EventRepository {
  final AppDatabase db;
  EventRepository(this.db);

  int sortTime(DateTime a, DateTime b) {
    final t1 = DateFormatter.timeOnly(a);
    final t2 = DateFormatter.timeOnly(b);

    if (t1.hour != t2.hour) return t1.hour.compareTo(t2.hour);
    return t1.minute.compareTo(t2.minute);
  }

  int sortDateTime(Event a, Event b) {
    final d1 = DateFormatter.dateOnly(a.date);
    final d2 = DateFormatter.dateOnly(b.date);
    final t1 = DateFormatter.timeOnly(a.date);
    final t2 = DateFormatter.timeOnly(b.date);

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


  DateTime addMonth(DateTime date) {
    var year = date.year + ((date.month + 1) ~/ 12);
    var month = (date.month + 1) % 12;
    var day = date.day;

    if (day > 28) {
      day = min(day, DateTime(year, month + 1, 0).day);
    }
    return DateTime(year, month, day, date.hour, date.minute, date.second, date.millisecond, date.microsecond);
  }


  Future getEventSource() async {
    final allEvents = await db.allEvents;
    List<CalendarEvent> testEventList = [];

    for (var e in allEvents) {
      CalendarEvent event = await dbToCalendarEvent(e);
      testEventList.add(event);
    }
    final eventDates = List.generate(
        testEventList.length,
        (index) => DateFormatter.dateOnly(testEventList[index].event.date)
    );

    final eventMap = {
      for (var date in eventDates)
        date : testEventList.where((element) => DateFormatter.dateOnly(element.event.date) == date).toList()
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

    for (var p in partners){
      if (p.id == unknownPartnerId) {
        partners.remove(p);
        partners.add(p);
      }
    }

    List<int?> partnerOrgasms = await db.getPartnerOrgasmsListByPartnersList(eventId, partners);
    Map<Partner, int?> partnersMap = Map.fromEntries(List.generate(partners.length, (index) =>
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

  
  Future<void> loadEventData(
      int eventId, int rating, EventDuration? duration, int? orgasmAmount,
      bool? didWatchPorn, bool? didUseToys) async {
    EventDuration? fixedDuration = (duration != null && duration.hours == 0 && duration.minutes == 0) ? null : duration;

    await db.insertEventData(
      EventDataTableCompanion.insert(
        eventId: eventId,
        rating: rating,
        duration: Value(fixedDuration?.minutesTotal),
        userOrgasms: Value(orgasmAmount),
        didWatchPorn: Value(didWatchPorn),
        didUseToys: Value(didUseToys)
      ),
    );
  }

  
  Future<void> loadEventPartner(int eventId, int partnerId, int? partnerOrgasms) async {
    await db.insertEventPartner(
        EventsPartnersCompanion.insert(
            eventId: eventId,
            partnerId: partnerId,
            partnerOrgasms: Value(partnerOrgasms)
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


  Future<void> updateEventData(
      int eventId, int rating, EventDuration? duration, int? orgasmAmount, bool? didWatchPorn, bool? didUseToys
  ) async {
    var event = await (db.select(db.events)..where((t) => t.id.equals(eventId))).getSingleOrNull();
    if (event == null) {
      if (kDebugMode) {
        print("No event found with id == $eventId");
      }
      return;
    }

    EventDuration? fixedDuration = (duration != null && duration.hours == 0 && duration.minutes == 0) ? null : duration;

    await db.updateEventDataByEventId(
      eventId,
      EventDataTableCompanion(
          rating: Value(rating),
          duration: Value(fixedDuration?.minutesTotal),
          userOrgasms: Value(orgasmAmount),
          didWatchPorn: Value(didWatchPorn),
          didUseToys: Value(didUseToys)
      ),
    );
  }


  Future<int> loadPartner(String name, Gender gender, DateTime? birthday, String notes) async {
    int partnerId = await db.insertPartner(
      PartnersCompanion.insert(
        name: name,
        gender: gender,
        birthday: Value(birthday),
        notes: Value(notes),
      )
    );
    return partnerId;
  }

  
  Future<Map<DateTime, int>> getEventAmountAfterDate(String typeSlug, DateTime afterDate) async {
    int typeId = await db.getTypeIdBySlug(typeSlug);
    Map<DateTime, int> map = await db.getEventsAmountAfterDateGroupByMonth(typeId, afterDate);
    return map;
  }

  Future<List<FlSpot>> getSpotsListByMonth(String typeSlug, DateTime period) async {
    // get date range from current datetime and period
    DateTime date2 = DateTime.now();
    DateTime date1 = DateTime(
      date2.year - period.year,
      date2.month - period.month,
      date2.day - period.day,
    );

    // form list of months to be displayed on X-axis of chart
    List<DateTime> dates = [];
    DateTime dummyDate = addMonth(date1);
    dummyDate = DateFormatter.yearMonthOnly(dummyDate);
    while (dummyDate.isBefore(date2) || dummyDate.isAtSameMomentAs(date2)) {
      dates.add(dummyDate);
      DateTime newDate = addMonth(dummyDate);
      newDate = DateFormatter.yearMonthOnly(newDate);
      dummyDate = newDate;
    }

    // get map of amount of events corresponding to their time period
    var dbMap = await getEventAmountAfterDate(typeSlug, date1);
    var formattedMap = {};
    for (var k in dbMap.keys) {
      DateTime key = DateFormatter.yearMonthOnly(k);
      formattedMap[key] = dbMap[k]!;
    }

    // if there are events in a month, write them to map, otherwise write zero
    List<FlSpot> list = [];
    for (var d in dates){
      d = DateFormatter.yearMonthOnly(d);
      if (formattedMap[d] != null) {
        list.add(FlSpot(d.millisecondsSinceEpoch.toDouble(), formattedMap[d]!.toDouble()));
      } else {
        list.add(FlSpot(d.millisecondsSinceEpoch.toDouble(), 0));
      }
    }
    return list;
  }


  Future<double?> getAvgDuration(String typeSlug) async {
    int typeId = await db.getTypeIdBySlug(typeSlug);
    double? avg = await db.getAvgDuration(typeId);
    return avg;
  }

  Future<int?> getTotalDuration(String typeSlug) async {
    int typeId = await db.getTypeIdBySlug(typeSlug);
    int? total = await db.getTotalDuration(typeId);
    return total;
  }

  Future<CalendarEvent?> getMaxOrMinDurationCalendarEvent(String typeSlug, AggroType agg) async {
    int typeId = await db.getTypeIdBySlug(typeSlug);
    List<Event?> list = (agg == AggroType.max)
        ? await db.getMaxDurationEvents(typeId)
        : await db.getMinDurationEvents(typeId);
    if (list.isEmpty || list.first == null) {
      return null;
    } else {
      Event randomItem = (list..shuffle()).first!;
      CalendarEvent event = await dbToCalendarEvent(randomItem);
      return event;
    }
  }


  Future<int> getUserOrgasmsAmount(String typeSlug) async {
    int typeId = await db.getTypeIdBySlug(typeSlug);
    int? amount = await db.countUserOrgasms(typeId);
    return amount ?? 0;
  }

  Future<int> getPartnersOrgasmsAmount() async {
    int? amount = await db.countPartnersAmount();
    return amount ?? 0;
  }

  Future<int> getEventsWithPornAmount() async {
    int? amount = await db.countSoloWithPorn();
    print(amount);
    return amount ?? 0;
  }

  Future<int> getEventsWithToysAmount() async {
    int? amount = await db.countSoloWithToys();
    return amount ?? 0;
  }

  Future<int> countEventsOfType(String typeSlug) async {
    int typeId = await db.getTypeIdBySlug(typeSlug);
    int? amount = await db.countEventsOfType(typeId);
    print(amount);
    return amount ?? 0;
  }


  Future<List<EOption>> getOptionsList(int eventId, String categorySlug) async {
    int categoryId = await db.getCategoryIdBySlug(categorySlug);
    List<EOption> options = await db.getEventOptionsByCategory(eventId, categoryId);
    return options;
  }

  Future<List<OptionRank>?> getOptionsRanked({
    required String categorySlug,
    int limit = 5,
    bool isReversed = false
  }) async {
    int categoryId = await db.getCategoryIdBySlug(categorySlug);
    List<OptionRank> values = await db.getTopOptionsInCategory(categoryId, limit, isReversed);

    values.sort((a, b) {
      int aValue = isReversed ? a.value : -1 * a.value;
      int bValue = isReversed ? b.value : -1 * b.value;
      return aValue.compareTo(bValue);
    });
    return values;
  }



  Future<DateTime> getPartnerLastEventDate(int partnerId) async {
    List<Event> events = await db.getEventsByPartnerId(partnerId);
    if (events.isEmpty) return defaultDate;
    events.sort(sortDateTime);
    return events.last.date;
  }

  Future<List<Partner>> getPartnersSorted(bool withUnknown) async {
    List<Partner> partners = await db.allPartners;
    final unknownPartner = await getUnknownPartner();

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

    if (unknownPartner != null) {
      partners.remove(unknownPartner);
      if (withUnknown) {
        partners.add(unknownPartner);
      }
    }

    return partners;
  }

  Future<Partner?> getUnknownPartner() async {
    return await (db.select(db.partners)..where((t) => t.id.equals(unknownPartnerId))).getSingleOrNull();
  }


  Future updatePartner(int id, String name, Gender gender, DateTime? birthday, String notes) async {
    await db.updatePartnerRaw(
      id,
      PartnersCompanion(
        name: Value(name),
        gender: Value(gender),
        birthday: Value(birthday),
        notes: Value(notes),
      ),
    );
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
          date: DateTime(DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
          time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 11, 20)),
          notes: Value("The following is a partial list of minor planets, running from minor-planet number 571001 through 572000, inclusive. The primary data for this and other partial lists is based on JPL's Small-Body Orbital Elements and data available from the Minor Planet Center. Critical list information is also provided by the MPC, unless otherwise specified from Lowell Observatory. A detailed description of the table's columns and additional sources are given on the main page including a complete list of every page in this series, and a statistical break-up on the dynamical classification of minor planets."),
        )
    );
    final event2Id = await db.insertEvent(
        EventsCompanion.insert(
            typeId: mstbTypeId,
            date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
            time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 10))
        )
    );
    final event3Id = await db.insertEvent(
        EventsCompanion.insert(
          typeId: medTypeId,
          date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
          time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0)),
        )
    );
    final event4Id = await db.insertEvent(
        EventsCompanion.insert(
          typeId: sexTypeId,
          date: DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day - 3),
          time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 30)),
        )
    );
    final event5Id = await db.insertEvent(
        EventsCompanion.insert(
          typeId: medTypeId,
          date: DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day + 2),
          time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 30)),
        )
    );
    final event6Id = await db.insertEvent(
        EventsCompanion.insert(
          typeId: sexTypeId,
          date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3),
          time: Value(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 30)),
        )
    );

    await db.insertEventData(
        EventDataTableCompanion.insert(
          eventId: event1Id,
          rating: 4,
          duration: Value(20),
          userOrgasms: Value(1),
        )
    );
    await db.insertEventData(
        EventDataTableCompanion.insert(
          eventId: event4Id,
          rating: 5,
          duration: Value(90),
          userOrgasms: Value(0),
        )
    );
    await db.insertEventData(
        EventDataTableCompanion.insert(
          eventId: event2Id,
          rating: 5,
          userOrgasms: Value(2),
          didWatchPorn: Value(false),
          didUseToys: Value(false),
        )
    );
    await db.insertEventData(
        EventDataTableCompanion.insert(
          eventId: event6Id,
          rating: 4,
          userOrgasms: Value(1),
          duration: Value(40),
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
    await db.insertEventPartner(
        EventsPartnersCompanion.insert(
            eventId: event6Id,
            partnerId: partnerId3,
            partnerOrgasms: Value(0)
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