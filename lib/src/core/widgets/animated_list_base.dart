import 'package:flutter/material.dart';

abstract class AnimatedListBase<T> extends StatefulWidget {
  const AnimatedListBase({
    super.key,
    required this.newList,
  });

  final List<T> newList;
}

class AnimatedListBaseState<T, W extends AnimatedListBase<T>> extends State<W> {
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late ListModel<T> list;

  @override
  void initState() {
    super.initState();
    list = ListModel<T>(
      listKey: listKey,
      initialItems: widget.newList,
      removedItemBuilder: buildRemovedItem,
    );
  }

  @override
  void didUpdateWidget(covariant W oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    removeItems();
    insertItems();
  }


  void removeItems() {
    final newList = widget.newList;

    for (int i = list.length - 1; i >= 0; i--) {
      final item = list[i];
      if (!newList.contains(item)) {
        list.removeAt(i);
      }
    }
  }

  void insertItems(){
    final newList = widget.newList;

    for (int i = 0; i < newList.length; i++) {
      final item = newList[i];
      int itemListIndex = list.indexOf(item);
      if (itemListIndex == -1) {
        list.insert(i, item);
      } else {
        list.update(i, item);
        setState(() {});
      }
    }
  }


  Widget buildItem(BuildContext context, int index, Animation<double> animation) {
    throw UnimplementedError();
  }

  Widget buildRemovedItem(T item, BuildContext context, Animation<double> animation,) {
    throw UnimplementedError();
  }

  
  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      key: listKey,
      initialItemCount: list.length,
      itemBuilder: buildItem,
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

  void update(int index, E item) {
    items[index] = item;
  }

  int get length => items.length;

  E operator [](int index) => items[index];

  int indexOf(E item) => items.indexOf(item);

  bool get isEmpty => items.isEmpty;
}