import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:lustlist/src/config/enums/aggro_type.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/domain/entities/events_amount_data.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';


extension EventRepositoryChart on EventRepository {
  DateTime addMonth(DateTime date) {
    final newMonth = date.month == 12 ? 1 : date.month + 1;
    final newYear = date.month == 12 ? date.year + 1 : date.year;

    final lastDay = DateTime(newYear, newMonth + 1, 0).day;
    final day = min(date.day, lastDay);

    return DateTime(
      newYear,
      newMonth,
      day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );
  }

  DateTime startDateInPeriod(DateTime endDate, Duration period) {
    DateTime startDate = endDate.subtract(period);
    return startDate;
  }

  List<DateTime> makeDateListInPeriod(DateTime date1, Function nextDateFunction, Function formatter) {
    // get date range from current datetime and period
    DateTime date2 = DateTime.now();

    // form list of dates to be displayed on X-axis of chart
    List<DateTime> dates = [];
    DateTime dummyDate = nextDateFunction(date1);
    dummyDate = formatter(dummyDate);
    while (dummyDate.isBefore(date2) || dummyDate.isAtSameMomentAs(date2)) {
      dates.add(dummyDate);
      DateTime newDate = nextDateFunction(dummyDate);
      newDate = formatter(newDate);
      dummyDate = newDate;
    }
    return dates;
  }

  Map<K, V> formatMapKeys<K, V>(Map<K, V> map, Function formatter) {
    Map<K, V> formattedMap = {};
    for (var k in map.keys) {
      final key = formatter(k);
      formattedMap[key] = map[k]!;
    }
    return formattedMap;
  }

  double getDefaultValue(List<int> data){
    double emptyValue = 1 / 30;
    if (data.isEmpty) return emptyValue;

    data.sort();
    var maxValue = data.last;
    if (maxValue == 0) return emptyValue;

    var defaultValue = maxValue / 30;
    return defaultValue;
  }

  DateTime oneYearAgo(DateTime now) {
    return DateTime(
      now.year - 1,
      now.month,
      min(
        now.day,
        DateTime(now.year - 1, now.month + 1, 0).day,
      ),
      now.hour,
      now.minute,
      now.second,
      now.millisecond,
      now.microsecond,
    );
  }

  Future<List<FlSpot>> getSpotsListByMonth(String typeSlug) async {
    Function formatter = DateFormatter.yearMonthOnly;

    DateTime startDate = oneYearAgo(DateTime.now());
    List<DateTime> dates = makeDateListInPeriod(startDate, addMonth, formatter);

    // get map of amount of events corresponding to their time period
    int typeId = await db.getTypeIdBySlug(typeSlug);
    var map = await db.getEventsAmountAfterDateGroupByMonth(typeId, startDate);
    map = formatMapKeys(map, formatter);

    // if there are events in a month, write them to map, otherwise write zero
    List<FlSpot> list = [];
    for (var d in dates){
      d = formatter(d);
      list.add(FlSpot(
        d.millisecondsSinceEpoch.toDouble(),
        map[d] != null ? map[d]!.toDouble() : 0
      ));
    }
    return list;
  }


  Future<List<EventsAmountData>> getEventAmountListByDay(Duration period) async {
    Function formatDate = DateFormatter.dateOnly;

    DateTime startDate = startDateInPeriod(DateTime.now(), period);
    List<DateTime> dates = makeDateListInPeriod(
        startDate,
        (DateTime date) => date.add(const Duration(hours: 24)),
        formatDate
    );

    // get map of amount of events corresponding to their time period
    int sexTypeId = await db.getTypeIdBySlug("sex");
    int mstbTypeId = await db.getTypeIdBySlug("masturbation");
    var sexMap = await db.getEventsAmountAfterDateGroupByDay(sexTypeId, startDate);
    var mstbMap = await db.getEventsAmountAfterDateGroupByDay(mstbTypeId, startDate);

    sexMap = formatMapKeys(sexMap, formatDate);
    mstbMap = formatMapKeys(mstbMap, formatDate);

    // if there are events in a day, write amount to list of values, otherwise write zero
    List<EventsAmountData> list = [];
    List<int> listValues = [];
    for (var d in dates){
      listValues.add(sexMap[d] != null ? sexMap[d]!.toInt() : 0);
      listValues.add(mstbMap[d] != null ? mstbMap[d]!.toInt() : 0);
    }
    var defaultValue = getDefaultValue(listValues);

    // if there are events in a day, write amount to list, otherwise write default value
    for (var d in dates){
      list.add(
        EventsAmountData(
          d.millisecondsSinceEpoch.toDouble(),
          sexMap[d] != null ? sexMap[d]!.toDouble() : defaultValue,
          mstbMap[d] != null ? mstbMap[d]!.toDouble() : defaultValue,
        ));
    }
    return list;
  }


  Future<List<EventsAmountData>> getEventAmountYearly() async {
    Function formatDate = DateFormatter.yearOnly;

    // get map of amount of events corresponding to their year
    int sexTypeId = await db.getTypeIdBySlug("sex");
    int mstbTypeId = await db.getTypeIdBySlug("masturbation");
    var sexMap = await db.getEventsAmountGroupByYear(sexTypeId);
    var mstbMap = await db.getEventsAmountGroupByYear(mstbTypeId);

    sexMap = formatMapKeys(sexMap, formatDate);
    mstbMap = formatMapKeys(mstbMap, formatDate);

    List<DateTime> yearsList = [];
    List<int> valuesList = [];

    for (var key in sexMap.keys) {
      DateTime keyYear = formatDate(key);
      int keyValue = sexMap[key]!;
      sexMap[keyYear] = keyValue;

      // filling possible missing years in db
      if (yearsList.isNotEmpty) {
        DateTime lastYear = yearsList.last;
        DateTime nextYear = DateTime(lastYear.year + 1);
        while (nextYear.year < keyYear.year) {
          yearsList.add(nextYear);
          valuesList.add(0);

          nextYear = DateTime(nextYear.year + 1);
        }
      }
      yearsList.add(keyYear);
      valuesList.add(keyValue);
    }

    for (var key in mstbMap.keys) {
      DateTime keyYear = formatDate(key);
      int keyValue = mstbMap[key]!;
      mstbMap[keyYear] = keyValue;

      if (yearsList.isNotEmpty) {
        DateTime lastYear = yearsList.last;
        DateTime nextYear = DateTime(lastYear.year + 1);
        while (nextYear.year < keyYear.year) {
          yearsList.add(nextYear);
          valuesList.add(0);

          nextYear = DateTime(nextYear.year + 1);
        }
      }
      yearsList.add(keyYear);
      valuesList.add(keyValue);
    }
    yearsList = yearsList.toSet().toList();
    yearsList.sort();
    var defaultValue = getDefaultValue(valuesList);


    // if there are events in a year, write amount to list, otherwise write default value
    List<EventsAmountData> list = [];
    for (var year in yearsList){
      list.add(
          EventsAmountData(
            year.millisecondsSinceEpoch.toDouble(),
            sexMap[year] != null ? sexMap[year]!.toDouble() : defaultValue,
            mstbMap[year] != null ? mstbMap[year]!.toDouble() : defaultValue,
          )
      );
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
    return amount ?? 0;
  }

  Future<int> getEventsWithToysAmount() async {
    int? amount = await db.countSoloWithToys();
    return amount ?? 0;
  }

  Future<int> countEventsOfType(String typeSlug) async {
    int typeId = await db.getTypeIdBySlug(typeSlug);
    int? amount = await db.countEventsOfType(typeId);
    return amount ?? 0;
  }
}