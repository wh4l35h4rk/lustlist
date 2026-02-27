import 'list_notifier.dart';

class FilterController<T> {
  final ListNotifier<T> selectedValues = ListNotifier<T>();

  FilterController({
    List<T>? selectedValuesList,
  }) {
    selectedValues.value = List<T>.from(selectedValuesList ?? []);
  }

  List<T> get values => selectedValues.value;

  bool isSelected(T value) => values.contains(value);

  void toggle(T value) {
    final newValues = List<T>.from(values);

    if (newValues.contains(value)) {
      newValues.remove(value);
    } else {
      newValues.add(value);
    }

    selectedValues.value = newValues;
  }

  void addAll(List<T> newValues) {
    selectedValues.value = List<T>.from(newValues);
  }
  void removeAll(){
    selectedValues.value = [];
  }
}