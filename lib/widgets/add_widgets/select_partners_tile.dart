import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/custom_icons.dart';
import '../../colors.dart';
import '../../main.dart';
import '../../db/partners.dart';

class SelectPartnersTile extends StatelessWidget {
  const SelectPartnersTile({
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
        color: AppColors.addEvent.surface(context),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Column(
        children: [
          buildTileBottom(context),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Divider(),
          )
        ],
      ),
    );
  }


  Widget buildTileBottom(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Partners:",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.addEvent.title(context),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.person,
              color: AppColors.addEvent.leadingIcon(context),
            ),
          ],
        ),
        SizedBox(height: 5,),
        FutureBuilder(
            future: _getPartnersList(database),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading partners...",
                  style: TextStyle(
                    color: AppColors.addEvent.text(context),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Error loading data",
                  style: TextStyle(
                    color: AppColors.addEvent.text(context),
                  ),
                );
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Text("No partners yet!",
                  style: TextStyle(
                    color: AppColors.addEvent.text(context),
                  ),
                );
              } else {
                return SizedBox(
                  height: 50,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          snapshot.data!.length, (index) =>
                          _PartnersListTile(partner: snapshot.data![index],)
                      )
                  ),
                );
              }
            }
        )
      ],
    );
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

  Future? _getPartnersList(AppDatabase db) async {
    List<Partner> partners = await db.allPartners;
    if (partners.isNotEmpty){
      partners.sort((a, b) => -1 * a.lastEventDate.compareTo(b.lastEventDate));
    }
    return partners;
  }
}


class _PartnersListTile extends StatelessWidget{
  final dynamic partner;

  const _PartnersListTile({
    required this.partner
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: () {
          //TODO: partner page routing
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 1.2, color: AppColors.addEvent.border(context)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              partner!.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.addEvent.text(context)
              ),
            ),
            SizedBox(width: 5,),
            Icon(getGenderIconData(partner), color: AppColors.addEvent.icon(context))
          ],
        ),
      ),
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
}