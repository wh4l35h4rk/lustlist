import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/providers/scale_provider.dart';


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
        borderRadius: BorderRadiusGeometry.circular(context.sizes.listTileBorderRadius),
        border: Border.all(color: context.theme.calendarColors.border),
      ),
      child: ListTile(
          onTap: () => _onTap(page, context),
          leading: Icon(
            iconData,
            size: context.sizes.iconBasic,
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
            style: TextStyle(fontSize: context.sizes.textBasic)
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