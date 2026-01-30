import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';

class LineLegend extends StatelessWidget {
  final Color color;
  final bool hasDots;

  const LineLegend({
    super.key,
    required this.color,
    required this.hasDots
  });

  @override
  Widget build(BuildContext context) {
    double dotSize = 8;
    double width = 30;

    return Stack(
      children: [
        Padding(
          padding: hasDots ?
            const EdgeInsets.only(top: 2.0) :
            const EdgeInsets.all(0),
          child: Container(
            height: 1,
            width: width,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: color,
                        width: AppSizes.chartLineWidth
                    )
                )
            ),
          ),
        ),
        hasDots ? Padding(
          padding: EdgeInsets.symmetric(horizontal: (width - dotSize) / 2),
          child: Container(
            height: dotSize,
            width: dotSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(20),
              color: color,
            ),
          ),
        ) : SizedBox.shrink()
      ]
    );
  }
}