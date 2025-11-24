import 'package:lustlist/src/ui/controllers/time_controller.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/mstb_switch.dart';

class EditMedEventDataController {
  DateTime date;
  DateTime time;
  bool isSti;
  bool isObgyn;

  EditMedEventDataController({
    required this.date,
    required this.time,
    required this.isSti,
    required this.isObgyn,
  });

  late final DateController dateController = DateController(date: date);
  late final TimeController timeController = TimeController(time: time);
  late final SwitchController stiController = SwitchController(value: isSti);
  late final SwitchController obgynController = SwitchController(value: isObgyn);
}