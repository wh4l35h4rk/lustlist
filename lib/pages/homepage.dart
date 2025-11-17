import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:lustlist/widgets/calendar.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import 'package:table_calendar/table_calendar.dart' hide normalizeDate;
import '../change_theme_button.dart';
import '../utils.dart';
import '../main.dart';
import '../calendar_event.dart';
import '../repository.dart';
import 'add_pages/add_med_page.dart';
import 'add_pages/add_mstb_page.dart';
import 'add_pages/add_sex_page.dart';


List<IconData> iconsData = [Icons.favorite, Icons.front_hand, Icons.medical_services];


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: MainAppBar(
        themeButton: ChangeThemeButton(),
      ),
      body: ValueListenableBuilder(
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

      floatingActionButton: MenuAnchor(
        builder: (BuildContext context, MenuController controller, Widget? child) {
          return FloatingActionButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            tooltip: 'Show menu',
            child: const Icon(Icons.add),
          );
        },
        menuChildren: List<MenuItemButton>.generate(
            3,
            (int index) => MenuItemButton(
              onPressed: () {
                _onAddEventTap(index);
              },
              child: Icon(iconsData[index])
            ),
          ),
        ),
      bottomNavigationBar: MainBottomNavigationBar(),
    );
  }
}


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}