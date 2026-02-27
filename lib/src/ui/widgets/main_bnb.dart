import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import '../controllers/home_navigation_controller.dart';


class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.context,
    this.onTap
  });
  
  final BuildContext context;
  final ValueChanged<int>? onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(AppIconData.calendar), label: PageTitleStrings.calendar),
        BottomNavigationBarItem(icon: Icon(AppIconData.statistics), label: PageTitleStrings.statistics),
        BottomNavigationBarItem(icon: Icon(AppIconData.options), label: PageTitleStrings.options),
      ],
      backgroundColor: AppColors.bnb(context),
      onTap: onTap ?? _onTap,
    );
  }

  Future<void> _onTap(int index) async {
    HomeNavigationController.pageIndex.value = index;
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
