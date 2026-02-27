import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';


enum Gender {
  male('Male', AppIconData.male),
  female('Female', AppIconData.female),
  nonbinary('Nonbinary', AppIconData.nonbinary),
  unknown('Unknown', AppIconData.unknownGender);

  const Gender(this.label, this.iconData);

  final String label;
  final IconData iconData;

  static final List<Gender> entries = [Gender.male, Gender.female, Gender.nonbinary, Gender.unknown];
}
