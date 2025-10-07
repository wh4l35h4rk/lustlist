import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/custom_icons.dart';
import '../../colors.dart';
import '../../map_notifier.dart';
import '../../main.dart';
import '../../db/partners.dart';
import '../basic_tile.dart';
import 'orgasms_picker.dart';

class SelectPartnersTile extends StatefulWidget {
  const SelectPartnersTile({
    super.key,
  });

  @override
  State<SelectPartnersTile> createState() => _SelectPartnersTileState();
}

class _SelectPartnersTileState extends State<SelectPartnersTile> {
  final _selectedPartners = MapNotifier<Partner>();


  @override
  Widget build(BuildContext context) {
    return BasicTile(
      surfaceColor: AppColors.addEvent.surface(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          listAllTile(context),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Divider(),
          ),
          listSelectedTile(context)
        ],
      ),
    );
  }

  Widget listAllTile(BuildContext context) {
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
        SizedBox(
          height: 50,
          child: Center(
            child: FutureBuilder(
                future: _getPartnersList(database),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading partners...",
                      style: TextStyle(
                        color: AppColors.addEvent.coloredText(context),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error loading data",
                      style: TextStyle(
                        color: AppColors.addEvent.coloredText(context),
                      ),
                    );
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Text("No partners yet!",
                      style: TextStyle(
                        color: AppColors.addEvent.coloredText(context),
                      ),
                    );
                  } else {
                    return Scrollbar(
                      thickness: 1,
                      radius: Radius.circular(20),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            snapshot.data!.length, (index) =>
                            partnersListButton(context, snapshot.data![index])
                        )
                      ),
                    );
                  }
                }
            ),
          ),
        )
      ],
    );
  }


  Widget listSelectedTile(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedPartners,
      builder: (context, partners, child) {
        return _selectedPartners.value.isNotEmpty ?
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var partner in partners.keys)
                      partnersListTile(context, partner)
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var partner in _selectedPartners.value.keys)
                      OrgasmsAmountPicker(
                        amount: partners[partner]!,
                        onChanged: (newValue) {
                          _selectedPartners.updateValue(partner, newValue);
                        },
                      )
                  ],
                )
              ],
            ),
          ) :
        Text("Select partner(s) for the event.",
          style: TextStyle(fontStyle: FontStyle.italic, color: AppColors.addEvent.coloredText(context),),
        );
      }
    );
  }


  Widget partnersListButton(BuildContext context, Partner partner) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            if  (_selectedPartners.value.keys.contains(partner)){
              _selectedPartners.remove(partner);
            } else {
              _selectedPartners.add(partner);
            }
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: _selectedPartners.value.keys.contains(partner) ?
            AppColors.addEvent.selectedSurface(context) : AppColors.addEvent.surface(context),
          side: BorderSide(width: 1.2, color: AppColors.addEvent.border(context)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              partner.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.addEvent.text(context)
              ),
            ),
            SizedBox(width: 5,),
            Icon(getGenderIconData(partner), color: AppColors.addEvent.coloredText(context))
          ],
        ),
      ),
    );
  }


  Widget partnersListTile(BuildContext context, Partner partner){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.addEvent.border(context),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              partner.name,
              textAlign: TextAlign.left,
              style: TextStyle(color: AppColors.addEvent.text(context)),
            ),
            SizedBox(width: 5,),
            Icon(
              getGenderIconData(partner),
              size: 16,
              color: AppColors.addEvent.coloredText(context),
            )
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


  Future? _getPartnersList(AppDatabase db) async {
    List<Partner> partners = await db.allPartners;
    if (partners.isNotEmpty){
      partners.sort((a, b) => -1 * a.lastEventDate.compareTo(b.lastEventDate));
    }
    return partners;
  }
}