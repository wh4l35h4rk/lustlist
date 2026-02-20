import 'package:intl/intl.dart';

class DateFormatter {
  static String dateWithDay(DateTime date) => DateFormat.yMMMMd().format(date);
  static String dateWithoutDay(DateTime date) => DateFormat.yMMMM().format(date);
  static String time(DateTime time) => DateFormat.Hm().format(time);
  static String month(int month) => DateFormat.MMM().format(DateTime(0, month)).toUpperCase();
  static String weekday(DateTime date) => DateFormat('E').format(date);

  static DateTime dateOnly (DateTime datetime) => DateTime(
    datetime.year,
    datetime.month,
    datetime.day
  );
  static DateTime timeOnly(DateTime datetime) => DateTime(
    1, 0, 0,
    datetime.hour,
    datetime.minute,
    datetime.second
  );
  static DateTime yearMonthOnly (DateTime date) => DateTime(date.year, date.month);
}
