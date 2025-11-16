import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/calendar_event.dart';


class EventListTile extends StatelessWidget {
  const EventListTile({
    required this.event,
    super.key,
    required this.onTap,
  });

  final CalendarEvent event;
  final GestureTapCallback onTap;

  String _getTitle() {
    final typeSlug = event.getTypeSlug();
    switch (typeSlug) {
      case "sex":
        return event.getPartnerNames().join(", ");
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
    String time = DateFormat("HH:mm").format(event.event.time);

    if ((type == "sex" || type == "masturbation") && event.data != null) {
      if (event.data!.duration != null) {
        int hours = event.data!.duration!.hour;
        int minutes = event.data!.duration!.minute;

        if (hours == 0 && minutes == 0) {
          return "$time, duration unknown";
        }

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
        final String timeString = [?hoursString, ?minutesString].join(" ");
        return [time, timeString].join(", ");
      } else {
        return "$time, duration unknown";
      }
    } else if (type == "medical") {
      final categoryNames = await db.getCategoryNamesOfEvent(event.event.id);
      if (categoryNames!.isNotEmpty) {
        return "$time, ${categoryNames.join(", ")}";
      } else {
        return time;
      }
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
          return AppColors.defaultTile(context);
      }
    } else {
      return AppColors.defaultTile(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
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
        title: Wrap(
          children: [Text(_getTitle(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )],
        ),
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