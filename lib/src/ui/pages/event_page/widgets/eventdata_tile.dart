import 'package:flutter/material.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/enums/type.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
import 'package:lustlist/src/ui/notifiers/event_notifier.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/sex_mstb_event/partners_column.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/sex_mstb_event/eventdata_column.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/medical_event/medical_data_tile.dart';
import 'package:lustlist/src/ui/widgets/shimmer_mstb_special.dart';
import 'package:lustlist/src/ui/widgets/switch_column_base.dart';


class EventDataTile extends StatefulWidget {
  const EventDataTile({
    super.key,
    required this.event,
  });

  final CalendarEvent event;

  @override
  State<EventDataTile> createState() => _EventDataTileState();
}

class _EventDataTileState extends State<EventDataTile> {
  bool _isLoading = true;
  bool _isError = false;
  bool? didWatchPorn;
  bool? didUseToys;

  @override
  void initState() {
    super.initState();
    _loadData();
    eventsUpdated.addListener(_loadData);
  }

  @override
  void dispose() {
    eventsUpdated.removeListener(_loadData);
    super.dispose();
  }
  
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    try {
      if (widget.event.type == EventType.masturbation) {
        final repo = EventRepository(database);

        int categoryId = await database.getCategoryIdBySlug("solo practices");
        List<EOption> options = await database.getEventOptionsByCategory(widget.event.event.id, categoryId);
        EOption pornOption = await repo.getOption("porn");
        EOption toysOption = await repo.getOption("solo toys");

        didWatchPorn = options.any((e) => e.id == pornOption.id);
        didUseToys = options.any((e) => e.id == toysOption.id);
      }
      if (!mounted) return;

      setState(() {
        _isError = false;
        _isLoading = false;
      });
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrint(stack.toString());
      if (!mounted) return;
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasicTile(
      surfaceColor: context.theme.eventDataColors.surface,
      margin: AppInsets.headerTile,
      child: buildTileBottom(context),
    );
  }

  Widget buildTileBottom(BuildContext context) {
    EventType type = widget.event.type;
    switch (type) {
      case EventType.sex:
        return Column(
          children: [
            EventDataColumn(event: widget.event),
            Padding(
              padding: AppInsets.dataDivider,
              child: Divider()
            ),
            PartnersColumn(event: widget.event),
          ],
        );
      case EventType.masturbation:
        return Column(
          children: [
            EventDataColumn(event: widget.event),
            Padding(
              padding: AppInsets.dataDivider,
              child: Divider()
            ),
            buildMstbSpecials(context),
          ]
        );
      case EventType.medical:
        return MedicalData(event: widget.event);
    }
  }


  Widget buildMstbSpecials(BuildContext context) {
    if (_isError) {
      return ErrorTile(colorsInverted: true);
    } else if (_isLoading || didUseToys == null || didWatchPorn == null) {
      return ShimmerMstbSpecial(
        baseColor: context.theme.eventDataColors.shimmerBase,
        highlightColor: context.theme.eventDataColors.shimmerHighlight,
        isDense: true,
      );
    }

    TextStyle style = TextStyle(
      fontSize: context.sizes.textBasic,
      color: context.theme.eventDataColors.text
    );

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SwitchColumnBase(
            title: DataStrings.porn,
            iconData: AppIconData.porn,
            invertedColors: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: Icon(
                    didWatchPorn! ? AppIconData.selected : AppIconData.notSelected,
                    size: context.sizes.iconBasic,
                    color: context.theme.eventDataColors.text,
                  ),
                ),
                Text(
                  didWatchPorn! ? MiscStrings.didWatch : MiscStrings.didNotWatch,
                  style: style
                ),
              ],
            )
          ),
        ),
        Expanded(
          flex: 1,
          child: SwitchColumnBase(
            title: DataStrings.toys,
            iconData: AppIconData.toys,
            invertedColors: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: Icon(
                    didUseToys! ? AppIconData.selected : AppIconData.notSelected,
                    size: context.sizes.iconBasic,
                    color: context.theme.eventDataColors.text,
                  ),
                ),
                Text(
                  didUseToys! ? MiscStrings.didUse : MiscStrings.didNotUse,
                  style: style
                ),
              ],
            )
          ),
        )
      ],
    );
  }
}
