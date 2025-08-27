import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'database.steps.dart';

import 'package:lustlist/db/categories.dart';
import 'package:lustlist/db/events.dart';
import 'package:lustlist/db/options.dart';
import 'package:lustlist/db/partners.dart';
import 'package:lustlist/db/sexual_event.dart';
import 'package:lustlist/db/types.dart';
import 'package:lustlist/db/categories_types.dart';
import 'package:lustlist/db/events_options.dart';
import 'package:lustlist/db/events_partners.dart';

part 'database.g.dart';


@DriftDatabase(tables: [Categories, Events, EOptions, Partners, SexualEvent, Types,
                        CategoriesTypes, EventsOptions, EventsPartners])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'll_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Future<List<Type>> get allTypes => select(types).get();
  Future<List<Category>> get allCategories => select(categories).get();
  Future<List<EOption>> get allOptions => select(eOptions).get();
  Future<List<Partner>> get allPartners => select(partners).get();
  Future<List<SexualEventData>> get allSexualEvents => select(sexualEvent).get();
  Future<List<Event>> get allEvents => select(events).get();

  Future<List<CategoryType>> get allCategoriesTypes => select(categoriesTypes).get();
  Future<List<EventOption>> get allEventsOptions => select(eventsOptions).get();
  Future<List<EventPartner>> get allEventsPartners => select(eventsPartners).get();


  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await batch((batch) {
            batch.insertAll(types, [
              TypesCompanion.insert(name: 'Sex'),
              TypesCompanion.insert(name: 'Masturbation'),
              TypesCompanion.insert(name: 'Medical')
            ]);
          });
          await batch((batch) {
            batch.insertAll(categories, [
              CategoriesCompanion.insert(name: 'Contraception'),
              CategoriesCompanion.insert(name: 'Poses'),
              CategoriesCompanion.insert(name: 'Practices'),
              CategoriesCompanion.insert(name: 'Solo Practices'),
              CategoriesCompanion.insert(name: 'Place'),
              CategoriesCompanion.insert(name: 'Location'),
              CategoriesCompanion.insert(name: 'Medical'),
            ]);
          });
        }
    );
  }
}