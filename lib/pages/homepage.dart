import 'package:flutter/material.dart';
import 'package:lustlist/widgets/calendar.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';


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

      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Add event',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: MainBottomNavigationBar(),
    );
  }
}
