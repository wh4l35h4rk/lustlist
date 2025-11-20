import 'package:flutter/material.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/widgets/add_widgets/date_picker.dart';
import 'package:lustlist/widgets/add_widgets/mstb_switch.dart';
import 'package:lustlist/widgets/add_widgets/time_picker.dart';
import '../../colors.dart';
import '../../database.dart';
import '../../main.dart';
import '../error_tile.dart';


class AddMedEventDataController {
  DateTime date;

  AddMedEventDataController({
    required this.date
  });

  late final DateController dateController = DateController(date);
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
  late IconData iconData = Icons.medical_services;
  
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
                  dataRow(Icons.calendar_month, "Date", null,
                      DatePicker(
                          controller: widget.controller.dateController
                      )
                  ),
                  dataRow(Icons.access_time, "Time", null,
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
                  fontSize: 16
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Type:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.addEvent.title(context),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                dataRow(CustomIcons.viruses, categoriesMap['sti']!.name, 20, null),
                SizedBox(
                  height: 30,
                  child: Transform.scale(
                    scale: 0.65,
                    child: Switch(
                      inactiveThumbColor: AppColors.addEvent.border(context),
                      value: isSti,
                      onChanged: (bool value) {
                      setState(() {
                        isSti = value;
                        widget.controller.stiController.setValue(value);
                      });
                    },),
                  ),
                ),

              ],
            ),
            Row(
              children: [
                dataRow(CategoryIcons.uterus, categoriesMap['obgyn']!.name, null, null),
                SizedBox(
                  height: 30,
                  child: Transform.scale(
                    scale: 0.65,
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
                ),
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