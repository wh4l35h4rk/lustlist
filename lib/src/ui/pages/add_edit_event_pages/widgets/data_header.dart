import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/custom_icons.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/ui/widgets/date_picker.dart';
import 'package:lustlist/src/ui/widgets/orgasms_picker.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/mstb_switch.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/time_picker.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
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
                      title: StringFormatter.colon(DataStrings.date),
                      titleColor: titleColor,
                      child: DatePicker(
                        controller: widget.controller.dateController,
                      )
                  ),
                  InfoRow(
                      iconData: Icons.access_time,
                      iconColor: iconColor,
                      title: StringFormatter.colon(DataStrings.time),
                      titleColor: titleColor,
                      child: TimePicker(
                        type: 0,
                        controller: widget.controller.timeController,
                      )
                  ),
                  InfoRow(
                      iconData: Icons.star,
                      iconColor: iconColor,
                      title: StringFormatter.colon(DataStrings.rating),
                      titleColor: titleColor,
                      child: ratingRow()
                  ),
                  InfoRow(
                      iconData: Icons.timelapse,
                      iconColor: iconColor,
                      title: StringFormatter.colon(DataStrings.duration),
                      titleColor: titleColor,
                      child: TimePicker(
                        type: 1,
                        controller: widget.controller.durationController,
                      )
                  ),
                  InfoRow(
                      iconData: Icons.auto_awesome,
                      iconColor: iconColor,
                      title: StringFormatter.colon(DataStrings.myOrgasms),
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
        ?isMstb ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Divider(),
        ) : null,
        ?isMstb ? Row(
          children: [
            Expanded(
              flex: 1,
              child: MstbSwitchColumn(
                title: DataStrings.porn,
                iconData: Icons.play_circle,
                context: context,
                widget: widget,
                isToys: false,
              ),
            ),
            Expanded(
              flex: 1,
              child: MstbSwitchColumn(
                title: DataStrings.toys,
                iconData: CategoryIcons.vibratorFilled,
                context: context,
                widget: widget,
                isToys: true,
              ),
            )
          ],
        ) : null,
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
                onPressed: () {
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
}


class MstbSwitchColumn extends StatelessWidget {
  const MstbSwitchColumn({
    super.key,
    required this.title,
    required this.iconData,
    required this.context,
    required this.widget,
    required this.isToys,
  });

  final BuildContext context;
  final AddEditEventDataColumn widget;
  final String title;
  final IconData iconData;
  final bool isToys;

  @override
  Widget build(BuildContext context) {
    final controller = isToys ? widget.controller.toysController : widget.controller.pornController;

    return Column(
      spacing: 6,
      children: [
        Row(
          spacing: 6,
          children: [
            Icon(
              iconData,
              color: AppColors.addEvent.icon(context),
              size: AppSizes.iconBasic,
            ),
            Text(
              StringFormatter.colon(title),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.addEvent.title(context),
                fontSize: AppSizes.titleSmall,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        MstbSwitch(isToys, controller)
      ],
    );
  }
}