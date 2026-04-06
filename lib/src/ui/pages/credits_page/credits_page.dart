import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/credits_strings.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';
import 'package:lustlist/src/ui/pages/credits_page/app_license_page.dart';
import 'package:lustlist/src/ui/widgets/animated_appbar.dart';
import 'package:lustlist/src/ui/widgets/main_bnb.dart';
import 'package:url_launcher/url_launcher.dart';


class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var surfaceColor = AppColors.notesBottom(context)!;
    TextStyle basicTextStyle = TextStyle(
      fontSize: AppSizes.textBasic,
      color: AppColors.categoryTile.text(context),
    );

    return Scaffold(
      body: CustomScrollView(
          slivers: [
            AnimatedAppBar(
              title: PageTitleStrings.credits,
              hasBackButton: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 15),
                BasicTile(
                  surfaceColor: surfaceColor,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: AppSizes.textBasic,
                        color: AppColors.categoryTile.text(context),
                        letterSpacing: 0.4,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: CreditsStrings.intro1),
                        TextSpan(text: CreditsStrings.githubNickname,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.categoryTile.leadingIcon(context),
                              letterSpacing: 0.4,
                            )
                        ),
                        TextSpan(text: CreditsStrings.intro2),
                      ],
                    ),
                  ),
                ),
                BasicTile(
                  surfaceColor: surfaceColor,
                  child: Text(
                    CreditsStrings.license,
                    style: basicTextStyle
                  )
                ),
                Padding(
                  padding: AppInsets.highDivider,
                  child: Divider(),
                ),
                _CreditsTile(
                  title: DataStrings.source,
                  subtitle: CreditsStrings.sourceSubtitle,
                  iconData: AppIconData.github,
                  trailingIconData: AppIconData.openExternal,
                  onTap: () async { await goToWebPage(CreditsStrings.link); },
                ),
                _CreditsTile(
                  title: DataStrings.feedback,
                  subtitle: CreditsStrings.feedbackSubtitle,
                  iconData: AppIconData.feedback,
                  trailingIconData: AppIconData.openExternal,
                  onTap: null,
                ),
                _CreditsTile(
                  title: DataStrings.license,
                  subtitle: CreditsStrings.licenseSubtitle,
                  iconData: AppIconData.license,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppLicensePage(),
                      ),
                    );
                  },
                ),
              ]),
            )
          ]
      ),
      bottomNavigationBar: MainBottomNavigationBar(
        currentIndex: HomeNavigationController.pageIndex.value,
        context: context
      ),
    );
  }


  Future<void> goToWebPage(String s) async {
    final Uri url = Uri.parse(s);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}

class _CreditsTile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String subtitle;
  final IconData iconData;
  final IconData? trailingIconData;

  const _CreditsTile({
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.onTap,
    this.trailingIconData
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppSizes.titleLarge,
            fontWeight: FontWeight.bold
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          iconData
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Icon(trailingIconData ?? AppIconData.arrowRight),
      onTap: onTap,
    );
  }
}