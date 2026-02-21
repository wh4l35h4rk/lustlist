import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/strings/chart_strings.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/domain/entities/event_duration.dart';
import 'package:lustlist/src/ui/pages/stats_page/widgets/minmax_duration_widget.dart';

class TotalDuration extends StatelessWidget {
  final int? sexDuration;
  final int? mstbDuration;

  const TotalDuration({
    required this.sexDuration,
    required this.mstbDuration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.stats,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringFormatter.colon(ChartStrings.totalDuration),
            style: AppStyles.chartTitle(context)
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: MinMaxDurationColumn(
                  event: null,
                  title: DataStrings.sex,
                  value: sexDuration != null ? EventDuration(sexDuration!) : null,
                  iconData: CategoryIcons.two,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: MinMaxDurationColumn(
                  event: null,
                  title: DataStrings.mstb,
                  value: mstbDuration != null ? EventDuration(mstbDuration!) : null,
                  iconData: Icons.front_hand,
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }
}