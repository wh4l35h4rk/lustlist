import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/enums/type.dart';

class AddEventFloatingButton extends StatelessWidget {
  final Function onEventTap;

  const AddEventFloatingButton({
    super.key,
    required this.onEventTap
  });

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (BuildContext context, MenuController controller, Widget? child) {
        return FloatingActionButton(
          elevation: 3,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: const Icon(AppIconData.add),
        );
      },
      alignmentOffset: AppInsets.floatingButtonOffset,
      style: MenuStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20)
          )
        )
      ),
      menuChildren: List<MenuItemButton>.generate(
        3,
        (int index) => MenuItemButton(
          onPressed: () {
            onEventTap(index);
          },
          child: Icon(EventType.entries[index].iconData)
        ),
      ),
    );
  }
}