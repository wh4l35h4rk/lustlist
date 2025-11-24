import 'package:flutter/material.dart';
import 'package:lustlist/src/ui/pages/partners_page/partners_page.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/ui/widgets/animated_appbar.dart';
import 'package:lustlist/src/ui/pages/options_page/widgets/options_listtile.dart';


class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}


class _OptionsPageState extends State<OptionsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AnimatedAppBar(title: PageTitleStrings.options),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 15),
            OptionsListTile(
                title: PageTitleStrings.partners,
                subtitle: MiscStrings.partnersSubtitle,
                iconData: Icons.person,
                page: PartnersPage()
            ),
            OptionsListTile(
                title: PageTitleStrings.tagVisibility,
                subtitle: MiscStrings.tagVisibilitySubtitle,
                iconData: Icons.tag,
                page: null
            ),
            OptionsListTile(
                title: PageTitleStrings.dataExport,
                subtitle: MiscStrings.dataExportSubtitle,
                iconData: Icons.import_export,
                page: null
            ),
            OptionsListTile(
                title: PageTitleStrings.credits,
                subtitle: MiscStrings.creditsSubtitle,
                iconData: Icons.code,
                page: null
            ),
          ]),
        )
      ]
    );
  }
}