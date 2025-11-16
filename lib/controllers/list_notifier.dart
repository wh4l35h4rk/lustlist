import 'package:flutter/material.dart';

class ListNotifier<K> extends ValueNotifier<List<K>> {
  ListNotifier() : super([]);

  void add(K newValue) {
    value.add(newValue);
    notifyListeners();
  }

  void remove(K removedValue) {
    value.remove(removedValue);
    notifyListeners();
  }
}