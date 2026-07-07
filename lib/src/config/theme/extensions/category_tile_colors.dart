import 'package:flutter/material.dart';

class CategoryTileColorsExtension extends ThemeExtension<CategoryTileColorsExtension> {
  CategoryTileColorsExtension({
    required this.surface,
    required this.text,
    required this.title,
    required this.icon,
    required this.leadingIcon,
    required this.border,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  final Color surface;
  final Color text;
  final Color title;
  final Color icon;
  final Color leadingIcon;
  final Color border;
  final Color shimmerBase;
  final Color shimmerHighlight;


  factory CategoryTileColorsExtension.fromScheme(ColorScheme scheme) {
    final surface = scheme.surfaceContainer;
    final basicColor = scheme.onSurface;
    final leadingColor = scheme.secondary;

    return CategoryTileColorsExtension(
      surface: surface,
      text: basicColor,
      title: leadingColor,
      icon: basicColor,
      leadingIcon: leadingColor,
      border: Color.lerp(scheme.onPrimaryContainer, scheme.primaryContainer, 0.8)!,
      shimmerBase: Color.lerp(surface, scheme.primary, 0.1)!,
      shimmerHighlight: Color.lerp(surface, scheme.primary, 0.05)!
    );
  }


  @override
  ThemeExtension<CategoryTileColorsExtension> copyWith({
    Color? surface,
    Color? text,
    Color? title,
    Color? icon,
    Color? leadingIcon,
    Color? border,
    Color? shimmerBase,
    Color? shimmerHighlight,
  }) {
    return CategoryTileColorsExtension(
      surface: surface ?? this.surface,
      text: text ?? this.text,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      border: border ?? this.border,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
    );
  }

  @override
  ThemeExtension<CategoryTileColorsExtension> lerp(
      covariant ThemeExtension<CategoryTileColorsExtension>? other,
      double t,
      ) {
    if (other is! CategoryTileColorsExtension) {
      return this;
    }

    return CategoryTileColorsExtension(
      surface: Color.lerp(surface, other.surface, t)!,
      text: Color.lerp(text, other.text, t)!,
      title: Color.lerp(title, other.title, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      leadingIcon: Color.lerp(leadingIcon, other.leadingIcon, t)!,
      border: Color.lerp(border, other.border, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
    );
  }
}