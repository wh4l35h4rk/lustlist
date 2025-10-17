import 'dart:collection';
import 'package:flutter/material.dart';


typedef StatusEntry = DropdownMenuEntry<TestStatus>;

enum TestStatus {
  positive('Positive'),
  negative('Negative'),
  waiting('Waiting for result');

  const TestStatus(this.label);
  final String label;

  static final List<TestStatus> entries = [TestStatus.positive, TestStatus.negative, TestStatus.waiting];
}
