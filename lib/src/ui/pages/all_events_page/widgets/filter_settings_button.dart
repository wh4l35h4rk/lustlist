import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/styles.dart';


class FilterSettingsButton extends StatelessWidget {
  const FilterSettingsButton({
    required this.onPressed,
    required this.title,
    this.backgroundColor,
    this.icon,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: OutlinedButton(
        onPressed: () => onPressed(),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.surface(context),
          side: BorderSide(
              width: 1.2,
              color: AppColors.addEvent.border(context)
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ?icon,
            if (icon != null) SizedBox(width: 6,),
            Text(
              title,
              textAlign: TextAlign.left,
              style: AppStyles.addEventBasicText(context)
            ),
          ],
        ),
      ),
    );
  }
}
