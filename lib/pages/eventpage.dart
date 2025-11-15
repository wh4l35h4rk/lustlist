import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import 'package:lustlist/calendar_event.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/widgets/event_widgets/med_event_info.dart';
import 'package:lustlist/widgets/event_widgets/sex_event_info.dart';
import 'package:lustlist/widgets/event_widgets/mstb_event_info.dart';
import '../main.dart';
import '../repository.dart';
import 'edit_pages/edit_sex_page.dart';


class EventPage extends StatefulWidget {
   const EventPage({
    required this.event,
    super.key
  });

  final CalendarEvent event;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final repo = EventRepository(database);
  late CalendarEvent event;
  bool eventChanged = false;

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: _getTitle(),
        backButton: IconButton(
            onPressed: () => Navigator.of(context).pop(eventChanged ? true : null),
            icon: Icon(Icons.arrow_back_ios),
            color: AppColors.appBar.icon(context),
        ),
        editButton: IconButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => _getEditEventTypeWidget(event)
              ),
            );
            if (result == true) {
              eventChanged = true;
              await Future.delayed(Duration(milliseconds: 100));
              await reloadEvent(database);
              setState(() {});
            }
          },
          icon: Icon(Icons.edit),
          color: AppColors.appBar.icon(context),
        ),
        deleteButton: IconButton(
          onPressed: () => _showPopUp(context),
          icon: Icon(Icons.delete),
          color: AppColors.appBar.icon(context),
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

  Widget _getEditEventTypeWidget(CalendarEvent event) {
    final String type = event.type.slug;
    switch (type) {
      case "sex":
        return EditSexEventPage(event: event);
      case "masturbation":
        throw UnimplementedError();
      case "medical":
        throw UnimplementedError();
      default:
        throw FormatException("Wrong type: $type");
    }
  }

  Future<void> deleteEvent(CalendarEvent event) async {
    await database.deleteEvent(event.event.id);
  }

  void _showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap:() {
            Navigator.of(context).pop();
          },
          child: AlertDialog(
            content: Text(
              "Are you sure you want to delete this event? This action can't be undone.",
              style: TextStyle(fontSize: 15, ),
              textAlign: TextAlign.justify,
            ),
            actions: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Text("Return to event"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                onPressed: () {
                  deleteEvent(event);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(true);
                },
                color: AppColors.appBar.surface(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  "Delete",
                  style: TextStyle(color: AppColors.appBar.text(context)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> reloadEvent(AppDatabase db) async {
    Event dbEvent = await db.getEventById(event.event.id);
    CalendarEvent calendarEvent = await repo.dbToCalendarEvent(dbEvent);

    event = calendarEvent;
  }
}