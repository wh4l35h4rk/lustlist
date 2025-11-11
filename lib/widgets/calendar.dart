import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/colors.dart';
import 'package:table_calendar/table_calendar.dart' hide normalizeDate;
import 'package:lustlist/main.dart';
import 'package:lustlist/example_utils.dart';
import 'package:lustlist/calendar_event.dart';
import 'package:lustlist/widgets/event_listtile.dart';
import '../pages/eventpage.dart';


class Calendar extends StatefulWidget {
  final ValueNotifier<LinkedHashMap<DateTime, List<CalendarEvent>>> events;
  final ValueNotifier<List<CalendarEvent>> selectedEvents;
  final ValueNotifier<DateTime?> selectedDay;
  final Future<void> Function()? onReload;

  const Calendar({
    super.key,
    required this.events,
    required this.selectedEvents,
    required this.selectedDay,
    this.onReload,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final PageController _pageController;
  late final ValueNotifier<List<CalendarEvent>> _selectedEvents = widget.selectedEvents;
  late final ValueNotifier<DateTime?> _selectedDay = widget.selectedDay;
  
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());


  @override
  void initState() {
    super.initState();
    _onDaySelected(DateTime.now(), _focusedDay.value);
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    final normalizedDay = normalizeDate(day);
    return widget.events.value[normalizedDay] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final normalizedSelectedDay = normalizeDate(selectedDay);

    if (!isSameDay(_selectedDay.value, normalizedSelectedDay)) {
      setState(() {
        _selectedDay.value = normalizedSelectedDay;
        _focusedDay.value = focusedDay;
        _selectedEvents.value = _getEventsForDay(_selectedDay.value!);
      });
    } else {
      setState(() {
        _selectedDay.value = null;
        _selectedEvents.value = [];
      });
    }
  }

  void _showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
                "Select a month",
                style: TextStyle(color: AppColors.calendar.title(context)),
              )),
          content: SizedBox(
            height: 100,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    fontSize: 16,
                  ),
                )
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.monthYear,
                minimumDate: kFirstDay,
                maximumDate: kLastDay,
                initialDateTime: _focusedDay.value.isAfter(kLastDay) ? kLastDay : _focusedDay.value,
              onDateTimeChanged: (DateTime newDate) {
                  _selectedDay.value = newDate;
                },
              ),
            ),
          ),
          actions: [
            MaterialButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                _focusedDay.value = _selectedDay.value!;
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _focusedDay,
        builder: (context, value, child) {
          return Column(
            children: [
              _CalendarHeader(
                focusedDay: _focusedDay.value,
                onTodayButtonTap: () {
                  setState(() {
                    _focusedDay.value = DateTime.now();
                    _selectedDay.value = DateTime.now();
                    _selectedEvents.value = _getEventsForDay(_selectedDay.value!);
                  });
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
                onSelectDateButtonTap: () {
                  _showPopUp(context);
                },
              ),

              ValueListenableBuilder(
                valueListenable: widget.events,
                builder: (context, value, child) {
                  return TableCalendar<CalendarEvent>(
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
                                children: List<Icon>.generate(events.length, (index) =>
                                  Icon(
                                    iconDataMap[events[index].getTypeId()],
                                    size: 12,
                                    color: (day.month == _focusedDay.value.month) ?
                                      AppColors.calendar.eventIcon(context) :
                                      AppColors.calendar.eventOtherMonthIcon(context)
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
                        color: AppColors.calendar.selectedEvent(context),
                      ),
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.calendar.todayEvent(context),
                      ),
                    ),
                    pageJumpingEnabled: true,
                    headerVisible: false,
                    eventLoader: _getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay.value, day);
                    },
                    onCalendarCreated: (controller) => _pageController = controller,
                    onDaySelected: _onDaySelected,
                    onPageChanged: (focusedDay) {
                      _focusedDay.value = focusedDay;
                    },
                  );
                }
              ),

              const SizedBox(height: 15.0),
              (_selectedEvents.value.isNotEmpty) ?
                Expanded(
                  child: ValueListenableBuilder<List<CalendarEvent>>(
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
                                    horizontal: BorderSide(color: AppColors.calendar.border(context))
                                ),
                              ),
                              child: EventListTile(
                                onTap: () => _onEventListTileTap(value[index]),
                                event: value[index],
                              )
                          );
                        },
                      );
                    },
                  ),
                ) :
                Column(
                  children: [
                    const SizedBox(height: 15.0),
                    Text(
                      _selectedDay.value != null ? "There are no events this day!" : "No days selected!",
                      style: TextStyle(
                        color: AppColors.defaultTile(context),
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
            ],
          );
        }
      ),
    );
  }

  Future<void> _onEventListTileTap(CalendarEvent event) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventPage(event: event),
      ),
    );
    if (result == true) {
      await Future.delayed(Duration(milliseconds: 200));
      await widget.onReload!();
      if (mounted && _selectedDay.value != null) {
        _selectedEvents.value = _getEventsForDay(_selectedDay.value!);
      }
      setState(() {});
    }
  }
}



class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onSelectDateButtonTap;

  const _CalendarHeader({
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
            color: AppColors.calendar.navigationIcon(context),
          ),
          SizedBox(
            width: 170,
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
            color: AppColors.calendar.navigationIcon(context),
          ),
        ],
      ),
    );
  }
}