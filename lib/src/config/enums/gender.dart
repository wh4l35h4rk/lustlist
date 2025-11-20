import 'package:flutter/material.dart';

typedef GenderEntry = DropdownMenuEntry<Gender>;

enum Gender {
  male('Male'),
  female('Female'),
  nonbinary('Nonbinary');

  const Gender(this.label);
  final String label;

  static final List<Gender> entries = [Gender.male, Gender.female, Gender.nonbinary];
}
