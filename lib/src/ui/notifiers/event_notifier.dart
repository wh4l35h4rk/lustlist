import 'package:flutter/material.dart';


class EventNotifier extends ValueNotifier<bool> {
  EventNotifier() : super(false);

  void notifyUpdate() {
    value = !value;
  }
}


final eventsUpdated = EventNotifier();