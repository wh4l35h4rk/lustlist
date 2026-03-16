class SelectableFilterData<T> {
  final bool isEnabled;
  final List<T> values;

  const SelectableFilterData({
    required this.isEnabled,
    required this.values,
  });
}