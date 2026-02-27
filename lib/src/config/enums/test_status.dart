import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';


enum TestStatus {
  positive('Positive', AppIconData.testPositive),
  negative('Negative', AppIconData.testNegative),
  waiting('Waiting for result', AppIconData.testWaiting);

  const TestStatus(
    this.label,
    this.iconData
  );

  final String label;
  final IconData iconData;

  static final List<TestStatus> entries = [TestStatus.positive, TestStatus.negative, TestStatus.waiting];
}
