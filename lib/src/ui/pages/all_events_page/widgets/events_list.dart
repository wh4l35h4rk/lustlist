import 'package:flutter/material.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';
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
    return Column(
      children: [
        Padding(
          padding: AppInsets.divider,
          child: Divider(
            height: AppSizes.dividerMinimal,
          ),
        ),
        ImplicitlyAnimatedList(
          itemEquality: (a, b) => a.calendarEvent.event.id == b.calendarEvent.event.id,
          itemData: list,
          itemBuilder: (context, event) {
            return Column(
              children: [
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
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        ),
      ],
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