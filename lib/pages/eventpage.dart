import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/db/events.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import 'package:lustlist/test_event.dart';
import 'package:lustlist/widgets/sex_event_info.dart';


class EventPage extends StatelessWidget {
  const EventPage({
    required this.event,
    super.key
  });

  final TestEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: _getTitle(),
        backButton: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
            color: Theme.of(context).colorScheme.surface,
        ),
      ),
      body: _getEventTypeWidget(event),
      bottomNavigationBar: MainBottomNavigationBar()
    );
  }

  String _getTitle() {
    final date = event.event.date;
    final time = event.event.time;
    final daytime = event.event.daytime;

    final dateFormatted = DateFormat.yMMMMd().format(date);

    final String timeFormatted;
    if (time != null){
      timeFormatted = DateFormat.Hm().format(time);
    } else {
      timeFormatted = daytime.label;
    }

    return "$dateFormatted, $timeFormatted";
  }

  Widget _getEventTypeWidget(TestEvent event) {
    final String type = event.type.slug;
    switch (type) {
      case "sex":
        return SexEventInfo(event: event);
      case "masturbation":
        return Text("No page yet!");
      case "medical":
        return Text("No page yet!");
      default:
        throw FormatException("Wrong type: $type");
    }
  }
}