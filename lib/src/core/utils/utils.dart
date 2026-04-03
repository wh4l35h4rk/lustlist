import 'package:lustlist/src/core/formatters/datetime_formatters.dart';


final kToday = DateTime.now();
final kFirstDay = defaultDate;
final kLastDay = DateFormatter.dateOnly(DateTime.now());

const appTitle = "LustList";

final defaultDate = DateTime(1970, 1, 1);
final minBirthday = DateTime(kToday.year - 130, 1, 1);

final maxOrgasms = 11;