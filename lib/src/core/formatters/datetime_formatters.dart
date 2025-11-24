import 'package:intl/intl.dart';

class DateFormatter {
  static String date(DateTime date) => DateFormat.yMMMMd().format(date);
  static String time(DateTime time) => DateFormat.Hm().format(time);
}
