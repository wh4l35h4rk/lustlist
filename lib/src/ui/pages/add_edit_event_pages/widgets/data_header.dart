import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/ui/widgets/date_picker.dart';
import 'package:lustlist/src/ui/widgets/orgasms_picker.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/mstb_switch.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/time_picker.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/core/widgets/info_row.dart';


class AddEditEventDataColumn extends StatefulWidget {
  final dynamic controller;
  final bool isMstb;

  const AddEditEventDataColumn({
    super.key,
    required this.controller,
    required this.isMstb,
  });

  @override
  State<AddEditEventDataColumn> createState() => _AddEditEventDataColumnState();
}

class _AddEditEventDataColumnState extends State<AddEditEventDataColumn> {
  int get rating => widget.controller.rating;
  int? get orgasmAmount => widget.controller.orgasmAmount;
  
  late bool isMstb = widget.isMstb;
  late IconData iconData = isMstb ? Icons.front_hand : Icons.favorite;

  @override
  Widget build(BuildContext context) {
    Color iconColor = AppColors.addEvent.icon(context);
    Color titleColor = AppColors.addEvent.title(context);

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(
                    iconData: Icons.calendar_month,
                    iconColor: iconColor,
                    title: colon(DataStrings.date),
                    titleColor: titleColor,
                    child: DatePicker(
                      controller: widget.controller.dateController,
                    )
                  ),
                  InfoRow(
                    iconData: Icons.access_time,
                    iconColor: iconColor,
                    title: colon(DataStrings.time),
                    titleColor: titleColor,
                    child: TimePicker(
                      type: 0,
                      controller: widget.controller.timeController,
                    )
                  ),
                  InfoRow(
                    iconData: Icons.star,
                    iconColor: iconColor,
                    title: colon(DataStrings.rating),
                    titleColor: titleColor,
                    child: ratingRow()
                  ),
                  InfoRow(
                    iconData: Icons.timelapse,
                    iconColor: iconColor,
                    title: colon(DataStrings.duration),
                    titleColor: titleColor,
                    child: TimePicker(
                      type: 1,
                      controller: widget.controller.durationController,
                    )
                  ),
                  InfoRow(
                    iconData: Icons.auto_awesome,
                    iconColor: iconColor,
                    title: colon(DataStrings.myOrgasms),
                    titleColor: titleColor,
                    child: OrgasmsAmountPicker(
                      amount: orgasmAmount,
                      onChanged: (newValue) {
                        setState(() {
                          widget.controller.setOrgasmAmount(newValue);
                        });
                      },
                    )
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    iconData,
                    color: AppColors.addEvent.leadingIcon(context),
                  ),
                ],
              ),
            ],
          ),
        ),
        ?isMstb ? pornColumn() : null
      ],
    );
  }


  Widget ratingRow() {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var index = 1; index <= 5; index++)
            SizedBox(
              height: 20,
              width: 20,
              child: IconButton(
                onPressed: (){
                  setState(() {
                    widget.controller.setRating(index);
                  });
                },
                icon: Icon(
                  index <= rating ? Icons.star : Icons.star_border,
                  size: AppSizes.iconMedium,
                  color: AppColors.addEvent.coloredText(context),
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            )
        ]
    );
  }

  Widget pornColumn() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              colon(DataStrings.porn),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.addEvent.title(context),
                fontSize: AppSizes.titleLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.play_circle,
              color: AppColors.addEvent.leadingIcon(context),
            ),
          ],
        ),
        MstbSwitch(widget.controller.pornController)
      ],
    );
  }
}