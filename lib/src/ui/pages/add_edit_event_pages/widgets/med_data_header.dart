import 'package:flutter/material.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/ui/widgets/date_picker.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/mstb_switch.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/time_picker.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/ui/controllers/time_controller.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/main.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/ui/widgets/switch_column_base.dart';


class AddMedEventDataController {
  DateTime date;

  AddMedEventDataController({
    required this.date
  });

  late final DateController dateController = DateController(date: date);
  final TimeController timeController = TimeController();
  final SwitchController stiController = SwitchController(value: true);
  final SwitchController obgynController = SwitchController(value: true);
}


class AddMedEventDataColumn extends StatefulWidget {
  final dynamic controller;

  const AddMedEventDataColumn({
    super.key,
    required this.controller
  });

  @override
  State<AddMedEventDataColumn> createState() => _AddMedEventDataColumnState();
}

class _AddMedEventDataColumnState extends State<AddMedEventDataColumn> {
  late Future<Map<String, Category>> _categoriesMapFuture;
  
  late bool isSti = widget.controller.stiController.value;
  late bool isObgyn = widget.controller.obgynController.value;
  late IconData iconData = AppIconData.medical;
  
  @override
  void initState() {
    super.initState();
    _categoriesMapFuture = _getCategoriesList(database);
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dataRow(AppIconData.date, DataStrings.date, null,
                    DatePicker(
                      controller: widget.controller.dateController
                    )
                  ),
                  dataRow(AppIconData.time, DataStrings.time, null,
                    TimePicker(
                      type: 0,
                      controller: widget.controller.timeController,
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
        typeColumn()
      ],
    );
  }


  Widget dataRow(IconData iconData, String title, double? size, Widget? child){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: size != null ? 6 : 0),
            child: Icon(
              iconData,
              color: AppColors.addEvent.icon(context),
              size: size,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              "$title:",
              style: TextStyle(
                  color: AppColors.addEvent.title(context),
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.titleSmall
              ),
            ),
          ),
          ?child
        ],
      ),
    );
  }

  Widget typeColumn() {
    return FutureBuilder(
      future: _categoriesMapFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          return ErrorTile();
        }

        final categoriesMap = snapshot.data!;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SwitchColumnBase(
                    title: categoriesMap['sti']!.name,
                    iconData: AppIconData.sti,
                    iconSize: AppSizes.iconViruses,
                    child: Switch(
                      inactiveThumbColor: AppColors.addEvent.border(context),
                      value: isSti,
                      onChanged: (bool value) {
                        setState(() {
                          isSti = value;
                          widget.controller.stiController.setValue(value);
                        });
                      }),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SwitchColumnBase(
                    title: categoriesMap['obgyn']!.name,
                    iconData: AppIconData.obgyn,
                    child: Switch(
                      inactiveThumbColor: AppColors.addEvent.border(context),
                      value: isObgyn,
                      onChanged: (bool value) {
                        setState(() {
                          isObgyn = value;
                          widget.controller.obgynController.setValue(value);
                        });
                      }),
                  ),
                )
              ],
            ),
          ],
        );
      }
    );
  }

  Future<Map<String, Category>> _getCategoriesList(AppDatabase db) async {
    List<Category> categories = await db.allCategories;
    var categoriesMap = { for (var v in categories) v.slug: v };
    return categoriesMap;
  }
}