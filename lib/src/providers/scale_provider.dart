import 'package:flutter/material.dart';
import 'package:lustlist/src/config/enums/scale_value.dart';
import 'package:lustlist/src/providers/scales.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ScaleProvider with ChangeNotifier {
  late final String _scaleKey = "scale";
  late ScaleValue _scaleValue = ScaleValue.def;

  ScaleValue get currentScaleValue => _scaleValue;
  double get value => _scaleValue.value;

  ScaleProvider() {
    _loadScalePreference();
  }

  void setFactor(ScaleValue value) {
    if (_scaleValue == value) return;
    _scaleValue = value;
    saveScalingToPreferences(value);
    notifyListeners();
  }

  AppScales get sizes => AppScales(factor: currentScaleValue.value);

  void saveScalingToPreferences(ScaleValue value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_scaleKey, currentScaleValue.name);
  }

  Future<void> _loadScalePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? scaleValueString = prefs.getString(_scaleKey);
    if (scaleValueString != null) {
      final loadedScaleValue = ScaleValue.values.firstWhere(
            (e) => e.toString() == 'ScaleValue.$scaleValueString',
        orElse: () => ScaleValue.def,
      );
      setFactor(loadedScaleValue);

      print(scaleValueString);
    }
  }
}

extension AppContextExtension on BuildContext {
  AppScales get sizes => watch<ScaleProvider>().sizes;
}