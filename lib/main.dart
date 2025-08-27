import 'package:flutter/material.dart';

import 'package:lustlist/database.dart';
import 'package:lustlist/pages/homepage.dart';


late AppDatabase database;

void main() {
  database = AppDatabase();
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