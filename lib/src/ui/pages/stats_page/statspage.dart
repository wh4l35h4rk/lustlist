import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/enums/aggro_type.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/core/widgets/duration_stats.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
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
  List<dynamic>? avgSexStats;

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

      final List<Future<Object?>> futures = [
        repo.getSpotsListByMonth("sex", period) as Future<Object?>, // List<FlSpot>
        repo.getSpotsListByMonth("masturbation", period) as Future<Object?>, // List<FlSpot>
        repo.getAvgDuration("sex") as Future<Object?>, // double?
        repo.getMaxOrMinDurationCalendarEvent("sex", AggroType.max) as Future<Object?>, // CalendarEvent?
        repo.getMaxOrMinDurationCalendarEvent("sex", AggroType.min) as Future<Object?>, // CalendarEvent?
      ];

      final List<Object?> results = await Future.wait(futures);

      if (results[0] is List<FlSpot> && results[1] is List<FlSpot>
          && results[2] is double? && results[3] is CalendarEvent? && results[4] is CalendarEvent?
      ) {
        setState(() {
          yearlySpots = [
            results[0] as List<FlSpot>,
            results[1] as List<FlSpot>,
          ];
          avgSexStats = [
            results[2] as double?,
            results[3] as CalendarEvent?,
            results[4] as CalendarEvent?,
          ];
          _isLoading = false;
          _isError = false;
        });
      } else {
        throw Exception('Invalid data types received');
      }
    } catch (e) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
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
                avgInMinutes: avgSexStats![0],
                maxEvent: avgSexStats![1],
                minEvent: avgSexStats![2],
              ),
              Padding(
                padding: AppInsets.divider,
                child: Divider(height: AppSizes.dividerMinimal,),
              ),
              LineChartYearly(
                spots: yearlySpots!,
              )
          ])),
        ]
    );
  }
}