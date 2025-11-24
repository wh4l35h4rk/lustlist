import 'package:flutter/material.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';

import 'package:lustlist/src/ui/pages/options_page/options_page.dart';
import 'package:lustlist/src/ui/pages/stats_page/statspage.dart';
import 'package:lustlist/src/ui/pages/calendar_page/calendar_page.dart';
import 'package:lustlist/src/ui/widgets/main_appbar.dart';
import 'package:lustlist/src/ui/widgets/main_bnb.dart';
import 'package:lustlist/src/ui/widgets/change_theme_button.dart';


class Homepage extends StatefulWidget {
  final int? index;

  const Homepage({super.key, this.index});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late int index = widget.index ?? 0;

  final pages = [
    CalendarPage(),
    StatsPage(),
    OptionsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: HomeNavigationController.pageIndex,
      builder: (_, value, _) {
        return Scaffold(
          appBar: value == 0
              ? MainAppBar(
                  title: PageTitleStrings.mainPages[value],
                  backButton: null,
                  editButton: null,
                  themeButton: ChangeThemeButton(),
              ) : null,
          body: IndexedStack(
            index: value,
            children: pages,
          ),
          bottomNavigationBar: MainBottomNavigationBar(
            currentIndex: value,
            onTap: (i) => HomeNavigationController.pageIndex.value = i,
            context: context,
          ),
        );
      }
    );
  }
}