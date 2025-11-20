import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/repository/partner_dated.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import 'package:lustlist/colors.dart';
import '../controllers/home_navigation_controller.dart';
import '../main.dart';
import '../repository/repository.dart';
import '../widgets/error_tile.dart';
import '../widgets/partner_widgets/partner_listtile.dart';
import '../widgets/partner_widgets/partner_profile.dart';


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
    partnersFuture = repo.getPartnersWithDatesSorted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Partners",
        backButton: IconButton(
          onPressed: () => Navigator.of(context).pop(partnersChanges ? true : null),
          icon: Icon(Icons.arrow_back_ios),
          color: AppColors.appBar.icon(context),
        ),
      ),
      body: FutureBuilder(
        future: partnersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return ErrorTile();
          }

          List<PartnerWithDate> partners = snapshot.data!;

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
                        onTap: () => _onTap(partner.partner),
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
      bottomNavigationBar: MainBottomNavigationBar(
        context: context,
        currentIndex: HomeNavigationController.pageIndex.value
      )
    );
  }

  Future<void> _onTap(Partner partner) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartnerProfile(partner: partner),
      ),
    );
    if (result == true) {
      partnersFuture = repo.getPartnersWithDatesSorted();
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {});
    }
  }
}