import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/providers/scale_provider.dart';


class SelectableOptionTile extends StatelessWidget {
  const SelectableOptionTile({
    super.key,
    required this.title,
    required this.iconData,
    this.iconSize,
  });

  final String title;
  final IconData iconData;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.theme.addEventColors.border,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: context.sizes.textBasic,
                  color: context.theme.addEventColors.text
              ),
            ),
            SizedBox(width: 5,),
            Icon(
              iconData,
              size: iconSize ?? context.sizes.iconMedium,
              color: context.theme.addEventColors.coloredText,
            )
          ],
        ),
      ),
    );
  }
}