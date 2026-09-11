import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
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
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              AppIconData.calendar,
              size: context.sizes.iconBasic
            ),
            label: PageTitleStrings.calendar,
        ),
        BottomNavigationBarItem(
            icon: Icon(AppIconData.statistics, size: context.sizes.iconBasic),
            label: PageTitleStrings.statistics),
        BottomNavigationBarItem(
            icon: Icon(AppIconData.options, size: context.sizes.iconBasic),
            label: PageTitleStrings.options,
        ),
      ],
      backgroundColor: context.theme.mainColors.bnb,
      onTap: onTap ?? _onTap,
      selectedFontSize: context.sizes.bnbLabelSelected,
      unselectedFontSize: context.sizes.bnbLabel,
    );
  }

  Future<void> _onTap(int index) async {
    HomeNavigationController.pageIndex.value = index;
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
