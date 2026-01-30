import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';

class CheckmarkLegendRow extends StatelessWidget {
  final IconData iconData;
  final Function onTap;
  final String title;
  final Widget marker;
  final Color? iconColor;
  final Color? titleColor;

  const CheckmarkLegendRow({
    required this.title,
    required this.iconData,
    required this.onTap,
    required this.marker,
    this.iconColor,
    this.titleColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Icon(
            iconData,
            size: AppSizes.iconBasic,
            color: iconColor ?? AppColors.icon(context),
          ),
          onTap: () => onTap(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: marker,
        ),
        Text(
          title,
          style: TextStyle(
            color: titleColor ?? AppColors.text(context),
            fontSize: AppSizes.textBasic,
          ),
        )
      ],
    );
  }
}