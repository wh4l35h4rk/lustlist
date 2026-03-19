import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';

enum BoolFilter {
  hasValue(AppIconData.selected),
  noValue(AppIconData.notSelected),
  notSet(null);

  const BoolFilter(this.iconData);

  final IconData? iconData;

  static final List<BoolFilter> entries = [
    BoolFilter.hasValue,
    BoolFilter.noValue,
    BoolFilter.notSet
  ];
}
