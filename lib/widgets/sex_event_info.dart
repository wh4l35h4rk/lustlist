import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/test_event.dart';
import 'package:lustlist/custom_icons.dart';
import '../db/partners.dart';


class SexEventInfo extends StatelessWidget {
  final TestEvent event;

  const SexEventInfo({
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18.0),
            margin: const EdgeInsets.all(10.0),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Row(
              children: [
                Icon(iconDataMap[event.getTypeId()]),
                Spacer(),
                Text(
                  "Event",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(child:
          Column(children: [
            Container(
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
                  Text("smth"),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider()),
                  PartnersColumn(event: event),
                ],
              ),
            )
          ],)
          )
        ]
    );
  }
}


class PartnersColumn extends StatelessWidget {
  const PartnersColumn({
    super.key,
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
              iconDataMap[event.getTypeId()],
              color: Theme.of(context).colorScheme.primaryFixed,
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
    } else if (partners!.length == 1) {
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