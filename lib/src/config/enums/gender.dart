import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';


enum Gender {
  male('Male', Icons.male),
  female('Female', Icons.female),
  nonbinary('Nonbinary', CustomIcons.genderless);

  const Gender(this.label, this.iconData);

  final String label;
  final IconData iconData;

  static final List<Gender> entries = [Gender.male, Gender.female, Gender.nonbinary];
}
