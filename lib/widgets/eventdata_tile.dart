import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/test_event.dart';
import 'package:lustlist/custom_icons.dart';
import '../db/partners.dart';

class EventDataTile extends StatelessWidget {
  const EventDataTile({
    super.key,
    required this.event,
  });

  final TestEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      margin: const EdgeInsets.all(10.0),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Column(
        children: [
          DataColumn(event: event),
          buildTileBottom(),
        ],
      ),
    );
  }

  Widget buildTileBottom() {
    String type = event.type.slug;
    switch (type) {
      case "sex":
        return Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider()
            ),
            _PartnersColumn(event: event),
          ],
        );
      case "masturbation":
        return _PornTile(event: event);
      default:
        throw FormatException("Unsuitable type: $type");
    }
  }
}


class _PornTile extends StatelessWidget{
  const _PornTile({
    required this.event,
  });

  final TestEvent event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(Icons.play_circle, color: Theme.of(context).colorScheme.primaryFixed,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              "Porn:",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryFixed,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ),
          FutureBuilder<String>(
            future: _checkOption(database, context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Error loading data",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                );
              } else {
                return Text(snapshot.data ?? "No data",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<String> _checkOption(AppDatabase db, context) async {
    int optionId = await db.getOptionIdBySlug("porn");
    bool check = await db.checkOptionEvent(event.event.id, optionId);

    if (check){
      return "Did watch";
    } else {
      return "Did not watch";
    }
  }
}


class DataColumn extends StatelessWidget {
  const DataColumn({
    super.key,
    required this.event,
  });

  final TestEvent event;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Theme.of(context).colorScheme.primaryFixed,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "Rating:",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primaryFixed,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    _getRatingIcons(event, context)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Icon(Icons.timelapse, color: Theme.of(context).colorScheme.primaryFixed,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "Duration:",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primaryFixed,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    Text(
                        _getDurationString(event),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                        )
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Theme.of(context).colorScheme.primaryFixed,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "My orgasms:",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primaryFixed,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    Text(
                        _getOrgasmsText(event),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                        )
                    )
                  ],
                ),
              )
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                iconDataMap[event.getTypeId()],
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDurationString(TestEvent event) {
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
      List<String> list = [?hoursString, ?minutesString];
      return list.join(" ");
    } else {
      return "unknown";
    }
  }

  String _getOrgasmsText(TestEvent event) {
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

  Row _getRatingIcons(TestEvent event, context) {
    final int rating = event.data!.rating;
    return Row(
      children: [
        Row(
            children: [
              for (var index = 0; index < rating; index++)
                Icon(
                    Icons.star,
                    size: 14,
                    color: Theme.of(context).colorScheme.surface
                )
            ]
        ),
        Row(
          children: [
            for (var index = 0; index < 5 - rating; index++)
              Icon(
                  Icons.star_border,
                  size: 14,
                  color: Theme.of(context).colorScheme.surface
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

  final TestEvent event;

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
                color: Theme.of(context).colorScheme.primaryFixed,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.inversePrimary,
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
                  for (var partner in event.partners!)
                    OutlinedButton(
                      onPressed: () {
                        //TODO: partner page routing
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1.2, color: Theme.of(context).colorScheme.onPrimaryFixedVariant),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            partner!.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              // fontSize: 16,
                                color: Theme.of(context).colorScheme.surface
                            ),
                          ),
                          SizedBox(width: 5,),
                          Icon(getGenderIconData(partner), color: Theme.of(context).colorScheme.primaryFixed,)
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
                  for (var index = 0; index < event.partnerOrgasms!.length; index++)
                    Text(
                      _getOrgasmsText(event.partnerOrgasms![index]),
                      style: TextStyle(color: Theme.of(context).colorScheme.surface),
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
    final partners = event.partners;
    if (partners!.length > 1) {
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