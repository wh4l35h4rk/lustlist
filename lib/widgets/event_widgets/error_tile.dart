import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';

class ErrorTile extends StatelessWidget {
  final IconData iconData;
  final String title;

  const ErrorTile({
    super.key,
    required this.iconData,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 36),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 30,
            color: AppColors.categoryTile.leadingIcon(context),
          ),
          SizedBox(width: 5,),
          Text(
            title,
            style: TextStyle(
              color: AppColors.categoryTile.text(context),
              fontSize: 14
            ),
          )
        ],
      ),
    );
  }
}