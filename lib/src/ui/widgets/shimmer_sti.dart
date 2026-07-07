import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerSti extends StatelessWidget {
  const ShimmerSti({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.theme.categoryTileColors.shimmerBase,
      highlightColor: context.theme.categoryTileColors.shimmerHighlight,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, _) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
                  color: Colors.white
              ),
              width: double.infinity,
              height: 35,
            )
        ),
        itemCount: 5,
      ),
    );
  }
}