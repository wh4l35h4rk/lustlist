import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
import 'package:lustlist/src/ui/pages/homepage.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/providers/theme_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';


late AppDatabase database;
Map<int, IconData> iconDataMap = {};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    await deleteDatabase();
  }

  database = AppDatabase();
  final repo = EventRepository(database);

  if (kDebugMode) {
    await repo.insertMockEntries();
  }
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ScaleProvider())
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'lustlist',
            themeMode: themeProvider.currentThemeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
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
    if (kDebugMode) {
      print('Database deleted');
    }
  } else if (kDebugMode) {
    print('Database file not found');
  }
}