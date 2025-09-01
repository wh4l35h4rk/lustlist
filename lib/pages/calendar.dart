import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/db/events.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/example_utils.dart';
import 'package:lustlist/test_event.dart';


class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final PageController _pageController;
  final ValueNotifier<List<TestEvent>> _selectedEvents = ValueNotifier([]);
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime? _selectedDay = DateTime.now();
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<TestEvent> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay.value = focusedDay;
        _selectedEvents.value = _getEventsForDay(_selectedDay!);
      });
    } else {
      setState(() {
        _selectedDay = null;
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
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              )),
          content: Container(
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
                  _selectedDay = newDate;
                },
              ),
            ),
          ),
          actions: [
            MaterialButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                _focusedDay.value = _selectedDay!;
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
                    _selectedDay = DateTime.now();
                    _selectedEvents.value = _getEventsForDay(_selectedDay!);
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

              TableCalendar<TestEvent>(
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
                pageJumpingEnabled: true,
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
              ),

              const SizedBox(height: 15.0),
              (_selectedEvents.value.isNotEmpty) ? 
                Expanded(
                  child: ValueListenableBuilder<List<TestEvent>>(
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
                              child: EventListTile(event: value[index],)
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
                      "There are no events this day!",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
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
}


class EventListTile extends StatelessWidget {
  const EventListTile({
    required this.event,
    super.key,
  });

  final TestEvent event;

  String _getTitle() {
    final typeSlug = event.getTypeSlug();
    switch (typeSlug) {
      case "sex":
        return List.generate(event.partners.length, (index) => event.partners[index]!.name).join(", ");
      case "masturbation":
        return event.type.name;
      case "medical":
        return event.type.name;
      default:
        throw FormatException("Wrong type: $event.type.slug");
    }
  }

  String _getSubtitle() {
    final type = event.getTypeSlug();
    String time = event.event.time != null ? DateFormat("HH:mm").format(event.event.time!) : event.event.daytime.label;

    if ((type == "sex" || type == "masturbation") && event.data != null) {
      if (event.data!.duration != null) {
        int hours = event.data!.duration!.hour;
        int minutes = event.data!.duration!.minute;

        String? hoursString;
        String? minutesString;

        switch (hours) {
          case 0:
            hoursString = null;
          case 1:
            hoursString = "$hours hour";
          default:
            hoursString = "$hours hours";
        }
        switch (minutes) {
          case 0:
            minutesString = null;
          case 1:
            minutesString = "$minutes minute";
          default:
            minutesString = "$minutes minutes";
        }
        List<String> list = [time, ?hoursString, ?minutesString];
        return list.join(", ");
      } else {
        return "$time, duration unknown";
      }
    } else if (type == "medical") {
      return time;
    } else {
      throw FormatException("Wrong type: $event.type.slug");
    }
  }

  Color _getBorderColor(BuildContext context) {
    final typeSlug = event.getTypeSlug();
    if ((typeSlug == "sex" || typeSlug == "masturbation") && event.data != null) {
      final int rating = event.data!.rating;
      switch (rating) {
        case 1:
          return Colors.red;
        case 2:
          return Colors.orange;
        case 3:
          return Colors.amber;
        case 4:
          return Colors.lightGreen;
        case 5:
          return Colors.green;
        default:
          return Theme.of(context).colorScheme.outline;
      }
    } else {
      return Theme.of(context).colorScheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => print('${event}'),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconDataMap[event.getTypeId()],
          ),
          SizedBox(width: 15),
          Container(
            height: double.infinity,
            width: 1,
            decoration: BoxDecoration(border: Border(right: BorderSide(color: _getBorderColor(context), width: 2.8))),
          )
        ],
      ),
      title: Text(_getTitle(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(_getSubtitle()),
      trailing: Icon(Icons.arrow_forward_ios)
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