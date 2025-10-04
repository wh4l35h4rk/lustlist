import 'package:flutter/material.dart';

Color? colorBlend(Color color1, color2, double amount) {
  return Color.lerp(color1, color2, amount)!;
}


class AppColors {
  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;
  
  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

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
}


class AddEventColors {
  Color surface(BuildContext context) => categoryTile.surface(context);

  Color selectedSurface(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;

  Color text(BuildContext context) => categoryTile.text(context);

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
      Theme.of(context).colorScheme.primary;

  Color navigationIcon(BuildContext context) => title(context);

  Color eventIcon(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  Color eventOtherMonthIcon(BuildContext context) =>
      Colors.black26;

  Color todayEvent(BuildContext context) =>
      Theme.of(context).colorScheme.primaryFixed;

  Color selectedEvent(BuildContext context) =>
      Theme.of(context).colorScheme.inversePrimary;
}

class AppBarColors {
  Color icon(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  Color title(BuildContext context) =>
      Theme.of(context).colorScheme.primaryFixed;

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
      Theme.of(context).colorScheme.primaryFixed;

  Color leadingIcon(BuildContext context) =>
      Theme.of(context).colorScheme.inversePrimary;

  Color border(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimaryFixedVariant;
}

