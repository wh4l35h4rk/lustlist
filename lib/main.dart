import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lustlist/calendar.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lustlist',
      theme: ThemeData(
        fontFamily: 'Liberation Mono',
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pink,
            brightness: Brightness.light
        ),
      ),
      home: const MyHomePage(),
    );
  }
}


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

      body: MyCalendar(),

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
