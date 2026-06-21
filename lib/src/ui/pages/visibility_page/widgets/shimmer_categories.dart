import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerCategories extends StatelessWidget {
  const ShimmerCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MainColors.shimmerBase(context),
      highlightColor: MainColors.shimmerHighlight(context),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, _) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
              color: Colors.white
            ),
            width: double.infinity,
            height: 40,
          )
        ),
        itemCount: 7,
      ),
    );
  }
}