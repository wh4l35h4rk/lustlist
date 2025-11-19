import 'package:flutter/cupertino.dart';
import '../colors.dart';

class InfoRow extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Widget child;

  const InfoRow({
    required this.iconData,
    required this.title,
    required this.child,
    super.key
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(
            iconData,
            color: AppColors.eventData.icon(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              title,
              style: TextStyle(
                  color: AppColors.eventData.title(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}