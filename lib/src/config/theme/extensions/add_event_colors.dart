import 'package:flutter/material.dart';

class AddEventColorsExtension extends ThemeExtension<AddEventColorsExtension> {
  AddEventColorsExtension({
    required this.surface,
    required this.selectedSurface,
    required this.pickerSurface,
    required this.text,
    required this.coloredText,
    required this.title,
    required this.icon,
    required this.leadingIcon,
    required this.border,
    required this.buttonOnTap,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  final Color surface;
  final Color selectedSurface;
  final Color pickerSurface;
  final Color text;
  final Color coloredText;
  final Color title;
  final Color icon;
  final Color leadingIcon;
  final Color border;
  final Color buttonOnTap;
  final Color shimmerBase;
  final Color shimmerHighlight;


  factory AddEventColorsExtension.fromScheme(ColorScheme scheme) {
    final surface = scheme.surfaceContainer;
    final selectedSurface = scheme.secondaryContainer;
    final title = scheme.onSecondaryContainer;
    final border = Color.lerp(selectedSurface, scheme.secondary, 0.3)!;

    return AddEventColorsExtension(
        surface: surface,
        selectedSurface: selectedSurface,
        pickerSurface: Color.lerp(selectedSurface, scheme.surface, 0.5)!,
        text: scheme.onSurface,
        coloredText: scheme.secondary,
        title: title,
        icon: title,
        leadingIcon: scheme.primary,
        border: border,
        buttonOnTap: Color.lerp(selectedSurface, border, 0.5)!,
        shimmerBase: Color.lerp(surface, scheme.primary, 0.1)!,
        shimmerHighlight: Color.lerp(surface, scheme.primary, 0.05)!
    );
  }


  @override
  ThemeExtension<AddEventColorsExtension> copyWith({
    Color? surface,
    Color? selectedSurface,
    Color? pickerSurface,
    Color? text,
    Color? coloredText,
    Color? title,
    Color? icon,
    Color? leadingIcon,
    Color? border,
    Color? buttonOnTap,
    Color? shimmerBase,
    Color? shimmerHighlight,
  }) {
    return AddEventColorsExtension(
      surface: surface ?? this.surface,
      selectedSurface: selectedSurface ?? this.selectedSurface,
      pickerSurface: pickerSurface ?? this.pickerSurface,
      text: text ?? this.text,
      coloredText: coloredText ?? this.coloredText,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      border: border ?? this.border,
      buttonOnTap: buttonOnTap ?? this.buttonOnTap,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
    );
  }

  @override
  ThemeExtension<AddEventColorsExtension> lerp(
      covariant ThemeExtension<AddEventColorsExtension>? other,
      double t,
      ) {
    if (other is! AddEventColorsExtension) {
      return this;
    }

    return AddEventColorsExtension(
      surface: Color.lerp(surface, other.surface, t)!,
      selectedSurface: Color.lerp(selectedSurface, other.selectedSurface, t)!,
      pickerSurface: Color.lerp(pickerSurface, other.pickerSurface, t)!,
      text: Color.lerp(text, other.text, t)!,
      coloredText: Color.lerp(coloredText, other.coloredText, t)!,
      title: Color.lerp(title, other.title, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      leadingIcon: Color.lerp(leadingIcon, other.leadingIcon, t)!,
      border: Color.lerp(border, other.border, t)!,
      buttonOnTap: Color.lerp(buttonOnTap, other.buttonOnTap, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
    );
  }
}