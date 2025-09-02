import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/db/events.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/test_event.dart';


class EventListTile extends StatelessWidget {
  const EventListTile({
    required this.event,
    super.key,
  });

  final TestEvent event;

  String _getTitle() {
    final typeSlug = event.getTypeSlug();
    switch (typeSlug) {
      case "sex":
        return List.generate(event.partners!.length, (index) => event.partners![index]!.name).join(", ");
      case "masturbation":
        return event.type.name;
      case "medical":
        return event.type.name;
      default:
        throw FormatException("Wrong type: $event.type.slug");
    }
  }

  Future<String> _getSubtitle(AppDatabase db) async {
    final type = event.getTypeSlug();
    String time = event.event.time != null ? DateFormat("HH:mm").format(event.event.time!) : event.event.daytime.label;

    if ((type == "sex" || type == "masturbation") && event.data != null) {
      if (event.data!.duration != null) {
        int hours = event.data!.duration!.hour;
        int minutes = event.data!.duration!.minute;

        String? hoursString;
        String? minutesString;

        switch (hours) {
          case 0:
            hoursString = null;
          case 1:
            hoursString = "$hours hour";
          default:
            hoursString = "$hours hours";
        }
        switch (minutes) {
          case 0:
            minutesString = null;
          case 1:
            minutesString = "$minutes minute";
          default:
            minutesString = "$minutes minutes";
        }
        List<String> list = [time, ?hoursString, ?minutesString];
        return list.join(", ");
      } else {
        return "$time, duration unknown";
      }
    } else if (type == "medical") {
      List<EOption> options = await db.getOptionsById(event.event.id);
      String optionsNames = List.generate(options.length, (index) => options[index].name).join(", ");
      return "$time, $optionsNames";
    } else {
      throw FormatException("Wrong type: ${event.type.slug}");
    }
  }

  Color _getBorderColor(BuildContext context) {
    final typeSlug = event.getTypeSlug();
    if ((typeSlug == "sex" || typeSlug == "masturbation") && event.data != null) {
      final int rating = event.data!.rating;
      switch (rating) {
        case 1:
          return Colors.red;
        case 2:
          return Colors.orange;
        case 3:
          return Colors.amber;
        case 4:
          return Colors.lime;
        case 5:
          return Colors.green;
        default:
          return Theme.of(context).colorScheme.outline;
      }
    } else {
      return Theme.of(context).colorScheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => print('$event'),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconDataMap[event.getTypeId()],
            ),
            SizedBox(width: 15),
            Container(
              height: double.infinity,
              width: 1,
              decoration: BoxDecoration(border: Border(right: BorderSide(color: _getBorderColor(context), width: 2.8))),
            )
          ],
        ),
        title: Text(_getTitle(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text(_getSubtitle()),
        subtitle: FutureBuilder<String>(
          future: _getSubtitle(database),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            } else if (snapshot.hasError) {
              return const Text("Error loading data");
            } else {
              return Text(snapshot.data ?? "No data");
            }
          },
        ),
        trailing: Icon(Icons.arrow_forward_ios)
    );
  }
}