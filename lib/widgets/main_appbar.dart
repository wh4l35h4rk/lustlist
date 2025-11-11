import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/example_utils.dart';


class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? backButton;
  final Widget? editButton;
  final Widget? deleteButton;
  final String title;

  const MainAppBar({
    super.key,
    this.backButton,
    this.editButton,
    this.deleteButton,
    this.title = appTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.appBar.surface(context),
      title: Text(
        title,
        style: TextStyle(
          fontSize: title != appTitle ? 19 : 25,
          color: editButton == null ? AppColors.appBar.title(context) : AppColors.appBar.text(context),
        ),
      ),
      leading: backButton,
      actions: [
        deleteButton ?? SizedBox.shrink(),
        editButton ?? SizedBox.shrink(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}