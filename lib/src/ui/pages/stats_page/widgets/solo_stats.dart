import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/strings/chart_strings.dart';
import 'package:lustlist/src/ui/pages/stats_page/widgets/percentage_stats_column.dart';


class SoloStats extends StatelessWidget{
  final List<int> pornStats;
  final List<int> toysStats;

  const SoloStats({
    required this.pornStats,
    required this.toysStats,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppInsets.stats,
        child: Row(
          spacing: 10,
          children: [
            Expanded(
              flex: 1,
              child: PercentageStatsColumn(
                valueTarget: pornStats[0],
                valueTotal: pornStats[1],
                title: ChartStrings.pornRatio,
                bgIconData: Icons.play_circle_outline
              )
            ),
            Expanded(
              flex: 1,
              child: PercentageStatsColumn(
                  valueTarget: toysStats[0],
                  valueTotal: toysStats[1],
                  title: ChartStrings.toyRatio,
                  bgIconData: CategoryIcons.vibrator
              )
            ),
          ]
        ),
      ),
    );
  }
}