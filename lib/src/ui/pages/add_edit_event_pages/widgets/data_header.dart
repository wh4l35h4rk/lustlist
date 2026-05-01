import 'package:flutter/material.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/ui/controllers/add_category_controller.dart';
import 'package:lustlist/src/ui/controllers/eventdata_controller_base.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/rating_row.dart';
import 'package:lustlist/src/ui/widgets/date_picker.dart';
import 'package:lustlist/src/ui/widgets/orgasms_picker.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/mstb_switch.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/time_picker.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/core/widgets/info_row.dart';


class AddEditEventDataColumn extends StatefulWidget {
  final EventDataControllerBase controller;
  final bool isMstb;
  final dynamic optionsController;

  const AddEditEventDataColumn({
    super.key,
    required this.controller,
    required this.isMstb,
    this.optionsController,
  });

  @override
  State<AddEditEventDataColumn> createState() => _AddEditEventDataColumnState();
}

class _AddEditEventDataColumnState extends State<AddEditEventDataColumn> {
  late bool isMstb = widget.isMstb;
  late IconData iconData = isMstb ? AppIconData.mstb : AppIconData.sex;

  late Future<EOption> pornOptionFuture;
  late Future<EOption> toysOptionFuture;

  @override
  void initState() {
    super.initState();
    EventRepository repo = EventRepository(database);
    if (isMstb) {
      pornOptionFuture = repo.getOption("porn");
      toysOptionFuture = repo.getOption("solo toys");
    }
  }

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
                    iconData: AppIconData.date,
                    iconColor: iconColor,
                    title: StringFormatter.colon(DataStrings.date),
                    titleColor: titleColor,
                    child: DatePicker(
                      controller: widget.controller.dateController,
                    )
                  ),
                  InfoRow(
                    iconData: AppIconData.time,
                    iconColor: iconColor,
                    title: StringFormatter.colon(DataStrings.time),
                    titleColor: titleColor,
                    child: TimePicker(
                      type: 0,
                      controller: widget.controller.timeController,
                    )
                  ),
                  InfoRow(
                    iconData: AppIconData.rating,
                    iconColor: iconColor,
                    title: StringFormatter.colon(DataStrings.rating),
                    titleColor: titleColor,
                    child: RatingRow(controller: widget.controller.ratingController)
                  ),
                  InfoRow(
                    iconData: AppIconData.duration,
                    iconColor: iconColor,
                    title: StringFormatter.colon(DataStrings.duration),
                    titleColor: titleColor,
                    child: TimePicker(
                      type: 1,
                      controller: widget.controller.durationController,
                    )
                  ),
                  OrgasmsPickerRow(
                    iconColor: iconColor,
                    titleColor: titleColor,
                    controller: widget.controller
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
        ?isMstb ? FutureBuilder(
          future: Future.wait([pornOptionFuture, toysOptionFuture]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text(MiscStrings.loading,
                style: TextStyle(
                  fontSize: AppSizes.textBasic,
                  color: AppColors.addEvent.coloredText(context),
                ),
              );
            } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty
                || widget.optionsController == null
            ) {
              return Text(MiscStrings.errorLoadingData,
                style: TextStyle(
                  fontSize: AppSizes.textBasic,
                  color: AppColors.addEvent.coloredText(context),
                ),
              );
            }

            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: MstbSwitchColumn(
                    title: DataStrings.porn,
                    iconData: AppIconData.porn,
                    option: snapshot.data![0],
                    controller: widget.optionsController,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: MstbSwitchColumn(
                    title: DataStrings.toys,
                    iconData: AppIconData.toys,
                    option: snapshot.data![1],
                    controller: widget.optionsController,
                  ),
                )
              ],
            );
          }
        ) : null,
      ],
    );
  }
}


class OrgasmsPickerRow extends StatefulWidget {
  const OrgasmsPickerRow({
    super.key,
    required this.iconColor,
    required this.titleColor,
    required this.controller,
  });

  final Color iconColor;
  final Color titleColor;
  final EventDataControllerBase controller;

  @override
  State<OrgasmsPickerRow> createState() => _OrgasmsPickerRowState();
}

class _OrgasmsPickerRowState extends State<OrgasmsPickerRow> {
  @override
  Widget build(BuildContext context) {
    return InfoRow(
        iconData: AppIconData.orgasms,
        iconColor: widget.iconColor,
        title: StringFormatter.colon(DataStrings.myOrgasms),
        titleColor: widget.titleColor,
        child: OrgasmsAmountPicker(
          amount: widget.controller.orgasmsController.value,
          onChanged: (newValue) {
            setState(() {
              widget.controller.orgasmsController.setValue(newValue);
            });
          },
        )
    );
  }
}


class MstbSwitchColumn extends StatelessWidget {
  const MstbSwitchColumn({
    super.key,
    required this.title,
    required this.iconData,
    required this.controller,
    required this.option,
  });

  final AddCategoryController controller;
  final String title;
  final IconData iconData;
  final EOption option;

  @override
  Widget build(BuildContext context) {
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
        MstbSwitch(
          controller: controller,
          option: option,
        )
      ],
    );
  }
}