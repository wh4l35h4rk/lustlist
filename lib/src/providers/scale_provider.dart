import 'package:flutter/material.dart';
import 'package:lustlist/src/config/enums/scale_value.dart';
import 'package:lustlist/src/providers/scales.dart';
import 'package:provider/provider.dart';


class ScaleProvider with ChangeNotifier {
  late ScaleValue _scaleValue = ScaleValue.def;

  ScaleValue get factor => _scaleValue;
  double get value => _scaleValue.value;

  void setFactor(ScaleValue value) {
    if (_scaleValue == value) return;
    _scaleValue = value;
    notifyListeners();
  }

  AppScales get sizes => AppScales(factor: factor.value);
}

extension AppContextExtension on BuildContext {
  AppScales get sizes => watch<ScaleProvider>().sizes;
}