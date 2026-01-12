import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';

class LegendRow extends StatelessWidget {
  const LegendRow({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: AppSizes.textBasic,
            color: textColor,
          ),
        )
      ],
    );
  }
}