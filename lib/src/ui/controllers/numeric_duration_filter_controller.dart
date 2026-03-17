import 'package:lustlist/src/domain/entities/event_duration.dart';
import 'package:lustlist/src/ui/controllers/numeric_filter_controller_base.dart';
import 'package:lustlist/src/ui/controllers/time_controller.dart';

class NumericDurationFilterController extends NumericFilterControllerBase{
  final TimeController startController = TimeController();
  final TimeController endController = TimeController();

  NumericDurationFilterController({
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
    DateTime t = startController.time;
    EventDuration dur = EventDuration.explicit(0, t.hour, t.minute);
    int value = dur.minutesTotal;
    return value == 0 ? null : value;
  }

  @override
  int? get end {
    if (isSingleValueMode) return start;
    DateTime t = endController.time;
    EventDuration dur = EventDuration.explicit(0, t.hour, t.minute);
    int value = dur.minutesTotal;
    return value == 0 ? null : value;
  }
}