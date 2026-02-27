import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';

enum EventType {
  sex('Sex', AppIconData.sex),
  masturbation('Solo', AppIconData.mstb),
  medical('Medical', AppIconData.medical);

  const EventType(this.name, this.iconData);

  final String name;
  final IconData iconData;

  static final List<EventType> entries = [EventType.sex, EventType.masturbation, EventType.medical];
}
