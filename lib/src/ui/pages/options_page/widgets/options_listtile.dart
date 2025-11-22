import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/colors.dart';


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
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 6.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(12),
        border: Border.all(
            color: AppColors.calendar.border(context)
        ),
      ),
      child: ListTile(
          onTap: () => _onTap(page, context),
          leading: Icon(
            iconData,
            color: AppColors.calendar.eventIcon(context),
          ),
          title: Wrap(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: AppSizes.titleLarge,
                  fontWeight: FontWeight.bold
                ),
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
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
}