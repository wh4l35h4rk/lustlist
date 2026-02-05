import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/enums/aggro_type.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/core/widgets/duration_stats.dart';
import 'package:lustlist/src/domain/entities/event_duration_stats.dart';
import 'package:lustlist/src/ui/controllers/event_notifier.dart';
import 'package:lustlist/src/ui/pages/stats_page/widgets/line_chart_yearly.dart';
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

  List<List<FlSpot>>? yearlySpots;
  EventDurationStats? sexDurationStats;
  EventDurationStats? mstbDurationStats;

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
      DateTime period = DateTime(1, 0, 0);

      // last year data line chart
      final sexSpots = await repo.getSpotsListByMonth("sex", period);
      final mstbSpots = await repo.getSpotsListByMonth("masturbation", period);

      // duration stats
      final sexAvg = await repo.getAvgDuration("sex");
      final sexMaxEvent = await repo.getMaxOrMinDurationCalendarEvent("sex", AggroType.max);
      final sexMinEvent = await repo.getMaxOrMinDurationCalendarEvent("sex", AggroType.min);
      final mstbAvg = await repo.getAvgDuration("masturbation");
      final mstbMaxEvent = await repo.getMaxOrMinDurationCalendarEvent("masturbation", AggroType.max);
      final mstbMinEvent = await repo.getMaxOrMinDurationCalendarEvent("masturbation", AggroType.min);

      setState(() {
        yearlySpots = [
          sexSpots,
          mstbSpots
        ];
        sexDurationStats = EventDurationStats(sexAvg, sexMinEvent, sexMaxEvent);
        mstbDurationStats = EventDurationStats(mstbAvg, mstbMinEvent, mstbMaxEvent);

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
              DurationStats(
                mstbStats: mstbDurationStats!,
                sexStats: sexDurationStats!,
              ),
              Padding(
                padding: AppInsets.divider,
                child: Divider(height: AppSizes.dividerMinimal,),
              ),
              LineChartYearly(spots: yearlySpots!)
          ])),
        ]
    );
  }
}