import 'package:flutter/material.dart';
import 'package:lustlist/src/config/theme/extensions/add_event_colors.dart';
import 'package:lustlist/src/config/theme/extensions/app_bar_colors.dart';
import 'package:lustlist/src/config/theme/extensions/calendar_colors_extension.dart';
import 'package:lustlist/src/config/theme/extensions/category_tile_colors.dart';
import 'package:lustlist/src/config/theme/extensions/chart_colors.dart';
import 'package:lustlist/src/config/theme/extensions/event_data_colors.dart';
import 'package:lustlist/src/config/theme/extensions/main_colors.dart';


final lightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.pinkAccent,
);

final darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.deepPurpleAccent,
);


class AppTheme {

  static final lightBase = ThemeData(
      useMaterial3: true,
      fontFamily: 'Liberation Mono',
      colorScheme: lightColorScheme
  );

  static final light = lightBase.copyWith(
    extensions: [
      MainColorsExtension.fromTheme(lightBase),
      CategoryTileColorsExtension.fromScheme(lightColorScheme),
      AddEventColorsExtension.fromScheme(lightColorScheme),
      EventDataColorsExtension.fromScheme(lightColorScheme),
      AppBarColorsExtension.fromScheme(lightColorScheme),
      CalendarColorsExtension.fromScheme(lightColorScheme),
      ChartColorsExtension.fromScheme(lightColorScheme)
    ]
  );


  static final darkBase = ThemeData(
      useMaterial3: true,
      fontFamily: 'Liberation Mono',
      colorScheme: darkColorScheme
  );

  static final dark = darkBase.copyWith(
      extensions: [
        MainColorsExtension.fromTheme(darkBase),
        CategoryTileColorsExtension.fromScheme(darkColorScheme),
        AddEventColorsExtension.fromScheme(darkColorScheme),
        EventDataColorsExtension.fromScheme(darkColorScheme),
        AppBarColorsExtension.fromScheme(darkColorScheme),
        CalendarColorsExtension.fromScheme(darkColorScheme),
        ChartColorsExtension.fromScheme(darkColorScheme)
      ]
  );
}


extension AppThemeExtension on ThemeData {
  /// usage example: Theme.of(context).appColors;

  MainColorsExtension get mainColors =>
      extension<MainColorsExtension>() ?? MainColorsExtension.fromTheme(AppTheme.lightBase);

  CategoryTileColorsExtension get categoryTileColors =>
      extension<CategoryTileColorsExtension>() ?? CategoryTileColorsExtension.fromScheme(lightColorScheme);

  AddEventColorsExtension get addEventColors =>
      extension<AddEventColorsExtension>() ?? AddEventColorsExtension.fromScheme(lightColorScheme);

  EventDataColorsExtension get eventDataColors =>
      extension<EventDataColorsExtension>() ?? EventDataColorsExtension.fromScheme(lightColorScheme);

  AppBarColorsExtension get appBarColors =>
      extension<AppBarColorsExtension>() ?? AppBarColorsExtension.fromScheme(lightColorScheme);

  CalendarColorsExtension get calendarColors =>
      extension<CalendarColorsExtension>() ?? CalendarColorsExtension.fromScheme(lightColorScheme);

  ChartColorsExtension get chartColors =>
      extension<ChartColorsExtension>() ?? ChartColorsExtension.fromScheme(lightColorScheme);

}

extension ThemeGetter on BuildContext {
  // usage example: `context.theme`
  ThemeData get theme => Theme.of(this);
}