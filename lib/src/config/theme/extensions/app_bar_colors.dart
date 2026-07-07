import 'package:flutter/material.dart';

class AppBarColorsExtension extends ThemeExtension<AppBarColorsExtension> {
  AppBarColorsExtension({
    required this.surface,
    required this.surfaceGradient,
    required this.text,
    required this.title,
    required this.icon,
  });

  final Color surface;
  final Color surfaceGradient;
  final Color text;
  final Color title;
  final Color icon;


  factory AppBarColorsExtension.fromScheme(ColorScheme scheme) {
    final surface = scheme.primary;
    final accent = scheme.inversePrimary;
    final onSurface = scheme.surface;

    return AppBarColorsExtension(
        surface: surface,
        surfaceGradient: Color.lerp(surface, accent, 0.6)!,
        text: onSurface,
        title: Color.lerp(accent, onSurface, 0.4)!,
        icon: onSurface,
    );
  }


  @override
  ThemeExtension<AppBarColorsExtension> copyWith({
    Color? surface,
    Color? surfaceGradient,
    Color? text,
    Color? title,
    Color? icon
  }) {
    return AppBarColorsExtension(
      surface: surface ?? this.surface,
      surfaceGradient: surfaceGradient ?? this.surfaceGradient,
      text: text ?? this.text,
      title: title ?? this.title,
      icon: icon ?? this.icon,
    );
  }

  @override
  ThemeExtension<AppBarColorsExtension> lerp(
      covariant ThemeExtension<AppBarColorsExtension>? other,
      double t,
      ) {
    if (other is! AppBarColorsExtension) {
      return this;
    }

    return AppBarColorsExtension(
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceGradient: Color.lerp(surfaceGradient, other.surfaceGradient, t)!,
      text: Color.lerp(text, other.text, t)!,
      title: Color.lerp(title, other.title, t)!,
      icon: Color.lerp(icon, other.icon, t)!
    );
  }
}