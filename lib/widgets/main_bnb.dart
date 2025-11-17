import 'package:flutter/material.dart';
import 'package:lustlist/colors.dart';


class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
        BottomNavigationBarItem(icon: Icon(Icons.stacked_bar_chart), label: 'Stats'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Options'),
      ],
      backgroundColor: AppColors.bnb(context),
    );
  }
}
