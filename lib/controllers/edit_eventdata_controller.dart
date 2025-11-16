import 'package:lustlist/widgets/add_widgets/date_picker.dart';
import 'package:lustlist/widgets/add_widgets/mstb_switch.dart';
import 'package:lustlist/widgets/add_widgets/time_picker.dart';


class EditEventDataController {
  DateTime date;
  DateTime time;
  DateTime? duration;
  bool? didWatchPorn;
  int? rating = 0;
  int? orgasmAmount = 0;

  EditEventDataController({
    required this.date,
    required this.time,
    required this.duration,
    required this.didWatchPorn,
    required this.rating,
    required this.orgasmAmount,
  });

  late final DateController dateController = DateController(date);
  late final TimeController timeController = TimeController(time: time);
  late final TimeController durationController = TimeController(time: duration);
  late final SwitchController pornController = SwitchController(value: didWatchPorn ?? false);

  void setRating(int newValue) {
    rating = newValue;
  }

  void setOrgasmAmount(int newValue) {
    orgasmAmount = newValue;
  }
}