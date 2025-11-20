import 'package:lustlist/src/presentation/controllers/time_controller.dart';
import 'package:lustlist/src/presentation/widgets/add_widgets/date_picker.dart';
import 'package:lustlist/src/presentation/widgets/add_widgets/mstb_switch.dart';
import 'package:lustlist/src/presentation/widgets/add_widgets/time_picker.dart';

class AddMedEventDataController {
  DateTime date;

  AddMedEventDataController({
    required this.date
  });

  late final DateController dateController = DateController(date);
  final TimeController timeController = TimeController();
  final SwitchController stiController = SwitchController(value: true);
  final SwitchController obgynController = SwitchController(value: true);
}