import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/ui/pages/calendar_page/widgets/calendar_event_listtile.dart';
import 'package:table_calendar/table_calendar.dart';


class EventsAnimatedList extends StatefulWidget {
  const EventsAnimatedList({
    super.key,
    required this.newList,
    required this.newDate,
    required this.onTap,
  });

  final List<CalendarEvent> newList;
  final Function(CalendarEvent item) onTap;
  final DateTime newDate;

  @override
  State<EventsAnimatedList> createState() => _EventsAnimatedListState();
}

class _EventsAnimatedListState extends State<EventsAnimatedList> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  late ListModel<CalendarEvent> _list;
  DateTime? _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.newDate;
    _list = ListModel<CalendarEvent>(
      listKey: _listKey,
      initialItems: widget.newList,
      removedItemBuilder: _buildRemovedItem,
    );
  }

  @override
  void didUpdateWidget(covariant EventsAnimatedList oldWidget) {
    super.didUpdateWidget(oldWidget);

    bool dateChanged = !isSameDay(_currentDate, widget.newDate);

    if (dateChanged) {
      _currentDate = widget.newDate;
      final newKey = GlobalKey<AnimatedListState>();

      _list = ListModel(
        listKey: newKey,
        initialItems: widget.newList,
        removedItemBuilder: _buildRemovedItem,
      );

      _listKey = newKey;
      setState(() {});
      return;
    }

    final newList = widget.newList;

    for (int i = _list.length - 1; i >= 0; i--) {
      final item = _list[i];
      if (!newList.contains(item)) {
        _list.removeAt(i);
      }
    }

    for (int i = 0; i < newList.length; i++) {
      final item = newList[i];
      if (_list.indexOf(item) == -1) {
        _list.insert(i, item);
      }
    }
  }


  Widget _buildItem(BuildContext context,
      int index,
      Animation<double> animation,) {
    return SizeTransition(
      sizeFactor: animation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalendarEventListTile(
            event: _list[index],
            onTap: () => widget.onTap(_list[index]),
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

  Widget _buildRemovedItem(CalendarEvent item,
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
          key: _listKey,
          initialItemCount: _list.length,
          itemBuilder: _buildItem,
        ),

        if (_list.isEmpty)
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


typedef RemovedItemBuilder<T> = Widget Function(T item, BuildContext context, Animation<double> animation);

class ListModel<E> {
  ListModel({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    items.insert(index, item);
    _animatedList!.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(index, (
          BuildContext context,
          Animation<double> animation,
          ) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => items.length;

  E operator [](int index) => items[index];

  int indexOf(E item) => items.indexOf(item);

  bool get isEmpty => items.isEmpty;
}