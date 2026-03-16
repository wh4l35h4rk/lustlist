import 'package:lustlist/src/config/enums/type.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/entities/event_with_options.dart';
import 'package:lustlist/src/domain/entities/filter_data.dart';
import 'package:lustlist/src/domain/entities/numeric_filter_data.dart';

class FilterQuery {
  final SelectableFilterData<EventType> types;
  final SelectableFilterData<int> rating;
  final SelectableFilterData<Partner> partners;
  final SelectableFilterData<EOption> contraception;
  final SelectableFilterData<EOption> practices;
  final SelectableFilterData<EOption> poses;
  final SelectableFilterData<EOption> places;
  final SelectableFilterData<EOption> complicacies;
  final SelectableFilterData<EOption> ejaculation;
  final SelectableFilterData<EOption> soloPractices;
  final SelectableFilterData<EOption> sti;
  final SelectableFilterData<EOption> obgyn;
  final NumericFilterData<int?> userOrgasms;

  FilterQuery({
    required this.types,
    required this.rating,
    required this.partners,
    required this.contraception,
    required this.practices,
    required this.poses,
    required this.places,
    required this.complicacies,
    required this.ejaculation,
    required this.soloPractices,
    required this.sti,
    required this.obgyn,
    required this.userOrgasms
  });

  List<CalendarEventWithOptions> filter(List<CalendarEventWithOptions> events) {
    print(userOrgasms);
    return events.where((event) =>
        (!types.isEnabled || types.values.contains(event.calendarEvent.type)) &&
        (!partners.isEnabled || _containsAny(event.calendarEvent.getPartners(), partners.values)) &&
        (!contraception.isEnabled || _containsAny(event.options, contraception.values)) &&
        (!practices.isEnabled || _containsAny(event.options, practices.values)) &&
        (!poses.isEnabled || _containsAny(event.options, poses.values)) &&
        (!places.isEnabled || _containsAny(event.options, places.values)) &&
        (!ejaculation.isEnabled || _containsAny(event.options, ejaculation.values)) &&
        (!complicacies.isEnabled || _containsAny(event.options, complicacies.values)) &&
        (!soloPractices.isEnabled || _containsAny(event.options, soloPractices.values)) &&
        (!sti.isEnabled || _containsAny(event.options, sti.values)) &&
        (!obgyn.isEnabled || _containsAny(event.options, obgyn.values)) &&
        (!rating.isEnabled || _containsData(rating.values, event.calendarEvent.data?.rating)) &&
        (!userOrgasms.isEnabled || _inRange(
            event.calendarEvent.data?.userOrgasms,
            userOrgasms.start, userOrgasms.end
        ))
    ).toList();
  }

  bool _containsData<T>(List<T> values, T? value) {
    if (value == null && values.isEmpty) return true;
    return values.contains(value);
  }

  bool _containsAny<T>(List<T> eventList, List<T> list){
    if (list.isEmpty && eventList.isEmpty) return true;
    return list.any((element) => eventList.contains(element));
  }

  bool _inRange(num? value, num? rangeStart, num? rangeEnd){
    if (value == null) {
      return rangeStart == null && rangeEnd == null;
    } else {
      if (rangeStart == null && rangeEnd == null) {
        return false;
      } else {
        if (rangeStart == null && rangeEnd != null) return value <= rangeEnd;
        if (rangeEnd == null && rangeStart != null) return value >= rangeStart;
        return rangeStart! <= value && value <= rangeEnd!;
      }
    }
  }
}