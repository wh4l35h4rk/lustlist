import 'package:lustlist/src/domain/entities/event_duration.dart';
import 'package:lustlist/src/ui/controllers/time_controller.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/mstb_switch.dart';

class EditEventDataController {
  DateTime date;
  DateTime time;
  EventDuration? duration;
  bool? didWatchPorn;
  bool? didUseToys;
  int? rating = 0;
  int? orgasmAmount;

  EditEventDataController({
    required this.date,
    required this.time,
    required this.duration,
    required this.didWatchPorn,
    required this.didUseToys,
    required this.rating,
    required this.orgasmAmount,
  });

  late final DateController dateController = DateController(date: date);
  late final TimeController timeController = TimeController(time: time);
  late final TimeController durationController = TimeController(time: duration?.toDateTime());
  late final SwitchController pornController = SwitchController(value: didWatchPorn ?? false);
  late final SwitchController toysController = SwitchController(value: didUseToys ?? false);

  void setRating(int newValue) {
    rating = newValue;
  }

  void setOrgasmAmount(int? newValue) {
    orgasmAmount = newValue;
  }
}