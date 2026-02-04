class EventDuration {
  late int hour;
  late int minute;
  late int minutesTotal;

  EventDuration(this.minutesTotal) {
    hour = minutesTotal ~/ 60;
    minute = minutesTotal % 60;
  }

  EventDuration.explicit(this.hour, this.minute) {
    minutesTotal = hour * 60 + minute;
  }

  DateTime toDateTime(){
    return DateTime(
      1, 0, 0,
      hour,
      minute
    );
  }
}
