import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/core/widgets/droplist_button.dart';

class ButtonStub<T> extends StatelessWidget {
  const ButtonStub({
    required this.title,
    this.isDroplist = true,
    super.key,
  });

  final String title;
  final bool isDroplist;

  @override
  Widget build(BuildContext context) {
    if (isDroplist) {
      return DroplistButton(
        title: title,
        backgroundColor: context.theme.mainColors.surface,
        onPressed: null,
      );
    } else {
      return OutlinedButton(
        style: AppStyles.outlinedButton(context.theme.mainColors.surface, context),
        onPressed: null,
        child: Text(title),
      );
    }
  }
}
