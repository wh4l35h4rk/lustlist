import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:marquee/marquee.dart';


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
      title: TitleWidget(title: title, editButton: editButton),
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


class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    this.editButton,
  });

  final String title;
  final Widget? editButton;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildTitle(context, constraints.maxWidth);
      },
    );
  }

  Widget _buildTitle(BuildContext context, double maxWidth) {
    final TextStyle style = TextStyle(
      fontSize: PageTitleStrings.mainPages.contains(title)
          ? AppSizes.appbarLarge
          : AppSizes.appbarBasic,
      color: editButton == null
          ? AppColors.appBar.title(context)
          : AppColors.appBar.text(context),
    );

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: title, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    final bool overflow = textPainter.width > maxWidth;

    if (overflow) {
      return SizedBox(
        width: maxWidth,
        height: kToolbarHeight,
        child: Center(
          child: Marquee(
            text: title,
            style: style,
            velocity: 30.0,
            blankSpace: 20.0,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      );
    } else {
      return Text(
        title,
        style: style,
        maxLines: 1
      );
    }
  }
}
