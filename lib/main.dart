import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/pages/homepage.dart';
import 'package:lustlist/repository.dart';
import 'package:path_provider/path_provider.dart';


late AppDatabase database;
Map<int, IconData> iconDataMap = {};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await deleteDatabase();
  database = AppDatabase();
  var repo = EventRepository(database);
  await repo.insertMockEntries();
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
            brightness: Brightness.light,
            seedColor: Colors.pink,
            // brightness: Brightness.dark,
            // seedColor: Colors.deepPurpleAccent,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}



Future<void> deleteDatabase() async {
  final dir = await getApplicationSupportDirectory();
  final dbFile = File('${dir.path}/ll_database.sqlite');
  if (await dbFile.exists()) {
    await dbFile.delete();
    print('Database deleted');
  } else {
    print('Database file not found');
  }
}