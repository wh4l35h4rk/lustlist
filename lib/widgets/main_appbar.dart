import 'package:flutter/material.dart';
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
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        title,
        style: TextStyle(
          fontSize: title != appTitle ? 20 : 25,
          color: Theme.of(context).colorScheme.surface
        ),
      ),
      leading: backButton,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}