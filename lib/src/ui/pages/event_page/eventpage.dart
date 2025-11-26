import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/core/formatters/datetime_formatters.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';

import 'package:lustlist/main.dart';
import 'package:lustlist/src/ui/controllers/event_notifier.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/edit_event_pages/edit_med_page.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/edit_event_pages/edit_mstb_page.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/edit_event_pages/edit_sex_page.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/medical_event/med_event_info.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/sex_mstb_event/sex_event_info.dart';
import 'package:lustlist/src/ui/pages/event_page/widgets/sex_mstb_event/mstb_event_info.dart';
import 'package:lustlist/src/ui/widgets/main_bnb.dart';
import 'package:lustlist/src/ui/widgets/main_appbar.dart';



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
      bottomNavigationBar: MainBottomNavigationBar(
        context: context,
        currentIndex: HomeNavigationController.pageIndex.value
      )
    );
  }

  String _getTitle() {
    final date = event.event.date;
    final time = event.event.time;

    final dateFormatted = DateFormatter.dateWithDay(date);
    final timeFormatted = DateFormatter.time(time);

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
        return EditMstbEventPage(event: event);
      case "medical":
        return EditMedEventPage(event: event);
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
              AlertStrings.deleteEvent,
              style: TextStyle(fontSize: AppSizes.alertBody),
              textAlign: TextAlign.justify,
            ),
            actions: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Text(
                  ButtonStrings.eventReturn,
                  style: TextStyle(fontSize: AppSizes.alertButton),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                onPressed: () {
                  deleteEvent(event);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(true);
                  eventsUpdated.notifyUpdate();
                },
                color: AppColors.appBar.surface(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  ButtonStrings.delete,
                  style: TextStyle(
                    fontSize: AppSizes.alertButton,
                    color: AppColors.appBar.text(context)
                  ),
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