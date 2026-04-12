import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';


class EventListTile extends StatelessWidget {
  const EventListTile({
    required this.title,
    required this.subtitleWidget,
    required this.iconData,
    required this.onTap,
    this.titleSize = AppSizes.titleLarge,
    this.hasBorder = false,
    this.borderColor,
    super.key,
  });

  final GestureTapCallback? onTap;
  final String title;
  final Widget subtitleWidget;
  final IconData? iconData;
  final bool hasBorder;
  final double titleSize;
  final Color? borderColor;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
          child: ListTile(
              onTap: onTap,
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    iconData
                  ),
                  SizedBox(width: 15),
                  if (hasBorder) Container(
                    height: double.infinity,
                    width: 1,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: borderColor ?? AppColors.defaultTile(context),
                          width: 2.8
                        )
                      )
                    ),
                  )
                ],
              ),
              title: Wrap(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              subtitle: subtitleWidget,
              trailing: Icon(AppIconData.arrowRight)
          ),
        ),
      ],
    );
  }
}