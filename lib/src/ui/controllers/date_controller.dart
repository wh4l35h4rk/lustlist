class DateController {
  DateTime? date;

  DateController({
    required this.date
  });

  void setDate(DateTime newValue) {
    date = newValue;
  }
}