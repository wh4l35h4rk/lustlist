import 'package:lustlist/src/ui/controllers/eventdata_controller_base.dart';
import 'package:lustlist/src/ui/controllers/int_controller.dart';
import 'package:lustlist/src/ui/controllers/time_controller.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';

class AddEventDataController extends EventDataControllerBase {
  DateTime date;

  AddEventDataController({
    required this.date
  });

  @override
  DateController initDateController() => DateController(date: date);

  @override
  TimeController initTimeController() => TimeController();

  @override
  TimeController initDurationController() => TimeController();

  @override
  IntController initOrgasmsController() => IntController();

  @override
  IntController initRatingController() => IntController();
}