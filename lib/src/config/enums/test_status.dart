import 'package:flutter/material.dart';


enum TestStatus {
  positive('Positive', Icons.check),
  negative('Negative', Icons.close),
  waiting('Waiting for result', Icons.autorenew);

  const TestStatus(
    this.label,
    this.iconData
  );

  final String label;
  final IconData iconData;

  static final List<TestStatus> entries = [TestStatus.positive, TestStatus.negative, TestStatus.waiting];
}
