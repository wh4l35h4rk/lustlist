import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';

class LegendRow extends StatelessWidget {
  const LegendRow({
    super.key,
    required this.color,
    required this.text,
    this.notExpanded = false,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final double size;
  final Color? textColor;
  final bool notExpanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        notExpanded ?
        Text(
          text,
          style: TextStyle(
            fontSize: AppSizes.textBasic,
            color: textColor,
          ),
          softWrap: true,
        ) :
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: AppSizes.textBasic,
              color: textColor,
            ),
            softWrap: true,
          ),
        )
      ],
    );
  }
}