import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/presentation/main.dart';
import 'package:lustlist/src/domain/entities/calendar_event.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/profile_strings.dart';


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
        return ProfileStrings.durationUnknown;
      }

      String? hoursString;
      String? minutesString;

      switch (hours) {
        case 0:
          hoursString = null;
        case 1:
          hoursString = "$hours ${ProfileStrings.hour}";
        default:
          hoursString = "$hours ${ProfileStrings.hours}";
      }
      switch (minutes) {
        case 0:
          minutesString = null;
        case 1:
          minutesString = "$minutes ${ProfileStrings.min}";
        default:
          minutesString = "$minutes ${ProfileStrings.mins}";
      }
      final String timeString = [?hoursString, ?minutesString].join(" ");
      return timeString;
    } else {
        return ProfileStrings.durationUnknown;
    }
  }

  Future<String> _getSubtitle(AppDatabase db) async {
    final type = event.getTypeSlug();
    String time = DateFormat("HH:mm").format(event.event.time);

    if ((type == "sex" || type == "masturbation") && event.data != null) {
      String duration = _getDuration();

      if (partnerOrgasms != null) {
        if (partnerOrgasms == 1) return "$duration, $partnerOrgasms ${ProfileStrings.orgasmOne}";
        return "$duration, $partnerOrgasms ${ProfileStrings.orgasmsMany}";
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
                      fontSize: partnerOrgasms == null ? AppSizes.titleLarge : AppSizes.titleSmall,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              subtitle: FutureBuilder<String>(
                future: _getSubtitle(database),
                builder: (context, snapshot) {
                  String string;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    string = ProfileStrings.loading;
                  } else if (snapshot.hasError) {
                    string = ProfileStrings.errorLoadingData;
                  } else {
                    return Text(string = snapshot.data ?? ProfileStrings.noData);
                  }

                  return Text(
                      string,
                      style: TextStyle(
                        fontSize: AppSizes.titleSmall,
                      )
                  );
                },
              ),
              trailing: Icon(Icons.arrow_forward_ios)
          ),
        ),
      ],
    );
  }
}