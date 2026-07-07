import 'package:flutter/material.dart';

class EventDataColorsExtension extends ThemeExtension<EventDataColorsExtension> {
  EventDataColorsExtension({
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


  factory EventDataColorsExtension.fromScheme(ColorScheme scheme) {
    final surface = scheme.primary;
    final accent = scheme.inversePrimary;
    final text = scheme.surface;

    return EventDataColorsExtension(
        surface: surface,
        text: text,
        title: Color.lerp(accent, text, 0.4)!,
        icon: Color.lerp(accent, text, 0.4)!,
        leadingIcon: accent,
        border: scheme.onPrimaryFixedVariant,
        shimmerBase: Color.lerp(surface, accent, 0.1)!,
        shimmerHighlight: Color.lerp(surface, accent, 0.05)!
    );
  }


  @override
  ThemeExtension<EventDataColorsExtension> copyWith({
    Color? surface,
    Color? text,
    Color? title,
    Color? icon,
    Color? leadingIcon,
    Color? border,
    Color? shimmerBase,
    Color? shimmerHighlight,
  }) {
    return EventDataColorsExtension(
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
  ThemeExtension<EventDataColorsExtension> lerp(
      covariant ThemeExtension<EventDataColorsExtension>? other,
      double t,
      ) {
    if (other is! EventDataColorsExtension) {
      return this;
    }

    return EventDataColorsExtension(
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