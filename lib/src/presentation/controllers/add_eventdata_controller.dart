import 'package:lustlist/src/presentation/controllers/time_controller.dart';
import 'package:lustlist/src/presentation/widgets/add_widgets/date_picker.dart';
import 'package:lustlist/src/presentation/widgets/add_widgets/mstb_switch.dart';

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