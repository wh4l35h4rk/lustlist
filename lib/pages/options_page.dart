import 'package:flutter/material.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import 'package:lustlist/widgets/options_listtile.dart';
import '../colors.dart';
import '../widgets/calendar_widgets/change_theme_button.dart';


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
    return Scaffold(
      appBar: MainAppBar(
        title: "Options",
        themeButton: ChangeThemeButton(),
      ),
      body: Expanded(
        child: ListView(
          children: [
            SizedBox(height: 15,),
            OptionsListTile(
              title: "Partners",
              subtitle: "Manage info of all of your sexual partners.",
              iconData: Icons.person,
              page: null
            ),
            OptionsListTile(
              title: "Tag visibility",
              subtitle: "Disable unused options' visibility and customize new ones.",
              iconData: Icons.tag,
              page: null
            ),
            OptionsListTile(
              title: "Data export",
              subtitle: "Export your data in machine-readable format.",
              iconData: Icons.import_export,
              page: null
            ),
            OptionsListTile(
                title: "Credits",
                subtitle: "Learn more about developer.",
                iconData: Icons.code,
                page: null
            ),
          ]
        ),
      ),
      bottomNavigationBar: MainBottomNavigationBar(context: context),
    );
  }


}