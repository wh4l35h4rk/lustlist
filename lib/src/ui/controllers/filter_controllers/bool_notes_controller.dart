import 'package:flutter/material.dart';
import 'package:lustlist/src/config/enums/bool_filter.dart';

class BoolNotesController{
  final ValueNotifier<BoolFilter> modeNotifier = ValueNotifier(BoolFilter.notSet);

  BoolNotesController();

  BoolFilter get mode => modeNotifier.value;

  void set(BoolFilter newValue) {
    modeNotifier.value = newValue;
  }

  void disable() {
    set(BoolFilter.notSet);
  }
}