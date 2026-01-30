import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/credits_strings.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/core/widgets/basic_tile.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';
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
                SourceCodeButton()
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
}



class SourceCodeButton extends StatelessWidget {
  const SourceCodeButton({
    super.key
  });


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: OutlinedButton(
        onPressed: () async {await goToWebPage(CreditsStrings.link);},
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return null;
            }
            return AppColors.categoryTile.surface(context);
          },
          ),
          side: WidgetStateBorderSide.resolveWith((Set<WidgetState> states) {
            return BorderSide(color: AppColors.categoryTile.border(context));
          },
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DataStrings.source,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.categoryTile.title(context),
                fontSize: AppSizes.titleSmall,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              CustomIcons.github,
              color: AppColors.categoryTile.leadingIcon(context),
            ),
          ],
        ),
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