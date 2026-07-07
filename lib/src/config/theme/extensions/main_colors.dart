import 'package:flutter/material.dart';

class MainColorsExtension extends ThemeExtension<MainColorsExtension> {
  MainColorsExtension({
    required this.primary,
    required this.surface,
    required this.text,
    required this.title,
    required this.icon,
    required this.avatarIcon,
    required this.iconButton,
    required this.border,
    required this.divider,
    required this.notes,
    required this.bnb,
    required this.filterButton,
    required this.filterSurface,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.defaultWidget,
    required this.notSelected
  });

  final Color primary;
  final Color surface;
  final Color text;
  final Color title;
  final Color icon;
  final Color avatarIcon;
  final Color iconButton;
  final Color border;
  final Color divider;
  final Color notes;
  final Color bnb;
  final Color filterSurface;
  final Color filterButton;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color defaultWidget;
  final Color notSelected;


  factory MainColorsExtension.fromTheme(ThemeData theme) {
    final scheme = theme.colorScheme;

    final primary = scheme.primary;
    final secondary = scheme.secondary;
    final surface = scheme.surface;
    final outline = scheme.outline;

    final surfaceContainer = scheme.surfaceContainer;
    final surfaceContainerSemitransparent = Color.lerp(surfaceContainer, surface, 0.5)!;

    return MainColorsExtension(
      primary: primary,
      surface: surface,
      text: scheme.onSurface,
      title: primary,
      icon: secondary,
      avatarIcon: secondary.withAlpha(80),
      iconButton: Color.lerp(primary, surfaceContainerSemitransparent, 0.23)!,
      border: secondary,
      divider: theme.dividerColor,
      notes: surfaceContainerSemitransparent,
      bnb: scheme.secondaryContainer,
      filterButton: surfaceContainerSemitransparent,
      filterSurface: surfaceContainer,
      shimmerBase: Color.lerp(surface, scheme.primary, 0.1)!,
      shimmerHighlight: Color.lerp(surface, scheme.primary, 0.05)!,
      defaultWidget: outline,
      notSelected: Color.lerp(outline, surface, 0.5)!
    );
  }


  @override
  ThemeExtension<MainColorsExtension> copyWith({
    Color? primary,
    Color? surface,
    Color? text,
    Color? title,
    Color? icon,
    Color? avatarIcon,
    Color? iconButton,
    Color? border,
    Color? divider,
    Color? notes,
    Color? bnb,
    Color? filterSurface,
    Color? filterButton,
    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? defaultWidget,
    Color? notSelected,
  }) {
    return MainColorsExtension(
      primary: primary ?? this.primary,
      surface: surface ?? this.surface,
      text: text ?? this.text,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      avatarIcon: avatarIcon ?? this.avatarIcon,
      iconButton: iconButton ?? this.iconButton,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      notes: notes ?? this.notes,
      bnb: bnb ?? this.bnb,
      filterSurface: filterSurface ?? this.filterSurface,
      filterButton: filterButton ?? this.filterButton,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
      defaultWidget: defaultWidget ?? this.defaultWidget,
      notSelected: notSelected ?? this.notSelected,
    );
  }

  @override
  ThemeExtension<MainColorsExtension> lerp(
      covariant ThemeExtension<MainColorsExtension>? other,
      double t,
      ) {
    if (other is! MainColorsExtension) {
      return this;
    }

    return MainColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      text: Color.lerp(text, other.text, t)!,
      title: Color.lerp(title, other.title, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      avatarIcon: Color.lerp(avatarIcon, other.avatarIcon, t)!,
      iconButton: Color.lerp(iconButton, other.iconButton, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      notes: Color.lerp(notes, other.notes, t)!,
      bnb: Color.lerp(bnb, other.bnb, t)!,
      filterSurface: Color.lerp(filterSurface, other.filterSurface, t)!,
      filterButton: Color.lerp(filterButton, other.filterButton, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
      defaultWidget: Color.lerp(defaultWidget, other.defaultWidget, t)!,
      notSelected: Color.lerp(notSelected, other.notSelected, t)!,
    );
  }
}