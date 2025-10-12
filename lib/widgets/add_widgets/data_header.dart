import 'package:flutter/material.dart';
import 'package:lustlist/widgets/add_widgets/date_picker.dart';
import 'package:lustlist/widgets/add_widgets/orgasms_picker.dart';
import 'package:lustlist/widgets/add_widgets/time_picker.dart';
import '../../colors.dart';


class AddEventDataController {
  final DateController dateController = DateController();
  final TimeController timeController = TimeController();
  final TimeController durationController = TimeController();

  int rating = 0;
  int orgasmAmount = 0;

  void setRating(int newValue) {
    rating = newValue;
  }

  void setOrgasmAmount(int newValue) {
    orgasmAmount = newValue;
  }
}


class AddEventDataColumn extends StatefulWidget {
  final IconData iconData;
  final AddEventDataController controller;

  const AddEventDataColumn({
    super.key,
    required this.controller,
    required this.iconData,
  });

  @override
  State<AddEventDataColumn> createState() => _AddEventDataColumnState();
}

class _AddEventDataColumnState extends State<AddEventDataColumn> {

  int get rating => widget.controller.rating;
  int get orgasmAmount => widget.controller.orgasmAmount;
  IconData get iconData => widget.iconData;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow(context, Icons.calendar_month, "Date",
                DatePicker(
                  controller: widget.controller.dateController
                )
              ),
              dataRow(context, Icons.access_time, "Time",
                TimePicker(
                  type: 0,
                  controller: widget.controller.timeController,
                )
              ),
              dataRow(context, Icons.star, "Rating",
                ratingRow(context)
              ),
              dataRow(context, Icons.timelapse, "Duration",
                TimePicker(
                  type: 1,
                  controller: widget.controller.durationController,
                )
              ),
              dataRow(context, Icons.auto_awesome, "My orgasms",
                OrgasmsAmountPicker(
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
    );
  }


  Widget dataRow(BuildContext context, IconData iconData, String title, Widget child){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(iconData, color: AppColors.addEvent.icon(context)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              "$title:",
              style: TextStyle(
                  color: AppColors.addEvent.title(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ),
          child
        ],
      ),
    );
  }

  Widget ratingRow(BuildContext context) {
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
                  size: 16,
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