import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/example_utils.dart';
import 'package:lustlist/test_event.dart';
import 'package:lustlist/widgets/event_listtile.dart';


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
                                    horizontal: BorderSide(color: AppColors.calendar.border(context))
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
            color: AppColors.calendar.navigationIcon(context),
          ),
        ],
      ),
    );
  }
}