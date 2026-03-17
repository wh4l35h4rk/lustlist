import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:lustlist/src/config/constants/misc.dart';
import 'package:lustlist/src/config/enums/type.dart';
import 'package:lustlist/src/config/enums/test_status.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/domain/entities/option_rank.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lustlist/src/database/tables/categories.dart';
import 'package:lustlist/src/database/tables/events.dart';
import 'package:lustlist/src/database/tables/options.dart';
import 'package:lustlist/src/database/tables/partners.dart';
import 'package:lustlist/src/database/tables/event_data.dart';
import 'package:lustlist/src/database/tables/categories_types.dart';
import 'package:lustlist/src/database/tables/events_options.dart';
import 'package:lustlist/src/database/tables/events_partners.dart';
import 'package:lustlist/src/config/strings/rowdata.dart';
import 'package:lustlist/src/config/enums/gender.dart';
part 'database.g.dart';


@DriftDatabase(tables: [Categories, Partners, EventDataTable, Events, EOptions,
                        CategoriesTypes, EventsOptions, EventsPartners])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;
  
  final rowData = RowData();

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'll_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Future<List<Category>> get allCategories => select(categories).get();
  Future<List<EOption>> get allOptions => select(eOptions).get();
  Future<List<Partner>> get allPartners => select(partners).get();
  Future<List<EventData>> get allEventData => select(eventDataTable).get();
  Future<List<Event>> get allEvents => select(events).get();

  Future<List<CategoryType>> get allCategoriesTypes => select(categoriesTypes).get();
  Future<List<EventOption>> get allEventsOptions => select(eventsOptions).get();
  Future<List<EventPartner>> get allEventsPartners => select(eventsPartners).get();


  // READ:
  // Get Event
  Future<Event> getEventById(int id) async {
    return (select(events)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<int?> countEventsOfType(EventType type) async {
    final query = select(events)
      ..where((e) => e.type.equals(type.index));
    final result = await query.get();
    return result.length;
  }

  Future<List<Event>> getEventsByPartnerId(int partnerId) async {
    final query = select(eventsPartners).join([
      innerJoin(events, events.id.equalsExp(eventsPartners.eventId)),
      innerJoin(partners, partners.id.equalsExp(eventsPartners.partnerId))
    ])..where(eventsPartners.partnerId.equals(partnerId));

    final result = await query.get();
    return result.map((row) => row.readTable(events)).toList();
  }

  Future<List<Event?>> getMaxDurationEvents(EventType type) async {
    final maxDuration = eventDataTable.duration.max();

    final query = select(eventDataTable).join([
      innerJoin(events, events.id.equalsExp(eventDataTable.eventId))
    ])..where(events.type.equals(type.index));
    query.addColumns([maxDuration]);

    final result = await query.get();
    return result.map((row) => row.readTableOrNull(events)).toList();
  }

  Future<List<Event?>> getMinDurationEvents(EventType type) async {
    final minDuration = eventDataTable.duration.min();

    final query = select(eventDataTable).join([
      innerJoin(events, events.id.equalsExp(eventDataTable.eventId))
    ])..where(events.type.equals(type.index));
    query.addColumns([minDuration]);

    final result = await query.get();
    return result.map((row) => row.readTableOrNull(events)).toList();
  }

  Future<Map<DateTime, int>> getEventsAmountAfterDateGroupByMonth(EventType type, DateTime date) async {
    final amountOfEvents = events.id.count();
    final eventsYear = events.date.year;
    final eventsMonth = events.date.month;

    final query = selectOnly(events)
      ..addColumns([eventsYear, eventsMonth, amountOfEvents])
      ..where(events.type.equals(type.index))
      ..where(events.date.isBiggerThanValue(date))
      ..groupBy([eventsYear, eventsMonth]);
    final result = await query.get();

    Map<DateTime, int> resultMap = {};
    for (final row in result) {
      final amount = row.read(amountOfEvents);
      final year = row.read(eventsYear);
      final month = row.read(eventsMonth);
      if (year != null && month != null && amount != null) {
        resultMap[DateTime(year, month)] = amount;
      }
    }
    return resultMap;
  }

  Future<Map<DateTime, int>> getEventsAmountAfterDateGroupByDay(EventType type, DateTime date) async {
    final amountOfEvents = events.id.count();
    final eventsYear = events.date.year;
    final eventsMonth = events.date.month;
    final eventsDay = events.date.day;

    final query = selectOnly(events)
      ..where(events.type.equals(type.index))
      ..where(events.date.isBiggerThanValue(date));
    
    query
      ..addColumns([eventsYear, eventsMonth, eventsDay, amountOfEvents])
      ..groupBy([events.type, eventsYear, eventsMonth, eventsDay]);

    final result = await query.get();

    Map<DateTime, int> resultMap = {};
    for (final row in result) {
      int? amount = row.read(amountOfEvents);
      int? year = row.read(eventsYear);
      int? month = row.read(eventsMonth);
      int? day = row.read(eventsDay);
      if (year != null && month != null && day != null && amount != null) {
        DateTime date = DateTime(year, month, day);
        resultMap[date] = amount;
      }
    }
    return resultMap;
  }

  Future<Map<DateTime, int>> getEventsAmountGroupByYear(EventType type) async {
    final amountOfEvents = events.id.count();
    final eventsYear = events.date.year;

    final query = selectOnly(events)
      ..where(events.type.equals(type.index));
    query
      ..addColumns([eventsYear, amountOfEvents])
      ..groupBy([events.type, eventsYear]);

    final result = await query.get();

    Map<DateTime, int> resultMap = {};
    for (final row in result) {
      int? amount = row.read(amountOfEvents);
      int? year = row.read(eventsYear);
      if (year != null && amount != null) {
        DateTime date = DateTime(year);
        resultMap[date] = amount;
      }
    }
    return resultMap;
  }


  // Get EventData
  Future<EventData?> getDataById(int id) async {
    return (select(eventDataTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<EventData?> getDataByEventId(int id) async {
    return await (select(eventDataTable)..where((t) => t.eventId.equals(id))).getSingleOrNull();
  }

  Future<double?> getAvgDuration(EventType type) async {
    final avgDuration = eventDataTable.duration.avg();

    final query = select(eventDataTable).join([
      innerJoin(events, events.id.equalsExp(eventDataTable.eventId))
    ])..where(events.type.equals(type.index));
    query.addColumns([avgDuration]);

    return query.map((row) => row.read(avgDuration)).getSingleOrNull();
  }

  Future<int?> getTotalDuration(EventType type) async {
    final totalDuration = eventDataTable.duration.sum();

    final query = select(eventDataTable).join([
      innerJoin(events, events.id.equalsExp(eventDataTable.eventId))
    ])..where(events.type.equals(type.index));
    query.addColumns([totalDuration]);

    return query.map((row) => row.read(totalDuration)).getSingleOrNull();
  }

  Future<int?> countUserOrgasms(EventType type) async {
    final totalAmount = eventDataTable.userOrgasms.sum();

    final query = select(eventDataTable).join([
      innerJoin(events, events.id.equalsExp(eventDataTable.eventId))
    ])..where(events.type.equals(type.index));
    query.addColumns([totalAmount]);

    return query.map((row) => row.read(totalAmount)).getSingleOrNull();
  }

  Future<int?> countPartnersAmount() async {
    final totalAmount = eventsPartners.partnerOrgasms.sum();

    final query = select(eventsPartners).join([
      innerJoin(events, events.id.equalsExp(eventsPartners.eventId))
    ]);
    query.addColumns([totalAmount]);

    return query.map((row) => row.read(totalAmount)).getSingleOrNull();
  }

  Future<int?> countEventsWithOption(String optionSlug) async {
    final optionId = await getOptionIdBySlug(optionSlug);
    final amount = events.id.count();

    final query = select(events).join([
      innerJoin(eventsOptions, events.id.equalsExp(eventsOptions.eventId))
    ])..where(eventsOptions.optionId.equals(optionId));
    query.addColumns([amount]);

    return query.map((row) => row.read(amount)).getSingleOrNull();
  }

  // Get Partners
  Future<Partner> getPartnerById(int id) async {
    return (select(partners)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<Partner>> getAllVisiblePartners() async {
    return (select(partners)..where((t) => t.isVisible.equals(true))).get();
  }

  Future<List<Partner>> getPartnersByEventId(int eventId) async {
    final query = select(eventsPartners).join([
      innerJoin(events, events.id.equalsExp(eventsPartners.eventId)),
      innerJoin(partners, partners.id.equalsExp(eventsPartners.partnerId))
    ])..where(eventsPartners.eventId.equals(eventId));
    final result = await query.get();
    return result.map((row) => row.readTable(partners)).toList();
  }

  Future<List<int?>> getPartnerOrgasmsListByPartnersList(int eventId, List<Partner> partnersList) async {
    final result = await Future.wait(List.generate(partnersList.length, (ii) async =>
      await (select(eventsPartners)..where((t) =>
      t.eventId.equals(eventId) & t.partnerId.equals(partnersList[ii].id))).getSingle()));
    return List.generate(partnersList.length, (ii) => result[ii].partnerOrgasms);
  }

  Future<int?> getPartnerOrgasm(int eventId, int partnerId) async {
    final result = await (select(eventsPartners)..where((t) => t.eventId.equals(eventId) & t.partnerId.equals(partnerId))).getSingleOrNull();
    return result?.partnerOrgasms;
  }

  // Get Category
  Future<String> getCategoryName(int id) async {
    final result = await (select(categories)..where((t) => t.id.equals(id))).getSingle();
    return result.name;
  }

  Future<String> getCategorySlug(int id) async {
    final result = await (select(categories)..where((t) => t.id.equals(id))).getSingle();
    return result.slug;
  }

  Future<int> getCategoryIdBySlug(String name) async {
    final query = select(categories)..where((t) => t.slug.equals(name));
    final result = await query.getSingleOrNull();
    return result!.id;
  }

  Future<List<String?>?> getCategoryNamesOfEvent(int eventId) async {
    final options = await getOptionsByEventId(eventId);
    if (options.isNotEmpty){
      final categoryNames = await Future.wait(
          List.generate(options.length, (index) async => await getCategoryName(options[index].categoryId))
      );
      final distinctCategoryNames = categoryNames.toSet().toList();
      return distinctCategoryNames;
    } else {
      return null;
    }
  }

  Future<List<String>?> getCategorySlugsOfEvent(int eventId) async {
    final options = await getOptionsByEventId(eventId);
    if (options.isNotEmpty){
      final categorySlugs = await Future.wait(
          List.generate(options.length, (index) async => await getCategorySlug(options[index].categoryId))
      );
      final distinctCategoryNames = categorySlugs.toSet().toList();
      return distinctCategoryNames;
    } else {
      return null;
    }
  }


  // Get Options
  Future<int> getOptionIdBySlug(String name) async {
    final query = select(eOptions)..where((t) => t.slug.equals(name));
    final result = await query.getSingleOrNull();
    return result!.id;
  }

  Future<EOption> getOption(int id) async {
    final query = select(eOptions)..where((t) => t.id.equals(id));
    final result = await query.getSingleOrNull();
    return result!;
  }

  Future<List<EOption>> getOptionsByCategory(int categoryId) async {
    final query = select(eOptions)..where((t) => t.categoryId.equals(categoryId) & t.isVisible);
    final result = await query.get();
    return result;
  }

  Future<List<EOption>> getOptionsByEventId(int eventId) async {
    final query = select(eventsOptions).join([
      innerJoin(events, events.id.equalsExp(eventsOptions.eventId)),
      innerJoin(eOptions, eOptions.id.equalsExp(eventsOptions.optionId))
    ])..where(eventsOptions.eventId.equals(eventId));
    final result = await query.get();
    return result.map((row) => row.readTable(eOptions)).toList();
  }

  Future<List<EOption>> getEventOptionsByCategory(int eventId, int categoryId) async {
    final query = select(eventsOptions).join([
      innerJoin(events, events.id.equalsExp(eventsOptions.eventId)),
      innerJoin(eOptions, eOptions.id.equalsExp(eventsOptions.optionId)),
    ])..where(eventsOptions.eventId.equals(eventId) & eOptions.categoryId.equals(categoryId));
    final result = await query.get();
    return result.map((row) => row.readTable(eOptions)).toList();
  }

  Future<bool> checkOptionEvent(int eventId, int optionId) async {
    final query = select(eventsOptions)..where(
        (t) => t.eventId.equals(eventId) & t.optionId.equals(optionId));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  Future<TestStatus?> getTestResult(int eventId, int optionId) async {
    final result = await (select(eventsOptions)..where((t) =>
      t.eventId.equals(eventId) & t.optionId.equals(optionId))).getSingle();
    return result.testStatus;
  }
  
  Future<List<OptionRank>> getTopOptionsInCategory(int categoryId, int limit, bool isReversed) async {
    final amountOfOccurrence = eOptions.id.count();
    
    final query = select(eventsOptions).join([
      innerJoin(
        eOptions, 
        eOptions.id.equalsExp(eventsOptions.optionId),
      ),
    ])..where(eOptions.categoryId.equals(categoryId));

    query
      ..addColumns([amountOfOccurrence])
      ..groupBy([eOptions.id])
      ..orderBy([isReversed ? OrderingTerm.asc(amountOfOccurrence) : OrderingTerm.desc(amountOfOccurrence)])
      ..limit(limit);

    final result = await query.get();

    List<OptionRank> resultList = [];
    for (final row in result) {
      int? optionId = row.read(eOptions.id);
      String? displayedName = row.read(eOptions.name);
      int? amount = row.read(amountOfOccurrence);
      if (optionId != null && displayedName != null && amount != null) {
        resultList.add(OptionRank(displayedName, amount));
      }
    }
    return resultList;
  }


  // INSERT:
  Future<int> insertEvent(EventsCompanion data) => into(events).insert(data);

  Future<int> insertOption(EOptionsCompanion data) => into(eOptions).insert(data);

  Future<int> insertPartner(PartnersCompanion data) => into(partners).insert(data);

  Future<int> insertEventData(EventDataTableCompanion data) => into(eventDataTable).insert(data);

  Future<int> insertEventPartner(EventsPartnersCompanion data) => into(eventsPartners).insert(data);

  Future<int> insertEventOption(EventsOptionsCompanion data) => into(eventsOptions).insert(data);


  // UPDATE:
  Future<void> updateEventRaw(int id, EventsCompanion data) =>
      (update(events)..where((t) => t.id.equals(id))).write(data);

  Future<void> updateEventDataByEventId(int eventId, EventDataTableCompanion data) =>
      (update(eventDataTable)..where((t) => t.eventId.equals(eventId))).write(data);

  Future<void> updatePartnerRaw(int id, PartnersCompanion data) =>
      (update(partners)..where((t) => t.id.equals(id))).write(data);


  // DELETE:
  Future deleteEvent(int eventId) async {
    await (delete(events)..where((t) => t.id.equals(eventId))).go();
  }

  Future<void> deleteEventPartners(int eventId) async {
    await (delete(eventsPartners)..where((t) => t.eventId.equals(eventId))).go();
  }

  Future<void> deleteEventOptions(int eventId) async {
    await (delete(eventsOptions)..where((t) => t.eventId.equals(eventId))).go();
  }

  Future deletePartner(int partnerId) async {
    await (delete(partners)..where((t) => t.id.equals(partnerId))).go();
  }


  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
        onCreate: (m) async {
          await m.createAll();
          await batch((batch) {
            assert (rowData.categoryNames.length == rowData.categorySlugs.length);
            batch.insertAll(categories, List<Insertable<Category>>.generate(rowData.categoryNames.length, (int index) =>
                CategoriesCompanion.insert(name: rowData.categoryNames[index], slug: rowData.categorySlugs[index]),
            ));
          });

          final contraceptionCategoryId = await getCategoryIdBySlug('contraception');
          final posesCategoryId = await getCategoryIdBySlug('poses');
          final practicesCategoryId = await getCategoryIdBySlug('practices');
          final ejaculationCategoryId = await getCategoryIdBySlug('ejaculation');
          final soloPracticesCategoryId = await getCategoryIdBySlug('solo practices');
          final placeCategoryId = await getCategoryIdBySlug('place');
          final complicaciesCategoryId = await getCategoryIdBySlug('complicacies');
          final stiCategoryId = await getCategoryIdBySlug('sti');
          final obgynCategoryId = await getCategoryIdBySlug('obgyn');


          await batch((batch) {
            batch.insertAll(categoriesTypes, [
              CategoriesTypesCompanion.insert(categoryId: contraceptionCategoryId, type: EventType.sex),
              CategoriesTypesCompanion.insert(categoryId: posesCategoryId, type: EventType.sex),
              CategoriesTypesCompanion.insert(categoryId: practicesCategoryId, type: EventType.sex),
              CategoriesTypesCompanion.insert(categoryId: placeCategoryId, type: EventType.sex),
              CategoriesTypesCompanion.insert(categoryId: ejaculationCategoryId, type: EventType.sex),
              CategoriesTypesCompanion.insert(categoryId: complicaciesCategoryId, type: EventType.sex),
              CategoriesTypesCompanion.insert(categoryId: soloPracticesCategoryId, type: EventType.masturbation),
              CategoriesTypesCompanion.insert(categoryId: placeCategoryId, type: EventType.masturbation),
              CategoriesTypesCompanion.insert(categoryId: complicaciesCategoryId, type: EventType.masturbation),
              CategoriesTypesCompanion.insert(categoryId: stiCategoryId, type: EventType.medical),
              CategoriesTypesCompanion.insert(categoryId: obgynCategoryId, type: EventType.medical),
            ]);

            assert (rowData.contraceptionOptionNames.length == rowData.contraceptionOptionSlugs.length);
            batch.insertAll(eOptions,
              List<Insertable<EOption>>.generate(rowData.contraceptionOptionNames.length, (int index) =>
                EOptionsCompanion.insert(
                  name: rowData.contraceptionOptionNames[index],
                  slug: rowData.contraceptionOptionSlugs[index],
                  categoryId: contraceptionCategoryId
                )),
            );

            assert (rowData.posesOptionNames.length == rowData.posesOptionSlugs.length);
            batch.insertAll(eOptions,
              List<Insertable<EOption>>.generate(rowData.posesOptionNames.length, (int index) =>
                EOptionsCompanion.insert(
                  name: rowData.posesOptionNames[index],
                  slug: rowData.posesOptionSlugs[index],
                  categoryId: posesCategoryId
                )),
            );

            assert (rowData.practicesOptionNames.length == rowData.practicesOptionSlugs.length);
            batch.insertAll(eOptions,
              List<Insertable<EOption>>.generate(rowData.practicesOptionNames.length, (int index) =>
                EOptionsCompanion.insert(
                    name: rowData.practicesOptionNames[index],
                    slug: rowData.practicesOptionSlugs[index],
                    categoryId: practicesCategoryId
                )),
            );

            assert (rowData.placeOptionNames.length == rowData.placeOptionSlugs.length);
            batch.insertAll(eOptions,
              List<Insertable<EOption>>.generate(rowData.placeOptionNames.length, (int index) =>
                EOptionsCompanion.insert(
                    name: rowData.placeOptionNames[index],
                    slug: rowData.placeOptionSlugs[index],
                    categoryId: placeCategoryId
                )),
            );

            assert (rowData.complicaciesOptionNames.length == rowData.complicaciesOptionSlugs.length);
            batch.insertAll(eOptions,
              List<Insertable<EOption>>.generate(rowData.complicaciesOptionNames.length, (int index) =>
                  EOptionsCompanion.insert(
                      name: rowData.complicaciesOptionNames[index],
                      slug: rowData.complicaciesOptionSlugs[index],
                      categoryId: complicaciesCategoryId
                  )),
            );

            assert (rowData.ejaculationOptionNames.length == rowData.ejaculationOptionSlugs.length);
            batch.insertAll(eOptions,
              List<Insertable<EOption>>.generate(rowData.ejaculationOptionNames.length, (int index) =>
                  EOptionsCompanion.insert(
                      name: rowData.ejaculationOptionNames[index],
                      slug: rowData.ejaculationOptionSlugs[index],
                      categoryId: ejaculationCategoryId
                  )),
            );

            assert (rowData.soloPracticesOptionNames.length == rowData.soloPracticesOptionSlugs.length);
            batch.insertAll(eOptions,
              List<Insertable<EOption>>.generate(rowData.soloPracticesOptionNames.length, (int index) =>
                EOptionsCompanion.insert(
                    name: rowData.soloPracticesOptionNames[index],
                    slug: rowData.soloPracticesOptionSlugs[index],
                    categoryId: soloPracticesCategoryId
                )),
            );

            assert (rowData.stiOptionNames.length == rowData.stiOptionSlugs.length);
            batch.insertAll(eOptions,
              List<Insertable<EOption>>.generate(rowData.stiOptionNames.length, (int index) =>
                EOptionsCompanion.insert(
                    name: rowData.stiOptionNames[index],
                    slug: rowData.stiOptionSlugs[index],
                    categoryId: stiCategoryId
                )),
            );

            assert (rowData.obgynOptionNames.length == rowData.obgynOptionSlugs.length);
            batch.insertAll(eOptions,
              List<Insertable<EOption>>.generate(rowData.obgynOptionNames.length, (int index) =>
                  EOptionsCompanion.insert(
                      name: rowData.obgynOptionNames[index],
                      slug: rowData.obgynOptionSlugs[index],
                      categoryId: obgynCategoryId
                  )),
            );

            batch.insert(partners,
              PartnersCompanion.insert(
                id: Value(unknownPartnerId),
                name: MiscStrings.unknownPartnerName,
                gender: Gender.unknown,
                isVisible: Value(false),
              )
            );
          });
        }
    );
  }
}