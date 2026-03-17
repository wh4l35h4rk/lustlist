import 'package:flutter/material.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/enums/type.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/widgets/info_row.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/ui/notifiers/event_notifier.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/sex_mstb_event/partners_column.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/sex_mstb_event/eventdata_column.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/medical_event/medical_data_tile.dart';


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
      surfaceColor: AppColors.eventData.surface(context),
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
        if (_isError) {
          return Text(MiscStrings.errorLoadingData,
            style: TextStyle(
              fontSize: AppSizes.textBasic,
              color: AppColors.addEvent.coloredText(context),
            ),
          );
        } else if (_isLoading || didUseToys == null || didWatchPorn == null) {
          return Text(MiscStrings.loading,
            style: TextStyle(
              fontSize: AppSizes.textBasic,
              color: AppColors.addEvent.coloredText(context),
            ),
          );
        }

        return Column(
          children: [
            EventDataColumn(event: widget.event),
            Padding(
              padding: AppInsets.dataDivider,
              child: Divider()
            ),
            InfoRow(
              iconData: AppIconData.porn,
              title: StringFormatter.colon(DataStrings.porn),
              child: Text(
                didWatchPorn! ? MiscStrings.didWatch : MiscStrings.didNotWatch,
                style: TextStyle(
                  fontSize: AppSizes.textBasic,
                  color: AppColors.eventData.text(context)
                ),
              )
            ),
            InfoRow(
                iconData: AppIconData.toys,
                title: StringFormatter.colon(DataStrings.toys),
                child: Text(
                  didUseToys! ? MiscStrings.didUse : MiscStrings.didNotUse,
                  style: TextStyle(
                      fontSize: AppSizes.textBasic,
                      color: AppColors.eventData.text(context)
                  ),
                )
            )
          ]
        );
      case EventType.medical:
        return MedicalData(event: widget.event);
    }
  }
}
