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

  static Color divider(BuildContext context) => Theme.of(context).dividerColor;
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

  Color basicText(BuildContext context) => AppColors.text(context);
  Color weekendText(BuildContext context) =>
      colorBlend(
          basicText(context),
          Theme.of(context).colorScheme.primary,
          0.9
      )!;
  Color disabledText(BuildContext context) =>
      colorBlend(
          basicText(context),
          Theme.of(context).colorScheme.surface,
          0.8
      )!;
  Color outsideText(BuildContext context) =>
      colorBlend(
          basicText(context),
          Theme.of(context).colorScheme.surface,
          0.6
      )!;
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
  Color colorAccent(Color color, BuildContext context) =>
      colorBlend(color, blendColor(context), 0.6)!;

  Color title(BuildContext context) => Theme.of(context).colorScheme.primary;
  Color subtitle(BuildContext context) => Theme.of(context).colorScheme.secondary;
  Color text(BuildContext context) => Theme.of(context).colorScheme.onSurface;

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


  // partners pie chart
  Color male(BuildContext context) =>
      colorBlend(Colors.lightBlue.shade300, blendColor(context), 0.2)!;
  Color female(BuildContext context) =>
      colorBlend(Colors.redAccent.shade200, blendColor(context), 0.2)!;
  Color nonbinary(BuildContext context) =>
      colorBlend(
          colorBlend(
              Colors.deepPurpleAccent.shade200,
              Colors.purpleAccent.shade200,
              0.5
          )!,
          blendColor(context),
          0.3
      )!;

  Color femaleAccent(BuildContext context) => colorAccent(female(context), context);
  Color maleAccent(BuildContext context) => colorAccent(male(context), context);
  Color nonbinaryAccent(BuildContext context) => colorAccent(nonbinary(context), context);

  // orgasm ratio pie chart
  Color user(BuildContext context) =>
      colorBlend(Colors.redAccent.shade200, blendColor(context), 0.2)!;
  Color partners(BuildContext context) =>
      colorBlend(Colors.amber.shade400, blendColor(context), 0.25)!;
  Color userAccent(BuildContext context) => colorAccent(user(context), context);
  Color partnersAccent(BuildContext context) => colorAccent(partners(context), context);


  // line chart
  Color sexLine(BuildContext context) =>
      colorBlend(
        blendColor(context),
        Theme.of(context).colorScheme.primary, 0.7)!;
  Color mstbLine(BuildContext context) => colorBlend(
      colorBlend(
          Theme.of(context).colorScheme.inversePrimary,
          blendColor(context), 0.7)!,
      Theme.of(context).colorScheme.primaryFixed, 0.2
  )!;




  // cards
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


  // bar chart
  Color practicesAccent() => Color.fromRGBO(80, 220, 200, 1);
  Color posesAccent() => Color.fromRGBO(90, 200, 240, 1);
  Color soloPracticesAccent() => Color.fromRGBO(150, 150, 220, 1);



  Color barStart(Color accentColor, BuildContext context) =>
      colorBlend(
          accentColor,
          blendColor(context),
          0.9
      )!;
  Color barEnd(Color accentColor, BuildContext context) =>
      colorBlend(
          accentColor,
          Theme.of(context).colorScheme.surface,
          0.1
      )!;

  Color softBarStart(Color accentColor, BuildContext context) =>
      colorBlend(
          accentColor,
          Theme.of(context).colorScheme.surface,
          0.3
      )!;
}

