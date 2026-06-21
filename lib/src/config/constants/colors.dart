import 'package:flutter/material.dart';

Color? colorBlend(Color color1, color2, double amount) {
  return Color.lerp(color1, color2, amount)!;
}


class MainColors {
  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;
  
  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color enabledBorder(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

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
    CategoryTileColors.surface(context),
    MainColors.surface(context),
    0.5
  );

  static Color filterSurface(BuildContext context) => CategoryTileColors.surface(context);
  static Color? filterButton(BuildContext context) => colorBlend(
    filterSurface(context),
    Theme.of(context).colorScheme.surface,
    0.5
  );

  static Color title(BuildContext context) => Theme.of(context).colorScheme.primary;

  static Color divider(BuildContext context) => Theme.of(context).dividerColor;

  static Color iconButtonSurface(BuildContext context) => colorBlend(
    primary(context),
    filterButton(context),
    0.23
  )!;

  static Color? avatarIcon(BuildContext context) => icon(context).withAlpha(80);

  static Color notSelected(BuildContext context) =>
      colorBlend(
          defaultTile(context),
          surface(context),
          0.5
      )!;

  static Color shimmerBase(BuildContext context) => colorBlend(
      surface(context),
      Theme.of(context).colorScheme.primary,
      0.05
  )!;

  static Color shimmerHighlight(BuildContext context) => colorBlend(
      surface(context),
      Theme.of(context).colorScheme.primary,
      0.025
  )!;
}


class AddEventColors {
  static Color surface(BuildContext context) => CategoryTileColors.surface(context);

  static Color selectedSurface(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;

  static Color text(BuildContext context) => CategoryTileColors.text(context);

  static Color coloredText(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static Color title(BuildContext context) =>
      Theme.of(context).colorScheme.onSecondaryContainer;

  static Color icon(BuildContext context) => title(context);

  static Color leadingIcon(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color pickerSurface(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.secondaryContainer,
          MainColors.surface(context),
          0.5
      )!;

  static Color border(BuildContext context) =>
      colorBlend(
          selectedSurface(context),
          Theme.of(context).colorScheme.secondary,
          0.3
      )!;

  static Color buttonOnTap(BuildContext context) =>
      colorBlend(
          selectedSurface(context),
          border(context),
          0.5
      )!;

  static Color shimmerBase(BuildContext context) => colorBlend(
      surface(context),
      Theme.of(context).colorScheme.primary,
      0.1
  )!;

  static Color shimmerHighlight(BuildContext context) => colorBlend(
      surface(context),
      Theme.of(context).colorScheme.primary,
      0.05
  )!;
}

class CategoryTileColors {
  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainer;

  static Color text(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color title(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static Color icon(BuildContext context) => text(context);

  static Color leadingIcon(BuildContext context) => title(context);

  static Color border(BuildContext context) =>
    colorBlend(
        Theme.of(context).colorScheme.onPrimaryContainer,
        Theme.of(context).colorScheme.primaryContainer,
        0.8
    )!;

  static Color shimmerBase(BuildContext context) => colorBlend(
      surface(context),
      Theme.of(context).colorScheme.primary,
      0.1
  )!;

  static Color shimmerHighlight(BuildContext context) => colorBlend(
      surface(context),
      Theme.of(context).colorScheme.primary,
      0.05
  )!;
}

class CalendarColors {
  static Color title(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color border(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.surface,
          0.4
      )!;

  static Color navigationIcon(BuildContext context) => title(context);

  static Color eventIcon(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static Color eventOtherMonthIcon(BuildContext context) =>
      Colors.black26;

  static Color todayEvent(BuildContext context) =>
      colorBlend(
        selectedEvent(context),
        Theme.of(context).colorScheme.surface,
        0.4
      )!;

  static Color selectedEvent(BuildContext context) =>
      Theme.of(context).colorScheme.inversePrimary;

  static Color basicText(BuildContext context) => MainColors.text(context);
  static Color weekendText(BuildContext context) =>
      colorBlend(
          basicText(context),
          Theme.of(context).colorScheme.primary,
          0.9
      )!;
  static Color disabledText(BuildContext context) =>
      colorBlend(
          basicText(context),
          Theme.of(context).colorScheme.surface,
          0.8
      )!;
  static Color outsideText(BuildContext context) =>
      colorBlend(
          basicText(context),
          Theme.of(context).colorScheme.surface,
          0.6
      )!;
}

class AppBarColors {
  static Color icon(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color surfaceGradient(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.inversePrimary,
          0.6
      )!;

  static Color title(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.inversePrimary,
          Theme.of(context).colorScheme.surface,
          0.4
      )!;

  static Color text(BuildContext context) =>
      Theme.of(context).colorScheme.surface;
}

class EventDataColors {
  static Color surface(BuildContext context) =>
      AppBarColors.surface(context);

  static Color title(BuildContext context) =>
      AppBarColors.title(context);

  static Color text(BuildContext context) =>
      AppBarColors.text(context);

  static Color icon(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.inversePrimary,
          Theme.of(context).colorScheme.surface,
          0.4
      )!;

  static Color leadingIcon(BuildContext context) =>
      Theme.of(context).colorScheme.inversePrimary;

  static Color border(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimaryFixedVariant;
}


class ChartColors{
  static Color blendColor(BuildContext context) => Theme.of(context).colorScheme.inversePrimary;
  static Color colorAccent(Color color, BuildContext context) =>
      colorBlend(color, blendColor(context), 0.6)!;

  static Color title(BuildContext context) => Theme.of(context).colorScheme.primary;
  static Color subtitle(BuildContext context) => Theme.of(context).colorScheme.secondary;
  static Color text(BuildContext context) => Theme.of(context).colorScheme.onSurface;

  static Color tooltipSurface(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.secondaryContainer, 0.5
      )!;

  static Color bgIcon(BuildContext context) =>
      colorBlend(
          Theme.of(context).colorScheme.surface,
          Colors.grey, 0.07
      )!;


  // partners pie chart
  static Color male(BuildContext context) =>
      colorBlend(Colors.lightBlue.shade300, blendColor(context), 0.2)!;
  static Color female(BuildContext context) =>
      colorBlend(Colors.redAccent.shade200, blendColor(context), 0.2)!;
  static Color nonbinary(BuildContext context) =>
      colorBlend(
          colorBlend(
              Colors.deepPurpleAccent.shade200,
              Colors.purpleAccent.shade200,
              0.5
          )!,
          blendColor(context),
          0.3
      )!;

  static Color femaleAccent(BuildContext context) => colorAccent(female(context), context);
  static Color maleAccent(BuildContext context) => colorAccent(male(context), context);
  static Color nonbinaryAccent(BuildContext context) => colorAccent(nonbinary(context), context);

  // orgasm ratio pie chart
  static Color user(BuildContext context) =>
      colorBlend(Colors.redAccent.shade200, blendColor(context), 0.2)!;
  static Color partners(BuildContext context) =>
      colorBlend(Colors.amber.shade400, blendColor(context), 0.25)!;
  static Color userAccent(BuildContext context) => colorAccent(user(context), context);
  static Color partnersAccent(BuildContext context) => colorAccent(partners(context), context);


  // line chart
  static Color sexLine(BuildContext context) =>
      colorBlend(
        blendColor(context),
        Theme.of(context).colorScheme.primary, 0.7)!;
  static Color mstbLine(BuildContext context) => colorBlend(
      colorBlend(
          Theme.of(context).colorScheme.inversePrimary,
          blendColor(context), 0.7)!,
      Theme.of(context).colorScheme.primaryFixed, 0.2
  )!;


  // cards
  static Color cardTop(BuildContext context) =>
      colorBlend(
        Theme.of(context).colorScheme.tertiaryContainer,
        Theme.of(context).colorScheme.primary, 0.85)!;

  static Color cardBottom(BuildContext context) =>
      colorBlend(
          colorBlend(
              Theme.of(context).colorScheme.tertiaryContainer,
              Theme.of(context).colorScheme.primaryContainer, 0.5)!,
          Theme.of(context).colorScheme.surface,
          0.5
      )!;

  static Color cardTitle(BuildContext context) => Theme.of(context).colorScheme.onPrimary;


  // bar chart
  static Color practicesAccent() => Color.fromRGBO(80, 220, 200, 1);
  static Color posesAccent() => Color.fromRGBO(90, 200, 240, 1);
  static Color soloPracticesAccent() => Color.fromRGBO(150, 150, 220, 1);
  static Color ejaculationAccent() => Color.fromRGBO(180, 150, 220, 1);

  static Color barStart(Color accentColor, BuildContext context) =>
      colorBlend(
          accentColor,
          blendColor(context),
          0.9
      )!;
  static Color barEnd(Color accentColor, BuildContext context) =>
      colorBlend(
          accentColor,
          Theme.of(context).colorScheme.surface,
          0.1
      )!;

  static Color softBarStart(Color accentColor, BuildContext context) =>
      colorBlend(
          accentColor,
          Theme.of(context).colorScheme.surface,
          0.3
      )!;

}

