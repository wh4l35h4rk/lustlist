import 'package:flutter/cupertino.dart';

class NumericFilterController{
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();

  final ValueNotifier<bool> enabled = ValueNotifier(false);
  final ValueNotifier<bool> singleMode = ValueNotifier(false);

  NumericFilterController({
    bool? isEnabledInitially,
  }) {
    enabled.value = isEnabledInitially ?? false;
  }

  int? get start {
    if (startController.text == "") return null;
    return int.parse(startController.text);
  }
  int? get end {
    if (endController.text == "") return null;
    return int.parse(endController.text);
  }
  bool get isEnabled => enabled.value;
  bool get hasValues => start != null || end != null;

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