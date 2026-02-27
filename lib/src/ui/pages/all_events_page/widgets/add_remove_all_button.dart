import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 40,
        child: OutlinedButton(
          onPressed: () => onPressed(),
          style: AppStyles.filterAllButton(context),
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
      ),
    );
  }
}
