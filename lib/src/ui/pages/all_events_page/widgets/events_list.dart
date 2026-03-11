import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/ui/pages/all_events_page/widgets/all_events_list_tile.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/domain/entities/event_with_options.dart';
import 'package:lustlist/src/ui/pages/event_page/eventpage.dart';


class AllEventsList extends StatelessWidget {
  final List<CalendarEventWithOptions> list;

  const AllEventsList({
    required this.list,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          CalendarEventWithOptions event = list[index];
          return Column(
            children: [
              index == 0 ? Padding(
                padding: AppInsets.divider,
                child: Divider(
                  height: AppSizes.dividerMinimal,
                ),
              ) : SizedBox.shrink(),
              AllEventsListTile(
                onTap: () => _onEventListTileTap(context, event),
                event: event.calendarEvent,
              ),
              Padding(
                padding: AppInsets.divider,
                child: Divider(
                  height: AppSizes.dividerMinimal,
                ),
              )
            ],
          );
        }
    );
  }


  Future<void> _onEventListTileTap(BuildContext context, CalendarEventWithOptions event) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventPage(event: event.calendarEvent),
      ),
    );
  }
}