import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/misc.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
import 'package:lustlist/src/ui/pages/calendar_page/widgets/events_animated_list.dart';
import 'package:table_calendar/table_calendar.dart' hide normalizeDate;
import 'package:lustlist/main.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/ui/pages/event_page/eventpage.dart';
import 'package:lustlist/src/config/constants/layout.dart';


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

  final repo = EventRepository(database);
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
    final normalizedDay = DateFormatter.dateOnly(day);
    return widget.events.value[normalizedDay] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final normalizedSelectedDay = DateFormatter.dateOnly(selectedDay);

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _focusedDay,
        builder: (context, value, child) {
          return Column(
            children: [
              _buildCalendarHeader(),
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
                              children: List<Widget>.generate(events.length, (index) {
                                if (index >= maxCalendarEventsAmount) {
                                  return SizedBox.shrink();
                                }
                                return Icon(
                                  index == maxCalendarEventsAmount - 1 && events.length > maxCalendarEventsAmount
                                    ? AppIconData.add
                                    : events[index].type.iconData,
                                  size: context.sizes.iconCalendarEvent,
                                  color: (day.month == _focusedDay.value.month)
                                    ? context.theme.calendarColors.eventIcon
                                    : context.theme.calendarColors.eventOtherMonthIcon
                                );
                              })
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    calendarStyle: _calendarStyle,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        color: context.theme.calendarColors.weekdayText,
                        fontSize: context.sizes.textBasic,
                      ),
                      weekendStyle: TextStyle(
                        color: context.theme.calendarColors.weekdayText,
                        fontSize: context.sizes.textBasic,
                      ),
                    ),
                    daysOfWeekHeight: context.sizes.calendarWeekdaysHeight,
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
                      _selectedDay.value = null;
                      _selectedEvents.value = [];
                    },
                  );
                }
              ),

              const SizedBox(height: 15.0),
              if (_selectedDay.value != null && _selectedEvents.value.isNotEmpty)
                Padding(
                  padding: AppInsets.divider,
                  child: Divider(
                    height: context.sizes.dividerMinimal,
                  ),
                ),
              ValueListenableBuilder(
                  valueListenable: _selectedDay,
                  builder: (context, day, _) {
                    if (day != null) {
                      return Expanded(
                        child: ValueListenableBuilder<List<CalendarEvent>>(
                          valueListenable: _selectedEvents,
                          builder: (context, list, _) {
                            return EventsAnimatedList(
                              newList: list,
                              newDate: _selectedDay.value!,
                              onTap: _onEventListTileTap,
                            );
                          },
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          const SizedBox(height: 15.0),
                          Text(
                            MiscStrings.noDaySelected,
                            style: TextStyle(
                                color: context.theme.mainColors.defaultWidget,
                                fontSize: context.sizes.titleSmall
                            ),
                          ),
                        ],
                      );
                    }
                  },
              ),

            ],
          );
        }
      ),
    );
  }


  CalendarStyle get _calendarStyle =>
    CalendarStyle(
      defaultTextStyle: TextStyle(color: context.theme.calendarColors.basicText, fontSize: context.sizes.textCalendar),
      weekendTextStyle: TextStyle(color: context.theme.calendarColors.weekendText, fontSize: context.sizes.textCalendar),
      disabledTextStyle: TextStyle(color: context.theme.calendarColors.disabledText, fontSize: context.sizes.textCalendar),
      outsideTextStyle: TextStyle(color: context.theme.calendarColors.outsideText, fontSize: context.sizes.textCalendar),
      selectedDecoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.theme.calendarColors.selectedEvent,
      ),
      todayTextStyle: TextStyle(color: context.theme.calendarColors.weekendText),
      todayDecoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.theme.calendarColors.todayEvent,
      ),
    );


  Future<void> _onEventListTileTap(CalendarEvent event) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventPage(event: event),
      ),
    );
    if (result == true) {
      await widget.onReload!();
      if (mounted && _selectedDay.value != null) {
        _selectedEvents.value = _getEventsForDay(_selectedDay.value!);
      }
      setState(() {});
    }
  }


  Widget _buildCalendarHeader() {
    final headerText = DateFormatter.dateWithoutDay(_focusedDay.value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: context.sizes.iconBasic,
            ),
            onPressed: () {
              _pageController.previousPage(
                duration: Duration(milliseconds: calendarDuration),
                curve: Curves.easeOut,
              );
              _selectedDay.value = null;
              _selectedEvents.value = [];
            },
            color: context.theme.calendarColors.navigationIcon,
          ),
          SizedBox(
            width: 170,
            child: TextButton(
              onPressed: () => _showPopUp(),
              child: Text(
                headerText,
                style: TextStyle(fontSize: context.sizes.titleLarge),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.calendar_today,
              size: context.sizes.iconMedium
            ),
            visualDensity: VisualDensity.compact,
            onPressed: () {
              setState(() {
                _focusedDay.value = DateTime.now();
                _selectedDay.value = DateTime.now();
                _selectedEvents.value = _getEventsForDay(_selectedDay.value!);
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              size: context.sizes.iconBasic,
            ),
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: calendarDuration),
                curve: Curves.easeOut,
              );
              _selectedDay.value = null;
              _selectedEvents.value = [];
            },
            color: context.theme.calendarColors.navigationIcon,
          ),
        ],
      ),
    );
  }

  void _showPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
                MiscStrings.selectMonth,
                style: TextStyle(
                  color: context.theme.calendarColors.title,
                  fontSize: context.sizes.textBasic
                ),
              )),
          content: SizedBox(
            height: 100,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                        fontSize: context.sizes.titleSmall,
                        color: context.theme.mainColors.text
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
              child: Text(
                ButtonStrings.ok,
                style: TextStyle(fontSize: context.sizes.textBasic),
              ),
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
}