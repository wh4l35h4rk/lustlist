import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/domain/entities/partner_dated.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/ui/widgets/main_bnb.dart';
import 'package:lustlist/src/ui/widgets/main_appbar.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/add_partner_page.dart';
import 'package:lustlist/src/ui/pages/partners_page/widgets/partner_listtile.dart';
import 'package:lustlist/src/ui/pages/partners_page/partner_profile.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';
import 'package:lustlist/main.dart';


class PartnersPage extends StatefulWidget {
  const PartnersPage({
    super.key
  });

  @override
  State<PartnersPage> createState() => _PartnersPageState();
}

class _PartnersPageState extends State<PartnersPage> {
  bool partnersChanges = false;
  final repo = EventRepository(database);
  late Future<List<PartnerWithDate>> partnersFuture;

  @override
  void initState() {
    super.initState();
    partnersFuture = repo.getPartnersWithDatesSorted(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: PageTitleStrings.partners,
        backButton: IconButton(
          onPressed: () => Navigator.of(context).pop(partnersChanges ? true : null),
          icon: Icon(Icons.arrow_back_ios),
          color: AppColors.appBar.icon(context),
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: partnersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || !snapshot.hasData) {
                return ErrorTile();
              }

              List<PartnerWithDate> partners = snapshot.data!;

              if (partners.isEmpty) {
                return Center(
                  child: Text(
                    AlertStrings.noPartners,
                    style: TextStyle(
                      color: AppColors.eventData.text(context),
                      fontStyle: FontStyle.italic,
                      fontSize: AppSizes.textBasic
                    ),
                  ),
                );
              }

              return ListView(
                children: [
                  //TODO: add sex distribution circle graph
                  SizedBox(height: 15),
                  ListView.builder(
                    itemCount: partners.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      PartnerWithDate partner = partners[index];
                      return Column(
                        children: [
                          index == 0 ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Divider(
                                height: 0
                            ),
                          ) : SizedBox.shrink(),
                          PartnerListTile(
                            partner: partner.partner,
                            onTap: () => _onTap(PartnerProfile(partner: partner.partner)),
                            lastDate: partner.lastDate,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Divider(
                                height: 0
                            ),
                          )
                        ],
                      );
                    }
                 )
                ]
              );
            }
          ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () => _onTap(AddPartnerPage()),
            child: const Icon(Icons.add),
          ),
        )
      ]),
      bottomNavigationBar: MainBottomNavigationBar(
        context: context,
        currentIndex: HomeNavigationController.pageIndex.value
      )
    );
  }

  Future<void> _onTap(Widget page) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
    if (result == true) {
      partnersFuture = repo.getPartnersWithDatesSorted(false);
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {});
    }
  }
}