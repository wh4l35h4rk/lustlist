import 'package:flutter/material.dart';
import 'package:lustlist/src/database/database.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/enums/test_status.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/category_tile.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/sti_option_listtile.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/ui/controllers/add_category_controller.dart';
import 'package:lustlist/src/ui/main.dart';



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
              return Text(
                MiscStrings.loading,
                style: TextStyle(
                  fontSize: AppSizes.textBasic,
                  color: AppColors.addEvent.coloredText(context),
                ),
              );
            } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
              return Text(
                MiscStrings.errorLoadingData,
                style: TextStyle(
                  fontSize: AppSizes.textBasic,
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

