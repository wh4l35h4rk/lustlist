import 'package:flutter/material.dart';
import 'package:lustlist/widgets/calendar.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import '../test_event.dart';
import 'add_pages/add_med_page.dart';
import 'add_pages/add_mstb_page.dart';
import 'add_pages/add_sex_page.dart';


List<IconData> iconsData = [Icons.favorite, Icons.front_hand, Icons.medical_services];


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Calendar(),

      floatingActionButton: MenuAnchor(
        builder: (BuildContext context, MenuController controller, Widget? child) {
          return FloatingActionButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            tooltip: 'Show menu',
            child: const Icon(Icons.add),

          );
        },
        menuChildren: List<MenuItemButton>.generate(
            3,
            (int index) => MenuItemButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) {
                      if (index == 0) {
                        return AddSexEventPage();
                      } else if (index == 1) {
                        return AddMstbEventPage();
                      } else {
                        return AddMedEventPage();
                      }
                    },
                  ),
                );
              },
              child: Icon(iconsData[index])
            ),
          ),
        ),
      bottomNavigationBar: MainBottomNavigationBar(),
    );
  }
}
