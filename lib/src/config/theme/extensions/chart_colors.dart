import 'package:flutter/material.dart';

class ChartColorsExtension extends ThemeExtension<ChartColorsExtension> {
  ChartColorsExtension({
    required this.surface,
    required this.blend,
    required this.title,
    required this.subtitle,
    required this.text,
    required this.male,
    required this.female,
    required this.nonbinary,
    required this.user,
    required this.partners,
    required this.tooltipSurface,
    required this.bgIcon,
    required this.sexLine,
    required this.mstbLine,
    required this.practicesBar,
    required this.posesBar,
    required this.soloBar,
    required this.ejacBar,
  });

  final Color surface;
  final Color blend;
  final Color title;
  final Color subtitle;
  final Color text;

  final Color male;
  final Color female;
  final Color nonbinary;
  final Color user;
  final Color partners;

  final Color tooltipSurface;
  final Color bgIcon;
  final Color sexLine;
  final Color mstbLine;

  final Color practicesBar;
  final Color posesBar;
  final Color soloBar;
  final Color ejacBar;


  Color colorAccent(Color color) => Color.lerp(color, blend, 0.6)!;
  
  Color barStart(Color accentColor) => Color.lerp(accentColor, blend, 0.9)!;
  Color barEnd(Color accentColor) => Color.lerp(accentColor, surface, 0.1)!;
  Color softBarStart(Color accentColor) => Color.lerp(accentColor, surface, 0.3)!;

  
  factory ChartColorsExtension.fromScheme(ColorScheme scheme) {
    final blend = scheme.inversePrimary;

    final male = Color.lerp(Colors.lightBlue.shade300, blend, 0.15)!;
    final female = Color.lerp(Colors.redAccent.shade200, blend, 0.15)!;
    final nonbinary = Color.lerp(
        Color.lerp(
            Colors.deepPurpleAccent.shade200,
            Colors.purpleAccent.shade200,
            0.5
        )!,
        blend,
        0.3
    )!;

    final user = Color.lerp(Colors.redAccent.shade200, blend, 0.2)!;
    final partners =  Color.lerp(Colors.amber.shade400, blend, 0.25)!;

    return ChartColorsExtension(
      surface: scheme.surface,
      blend: blend,
      title: scheme.primary,
      subtitle: scheme.secondary,
      text: scheme.onSurface,
      tooltipSurface: Color.lerp(scheme.surface, scheme.secondaryContainer, 0.5)!,
      bgIcon: Color.lerp(scheme.surface, Colors.grey, 0.07)!,
      male: male,
      female: female,
      nonbinary: nonbinary,
      user: user,
      partners: partners,
      sexLine: Color.lerp(blend, scheme.primary, 0.7)!,
      mstbLine: Color.lerp(
          Color.lerp(scheme.inversePrimary,blend, 0.7)!,
          scheme.primaryFixed, 0.05
      )!,
      practicesBar: Color.fromRGBO(80, 220, 200, 1),
      posesBar: Color.fromRGBO(90, 200, 240, 1),
      soloBar: Color.fromRGBO(150, 150, 220, 1),
      ejacBar: Color.fromRGBO(180, 150, 220, 1),
    );
  }


  @override
  ThemeExtension<ChartColorsExtension> copyWith({
    Color? surface,
    Color? blend,
    Color? title,
    Color? subtitle,
    Color? text,
    Color? male,
    Color? female,
    Color? nonbinary,
    Color? user,
    Color? partners,
    Color? tooltipSurface,
    Color? bgIcon,
    Color? sexLine,
    Color? mstbLine,
    Color? practicesBar,
    Color? posesBar,
    Color? soloBar,
    Color? ejacBar,
    Color? barStart,
    Color? barEnd,
    Color? softBarStart,
  }) {
    return ChartColorsExtension(
      surface: surface ?? this.surface,
      blend: blend ?? this.blend,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      text: text ?? this.text,
      male: male ?? this.male,
      female: female ?? this.female,
      nonbinary: nonbinary ?? this.nonbinary,
      user: user ?? this.user,
      partners: partners ?? this.partners,
      tooltipSurface: tooltipSurface ?? this.tooltipSurface,
      bgIcon: bgIcon ?? this.bgIcon,
      sexLine: sexLine ?? this.sexLine,
      mstbLine: mstbLine ?? this.mstbLine,
      practicesBar: practicesBar ?? this.practicesBar,
      posesBar: posesBar ?? this.posesBar,
      soloBar: soloBar ?? this.soloBar,
      ejacBar: ejacBar ?? this.ejacBar
    );
  }

  @override
  ThemeExtension<ChartColorsExtension> lerp(
      covariant ThemeExtension<ChartColorsExtension>? other,
      double t,
      ) {
    if (other is! ChartColorsExtension) {
      return this;
    }

    return ChartColorsExtension(
      surface: Color.lerp(surface, other.surface, t)!,
      blend: Color.lerp(blend, other.blend, t)!,
      title: Color.lerp(title, other.title, t)!,
      subtitle: Color.lerp(subtitle, other.subtitle, t)!,
      text: Color.lerp(text, other.text, t)!,
      male: Color.lerp(male, other.male, t)!,
      female: Color.lerp(female, other.female, t)!,
      nonbinary: Color.lerp(nonbinary, other.nonbinary, t)!,
      user: Color.lerp(user, other.user, t)!,
      partners: Color.lerp(partners, other.partners, t)!,
      tooltipSurface: Color.lerp(tooltipSurface, other.tooltipSurface, t)!,
      bgIcon: Color.lerp(bgIcon, other.bgIcon, t)!,
      sexLine: Color.lerp(sexLine, other.sexLine, t)!,
      mstbLine: Color.lerp(mstbLine, other.mstbLine, t)!,
      practicesBar: Color.lerp(practicesBar, other.practicesBar, t)!,
      posesBar: Color.lerp(posesBar, other.posesBar, t)!,
      soloBar: Color.lerp(soloBar, other.soloBar, t)!,
      ejacBar: Color.lerp(ejacBar, other.ejacBar, t)!
    );
  }
}