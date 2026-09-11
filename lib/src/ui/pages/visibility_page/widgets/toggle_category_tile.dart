import 'package:flutter/material.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/config/enums/type.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/providers/scale_provider.dart';


class ToggleCategoryTile extends StatefulWidget{
  final Category category;
  final IconData iconData;
  final double? iconSize;

  const ToggleCategoryTile({
    super.key,
    required this.category,
    required this.iconData,
    this.iconSize
  });

  @override
  State<ToggleCategoryTile> createState() => _ToggleCategoryTileState();
}

class _ToggleCategoryTileState extends State<ToggleCategoryTile> {
  late bool isSelected = widget.category.isVisible;
  EventRepository repo = EventRepository(database);

  @override
  Widget build(BuildContext context) {
    Color inactiveColor = context.theme.mainColors.notSelected;

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
            fontSize: context.sizes.titleSmall,
            color: isSelected ? context.theme.mainColors.text : inactiveColor
          ),
        ),
        leading: Icon(
          widget.iconData,
          size: widget.iconSize ?? context.sizes.iconBasic,
          color: isSelected ? context.theme.mainColors.icon : inactiveColor,
        ),
        trailing: Icon(
          isSelected ? AppIconData.checkboxSelected : AppIconData.checkboxNotSelected,
          size: context.sizes.iconBasic,
          color: isSelected ? context.theme.mainColors.icon : inactiveColor,
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