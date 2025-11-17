import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';
import 'package:lustlist/pages/homepage.dart';
import '../pages/options_page.dart';
import '../pages/statspage.dart';


class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({
    super.key, 
    required this.context,
  });
  
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
        BottomNavigationBarItem(icon: Icon(Icons.stacked_bar_chart), label: 'Stats'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Options'),
      ],
      backgroundColor: AppColors.bnb(context),
      onTap: _onTap,
    );
  }

  Future<void> _onTap(int index) async {
    Widget page;
    switch (index) {
      case 0: page = Homepage();
      case 1: page = StatsPage();
      case 2: page = OptionsPage();
      default: throw FormatException('Invalid page index: $index');
    }
    
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );

    //TODO: fix selected item not changing
    //TODO: fix back arrow button on main pages
    //TODO: add alert dialog when calling from add/edit pages
  }
}
