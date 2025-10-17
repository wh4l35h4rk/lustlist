import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/test_status.dart';
import 'package:lustlist/widgets/add_widgets/category_tile.dart';
import 'package:lustlist/widgets/add_widgets/mstb_switch.dart';
import '../../colors.dart';


class StiOptionListTile extends StatefulWidget {
  const StiOptionListTile({
    super.key,
    required this.context,
    required this.option,
    required this.categoryController,
  });

  final BuildContext context;
  final EOption option;
  final AddCategoryController categoryController;

  @override
  State<StiOptionListTile> createState() => _StiOptionListTileState();
}

class _StiOptionListTileState extends State<StiOptionListTile> {
  final _switchController = SwitchController(value: false);
  late bool value = _switchController.value;

  TestStatus selectedStatus = TestStatus.waiting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.addEvent.border(context),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(widget.option.name,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColors.addEvent.text(context),
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 6,),
          Expanded(
            flex: 2,
            child: Transform.scale(
              scale: 0.8,
              child: SizedBox(
                height: 40,
                child: Switch(
                  inactiveThumbColor: AppColors.addEvent.border(context),
                  value: value,
                  onChanged: (bool value) {
                    setState(() {
                      this.value = value;
                      _switchController.setValue(value);
                      if (widget.categoryController.selectedOptions.value.contains(widget.option)){
                        widget.categoryController.selectedOptions.remove(widget.option);
                        widget.categoryController.statusMap.remove(widget.option);
                      } else {
                        widget.categoryController.selectedOptions.add(widget.option);
                        widget.categoryController.setStatus(widget.option, TestStatus.waiting);
                      }
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 6,),
          Expanded(
            flex: 5,
            child: value ?
            DropdownButton<TestStatus>(
              isDense: true,
              value: selectedStatus,
              icon: const Icon(Icons.keyboard_arrow_down_sharp),
              alignment: Alignment.centerLeft,
              style: TextStyle(color: AppColors.addEvent.text(context), fontSize: 14),
              underline: Container(height: 2, color: AppColors.addEvent.border(context)),
              onChanged: (TestStatus? status) {
                setState(() {
                  selectedStatus = status!;
                  widget.categoryController.setStatus(widget.option, status);
                });
              },
              items: TestStatus.entries.map<DropdownMenuItem<TestStatus>>((TestStatus value) {
                return DropdownMenuItem<TestStatus>(value: value, child: Text(value.label));
              }).toList(),
            ) :
            Text("Did not take",
              style: TextStyle(
                  color: AppColors.addEvent.text(context),
                  fontSize: 14
              ),
            ),
          ),
        ],
      ),
    );
  }
}