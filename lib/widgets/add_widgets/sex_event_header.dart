import 'package:flutter/material.dart';
import 'package:lustlist/widgets/add_widgets/data_header.dart';
import 'package:lustlist/widgets/basic_tile.dart';
import '../../colors.dart';

class AddSexEventData extends StatelessWidget {
  const AddSexEventData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BasicTile(
        surfaceColor: AppColors.addEvent.surface(context),
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 5,),
        child: AddEventDataColumn(iconData: Icons.favorite)
    );
  }
}