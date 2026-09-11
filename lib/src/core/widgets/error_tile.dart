import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/providers/scale_provider.dart';


class ErrorTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool colorsInverted;

  const ErrorTile({
    super.key,
    this.iconData = AppIconData.error,
    this.title = MiscStrings.errorLoadingData,
    this.colorsInverted = false
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: context.sizes.iconHelper,
              color: colorsInverted ? context.theme.appBarColors.icon : context.theme.categoryTileColors.leadingIcon,
            ),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                color: colorsInverted ? context.theme.appBarColors.text : context.theme.categoryTileColors.text,
                fontSize: context.sizes.textBasic
              ),
            )
          ],
        ),
      ),
    );
  }
}