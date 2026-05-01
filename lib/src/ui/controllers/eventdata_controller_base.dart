import 'package:lustlist/src/ui/controllers/int_controller.dart';
import 'package:lustlist/src/ui/controllers/time_controller.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';

abstract class EventDataControllerBase {
  EventDataControllerBase();

  late final DateController dateController = initDateController();
  late final TimeController timeController = initTimeController();
  late final TimeController durationController = initDurationController();
  late final IntController ratingController = initRatingController();
  late final IntController orgasmsController = initOrgasmsController();

  DateController initDateController();
  TimeController initTimeController();
  TimeController initDurationController();
  IntController initRatingController();
  IntController initOrgasmsController();
}