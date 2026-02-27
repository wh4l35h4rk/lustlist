import 'package:flutter/material.dart';

enum EventType {
  sex('Sex', Icons.favorite),
  masturbation('Solo', Icons.front_hand),
  medical('Medical', Icons.medical_services);

  const EventType(this.name, this.iconData);

  final String name;
  final IconData iconData;

  static final List<EventType> entries = [EventType.sex, EventType.masturbation, EventType.medical];
}
