import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/ui/controllers/numeric_filter_controller_base.dart';

class NumericTextFilterController extends NumericFilterControllerBase{
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();

  NumericTextFilterController({
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

  @override
  int? get start {
    if (startController.text == "") return null;
    return int.parse(startController.text);
  }

  @override
  int? get end {
    if (isSingleValueMode) return start;
    if (endController.text == "") return null;
    return int.parse(endController.text);
  }
}