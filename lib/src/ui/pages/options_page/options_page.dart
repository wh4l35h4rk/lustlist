import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/ui/pages/all_events_page/all_events_page.dart';
import 'package:lustlist/src/ui/pages/credits_page/credits_page.dart';
import 'package:lustlist/src/ui/pages/partners_page/partners_page.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/ui/widgets/animated_appbar.dart';
import 'package:lustlist/src/ui/pages/options_page/widgets/options_listtile.dart';


class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AnimatedAppBar(
          title: PageTitleStrings.options,
          hasBackButton: false,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 15),
            OptionsListTile(
                title: PageTitleStrings.partners,
                subtitle: MiscStrings.partnersSubtitle,
                iconData: AppIconData.partners,
                page: PartnersPage()
            ),
            OptionsListTile(
              title: PageTitleStrings.allEvents,
              subtitle: MiscStrings.allEventsSubtitle,
              iconData: AppIconData.allEvents,
              page: AllEventsPage()
            ),
            // OptionsListTile(
            //     title: PageTitleStrings.tagVisibility,
            //     subtitle: MiscStrings.tagVisibilitySubtitle,
            //     iconData: AppIconData.customizeTags,
            //     page: null
            // ),
            // OptionsListTile(
            //     title: PageTitleStrings.dataExport,
            //     subtitle: MiscStrings.dataExportSubtitle,
            //     iconData: AppIconData.importExport,
            //     page: null
            // ),
            OptionsListTile(
                title: PageTitleStrings.credits,
                subtitle: MiscStrings.creditsSubtitle,
                iconData: AppIconData.info,
                page: CreditsPage()
            ),
          ]),
        )
      ]
    );
  }
}