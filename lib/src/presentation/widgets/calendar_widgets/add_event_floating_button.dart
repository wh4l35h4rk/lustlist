import 'package:flutter/material.dart';
import '../../pages/main_pages/calendar_page.dart';

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
      alignmentOffset: Offset(-5, 10),
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
            child: Icon(iconsData[index])
        ),
      ),
    );
  }
}