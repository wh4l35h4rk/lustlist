import 'package:flutter/cupertino.dart';

class NumericFilterController{
  final ValueNotifier<bool> enabled = ValueNotifier(false);
  final ValueNotifier<bool> singleMode = ValueNotifier(false);

  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  late final ValueNotifier<int?> startNotifier = ValueNotifier(start);
  late final ValueNotifier<int?> endNotifier = ValueNotifier(end);

  NumericFilterController({
    bool? isEnabledInitially,
  }) {
    enabled.value = isEnabledInitially ?? false;

    startController.addListener(() {
      startNotifier.value = start;
    });
    endController.addListener(() {
      endNotifier.value = end;
    });
  }

  int? get start {
    if (startController.text == "") return null;
    return int.parse(startController.text);
  }
  int? get end {
    if (isSingleValueMode) return start;
    if (endController.text == "") return null;
    return int.parse(endController.text);
  }
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