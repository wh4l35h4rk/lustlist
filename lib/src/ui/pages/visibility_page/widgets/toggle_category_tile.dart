import 'package:flutter/material.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/enums/type.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/domain/repository.dart';


class ToggleCategoryTile extends StatefulWidget{
  final Category category;
  final IconData iconData;
  final double iconSize;

  const ToggleCategoryTile({
    super.key,
    required this.category,
    required this.iconData,
    this.iconSize = AppSizes.iconBasic
  });

  @override
  State<ToggleCategoryTile> createState() => _ToggleCategoryTileState();
}

class _ToggleCategoryTileState extends State<ToggleCategoryTile> {
  late bool isSelected = widget.category.isVisible;
  EventRepository repo = EventRepository(database);

  @override
  Widget build(BuildContext context) {
    Color inactiveColor = MainColors.notSelected(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        dense: true,
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          _toggleVisibility(isSelected);
        },
        title: Text(
          title(),
          style: TextStyle(
            fontSize: AppSizes.titleSmall,
            color: isSelected ? MainColors.text(context) : inactiveColor
          ),
        ),
        leading: Icon(
          widget.iconData,
          size: widget.iconSize,
          color: isSelected ? MainColors.icon(context) : inactiveColor,
        ),
        trailing: Icon(
          isSelected ? AppIconData.checkboxSelected : AppIconData.checkboxNotSelected,
          color: isSelected ? MainColors.icon(context) : inactiveColor,
        ),
      ),
    );
  }

  Future _toggleVisibility(bool value) async {
    repo.toggleCategoryVisibility(widget.category, value);
  }

  String title() {
    if (widget.category.slug == 'solo practices') {
      return "${widget.category.name} (${EventType.masturbation.name})";
    } else {
      return widget.category.name;
    }
  }
}