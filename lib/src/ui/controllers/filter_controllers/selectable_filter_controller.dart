import 'package:flutter/cupertino.dart';
import '../../notifiers/list_notifier.dart';

class SelectableFilterController<T> {
  late List<T> allValues;
  final ListNotifier<T> selectedValues = ListNotifier<T>();
  final ValueNotifier<bool> enabled = ValueNotifier(false);

  SelectableFilterController({
    required List<T> allValuesList,
    bool? isEnabledInitially,
  }) {
    allValues = allValuesList;
    selectedValues.value = List<T>.from(allValuesList);
    enabled.value = isEnabledInitially ?? false;
  }

  List<T> get values => selectedValues.value;
  bool get isEnabled => enabled.value;

  bool isSelected(T value) => values.contains(value);
  bool allSelected() => values.length == allValues.length;

  void setValues(List<T> values){
    allValues = values;
    selectedValues.value = values;
  }


  void toggle(T value) {
    List<T> newValues;
    if (!isEnabled) {
      toggleEnabled();
      newValues = [];
    } else {
      newValues = List<T>.from(values);
    }

    if (newValues.contains(value)) {
      newValues.remove(value);
    } else {
      newValues.add(value);
    }

    selectedValues.value = newValues;
  }

  void toggleEnabled() {
    enabled.value = !enabled.value;
  }

  void addAll() {
    if (!isEnabled) toggleEnabled();
    selectedValues.value = List<T>.from(allValues);
  }
  void removeAll(){
    if (!isEnabled) toggleEnabled();
    selectedValues.value = [];
  }
  void disable(){
    enabled.value = false;
  }
}