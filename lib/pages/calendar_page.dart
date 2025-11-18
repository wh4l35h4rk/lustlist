import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:lustlist/widgets/calendar_widgets/add_event_floating_button.dart';
import 'package:lustlist/widgets/calendar_widgets/calendar.dart';
import 'package:table_calendar/table_calendar.dart' hide normalizeDate;
import '../utils.dart';
import '../main.dart';
import '../calendar_event.dart';
import '../repository.dart';
import 'add_pages/add_med_page.dart';
import 'add_pages/add_mstb_page.dart';
import 'add_pages/add_sex_page.dart';


List<IconData> iconsData = [Icons.favorite, Icons.front_hand, Icons.medical_services];


class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final repo = EventRepository(database);
  final ValueNotifier<LinkedHashMap<DateTime, List<CalendarEvent>>> _events = ValueNotifier(
    LinkedHashMap(equals: isSameDay, hashCode: getHashCode),
  );

  final ValueNotifier<List<CalendarEvent>> _selectedEvents = ValueNotifier([]);
  final ValueNotifier<DateTime?> _selectedDay = ValueNotifier(null);
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);


  Future<void> _loadEvents() async {
    final data = await repo.getEventSource();
    _events.value = LinkedHashMap<DateTime, List<CalendarEvent>>(equals: isSameDay, hashCode: getHashCode)..addAll(data);

    final types = await database.allTypes;
    for (final type in types) {
      iconDataMap[type.id] = getTypeIconData(type.slug);
    }
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    final normalizedDay = repo.normalizeDate(day);
    return _events.value[normalizedDay] ?? [];
  }

  Future<void> _onAddEventTap(int index) async {
    StatefulWidget widget;
    if (index == 0) {
      widget = AddSexEventPage(_selectedDay.value);
    } else if (index == 1) {
      widget = AddMstbEventPage(_selectedDay.value);
    } else {
      widget = AddMedEventPage(_selectedDay.value);
    }

    final result = await Navigator.push(context,
      MaterialPageRoute(builder: (_) => widget),
    );
    if (result == true) {
      await Future.delayed(Duration(milliseconds: 200));
      await _loadEvents();
      if (mounted && _selectedDay.value != null) {
        _selectedEvents.value = _getEventsForDay(_selectedDay.value!);
      }
      setState(() {});
    }
  }

  Future<void> _init() async {
    await _loadEvents();
    if (mounted && _selectedDay.value != null) {
      _selectedEvents.value = _getEventsForDay(_selectedDay.value!);
    }
    _isLoading.value = false;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: _isLoading,
          builder: (context, isLoading, child) {
            if (!isLoading) {
              return Calendar(
                events: _events,
                selectedEvents: _selectedEvents,
                selectedDay: _selectedDay,
                onReload: _loadEvents,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: AddEventFloatingButton(onEventTap: _onAddEventTap),
        )
      ]
    );
  }
}


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}