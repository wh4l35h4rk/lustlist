import 'package:flutter/material.dart';
import 'package:lustlist/src/config/enums/gender.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/ui/controllers/map_notifier.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/add_partner_page.dart';
import 'package:lustlist/src/ui/widgets/orgasms_picker.dart';


class SelectPartnersController {
  final MapNotifier<Partner> selectedPartners = MapNotifier<Partner>();

  SelectPartnersController({
    Map<Partner, int?>? selectedPartnersMap,
  }) {
    selectedPartners.value = selectedPartnersMap ?? {};
  }

  Map<Partner, int?> getSelectedPartners() => selectedPartners.value;

  Future<void> setDefault() async {
    final repo = EventRepository(database);
    Partner? defaultPartner = await repo.getUnknownPartner();
    if (defaultPartner != null) {
      selectedPartners.value = {defaultPartner: 1};
    }//TODO: make orgasms nullable
  }
}



class SelectPartnersTile extends StatefulWidget {
  final SelectPartnersController controller;

  const SelectPartnersTile({
    required this.controller,
    super.key,
  });

  @override
  State<SelectPartnersTile> createState() => _SelectPartnersTileState();
}

class _SelectPartnersTileState extends State<SelectPartnersTile> {
  late Future<List<Partner>> _partnersListFuture;
  var repo = EventRepository(database);

  MapNotifier<Partner> get _selectedPartners => widget.controller.selectedPartners;

  @override
  void initState() {
    super.initState();
    _partnersListFuture = repo.getPartnersSorted();
  }

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
              StringFormatter.colon(PageTitleStrings.partners),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.addEvent.title(context),
                fontSize: AppSizes.titleLarge,
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
                future: _partnersListFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      MiscStrings.loading,
                      style: TextStyle(
                        fontSize: AppSizes.textBasic,
                        color: AppColors.addEvent.coloredText(context),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bug_report,
                          color: AppColors.categoryTile.leadingIcon(context),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          MiscStrings.errorLoadingData,
                          style: TextStyle(
                            fontSize: AppSizes.textBasic,
                            color: AppColors.categoryTile.text(context),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        addPartnersButton(context),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text(
                            MiscStrings.noPartners,
                            style: TextStyle(
                              fontSize: AppSizes.textBasic,
                              color: AppColors.addEvent.coloredText(context),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    Widget button = addPartnersButton(context);
                    List<Widget> buttonList = List.generate(
                        snapshot.data!.length, (index) =>
                        partnersListButton(context, snapshot.data![index])
                    );
                    buttonList.add(button);

                    return Scrollbar(
                      thickness: 1,
                      radius: Radius.circular(20),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: buttonList
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
                        amount: partners[partner],
                        onChanged: (newValue) {
                          _selectedPartners.updateValue(partner, newValue);
                        },
                      )
                  ],
                )
              ],
            ),
          ) :
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            AlertStrings.noEventPartner,
            style: TextStyle(
              fontSize: AppSizes.textBasic,
              fontStyle: FontStyle.italic,
              color: AppColors.addEvent.coloredText(context),
            ),
          ),
        );
      }
    );
  }

  Widget addPartnersButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPartnerPage(),
            ),
          );
          if (result == true) {
            await Future.delayed(Duration(milliseconds: 100));
            setState(() {});
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.addEvent.surface(context),
            border: Border.all(
              width: 1.2,
              color: AppColors.addEvent.border(context),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.add,
            size: AppSizes.iconAdd,
            color: AppColors.addEvent.icon(context),
          ),
        ),
      ),
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
                  fontSize: AppSizes.textBasic,
                  color: AppColors.addEvent.text(context)
              ),
            ),
            SizedBox(width: 5,),
            Icon(
              partner.gender.iconData,
              size: partner.gender == Gender.nonbinary
                  ? AppSizes.iconBasic - 3 : AppSizes.iconBasic,
              color: AppColors.addEvent.coloredText(context)
            )
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
              style: TextStyle(
                  fontSize: AppSizes.textBasic,
                  color: AppColors.addEvent.text(context)
              ),
            ),
            SizedBox(width: 5,),
            Icon(
              partner.gender.iconData,
              size: partner.gender == Gender.nonbinary
                  ? AppSizes.iconMedium - 3 : AppSizes.iconMedium,
              color: AppColors.addEvent.coloredText(context),
            )
          ],
        ),
      ),
    );
  }
}