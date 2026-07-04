import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerMstbSpecial extends StatelessWidget {
  const ShimmerMstbSpecial({
    super.key,
    required this.baseColor,
    required this.highlightColor,
    this.isDense = false,
  });

  final Color baseColor;
  final Color highlightColor;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: buildShimmer(context)
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: buildShimmer(context),
        ),
      ],
    );
  }

  Widget buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        height: isDense ? 70 : 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}