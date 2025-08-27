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

  // @override
  // MigrationStrategy get migration {
  //   return MigrationStrategy(
  //     onUpgrade: stepByStep(
  //       from1To2: (m, schema) async {
  //         await m.createTable(schema.partners);
  //         await m.createTable(schema.categories);
  //         await m.createTable(schema.eOptions);
  //         await m.createTable(schema.types);
  //         await m.createTable(schema.sexualEvent);
  //         await m.createTable(schema.events);
  //       },
  //       from2To3: (m, schema) async {
  //         await m.createTable(schema.categoriesTypes);
  //         await m.createTable(schema.eventsOptions);
  //         await m.createTable(schema.eventsPartners);
  //       },
  //     ),
  //   );
  // }
}