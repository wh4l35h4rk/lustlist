import 'package:flutter/material.dart';

class MapNotifier<K> extends ValueNotifier<Map<K, int>> {
  MapNotifier() : super({});

  void add(K key) {
    value[key] = 0;
    notifyListeners();
  }

  void updateValue(K key, int newValue) {
    if (value.containsKey(key)) {
      value[key] = newValue;
      notifyListeners();
    }
  }

  void remove(K key) {
    value.remove(key);
    notifyListeners();
  }
}