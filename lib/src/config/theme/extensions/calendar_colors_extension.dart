import 'package:flutter/material.dart';

class CalendarColorsExtension extends ThemeExtension<CalendarColorsExtension> {
  CalendarColorsExtension({
    required this.title,
    required this.basicText,
    required this.weekdayText,
    required this.weekendText,
    required this.disabledText,
    required this.outsideText,
    required this.eventIcon,
    required this.eventOtherMonthIcon,
    required this.navigationIcon,
    required this.todayEvent,
    required this.selectedEvent,
    required this.border,
  });

  final Color title;
  final Color basicText;
  final Color weekdayText;
  final Color weekendText;
  final Color disabledText;
  final Color outsideText;
  final Color eventIcon;
  final Color eventOtherMonthIcon;
  final Color navigationIcon;
  final Color todayEvent;
  final Color selectedEvent;
  final Color border;


  factory CalendarColorsExtension.fromScheme(ColorScheme scheme) {
    final surface = scheme.surface;
    final onSurface = scheme.onSurface;
    final primary = scheme.primary;
    final inversePrimary = scheme.inversePrimary;
    final secondary = scheme.secondary;

    return CalendarColorsExtension(
        title: primary,
        basicText: onSurface,
        weekdayText: Color.lerp(onSurface, surface, 0.3)!,
        weekendText: Color.lerp(onSurface, primary, 0.9)!,
        disabledText: Color.lerp(onSurface, surface, 0.8)!,
        outsideText: Color.lerp(onSurface, surface, 0.6)!,
        eventIcon: secondary,
        eventOtherMonthIcon: Colors.black26,
        navigationIcon: primary,
        todayEvent: Color.lerp(inversePrimary, surface, 0.4)!,
        selectedEvent: inversePrimary,
        border: Color.lerp(primary, surface, 0.4)!,
    );
  }


  @override
  ThemeExtension<CalendarColorsExtension> copyWith({
    Color? title,
    Color? basicText,
    Color? weekdayText,
    Color? weekendText,
    Color? disabledText,
    Color? outsideText,
    Color? eventIcon,
    Color? eventOtherMonthIcon,
    Color? navigationIcon,
    Color? todayEvent,
    Color? selectedEvent,
    Color? border,
  }) {
    return CalendarColorsExtension(
      title: title ?? this.title,
      basicText: basicText ?? this.basicText,
      weekdayText: weekdayText ?? this.weekdayText,
      weekendText: weekendText ?? this.weekendText,
      disabledText: disabledText ?? this.disabledText,
      outsideText: outsideText ?? this.outsideText,
      eventIcon: eventIcon ?? this.eventIcon,
      eventOtherMonthIcon: eventOtherMonthIcon ?? this.eventOtherMonthIcon,
      navigationIcon: navigationIcon ?? this.navigationIcon,
      todayEvent: todayEvent ?? this.todayEvent,
      selectedEvent: selectedEvent ?? this.selectedEvent,
      border: border ?? this.border,
    );
  }

  @override
  ThemeExtension<CalendarColorsExtension> lerp(
      covariant ThemeExtension<CalendarColorsExtension>? other,
      double t,
      ) {
    if (other is! CalendarColorsExtension) {
      return this;
    }

    return CalendarColorsExtension(
      title: Color.lerp(title, other.title, t)!,
      basicText: Color.lerp(basicText, other.basicText, t)!,
      weekendText: Color.lerp(weekendText, other.weekendText, t)!,
      weekdayText: Color.lerp(weekdayText, other.weekdayText, t)!,
      disabledText: Color.lerp(disabledText, other.disabledText, t)!,
      outsideText: Color.lerp(outsideText, other.outsideText, t)!,
      eventIcon: Color.lerp(eventIcon, other.eventIcon, t)!,
      eventOtherMonthIcon: Color.lerp(eventOtherMonthIcon, other.eventOtherMonthIcon, t)!,
      navigationIcon: Color.lerp(navigationIcon, other.navigationIcon, t)!,
      todayEvent: Color.lerp(todayEvent, other.todayEvent, t)!,
      selectedEvent: Color.lerp(selectedEvent, other.selectedEvent, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}