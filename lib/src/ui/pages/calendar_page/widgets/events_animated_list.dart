import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/ui/pages/calendar_page/widgets/calendar_event_listtile.dart';
import 'package:lustlist/src/core/widgets/animated_list_base.dart';
import 'package:table_calendar/table_calendar.dart';


class EventsAnimatedList extends AnimatedListBase<CalendarEvent> {
  const EventsAnimatedList({
    super.key,
    required super.newList,
    required this.newDate,
    required this.onTap,
  });


  final Function(CalendarEvent item) onTap;
  final DateTime newDate;

  @override
  State<EventsAnimatedList> createState() => _EventsAnimatedListState();
}

class _EventsAnimatedListState extends AnimatedListBaseState<CalendarEvent, EventsAnimatedList> {
  DateTime? _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.newDate;
  }

  @override
  void didUpdateWidget(covariant EventsAnimatedList oldWidget) {
    bool dateChanged = !isSameDay(_currentDate, widget.newDate);

    if (dateChanged) {
      _currentDate = widget.newDate;
      final newKey = GlobalKey<AnimatedListState>();

      list = ListModel(
        listKey: newKey,
        initialItems: widget.newList,
        removedItemBuilder: buildRemovedItem,
      );

      listKey = newKey;
      setState(() {});
      return;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget buildItem(BuildContext context,
      int index,
      Animation<double> animation,) {
    return SizeTransition(
      sizeFactor: animation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalendarEventListTile(
            event: list[index],
            onTap: () => widget.onTap(list[index]),
          ),
          Padding(
            padding: AppInsets.divider,
            child: Divider(
              height: AppSizes.dividerMinimal,
            ),
          )
        ],
      )
    );
  }

  @override
  Widget buildRemovedItem(CalendarEvent item,
      BuildContext context,
      Animation<double> animation,) {
    return SizeTransition(
        sizeFactor: animation,
        child: CalendarEventListTile(
            event: item
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedList(
          key: listKey,
          initialItemCount: list.length,
          itemBuilder: buildItem,
        ),

        if (list.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  MiscStrings.noEventsForDaySelected,
                  style: TextStyle(
                    color: AppColors.defaultTile(context),
                    fontSize: AppSizes.titleSmall,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}