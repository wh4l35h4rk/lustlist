import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/enums/gender.dart';
import 'package:lustlist/src/providers/scale_provider.dart';

class InfoRow extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Widget child;
  final Color? iconColor;
  final Color? titleColor;

  const InfoRow({
    required this.iconData,
    required this.title,
    required this.child,
    this.iconColor,
    this.titleColor,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(
            iconData,
            size: iconData == Gender.nonbinary.iconData
                ? context.sizes.iconNoninaryBasic : context.sizes.iconBasic,
            color: iconColor ?? context.theme.eventDataColors.icon,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              title,
              style: TextStyle(
                color: titleColor ?? context.theme.eventDataColors.title,
                fontWeight: FontWeight.bold,
                fontSize: context.sizes.titleSmall,
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}