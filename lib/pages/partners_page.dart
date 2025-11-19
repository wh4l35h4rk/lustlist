import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import 'package:lustlist/colors.dart';
import '../controllers/home_navigation_controller.dart';
import '../main.dart';
import '../repository.dart';
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
  late Future<List<Partner>> partnersFuture;

  @override
  void initState() {
    super.initState();
    partnersFuture = _loadPartners(database);
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
            return Center(
                child: Text(
                  "Error loading data.",
                  style: TextStyle(
                    color: AppColors.categoryTile.text(context),
                  ),
                )
            );
          }

          List<Partner> partners = snapshot.data!;

          return ListView(
            children: [
              //TODO: add sex distribution circle graph
              SizedBox(height: 15),
              ListView.builder(
                itemCount: partners.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Partner partner = partners[index];
                  return Column(
                    children: [
                      index == 0 ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Divider(
                            height: 0
                        ),
                      ) : SizedBox.shrink(),
                      PartnerListTile(
                        partner: partner,
                        onTap: () => _onTap(partner),
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

  Future<List<Partner>> _loadPartners(AppDatabase db) async {
    List<Partner> allPartners = await db.allPartners;
    allPartners.sort((a, b) => a.lastEventDate.isAfter(b.lastEventDate) ? -1 : 1);
    return allPartners;
  }

  Future<void> _onTap(Partner partner) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartnerProfile(partner: partner),
      ),
    );
    if (result == true) {
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {});
    }
  }
}