import 'package:flutter/material.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/alert_strings.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/domain/entities/partner_dated.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/ui/pages/partners_page/widgets/partner_listtile.dart';
import 'package:lustlist/src/ui/widgets/main_bnb.dart';
import 'package:lustlist/src/ui/widgets/main_appbar.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/add_partner_page.dart';
import 'package:lustlist/src/ui/pages/partners_page/widgets/partners_chart.dart';
import 'package:lustlist/src/ui/pages/partners_page/partner_profile.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';
import 'package:lustlist/src/config/constants/layout.dart';
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

  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  late final ValueNotifier<List<PartnerWithDate>> partnersNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    partnersNotifier.value = await repo.getPartnersWithDatesSorted(false);
    _isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: PageTitleStrings.partners,
        backButton: IconButton(
          onPressed: () => Navigator.of(context).pop(partnersChanges ? true : null),
          icon: Icon(AppIconData.backButton),
          color: AppColors.appBar.icon(context),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, value, child) {
          if (value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              ValueListenableBuilder(
                valueListenable: partnersNotifier,
                builder: (context, partners, _) {

                  if (partners.isEmpty) {
                    return Center(
                      child: Text(
                        AlertStrings.noPartners,
                        style: TextStyle(
                          color: AppColors.defaultTile(context),
                          fontStyle: FontStyle.italic,
                          fontSize: AppSizes.textBasic
                        ),
                      ),
                    );
                  }

                  return ListView(
                    children: [
                      Padding(
                        padding: AppInsets.pieChart,
                        child: PartnersChart(partners: partners),
                      ),
                      Padding(
                        padding: AppInsets.divider,
                        child: Divider(
                          height: AppSizes.dividerMinimal,
                        ),
                      ),
                      ImplicitlyAnimatedList(
                        itemData: partners,
                        itemBuilder: (context, partnerWithDate) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              PartnerListTile(
                                partner: partnerWithDate.partner,
                                onTap: () => _onTap(PartnerProfile(partner: partnerWithDate.partner)),
                                lastDate: partnerWithDate.lastDate,
                              ),
                              Padding(
                                padding: AppInsets.divider,
                                child: Divider(
                                  height: AppSizes.dividerMinimal,
                                ),
                              )
                            ],
                          );
                        },
                        shrinkWrap: true,
                      ),
                    ]
                  );
                }
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () => _onTap(AddPartnerPage()),
                  child: const Icon(AppIconData.add),
                ),
              )
          ]);
        }
      ),
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
      partnersNotifier.value = await repo.getPartnersWithDatesSorted(false);
      setState(() {});
    }
  }
}