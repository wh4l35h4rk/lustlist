import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/strings/chart_strings.dart';
import 'package:lustlist/src/domain/entities/event_duration_stats.dart';
import 'package:lustlist/src/ui/pages/stats_page/widgets/avg_duration_widget.dart';
import 'package:lustlist/src/ui/pages/stats_page/widgets/minmax_duration_widget.dart';


class DurationStats extends StatelessWidget{
  final EventDurationStats mstbStats;
  final EventDurationStats sexStats;

  const DurationStats({
    required this.sexStats,
    required this.mstbStats,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.stats,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: AvgDurationColumn(
                  avgInMinutes: sexStats.avgInMinutes,
                  title: ChartStrings.avgSexDuration,
                  bgIconData: CupertinoIcons.time,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    MinMaxDurationColumn(
                      event: sexStats.minEvent,
                      title: ChartStrings.minSexDuration,
                    ),
                    SizedBox(height: 20),
                    MinMaxDurationColumn(
                      event: sexStats.maxEvent,
                      title: ChartStrings.maxSexDuration,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      MinMaxDurationColumn(
                        event: mstbStats.minEvent,
                        title: ChartStrings.minMstbDuration,
                      ),
                      SizedBox(height: 20),
                      MinMaxDurationColumn(
                        event: mstbStats.maxEvent,
                        title: ChartStrings.maxMstbDuration,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AvgDurationColumn(
                    avgInMinutes: mstbStats.avgInMinutes,
                    title: ChartStrings.avgMstbDuration,
                    bgIconData: Icons.front_hand_outlined,
                    bgIconSize: 150,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}