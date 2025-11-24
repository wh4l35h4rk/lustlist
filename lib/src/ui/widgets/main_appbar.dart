import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/core/utils/utils.dart';


class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? backButton;
  final Widget? editButton;
  final Widget? deleteButton;
  final Widget? themeButton;
  final String title;

  const MainAppBar({
    super.key,
    this.backButton,
    this.editButton,
    this.deleteButton,
    this.themeButton,
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
          fontSize: PageTitleStrings.mainPages.contains(title) ? AppSizes.appbarLarge : AppSizes.appbarBasic,
          color: editButton == null ? AppColors.appBar.title(context) : AppColors.appBar.text(context),
        ),
      ),
      leading: backButton,
      actions: [
        deleteButton ?? SizedBox.shrink(),
        editButton ?? SizedBox.shrink(),
        themeButton ?? SizedBox.shrink(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}