import 'package:flutter/material.dart';
import 'package:lustlist/custom_icons.dart';
import 'package:lustlist/database.dart';
import '../../colors.dart';
import '../../list_notifier.dart';
import '../../main.dart';
import '../basic_tile.dart';

class AddCategoryTile extends StatefulWidget {
  final Category category;
  final IconData iconData;
  final double iconSize;

  const AddCategoryTile({
    super.key,
    required this.category,
    required this.iconData,
    this.iconSize = 24,
  });

  @override
  State<StatefulWidget> createState() => _AddCategoryTileState();

}

class _AddCategoryTileState  extends State<AddCategoryTile> {
  final _selectedOptions = ListNotifier<EOption>();
  late final Category category = widget.category;
  late final IconData iconData = widget.iconData;
  late final double iconSize = widget.iconSize;
  late Future<List<EOption>> _optionsListFuture;

  @override
  void initState() {
    super.initState();
    _optionsListFuture = _getOptionsList(database, category.id);
  }

  @override
  Widget build(BuildContext context) {
    return BasicTile(
        surfaceColor: AppColors.addEvent.surface(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${category.name}:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.addEvent.title(context),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  iconData,
                  size: iconSize,
                  color: AppColors.addEvent.leadingIcon(context),
                ),
              ],
            ),
            SizedBox(height: 5,),
            FutureBuilder(
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
                    return Center(
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        spacing: 6,
                        children: List.generate(
                          snapshot.data!.length, (index) =>
                              optionListButton(context, snapshot.data![index])
                          ),
                        ),
                    );
                  }
                }
            ),
          ],
        ),
    );
  }

  Widget optionListButton(BuildContext context, EOption option) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          if  (_selectedOptions.value.contains(option)){
            _selectedOptions.remove(option);
          } else {
            _selectedOptions.add(option);
          }
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: _selectedOptions.value.contains(option) ?
          AppColors.addEvent.selectedSurface(context) : AppColors.addEvent.surface(context),
        side: BorderSide(width: 1.2, color: AppColors.addEvent.border(context)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _selectedOptions.value.contains(option) ?
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(Icons.check),
              )
              : SizedBox(),
          Text(
            option.name,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColors.addEvent.text(context)
            ),
          ),
        ],
      ),
    );
  }


  Future<List<EOption>> _getOptionsList(AppDatabase db, int categoryId) async {
    List<EOption> options = await db.getOptionsByCategory(categoryId);
    return options;
  }
}