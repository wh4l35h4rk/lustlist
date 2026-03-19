import 'package:flutter/cupertino.dart';

abstract class NumericFilterControllerBase{
  final ValueNotifier<bool> enabled = ValueNotifier(false);
  final ValueNotifier<bool> singleMode = ValueNotifier(false);
  late final ValueNotifier<int?> startNotifier = ValueNotifier(start);
  late final ValueNotifier<int?> endNotifier = ValueNotifier(end);

  NumericFilterControllerBase();

  int? get start;
  int? get end;

  bool get isEnabled => enabled.value;
  bool get hasValues => start != null || end != null;
  bool get isSingleValueMode => singleMode.value;

  void toggleEnabled() {
    enabled.value = !enabled.value;
  }
  void disable(){
    enabled.value = false;
  }

  void toggleMode(){
    singleMode.value = !singleMode.value;
  }
}