import 'package:flutter/material.dart';
import 'package:lustlist/src/config/enums/theme_mode_extension.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';
import 'package:lustlist/src/ui/widgets/main_appbar.dart';
import 'package:lustlist/src/ui/widgets/main_bnb.dart';
import 'package:lustlist/src/ui/theme_provider.dart';
import 'package:provider/provider.dart';


class AppearancePage extends StatefulWidget {
  const AppearancePage({super.key});

  @override
  State<AppearancePage> createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  late final themeProvider = context.read<ThemeProvider>();
  late ThemeMode _themeMode = themeProvider.themeMode;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: PageTitleStrings.appearance,
        backButton: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(AppIconData.backButton),
          color: context.theme.appBarColors.icon,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
        child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),

            children: [
              ListTile(
                leading: Icon(_themeMode.iconData),
                title: Text(DataStrings.theme),
                trailing: buildThemeDropdownButton(),
              ),
              Divider(),
              ListTile(
                leading: Icon(_themeMode.iconData),
                title: Text(DataStrings.scale),
                trailing: buildThemeDropdownButton(),
              )
            ]
        ),
      ),
      bottomNavigationBar: MainBottomNavigationBar(
          currentIndex: HomeNavigationController.pageIndex.value,
          context: context
      ),
    );
  }


  DropdownButton<ThemeMode> buildThemeDropdownButton() {
    return DropdownButton<ThemeMode>(
      isDense: true,
      value: _themeMode,
      icon: const Icon(AppIconData.dropList),
      alignment: Alignment.centerLeft,
      style: TextStyle(color: context.theme.addEventColors.text, fontSize: AppSizes.textBasic),
      underline: Container(height: 2, color: context.theme.addEventColors.border),
      onChanged: (ThemeMode? themeMode) {
        setState(() {
          _themeMode = themeMode!;
          themeProvider.setThemeMode(_themeMode);
        });
      },
      items: ThemeMode.values.map<DropdownMenuItem<ThemeMode>>((ThemeMode value) {
        return DropdownMenuItem<ThemeMode>(
          value: value,
          child: Text(
            value.label,
            style: TextStyle(
              fontSize: AppSizes.textBasic,
              color: context.theme.addEventColors.coloredText
            ),
          ));
      }).toList(),
    );
  }

}

