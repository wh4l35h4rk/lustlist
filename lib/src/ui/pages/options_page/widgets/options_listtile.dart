import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/styles.dart';


class OptionsListTile extends StatelessWidget {
  const OptionsListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.page,
  });

  final Widget? page;
  final String title;
  final IconData iconData;
  final String subtitle;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppInsets.optionsListTile,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(AppSizes.listTileBorderRadius),
        border: Border.all(
            color: context.theme.calendarColors.border
        ),
      ),
      child: ListTile(
          onTap: () => _onTap(page, context),
          leading: Icon(
            iconData,
            color: context.theme.calendarColors.eventIcon,
          ),
          title: Wrap(
            children: [
              Text(
                title,
                style: AppStyles.largeTitleText(context)
              )
            ],
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: AppSizes.textBasic,
            )
          )
      ),
    );
  }

  Future<void> _onTap(Widget? page, BuildContext context) async {
    if (page == null) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
}