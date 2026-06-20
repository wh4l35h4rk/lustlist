import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';

class SwitchColumnBase extends StatelessWidget {
  const SwitchColumnBase({
    super.key,
    required this.title,
    required this.iconData,
    required this.child,
    this.iconSize,
  });

  final Widget child;
  final String title;
  final IconData iconData;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      children: [
        Row(
          spacing: 6,
          children: [
            Padding(
              padding: EdgeInsets.only(right: iconSize != null ? 6 : 0),
              child: Icon(
                iconData,
                color: AddEventColors.icon(context),
                size: iconSize ?? AppSizes.iconBasic,
              ),
            ),
            Text(
              StringFormatter.colon(title),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AddEventColors.title(context),
                fontSize: AppSizes.titleSmall,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        child
      ],
    );
  }
}