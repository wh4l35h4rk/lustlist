class FilterData<T> {
  final bool isEnabled;
  final List<T> values;

  const FilterData({
    required this.isEnabled,
    required this.values,
  });
}