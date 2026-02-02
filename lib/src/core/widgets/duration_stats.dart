import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/chart_strings.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';

class DurationStats extends StatelessWidget{
  const DurationStats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.stats,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Icon(
                    CupertinoIcons.clock,
                    color: AppColors.chart.bgIcon(context),
                    size: 180,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      StringFormatter.colon(ChartStrings.avgSexDuration),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.chart.title(context),
                        fontSize: AppSizes.titleSmall,
                        letterSpacing: AppSizes.chartTitleSpacing,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '55',
                        style: TextStyle(
                          fontSize: AppSizes.numStatsLarge,
                          color: AppColors.chart.subtitle(context)
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' min',
                            style: TextStyle(
                                fontSize: AppSizes.textBasic,
                                color: AppColors.text(context)
                            )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ]
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringFormatter.colon(ChartStrings.minSexDuration),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.chart.title(context),
                    fontSize: AppSizes.titleSmall,
                    letterSpacing: AppSizes.chartTitleSpacing,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '15',
                    style: TextStyle(
                        fontSize: AppSizes.numStatsMedium,
                        color: AppColors.chart.subtitle(context)
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' min',
                          style: TextStyle(
                              fontSize: AppSizes.textBasic,
                              color: AppColors.text(context)
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  StringFormatter.colon(ChartStrings.maxSexDuration),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.chart.title(context),
                    fontSize: AppSizes.titleSmall,
                    letterSpacing: AppSizes.chartTitleSpacing,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '1',
                    style: TextStyle(
                        fontSize: 35,
                        color: AppColors.chart.subtitle(context)
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' h   ',
                          style: TextStyle(
                              fontSize: AppSizes.textBasic,
                              color: AppColors.text(context)
                          )
                      ),
                      TextSpan(
                          text: '25',
                      ),
                      TextSpan(
                          text: ' min',
                          style: TextStyle(
                              fontSize: AppSizes.textBasic,
                              color: AppColors.text(context)
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}