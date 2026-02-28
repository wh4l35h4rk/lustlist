import 'list_notifier.dart';

class FilterController<T> {
  late final List<T> allValues;
  final ListNotifier<T> selectedValues = ListNotifier<T>();

  FilterController({
    required List<T> allValuesList,
    List<T>? selectedValuesList,
  }) {
    allValues = allValuesList;
    selectedValues.value = List<T>.from(selectedValuesList ?? []);
  }

  List<T> get values => selectedValues.value;

  bool isSelected(T value) => values.contains(value);
  bool allSelected() => values.length == allValues.length;

  void toggle(T value) {
    final newValues = List<T>.from(values);

    if (newValues.contains(value)) {
      newValues.remove(value);
    } else {
      newValues.add(value);
    }

    selectedValues.value = newValues;
  }

  void addAll() {
    selectedValues.value = List<T>.from(allValues);
  }
  void removeAll(){
    selectedValues.value = [];
  }
}