import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/ui/pages/homepage.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/ui/controllers/theme_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';


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


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'lustlist',
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: 'Liberation Mono',
              colorScheme: lightColorScheme
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              fontFamily: 'Liberation Mono',
              colorScheme: darkColorScheme
            ),
            home: const Homepage(),
          );
      })
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