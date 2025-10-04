import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/example_utils.dart';


class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? backButton;
  final Widget? editButton;
  final String title;

  const MainAppBar({
    super.key,
    this.backButton,
    this.editButton,
    this.title = appTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.appBar.surface(context),
      title: editButton == null ?
        Text(
          title,
          style: TextStyle(
            fontSize: title != appTitle ? 20 : 25,
            color: AppColors.appBar.title(context),
          ),
        ) :
        Row(children: [
          Spacer(),
          Text(
            title,
            style: TextStyle(
                fontSize: title != appTitle ? 20 : 25,
                color: AppColors.appBar.text(context),
            ),
          ),
          Spacer(),
          editButton!,
        ],),
      leading: backButton,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}