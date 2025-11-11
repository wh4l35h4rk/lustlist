import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import 'package:lustlist/calendar_event.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/widgets/event_widgets/med_event_info.dart';
import 'package:lustlist/widgets/event_widgets/sex_event_info.dart';
import 'package:lustlist/widgets/event_widgets/mstb_event_info.dart';
import '../main.dart';


class EventPage extends StatelessWidget {
  const EventPage({
    required this.event,
    super.key
  });

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: _getTitle(),
        backButton: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
            color: AppColors.appBar.icon(context),
        ),
        editButton: IconButton(
          onPressed: () {
            //TODO: edit event page
          },
          icon: Icon(Icons.edit),
          color: AppColors.appBar.icon(context),
          padding: EdgeInsets.all(0.0),
          constraints: BoxConstraints(),
        ),
        deleteButton: IconButton(
          onPressed: () {
            deleteEvent(event);
            Navigator.of(context).pop(true);
          }, 
          icon: Icon(Icons.delete),
          color: AppColors.appBar.icon(context),
          padding: EdgeInsets.all(0.0),
          constraints: BoxConstraints(),
        ),
      ),
      body: _getEventTypeWidget(event),
      bottomNavigationBar: MainBottomNavigationBar()
    );
  }

  String _getTitle() {
    final date = event.event.date;
    final time = event.event.time;

    final dateFormatted = DateFormat.yMMMMd().format(date);
    final timeFormatted = DateFormat.Hm().format(time);

    return "$dateFormatted, $timeFormatted";
  }

  Widget _getEventTypeWidget(CalendarEvent event) {
    final String type = event.type.slug;
    switch (type) {
      case "sex":
        return SexEventInfo(event: event);
      case "masturbation":
        return MstbEventInfo(event: event);
      case "medical":
        return MedEventInfo(event: event);
      default:
        throw FormatException("Wrong type: $type");
    }
  }

  Future<void> deleteEvent(CalendarEvent event) async {
    await database.deleteEvent(event.event.id);
  }
}