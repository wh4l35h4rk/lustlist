import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/providers/scale_provider.dart';


class EventListTile extends StatelessWidget {
  const EventListTile({
    required this.title,
    required this.subtitleWidget,
    required this.iconData,
    required this.onTap,
    this.titleSize,
    this.hasBorder = false,
    this.borderColor,
    super.key,
  });

  final GestureTapCallback? onTap;
  final String title;
  final Widget subtitleWidget;
  final IconData? iconData;
  final bool hasBorder;
  final double? titleSize;
  final Color? borderColor;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 4.0,
            ),
            padding: AppInsets.eventListTile,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    iconData,
                    size: context.sizes.iconBasic
                  ),
                  SizedBox(width: 15),
                  if (hasBorder) Container(
                    width: 1,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                            color: borderColor ?? context.theme.mainColors.defaultWidget,
                            width: 2.8
                        )
                      )
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: titleSize ?? context.sizes.titleLarge,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                          subtitleWidget
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Icon(AppIconData.arrowRight, size: context.sizes.iconBasic)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}