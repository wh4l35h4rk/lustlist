import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:lustlist/test_status.dart';
import 'package:path_provider/path_provider.dart';

import 'package:lustlist/db/categories.dart';
import 'package:lustlist/db/events.dart';
import 'package:lustlist/db/options.dart';
import 'package:lustlist/db/partners.dart';
import 'package:lustlist/db/event_data.dart';
import 'package:lustlist/db/types.dart';
import 'package:lustlist/db/categories_types.dart';
import 'package:lustlist/db/events_options.dart';
import 'package:lustlist/db/events_partners.dart';
import 'package:lustlist/rowdata.dart';

import 'gender.dart';
part 'database.g.dart';


@DriftDatabase(tables: [Types, Categories, Partners, EventDataTable, Events, EOptions,
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

  Stream<List<Event>> watchAllEvents() => select(events).watch();

  Future<List<Type>> get allTypes => select(types).get();
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

  Future<List<Event>> getEventsByPartnerId(int partnerId) async {
    final query = select(eventsPartners).join([
      innerJoin(events, events.id.equalsExp(eventsPartners.eventId)),
      innerJoin(partners, partners.id.equalsExp(eventsPartners.partnerId))
    ])..where(eventsPartners.partnerId.equals(partnerId));
    final result = await query.get();
    return result.map((row) => row.readTable(events)).toList();
  }


  // Get EventData
  Future<EventData?> getDataById(int id) async {
    return (select(eventDataTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<EventData?> getDataByEventId(int id) async {
    return await (select(eventDataTable)..where((t) => t.eventId.equals(id))).getSingleOrNull();
  }


  // Get Type
  Future<Type> getTypeByEventId(Event event) async {
    return (select(types)..where((t) => t.id.equals(event.typeId))).getSingle();
  }

  Future<int> getTypeIdBySlug(String name) async {
    final query = select(types)..where((t) => t.slug.equals(name));
    final result = await query.getSingleOrNull();
    return result!.id;
  }


  // Get Partners
  Future<Partner> getPartnerById(int id) async {
    return (select(partners)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<Partner>> getPartnersByEventId(int eventId) async {
    final query = select(eventsPartners).join([
      innerJoin(events, events.id.equalsExp(eventsPartners.eventId)),
      innerJoin(partners, partners.id.equalsExp(eventsPartners.partnerId))
    ])..where(eventsPartners.eventId.equals(eventId));
    final result = await query.get();
    return result.map((row) => row.readTable(partners)).toList();
  }

  Future<List<int>> getPartnerOrgasmsListByPartnersList(int eventId, List<Partner> partnersList) async {
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

  Future<List<String>?> getCategoryNamesOfEvent(int eventId) async {
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

  Future<void> updatePartner(int id, PartnersCompanion data) =>
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
        onCreate: (m) async {
          await m.createAll();
          await batch((batch) {
            assert (rowData.typeNames.length == rowData.typeSlugs.length);
            batch.insertAll(types, List<Insertable<Type>>.generate(rowData.typeNames.length, (int index) =>
                TypesCompanion.insert(name: rowData.typeNames[index], slug: rowData.typeSlugs[index]),
            ));

            assert (rowData.categoryNames.length == rowData.categorySlugs.length);
            batch.insertAll(categories, List<Insertable<Category>>.generate(rowData.categoryNames.length, (int index) =>
                CategoriesCompanion.insert(name: rowData.categoryNames[index], slug: rowData.categorySlugs[index]),
            ));
          });


          final sexTypeId = await getTypeIdBySlug('sex');
          final masturbationTypeId = await getTypeIdBySlug('masturbation');
          final medicalTypeId = await getTypeIdBySlug('medical');

          final contraceptionCategoryId = await getCategoryIdBySlug('contraception');
          final posesCategoryId = await getCategoryIdBySlug('poses');
          final practicesCategoryId = await getCategoryIdBySlug('practices');
          final soloPracticesCategoryId = await getCategoryIdBySlug('solo practices');
          final placeCategoryId = await getCategoryIdBySlug('place');
          final stiCategoryId = await getCategoryIdBySlug('sti');
          final obgynCategoryId = await getCategoryIdBySlug('obgyn');


          await batch((batch) {
            batch.insertAll(categoriesTypes, [
              CategoriesTypesCompanion.insert(categoryId: contraceptionCategoryId, typeId: sexTypeId),
              CategoriesTypesCompanion.insert(categoryId: posesCategoryId, typeId: sexTypeId),
              CategoriesTypesCompanion.insert(categoryId: practicesCategoryId, typeId: sexTypeId),
              CategoriesTypesCompanion.insert(categoryId: placeCategoryId, typeId: sexTypeId),
              CategoriesTypesCompanion.insert(categoryId: soloPracticesCategoryId, typeId: masturbationTypeId),
              CategoriesTypesCompanion.insert(categoryId: placeCategoryId, typeId: masturbationTypeId),
              CategoriesTypesCompanion.insert(categoryId: stiCategoryId, typeId: medicalTypeId),
              CategoriesTypesCompanion.insert(categoryId: obgynCategoryId, typeId: medicalTypeId),
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
          });
        }
    );
  }
}