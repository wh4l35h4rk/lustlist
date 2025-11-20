import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/repository/calendar_event.dart';


class EventListTile extends StatelessWidget {
  const EventListTile({
    required this.event,
    required this.onTap,
    this.partnerOrgasms,
    this.partneredIcon,
    super.key,
  });

  final CalendarEvent event;
  final GestureTapCallback onTap;
  final int? partnerOrgasms;
  final IconData? partneredIcon;

  String _getTitle() {
    if (partnerOrgasms != null) {
      String time = DateFormat.Hm().format(event.event.time);
      String date = DateFormat.yMMMMd().format(event.event.date);
      return "$date, $time";
    }

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

  String _getDuration() {
    if (event.data!.duration != null) {
      int hours = event.data!.duration!.hour;
      int minutes = event.data!.duration!.minute;

      if (hours == 0 && minutes == 0) {
        return "duration unknown";
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
      return timeString;
    } else {
        return "duration unknown";
    }
  }

  Future<String> _getSubtitle(AppDatabase db) async {
    final type = event.getTypeSlug();
    String time = DateFormat("HH:mm").format(event.event.time);

    if ((type == "sex" || type == "masturbation") && event.data != null) {
      String duration = _getDuration();

      if (partnerOrgasms != null) {
        if (partnerOrgasms == 1) return "$duration, 1 orgasm";
        return "$duration, $partnerOrgasms orgasms";
      }
      return [time, duration].join(", ");

    } else if (type == "medical") {
      final categoryNames = await db.getCategoryNamesOfEvent(event.event.id);
      if (categoryNames != null && categoryNames.isNotEmpty) {
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
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
          child: ListTile(
              onTap: onTap,
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    partneredIcon ?? iconDataMap[event.getTypeId()],
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: double.infinity,
                    width: 1,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: _getBorderColor(context), width: 2.8)
                      )
                    ),
                  )
                ],
              ),
              title: Wrap(
                children: [
                  Text(
                    _getTitle(),
                    style: TextStyle(
                      fontSize: partnerOrgasms == null ? 18 : 16,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
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
          ),
        ),
      ],
    );
  }
}