import 'package:lustlist/src/domain/entities/event_duration.dart';
import 'package:lustlist/src/ui/controllers/eventdata_controller_base.dart';
import 'package:lustlist/src/ui/controllers/int_controller.dart';
import 'package:lustlist/src/ui/controllers/time_controller.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';

class EditEventDataController extends EventDataControllerBase {
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
    required this.rating,
    required this.orgasmAmount,
  });


  @override
  DateController initDateController() => DateController(date: date);

  @override
  TimeController initTimeController() => TimeController(time: time);

  @override
  TimeController initDurationController() => TimeController(time: duration?.toDateTime());

  @override
  IntController initOrgasmsController() => IntController(value: orgasmAmount);

  @override
  IntController initRatingController() => IntController(value: rating);
}