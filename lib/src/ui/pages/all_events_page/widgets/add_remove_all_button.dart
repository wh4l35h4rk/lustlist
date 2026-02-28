import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/styles.dart';


class AddRemoveAllButton extends StatelessWidget {
  const AddRemoveAllButton({
    required this.onPressed,
    required this.title,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: OutlinedButton(
        onPressed: () => onPressed(),
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surface(context),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: BorderSide(
              width: 1.2,
              color: AppColors.addEvent.border(context)
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
