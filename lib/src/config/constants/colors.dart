import 'package:flutter/material.dart';

Color? colorBlend(Color color1, color2, double amount) {
  return Color.lerp(color1, color2, amount)!;
}


class AppColors {
  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;
  
  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color icon(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static Color defaultTile(BuildContext context) =>
      Theme.of(context).colorScheme.outline;

  static Color text(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color bnb(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;

  static EventDataColors eventData = EventDataColors();
  static AppBarColors appBar = AppBarColors();
  static CalendarColors calendar = CalendarColors();
  static CategoryTileColors categoryTile = CategoryTileColors();
  static AddEventColors addEvent = AddEventColors();
  static ChartColors chart = ChartColors();

  static Color? notesBottom(BuildContext context) => colorBlend(
      AppColors.categoryTile.surface(context),
      AppColors.surface(context),
      0.5
  );

  static Color title(BuildContext context) => Theme.of(context).colorScheme.primary;
}


class AddEventColors {
  Color surface(BuildContext context) => categoryTile.surface(context);

  Color selectedSurface(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;

  Color text(BuildContext context) => categoryTile.text(context);

  Color coloredText(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  Color title(BuildContext context) =>
      Theme.of(context).colorScheme.onSecondaryContainer;

  Color icon(BuildContext context) => title(context);

  Color leadingIcon(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  Color pickerSurface(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;

  Color border(BuildContext context) =>
      colorBlend(
          selectedSurface(context),
          Theme.of(context).colorScheme.secondary,
          0.5
      )!;

  Color buttonOnTap(BuildContext context) =>
      colorBlend(
          selectedSurface(context),
          border(context),
          0.5
      )!;

  static CategoryTileColors categoryTile = CategoryTileColors();
}

class CategoryTileColors {
  Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainer;

  Color text(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  Color title(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  Color icon(BuildContext context) => text(context);

  Color leadingIcon(BuildContext context) => title(context);

  Color border(BuildContext context) =>
    colorBlend(
        Theme.of(context).colorScheme.onPrimaryContainer,
        Theme.of(context).colorScheme.primaryContainer,
        0.8
    )!;
}

class CalendarColors {
  Color title(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  Color border(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.surface,
          0.4
      )!;

  Color navigationIcon(BuildContext context) => title(context);

  Color eventIcon(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  Color eventOtherMonthIcon(BuildContext context) =>
      Colors.black26;

  Color todayEvent(BuildContext context) =>
      colorBlend(
        selectedEvent(context),
        Theme.of(context).colorScheme.surface,
        0.4
      )!;

  Color selectedEvent(BuildContext context) =>
      Theme.of(context).colorScheme.inversePrimary;
}

class AppBarColors {
  Color icon(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  Color surfaceGradient(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.inversePrimary,
          0.6
      )!;

  Color title(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.inversePrimary,
          Theme.of(context).colorScheme.surface,
          0.4
      )!;

  Color text(BuildContext context) =>
      Theme.of(context).colorScheme.surface;
}

class EventDataColors {
  static AppBarColors appBarColors = AppBarColors();

  Color surface(BuildContext context) =>
      appBarColors.surface(context);

  Color title(BuildContext context) =>
      appBarColors.title(context);

  Color text(BuildContext context) =>
      appBarColors.text(context);

  Color icon(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.inversePrimary,
          Theme.of(context).colorScheme.surface,
          0.4
      )!;

  Color leadingIcon(BuildContext context) =>
      Theme.of(context).colorScheme.inversePrimary;

  Color border(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimaryFixedVariant;
}


class ChartColors{
  Color blendColor(BuildContext context) => Theme.of(context).colorScheme.inversePrimary;

  Color title(BuildContext context) => Theme.of(context).colorScheme.primary;
  Color subtitle(BuildContext context) => Theme.of(context).colorScheme.secondary;

  Color male(BuildContext context) =>
      colorBlend(Colors.lightBlue, blendColor(context), 0.4)!;
  Color female(BuildContext context) =>
      colorBlend(Colors.redAccent, blendColor(context), 0.4)!;

  Color nonbinary(BuildContext context) =>
      colorBlend(
          colorBlend(
              Colors.deepPurpleAccent,
              Colors.purpleAccent,
              0.5
          )!,
          blendColor(context),
          0.4
      )!;

  Color femaleAccent(BuildContext context) =>
      colorBlend(female(context), blendColor(context), 0.6)!;
  Color maleAccent(BuildContext context) =>
      colorBlend(male(context), blendColor(context), 0.6)!;
  Color nonbinaryAccent(BuildContext context) =>
      colorBlend(nonbinary(context), blendColor(context), 0.6)!;

  Color sexLine(BuildContext context) =>
      colorBlend(
        blendColor(context),
        Theme.of(context).colorScheme.secondary, 0.7)!;
  
  Color mstbLine(BuildContext context) =>
      colorBlend(
        blendColor(context),
        Theme.of(context).colorScheme.secondary, 0.1
      )!;

  Color tooltipSurface(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.secondaryContainer, 0.5
      )!;

  Color bgIcon(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.surface,
          Colors.grey, 0.07
      )!;

  Color cardTop(BuildContext context) =>
      colorBlend(
        Theme.of(context).colorScheme.tertiaryContainer,
        Theme.of(context).colorScheme.primary, 0.85)!;

  Color cardBottom(BuildContext context) =>
      colorBlend(
          colorBlend(
              Theme.of(context).colorScheme.tertiaryContainer,
              Theme.of(context).colorScheme.primaryContainer, 0.5)!,
          Theme.of(context).colorScheme.surface,
          0.5
      )!;

  Color cardTitle(BuildContext context) => Theme.of(context).colorScheme.onPrimary;
}

