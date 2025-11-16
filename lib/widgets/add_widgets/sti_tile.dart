import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/test_status.dart';
import 'package:lustlist/widgets/add_widgets/category_tile.dart';
import 'package:lustlist/widgets/add_widgets/sti_option_listtile.dart';
import '../../colors.dart';
import '../../controllers/add_category_controller.dart';
import '../../main.dart';



class AddStiTile extends StatefulWidget {
  final Category category;
  final AddCategoryController controller;
  final IconData iconData;
  final double iconSize;
  final Widget? body;

  const AddStiTile({
    super.key,
    required this.category,
    required this.controller,
    required this.iconData,
    this.iconSize = 24,
    this.body,
  });

  @override
  State<StatefulWidget> createState() => _AddStiTileState();

}

class _AddStiTileState  extends State<AddStiTile> {
  late Future<List<EOption>> _optionsListFuture;

  Category get category => widget.category;
  IconData get iconData => widget.iconData;
  double get iconSize => widget.iconSize;
  Widget? get body => widget.body;

  List<EOption> get selectedOptions => widget.controller.selectedOptions.value;
  Map<EOption, TestStatus> get statusMap => widget.controller.statusMap;

  @override
  void initState() {
    super.initState();
    _optionsListFuture = database.getOptionsByCategory(category.id);
  }

  @override
  Widget build(BuildContext context) {
    return AddCategoryTile(
      category: category,
      controller: widget.controller,
      iconData: iconData,
      iconSize: iconSize,
      body: FutureBuilder(
          future: _optionsListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading data...",
                style: TextStyle(
                  color: AppColors.addEvent.coloredText(context),
                ),
              );
            } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
              return Text("Error loading data",
                style: TextStyle(
                  color: AppColors.addEvent.coloredText(context),
                ),
              );
            } else {
              return Column(
                children: List.generate(
                    snapshot.data!.length, (index) {
                      EOption option = snapshot.data![index];
                      bool isSelected = selectedOptions.contains(option) && statusMap.keys.contains(option);
                      return StiOptionListTile(
                        context: context,
                        option: option,
                        categoryController: widget.controller,
                        initStatus: isSelected ? statusMap[option] : null,
                      );
                }),
              );
            }
          }
      ),
    );
  }
}

