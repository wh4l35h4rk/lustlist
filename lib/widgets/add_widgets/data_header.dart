import 'package:flutter/material.dart';
import 'package:lustlist/widgets/add_widgets/orgasms_picker.dart';
import 'package:lustlist/widgets/add_widgets/time_picker.dart';
import '../../colors.dart';


class AddEventDataColumn extends StatefulWidget {
  final IconData iconData;

  const AddEventDataColumn({
    super.key,
    required this.iconData
  });

  @override
  State<AddEventDataColumn> createState() => _AddEventDataColumnState();
}

class _AddEventDataColumnState extends State<AddEventDataColumn> {
  int rating = 0;
  late var orgasmAmount = 0;
  late final IconData iconData = widget.iconData;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: AppColors.addEvent.icon(context)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "Time:",
                        style: TextStyle(
                            color: AppColors.addEvent.title(context),
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    TimePicker(type: 0)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Icon(Icons.star, color: AppColors.addEvent.icon(context)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "Rating:",
                        style: TextStyle(
                            color: AppColors.addEvent.title(context),
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    ratingRow(context)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Icon(Icons.timelapse, color: AppColors.addEvent.icon(context)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "Duration:",
                        style: TextStyle(
                            color: AppColors.addEvent.title(context),
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    TimePicker(type: 1,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: AppColors.addEvent.icon(context)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "My orgasms:",
                        style: TextStyle(
                            color: AppColors.addEvent.title(context),
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    OrgasmsAmountPicker(
                      amount: orgasmAmount,
                      onChanged: (newValue) {
                        setState(() {
                          orgasmAmount = newValue;
                        });
                      },
                    )
                  ],
                ),
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
                    if (rating < index) {
                      rating += index - rating;
                    } else if (rating >= index) {
                      rating -= rating - index;
                    }
                  });
                },
                icon: Icon(
                  index <= rating ? Icons.star : Icons.star_border,
                  size: 16,
                  color: AppColors.addEvent.leadingIcon(context),
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            )
        ]
    );
  }
}