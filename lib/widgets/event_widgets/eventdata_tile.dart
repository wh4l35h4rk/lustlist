import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/calendar_event.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/widgets/basic_tile.dart';
import '../../db/partners.dart';

class EventDataTile extends StatelessWidget {
  const EventDataTile({
    super.key,
    required this.event,
  });

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return BasicTile(
      surfaceColor: AppColors.eventData.surface(context),
      margin: const EdgeInsets.all(10),
      child: buildTileBottom(),
    );
  }

  Widget buildTileBottom() {
    String type = event.type.slug;
    switch (type) {
      case "sex":
        return Column(
          children: [
            _DataColumn(event: event),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider()
            ),
            _PartnersColumn(event: event),
          ],
        );
      case "masturbation":
        return Column(
          children: [
            _DataColumn(event: event),
            _PornTile(event: event)
          ]);
      case "medical":
        return _MedicalData(event: event);
      default:
        throw FormatException("Wrong type: $type");
    }
  }
}


class _DataColumn extends StatelessWidget {
  const _DataColumn({
    required this.event,
  });

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoRow(context, event, Icons.star, "Rating:",
                _getRatingIcons(event, context)
              ),
              infoRow(context, event, Icons.timelapse, "Duration:",
                Text(
                  _getDurationString(event),
                  style: TextStyle(
                    color: AppColors.eventData.text(context),
                  )
                )
              ),
              infoRow(context, event, Icons.auto_awesome, "My orgasms:",
                Text(
                  _getOrgasmsText(event),
                  style: TextStyle(
                    color: AppColors.eventData.text(context),
                  )
                )
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                iconDataMap[event.getTypeId()],
                color: AppColors.eventData.leadingIcon(context),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget infoRow(BuildContext context, CalendarEvent event, IconData iconData, String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(iconData, color: AppColors.eventData.icon(context),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              title,
              style: TextStyle(
                  color: AppColors.eventData.title(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ),
          child
        ],
      ),
    );
  }

  String _getDurationString(CalendarEvent event) {
    final DateTime? duration = event.data!.duration;
    if (duration != null) {
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

      if (hoursString == null && minutesString == null) {
        return "Unknown";
      }

      List<String> list = [?hoursString, ?minutesString];
      return list.join(" ");
    } else {
      return "Unknown";
    }
  }

  String _getOrgasmsText(CalendarEvent event) {
    final int orgasmsAmount = event.data!.userOrgasms;
    final String amountString = orgasmsAmount.toString();

    final String orgasmsString;
    if (orgasmsAmount == 1) {
      orgasmsString = "orgasm";
    } else {
      orgasmsString = "orgasms";
    }
    return "$amountString $orgasmsString";
  }

  Row _getRatingIcons(CalendarEvent event, context) {
    final int rating = event.data!.rating;
    return Row(
      children: [
        Row(
            children: [
              for (var index = 0; index < rating; index++)
                Icon(
                    Icons.star,
                    size: 16,
                    color: AppColors.eventData.text(context)
                )
            ]
        ),
        Row(
          children: [
            for (var index = 0; index < 5 - rating; index++)
              Icon(
                  Icons.star_border,
                  size: 16,
                  color: AppColors.eventData.text(context)
              )
          ],
        ),
      ],
    );
  }
}



class _PartnersColumn extends StatelessWidget {
  const _PartnersColumn({
    required this.event,
  });

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              _getPartnersTitle(),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.eventData.title(context),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.person,
              color: AppColors.eventData.leadingIcon(context),
            ),
          ],
        ),
        SizedBox(height: 5,),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var partner in event.partnersMap!.keys)
                    OutlinedButton(
                      onPressed: () {
                        //TODO: partner page routing
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1.2, color: AppColors.eventData.border(context)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            partner.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.eventData.text(context)
                            ),
                          ),
                          SizedBox(width: 5,),
                          Icon(
                            getGenderIconData(partner),
                            color: AppColors.eventData.icon(context),
                          )
                        ],
                      ),
                    )
                ],
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var amount in event.partnersMap!.values)
                    Text(
                      _getOrgasmsText(amount),
                      style: TextStyle(color: AppColors.eventData.text(context)),
                    )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }


  IconData? getGenderIconData(Partner partner) {
    final Gender gender = partner.gender;
    switch (gender) {
      case Gender.female:
        return Icons.female;
      case Gender.male:
        return Icons.male;
      case Gender.nonbinary:
        return CustomIcons.genderless;
    }
  }

  String _getPartnersTitle() {
    final partners = event.partnersMap!.keys;
    if (partners.length > 1) {
      return "Partners:";
    } else if (partners.length == 1) {
      return "Partner:";
    } else {
      throw FormatException("No partners passed");
    }
  }

  String _getOrgasmsText(int orgasmsAmount) {
    final String amountString = orgasmsAmount.toString();
    final String orgasmsString;
    if (orgasmsAmount == 1) {
      orgasmsString = "orgasm";
    } else {
      orgasmsString = "orgasms";
    }
    return "$amountString $orgasmsString";
  }
}


class _PornTile extends StatelessWidget{
  const _PornTile({
    required this.event,
  });

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(Icons.play_circle, color: AppColors.eventData.icon(context),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              "Porn:",
              style: TextStyle(
                  color: AppColors.eventData.title(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ),
          Text(
            event.data!.didWatchPorn! ? "Did watch" : "Did not watch",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.eventData.text(context)
            ),
          )
        ],
      ),
    );
  }
}


class _MedicalData extends StatelessWidget{
  const _MedicalData({
    required this.event,
  });

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.medical_services, color: AppColors.eventData.icon(context),),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            "Type:",
            style: TextStyle(
                color: AppColors.eventData.title(context),
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
          ),
        ),
        Wrap(
          children: [
            FutureBuilder<Widget>(
              future: getCategoryListText(database, context),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...", style: TextStyle(color: AppColors.eventData.text(context)),);
                } else if (snapshot.hasError) {
                  return Text("Error loading data", style: TextStyle(color: AppColors.eventData.text(context)),);
                } else if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return Text("No data", style: TextStyle(color: AppColors.eventData.text(context)),);
                }
              },
            ),
          ],
        )
      ],
    );
  }

  Future<Widget> getCategoryListText(AppDatabase db, context) async {
    final categoryNames = await db.getCategoryNamesOfEvent(event.event.id);
    String categoryString;
    if (categoryNames!.isNotEmpty) {
      categoryString = categoryNames.join(", ");
    } else {
      categoryString = "Unknown";
    }
    return Text(categoryString, style: TextStyle(color: AppColors.eventData.text(context)),);
  }
}
