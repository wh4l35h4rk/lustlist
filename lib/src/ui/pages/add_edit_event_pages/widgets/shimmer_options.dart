import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerOptions extends StatelessWidget {
  const ShimmerOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AddEventColors.shimmerBase(context),
      highlightColor: AddEventColors.shimmerHighlight(context),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          spacing: 6,
          runSpacing: 6,
          children: List.generate(
              6,
              (index) => Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
          ),
        ),
      ),
    );
  }
}