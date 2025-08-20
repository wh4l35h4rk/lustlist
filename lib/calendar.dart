import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lustlist/example_utils.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({super.key});

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  late final PageController _pageController;
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _selectedDay = DateTime.now();
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }


  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay.value = focusedDay;
      });
    } else {
      setState(() {
        _selectedDay = DateTime.now();
        _focusedDay.value = DateTime.now();
      });
    }

    _selectedEvents.value = _getEventsForDay(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ValueListenableBuilder<DateTime>(
            valueListenable: _focusedDay,
            builder: (context, value, _) {
              return _CalendarHeader(
                focusedDay: _focusedDay.value,
                onTodayButtonTap: () {
                  setState(() => _focusedDay.value = DateTime.now());
                },
                onLeftArrowTap: () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                onRightArrowTap: () {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                onSelectDateButtonTap: (){
                  null;
                }
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: _focusedDay,
            builder: (context, value, child) {
              return TableCalendar<Event>(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay.value,
                calendarFormat: _calendarFormat,
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (events.isNotEmpty) {
                      return Positioned(
                        bottom: 1,
                        child: Row(
                            children: List<Icon>.filled(
                              events.length,
                              Icon(
                                Icons.favorite,
                                size: 12,
                                color: (day.month == _focusedDay.value.month) ?
                                  Theme.of(context).colorScheme.secondary :
                                  Colors.black26
                              ),
                            )
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
                headerVisible: false,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onCalendarCreated: (controller) => _pageController = controller,
                onDaySelected: _onDaySelected,
                onPageChanged: (focusedDay) {
                  _focusedDay.value = focusedDay;
                },
              );
            }
          ),

          const SizedBox(height: 10.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(color: Theme.of(context).colorScheme.primary)
                        ),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onSelectDateButtonTap;

  const _CalendarHeader({
    super.key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onSelectDateButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMMM().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: onLeftArrowTap,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(
            width: 130.0,
            child: TextButton(
              onPressed: onSelectDateButtonTap,
              child: Text(
                headerText,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.calendar_today, size: 16.0),
            visualDensity: VisualDensity.compact,
            onPressed: onTodayButtonTap,
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: onRightArrowTap,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}