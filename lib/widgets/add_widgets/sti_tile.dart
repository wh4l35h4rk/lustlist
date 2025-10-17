import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import 'package:lustlist/widgets/add_widgets/category_tile.dart';
import 'package:lustlist/widgets/add_widgets/sti_option_listtile.dart';
import '../../colors.dart';
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


  @override
  void initState() {
    super.initState();
    _optionsListFuture = _getOptionsList(database, category.id);
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
                    snapshot.data!.length, (index) =>
                    StiOptionListTile(
                      context: context,
                      option: snapshot.data![index],
                      categoryController: widget.controller,
                    )
                ),
              );
            }
          }
      ),
    );
  }


  Future<List<EOption>> _getOptionsList(AppDatabase db, int categoryId) async {
    List<EOption> options = await db.getOptionsByCategory(categoryId);
    return options;
  }
}

