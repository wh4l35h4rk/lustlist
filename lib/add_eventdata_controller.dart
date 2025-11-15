import 'package:lustlist/widgets/add_widgets/date_picker.dart';
import 'package:lustlist/widgets/add_widgets/mstb_switch.dart';
import 'package:lustlist/widgets/add_widgets/time_picker.dart';

class AddEventDataController {
  DateTime date;

  AddEventDataController({
    required this.date
  });

  late final DateController dateController = DateController(date);
  final TimeController timeController = TimeController();
  final TimeController durationController = TimeController();
  final SwitchController pornController = SwitchController(value: false);

  int rating = 0;
  int orgasmAmount = 0;

  void setRating(int newValue) {
    rating = newValue;
  }

  void setOrgasmAmount(int newValue) {
    orgasmAmount = newValue;
  }
}