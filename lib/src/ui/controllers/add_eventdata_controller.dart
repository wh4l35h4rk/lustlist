import 'package:lustlist/src/ui/controllers/rating_controller.dart';
import 'package:lustlist/src/ui/controllers/time_controller.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';

class AddEventDataController {
  DateTime date;

  AddEventDataController({
    required this.date
  });

  late final DateController dateController = DateController(date: date);
  final TimeController timeController = TimeController();
  final TimeController durationController = TimeController();
  final RatingController ratingController = RatingController();


  int? orgasmAmount;

  void setOrgasmAmount(int? newValue) {
    orgasmAmount = newValue;
  }
}