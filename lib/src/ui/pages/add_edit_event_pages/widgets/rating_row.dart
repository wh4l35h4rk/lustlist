import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/ui/controllers/int_controller.dart';


class RatingRow extends StatefulWidget {
  const RatingRow({
    super.key,
    required this.controller,
  });

  final IntController controller;

  @override
  State<RatingRow> createState() => _RatingRowState();
}

class _RatingRowState extends State<RatingRow> {
  int get rating => widget.controller.value ?? 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 1; index <= 5; index++)
          SizedBox(
            height: 20,
            width: 20,
            child: IconButton(
              onPressed: () {
                setState(() {
                  widget.controller.setValue(index);
                });
              },
              icon: Icon(
                index <= rating ? AppIconData.rating : AppIconData.ratingEmpty,
                size: AppSizes.iconMedium,
                color: AddEventColors.coloredText(context),
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          )
      ]
    );
  }
}
