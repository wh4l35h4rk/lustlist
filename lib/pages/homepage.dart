import 'package:flutter/material.dart';
import 'package:lustlist/pages/calendar.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "ll",
          style: TextStyle(color: Theme.of(context).colorScheme.surface),
        ),
      ),

      body: Calendar(),

      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Add event',
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.stacked_bar_chart), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
    );
  }
}
