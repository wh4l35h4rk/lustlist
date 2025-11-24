import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';

class ErrorTile extends StatelessWidget {
  final IconData iconData;
  final String title;

  const ErrorTile({
    super.key,
    this.iconData = Icons.bug_report,
    this.title = MiscStrings.errorLoadingData,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 36),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: AppSizes.iconHelper,
              color: AppColors.categoryTile.leadingIcon(context),
            ),
            SizedBox(width: 5,),
            Text(
              title,
              style: TextStyle(
                color: AppColors.categoryTile.text(context),
                fontSize: AppSizes.textBasic
              ),
            )
          ],
        ),
      ),
    );
  }
}