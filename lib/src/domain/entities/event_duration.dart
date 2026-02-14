class EventDuration {
  late int days;
  late int hours;
  late int minutes;
  late int minutesTotal;

  EventDuration(this.minutesTotal) {
    days = minutesTotal ~/ (60 * 24);
    final minutesWithoutDays = minutesTotal % (60 * 24);

    hours = minutesWithoutDays ~/ 60;
    minutes = minutesWithoutDays % 60;
  }

  EventDuration.explicit(this.days, this.hours, this.minutes) {
    minutesTotal = days * 24 * 60 + hours * 60 + minutes;
  }

  DateTime toDateTime(){
    return DateTime(
      1, 0,
      days,
      hours,
      minutes
    );
  }
}
