import 'package:flutter/material.dart';
import 'package:lustlist/widgets/add_widgets/data_header.dart';
import '../../colors.dart';

class AddSexEventData extends StatelessWidget {
  const AddSexEventData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 5),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.addEvent.surface(context),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: AddEventDataColumn(iconData: Icons.favorite),
    );
  }
}