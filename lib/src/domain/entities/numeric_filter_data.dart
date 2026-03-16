class NumericFilterData<T> {
  final bool isEnabled;
  final T start;
  final T end;

  const NumericFilterData({
    required this.isEnabled,
    required this.start,
    required this.end
  });

  @override
  String toString() {
    return "NumericFilterData(isEnabled: $isEnabled, start: $start, end: $end";
  }
}