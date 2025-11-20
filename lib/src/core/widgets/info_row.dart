import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';

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
            color: iconColor ?? AppColors.eventData.icon(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              title,
              style: TextStyle(
                  color: titleColor ?? AppColors.eventData.title(context),
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.titleSmall,
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}