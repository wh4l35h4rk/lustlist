import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/enums/aggro_type.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/strings/chart_strings.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/core/widgets/default_divider.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/domain/entities/events_amount_data.dart';
import 'package:lustlist/src/domain/entities/option_rank.dart';
import 'package:lustlist/src/domain/repository_chart.dart';
import 'package:lustlist/src/ui/pages/stats_page/charts/last_week_bar_chart.dart';
import 'package:lustlist/src/ui/pages/stats_page/charts/orgasms_ratio_chart.dart';
import 'package:lustlist/src/ui/pages/stats_page/charts/duration_stats.dart';
import 'package:lustlist/src/domain/entities/event_duration_stats.dart';
import 'package:lustlist/src/ui/controllers/event_notifier.dart';
import 'package:lustlist/src/ui/pages/stats_page/charts/line_chart_yearly.dart';
import 'package:lustlist/src/ui/pages/stats_page/charts/solo_stats.dart';
import 'package:lustlist/src/ui/pages/stats_page/charts/top_options_chart.dart';
import 'package:lustlist/src/ui/pages/stats_page/widgets/total_duration_widget.dart';
import 'package:lustlist/src/ui/widgets/animated_appbar.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/config/constants/misc.dart';


class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}


class _StatsPageState extends State<StatsPage> {
  bool _isLoading = true;
  bool _isError = false;

  List<EventsAmountData>? weeklyRodData;
  List<EventsAmountData>? yearlyRodData;
  List<List<FlSpot>>? monthlySpots;
  EventDurationStats? sexDurationStats;
  EventDurationStats? mstbDurationStats;
  List<int?>? totalDurationStats;
  List<OptionRank>? topPractices;
  List<OptionRank>? topSoloPractices;
  List<OptionRank>? topPoses;
  List<int>? orgasmsAmount;
  List<int>? pornStats;
  List<int>? toysStats;

  @override
  void initState() {
    super.initState();
    _loadData();
    eventsUpdated.addListener(_onEventsUpdated);
  }

  @override
  void dispose() {
    eventsUpdated.removeListener(_onEventsUpdated);
    super.dispose();
  }


  void _onEventsUpdated() async {
    await Future.delayed(Duration(milliseconds: futureDelay));
    await _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    try {
      final repo = EventRepository(database);

      // events amount bar chart
      final barDataWeekly = await repo.getEventAmountListByDay(Duration(days: 7));
      final barDataYearly = await repo.getEventAmountYearly();

      // last year data line chart
      final sexSpots = await repo.getSpotsListByMonth("sex");
      final mstbSpots = await repo.getSpotsListByMonth("masturbation");

      
      // duration stats
      final sexAvg = await repo.getAvgDuration("sex");
      final sexMaxEvent = await repo.getMaxOrMinDurationCalendarEvent("sex", AggroType.max);
      final sexMinEvent = await repo.getMaxOrMinDurationCalendarEvent("sex", AggroType.min);
      final mstbAvg = await repo.getAvgDuration("masturbation");
      final mstbMaxEvent = await repo.getMaxOrMinDurationCalendarEvent("masturbation", AggroType.max);
      final mstbMinEvent = await repo.getMaxOrMinDurationCalendarEvent("masturbation", AggroType.min);

      // total duration stats
      final sexTotal = await repo.getTotalDuration("sex");
      final mstbTotal = await repo.getTotalDuration("masturbation");

      // top options
      final topPracticesList = await repo.getOptionsRanked(categorySlug: "practices");
      final topSoloPracticesList = await repo.getOptionsRanked(categorySlug: "solo practices", limit: 3);
      final topPosesList = await repo.getOptionsRanked(categorySlug: "poses");

      // orgasm ratio
      final userOrgasms = await repo.getUserOrgasmsAmount("sex");
      final partnersOrgasms = await repo.getPartnersOrgasmsAmount();

      // solo stats
      final mstbWithPorn = await repo.getEventsWithPornAmount();
      final mstbWithToys = await repo.getEventsWithToysAmount();
      final totalSoloEvents = await repo.countEventsOfType("masturbation");


      setState(() {
        weeklyRodData = barDataWeekly;
        monthlySpots = [
          sexSpots,
          mstbSpots
        ];
        yearlyRodData = barDataYearly;
        
        sexDurationStats = EventDurationStats(sexAvg, sexMinEvent, sexMaxEvent);
        mstbDurationStats = EventDurationStats(mstbAvg, mstbMinEvent, mstbMaxEvent);
        totalDurationStats = [
          sexTotal,
          mstbTotal
        ];
        topPractices = topPracticesList;
        topPoses = topPosesList;
        topSoloPractices = topSoloPracticesList;

        orgasmsAmount = [
          userOrgasms,
          partnersOrgasms
        ];

        pornStats = [
          mstbWithPorn,
          totalSoloEvents
        ];
        toysStats = [
          mstbWithToys,
          totalSoloEvents
        ];

        _isLoading = false;
        _isError = false;
      });
    } catch (e) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
      return;
    }
  }


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          AnimatedAppBar(title: PageTitleStrings.statistics, hasBackButton: false),
          (_isLoading || _isError) ?
          SliverList(
            delegate: SliverChildListDelegate([
              _isLoading ?
              Padding(
                padding: AppInsets.progressInList,
                child: Center(child: CircularProgressIndicator()),
              ) : SizedBox.shrink(),
              _isError ?
              Padding(
                padding: AppInsets.progressInList,
                child: ErrorTile(),
              ) : SizedBox.shrink(),
          ])) :
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 15,),
              SexMstbEventsBarChart(
                eventAmountList: weeklyRodData!,
                getBottomTitles: _getBottomTitlesWeekly,
                title: ChartStrings.lastWeekChart,
                isWeekly: true,
                gridHorizontalInterval: 1,
              ),
              DefaultDivider(),
              DurationStats(
                mstbStats: mstbDurationStats!,
                sexStats: sexDurationStats!,
              ),
              DefaultDivider(),
              TopOptionsChart(
                optionsList: topPractices!,
                title: ChartStrings.topPracticesChart,
                barAccentColor: AppColors.chart.practicesAccent(),
              ),
              DefaultDivider(),
              TopOptionsChart(
                optionsList: topPoses!,
                title: ChartStrings.topPosesChart,
                barAccentColor: AppColors.chart.posesAccent(),
              ),
              DefaultDivider(),
              OrgasmsRatioChart(
                userAmount: orgasmsAmount![0],
                partnersAmount: orgasmsAmount![1],
              ),
              DefaultDivider(),
              TotalDuration(
                sexDuration: totalDurationStats![0],
                mstbDuration: totalDurationStats![1],
              ),
              DefaultDivider(),
              TopOptionsChart(
                optionsList: topSoloPractices!,
                title: ChartStrings.topSoloPracticesChart,
                barAccentColor: AppColors.chart.soloPracticesAccent(),
              ),
              DefaultDivider(),
              SoloStats(pornStats: pornStats!, toysStats: toysStats!),
              DefaultDivider(),
              LineChartMonthly(spots: monthlySpots!),
              DefaultDivider(),
              SexMstbEventsBarChart(
                eventAmountList: yearlyRodData!,
                title: ChartStrings.allYearsChart,
                isWeekly: false,
                getBottomTitles: _getBottomTitlesYearly,
              ),
              SizedBox(height: 25)
          ])),
        ]
    );
  }


  Widget _getBottomTitlesWeekly(double value, TitleMeta meta, BuildContext context) {
    final style = AppStyles.chartSideTitles(context);

    final DateTime date = DateTime.now().subtract(Duration(days: 6 - value.toInt()));
    final String text = DateFormatter.weekday(date);

    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }

  Widget _getBottomTitlesYearly(double value, TitleMeta meta, BuildContext context) {
    final style = AppStyles.chartSideTitles(context);

    DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    String text = date.year.toString();

    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.right,
        softWrap: true,
      ),
    );
  }
}