import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/test_event.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/widgets/add_widgets/orgasms_picker.dart';
import 'package:lustlist/widgets/add_widgets/time_picker.dart';
import '../../db/partners.dart';

class AddSexEventData extends StatelessWidget {
  const AddSexEventData({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      margin: const EdgeInsets.all(10.0),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: buildTileBottom(),
    );
  }

  Widget buildTileBottom() {
    return Column(
      children: [
        DataColumn(),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider()
        ),
        // _PartnersColumn(event: event),
      ],
    );
  }
}



class DataColumn extends StatefulWidget {
  const DataColumn({
    super.key,
  });

  @override
  State<DataColumn> createState() => _DataColumnState();
}

class _DataColumnState extends State<DataColumn> {
  int rating = 0;

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
                    Icon(Icons.access_time, color: Theme.of(context).colorScheme.onPrimaryContainer,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "Time:",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    TimePicker(type: 0,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Theme.of(context).colorScheme.onPrimaryContainer,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "Rating:",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    ratingRow(context)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Icon(Icons.timelapse, color: Theme.of(context).colorScheme.onPrimaryContainer,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "Duration:",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    TimePicker(type: 1,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Theme.of(context).colorScheme.onPrimaryContainer,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "My orgasms:",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    OrgasmsAmountPicker()
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ratingRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 1; index <= 5; index++)
          SizedBox(
            height: 20,
            width: 20,
            child: IconButton(
              onPressed: (){
                setState(() {
                  if (rating < index) {
                    rating += index - rating;
                  } else if (rating >= index) {
                    rating -= rating - index;
                  }
                });
              },
              icon: Icon(
                index <= rating ? Icons.star : Icons.star_border,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          )
      ]
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