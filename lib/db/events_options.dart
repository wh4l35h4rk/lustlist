import 'package:drift/drift.dart';
import 'package:lustlist/db/events.dart';
import 'package:lustlist/db/options.dart';

extension TestStatusLabel on TestStatus {
  String get label {
    switch (this) {
      case TestStatus.positive:
        return "Positive";
      case TestStatus.negative:
        return "Negative";
      case TestStatus.waiting:
        return "Waiting for result";
    }
  }
}

enum TestStatus {
  positive,
  negative,
  waiting,
}

@DataClassName('EventOption')
class EventsOptions extends Table {
  IntColumn get eventId => integer().references(Events, #id)();
  IntColumn get optionId => integer().references(EOptions, #id)();
  TextColumn get testStatus => textEnum<TestStatus>().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {eventId, optionId};
}