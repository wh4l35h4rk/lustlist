import 'package:lustlist/src/config/enums/type.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/entities/event_with_options.dart';
import 'package:lustlist/src/domain/entities/filter_data.dart';

class FilterQuery {
  final FilterData<EventType> types;
  final FilterData<EOption> contraception;
  final FilterData<EOption> practices;
  final FilterData<EOption> poses;
  final FilterData<EOption> places;
  final FilterData<EOption> complicacies;
  final FilterData<EOption> ejaculation;
  // final FilterData<EOption> medical;

  FilterQuery({
    required this.types,
    // required this.partners,
    required this.contraception,
    required this.practices,
    required this.poses,
    required this.places,
    required this.complicacies,
    required this.ejaculation,
    // required this.medical,
  });

  List<CalendarEventWithOptions> filter(List<CalendarEventWithOptions> events) {
    return events.where((event) =>
      (!types.isEnabled || types.values.contains(event.calendarEvent.type)) &&
      (!contraception.isEnabled || _containsAny(event.options, contraception.values)) &&
      (!practices.isEnabled || _containsAny(event.options, practices.values)) &&
      (!poses.isEnabled || _containsAny(event.options, poses.values)) &&
      (!places.isEnabled || _containsAny(event.options, places.values)) &&
      (!ejaculation.isEnabled || _containsAny(event.options, ejaculation.values)) &&
      (!complicacies.isEnabled || _containsAny(event.options, complicacies.values)) &&
      // (!medical.isEnabled || _containsAny(event.options, medical.values)) &&
      true
    ).toList();
  }

  
  bool _containsAny<T>(List<T> eventList, List<T> list){
    if (list.isEmpty && eventList.isEmpty) return true;
    return list.any((element) => eventList.contains(element));
  }
}