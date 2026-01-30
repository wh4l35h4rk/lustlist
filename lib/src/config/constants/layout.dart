import 'package:flutter/widgets.dart';
import 'package:lustlist/src/config/constants/sizes.dart';

class AppInsets {

  // tiles
  static const EdgeInsets headerTile = EdgeInsets.all(10);
  static const EdgeInsets listTile = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 4.0,
  );
  static const EdgeInsets optionsListTile = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 6.0,
  );
  static const EdgeInsets optionsContainer = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 6,
  );

  static const EdgeInsets addDataMargin = EdgeInsets.only(
      left: 10.0, right: 10.0, top: 10, bottom: 5
  );

  // misc
  static const EdgeInsets progressInList = EdgeInsets.symmetric(vertical: 150);
  static const EdgeInsets divider = EdgeInsets.symmetric(horizontal: 12.0);
  static const EdgeInsets dataDivider = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets dataIcon = EdgeInsets.symmetric(horizontal: 6);
  static const Offset floatingButtonOffset = Offset(-5, 10);


  // chart-specific
  static const EdgeInsets lineChart = EdgeInsets.only(
      left: 20,
      right: 10 + AppSizes.chartSideTitlesSpace
  );
  static const EdgeInsets chartTitle = EdgeInsets.only(
      right: 8.0,
      left: 8.0,
      top: 37,
      bottom: 15
  );
  
  static const EdgeInsets pieChart = EdgeInsets.all(40.0);
  static const EdgeInsets chartIcon = EdgeInsets.all(4.0);
  static const EdgeInsets legendRow = EdgeInsets.symmetric(vertical: 2.0);


  // credit page
  static const EdgeInsets highDivider = EdgeInsets.symmetric(horizontal: 12.0, vertical: 6);

}


