import 'package:intl/intl.dart';

class DateFormatter {
  static String dateWithDay(DateTime date) => DateFormat.yMMMMd().format(date);
  static String dateWithoutDay(DateTime date) => DateFormat.yMMMM().format(date);
  static String time(DateTime time) => DateFormat.Hm().format(time);
}
