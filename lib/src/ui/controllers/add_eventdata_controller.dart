import 'package:lustlist/src/ui/controllers/time_controller.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/mstb_switch.dart';

class AddEventDataController {
  DateTime date;

  AddEventDataController({
    required this.date
  });

  late final DateController dateController = DateController(date: date);
  final TimeController timeController = TimeController();
  final TimeController durationController = TimeController();
  final SwitchController pornController = SwitchController(value: false);
  final SwitchController toysController = SwitchController(value: false);

  int rating = 0;
  int? orgasmAmount;

  void setRating(int newValue) {
    rating = newValue;
  }

  void setOrgasmAmount(int? newValue) {
    orgasmAmount = newValue;
  }
}