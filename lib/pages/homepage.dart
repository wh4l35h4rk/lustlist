import 'package:flutter/material.dart';
import 'package:lustlist/utils.dart';
import 'package:lustlist/widgets/animated_appbar.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import 'package:lustlist/pages/statspage.dart';
import '../controllers/home_navigation_controller.dart';
import '../widgets/calendar_widgets/change_theme_button.dart';
import 'calendar_page.dart';
import 'options_page.dart';


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
                  title: mainPageNames[value],
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

//TODO: make main app bar change width on scroll