import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/colors.dart';


class DroplistButton<T> extends StatelessWidget {
  const DroplistButton({
    required this.title,
    required this.backgroundColor,
    required this.onPressed,
    super.key,
  });

  final String title;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(
              width: 1.2,
              color: AppColors.addEvent.border(context)
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            Text(title),
            Icon(AppIconData.dropList)
          ],
        )
    );
  }
}
