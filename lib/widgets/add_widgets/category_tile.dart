import 'package:flutter/material.dart';
import 'package:lustlist/database.dart';
import '../../colors.dart';
import '../../controllers/add_category_controller.dart';
import '../../controllers/list_notifier.dart';
import '../../main.dart';
import '../basic_tile.dart';


class AddCategoryTile extends StatefulWidget {
  final Category category;
  final AddCategoryController controller;
  final IconData iconData;
  final double iconSize;
  final Widget? body;

  const AddCategoryTile({
    super.key,
    required this.category,
    required this.controller,
    required this.iconData,
    this.iconSize = 24,
    this.body,
  });

  @override
  State<StatefulWidget> createState() => _AddCategoryTileState();

}

class _AddCategoryTileState  extends State<AddCategoryTile> {
  late Future<List<EOption>> _optionsListFuture;

  ListNotifier<EOption> get _selectedOptions => widget.controller.selectedOptions;
  Category get category => widget.category;
  IconData get iconData => widget.iconData;
  double get iconSize => widget.iconSize;
  Widget? get body => widget.body;


  @override
  void initState() {
    super.initState();
    _optionsListFuture = database.getOptionsByCategory(category.id);
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
          body ?? FutureBuilder(
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
                          optionListButton(
                              context,
                              snapshot.data![index],
                          )
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
}