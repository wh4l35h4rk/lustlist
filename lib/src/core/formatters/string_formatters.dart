import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';

class StringFormatter {

  static String colon(String s){
    return "$s:";
  }
  
  static String orgasmsAmount(int? orgasmsAmount) {
    if (orgasmsAmount == null) return DataStrings.unknown;

    final String amountString = orgasmsAmount.toString();
    final String orgasmsString;
    if (orgasmsAmount == 1) {
      orgasmsString = MiscStrings.orgasmOne;
    } else {
      orgasmsString = MiscStrings.orgasmsMany;
    }
    return "$amountString $orgasmsString";
  }

  static String duration(DateTime? duration) {
    if (duration != null) {
      int hours = duration.hour;
      int minutes = duration.minute;

      if (hours == 0 && minutes == 0) {
        return MiscStrings.durationUnknown;
      }

      String? hoursString;
      String? minutesString;

      switch (hours) {
        case 0:
          hoursString = null;
        case 1:
          hoursString = "$hours ${MiscStrings.hour}";
        default:
          hoursString = "$hours ${MiscStrings.hours}";
      }
      switch (minutes) {
        case 0:
          minutesString = null;
        case 1:
          minutesString = "$minutes ${MiscStrings.min}";
        default:
          minutesString = "$minutes ${MiscStrings.mins}";
      }
      final String timeString = [?hoursString, ?minutesString].join(" ");
      return timeString;
    } else {
      return MiscStrings.durationUnknown;
    }
  }

  static String dateTimeTitle(DateTime date, DateTime time) {
    final dateFormatted = DateFormatter.date(date);
    final timeFormatted = DateFormatter.time(time);
    return "$dateFormatted, $timeFormatted";
  }

  static String partnerNamesTitle(List<String> partnerNames) => partnerNames.join(", ");

  static String time(DateTime time) {
    String hoursString = time.hour.toString();
    String minutesSting = time.minute.toString();

    if (time.hour < 10) {
      hoursString = '0$hoursString';
    }
    if (time.minute < 10) {
      minutesSting = '0$minutesSting';
    }

    return '$hoursString:$minutesSting';
  }
}
